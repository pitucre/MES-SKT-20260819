# OEE 状态判断逻辑改善分析（144）

日期：2026-09-23  
范围：正式库 `172.16.5.144 / LeanMes`（对照测试库 179）  
前提：修改任何原有存储过程前须先按 `AGENTS.md` 带时间戳备份；本文仅分析，未改线上对象。

---

## 1. 业务诉求与实际链路

**诉求**：通过注塑机明细，用两次采集之间**开关模数（ShotCounter）是否增加**判断生产状态，供管理者查看 32 台注塑机状态与 OEE。

**实际链路**：

```
FileWatch/OPC/MQTT
  → uspEquimentCollection (type=1 恩格尔 / type=2 海天)
    或 uspEquimentCollectionHMG / HT / HMGTest
  → 采集时用 @NowShotCounter vs @ShotCounter 决定
      累加 Prod_EquipmentStatusCollectionCurrent.TotalRuntime / TotalStop
      并写 Prod_CollectionEngelData(History) 等
  → vwEquipmentOEE
      Status  ← PES.CurrentStatus IN (1,4) + 心跳(PCE.UpdateDateTime > 5min)
      TimeRate/OEE ← PES.TotalRuntime / 86400（当天分母为已过秒）
      tQty     ← vwEquipmentOutQty（工单口径，非机台 Shot）
  → uspEquipmentOEEReport → ReportPage.aspx → 32 行
```

**结论**：

| 层级 | 是否用 Shot 判产 |
|------|------------------|
| 采集 SP（恩格尔/海天） | 是：ΔShot ≠ 0 → 计运行，否则计停 |
| 采集 SP（HMG） | **基本失效**（变量 bug + 分支条件错） |
| 线上 `vwEquipmentOEE` | **否**：只看 `CurrentStatus` + 心跳 |
| 旁路 `vwEquipmentOEE_Opt` | 是（区间法），但**用 PrevStatus 而非 ΔShot**，尚未替换原报表 |

---

## 2. 线上核实摘要（2026-09-23 探测）

- 主数据 `Basal_Equipment` 可见 **32** 台；`PES` 近日按 `WorkDate` 各 **32** 行。
- `PES.CurrentStatus` 当日分布：`0:3, 1:2, 4:21, 5:6` —— 视图仅认 `1/4` 为生产中，**含 5 的机台会被算成非生产**。
- 采集 History 近期样本：`EquipmentType=1` 状态 4/0、`type=2` 状态 1/0；Shot 在跑的机台有递增。
- **Shot 递减实例**：机台 `11`，`ShotCounter 15618 → 0`（复位/清零已发生）。
- 线上 `uspEquimentCollection`：**无** `@EquiCode` 重复参数问题（`NO_DUP_OR_FIXED`）；状态段仍为 `IF @NowShotCounter=@ShotCounter`（原始机台状态判断已被注释）。
- 线上 `uspEquimentCollectionHMG`：**仍使用 `EquipmentCode=@EquipmentCode` 取 `@NowShotCounter`**（`@EquipmentCode` 未赋值 → 查询空结果 → NowShot 恒为初值 0）。

---

## 3. 采集 SP 状态逻辑（核心）

### 3.1 恩格尔/海天 `uspEquimentCollection`

```sql
select @NowShotCounter=ShotCounter
  from Prod_CollectionEngelData with(nolock)
 where EquipmentCode=@EquiCode

-- 原始机台状态条件已被注释，例如：
-- IF @Status in(0,3) OR @NowShotCounter=@ShotCounter or @RunTime>120
IF @NowShotCounter=@ShotCounter
BEGIN
    SET @Status=0            -- 停
    SET @TotalStop=@RunTime
END
ELSE
BEGIN
    SET @Status=4            -- 恩格尔写 4；海天写 1
    SET @TotalRuntime=@RunTime
END
UPDATE dbo.Prod_EquipmentStatusCollectionCurrent
   SET CurrentStatus=@Status,
       TotalRuntime=TotalRuntime+@TotalRuntime,
       TotalStop=TotalStop+@TotalStop ...
```

**意图正确**：间隔内模数不变 → 停机时长；变化 → 运行时长。

### 3.2 HMG `uspEquimentCollectionHMG`

```sql
@NowShotCounter VARCHAR(100)=0
-- BUG: @EquipmentCode 从未赋值（只有 @EquiCode 来自 JSON）
select @NowShotCounter
  from Prod_CollectionEngelData with(nolock)
 where EquipmentCode=@EquipmentCode   -- 恒 NULL 结果集

-- STS 注释: 0=生产中, 1=待机中
IF @Status=1 OR @NowShotCounter=@ShotCounter OR @RunTime>120
BEGIN
    SET @Status=0
    SET @TotalStop=@RunTime
END
ELSE IF @Status IN (2)          -- JSON 不会出现 2
BEGIN
    SET @Status=1
    SET @TotalRuntime=@RunTime
END
```

**后果**：STS=0（生产）时两分支都不满足 → **运行时长基本不累积**；且 NowShot 比较恒失败。

---

## 4. 问题清单（按优先级）

### P0 — 直接导致状态/时长错误

| # | 问题 | 位置 | 影响 |
|---|------|------|------|
| 1 | HMG `@NowShotCounter` 查询用未赋值的 `@EquipmentCode` | `uspEquimentCollectionHMG` 取 NowShot 处 | 模数比较失效 |
| 2 | HMG 生产分支写成 `ELSE IF @Status IN(2)`，与 STS 0/1 注释矛盾 | 同 SP 状态 IF | 生产中不累加 `TotalRuntime` |
| 3 | 恩格尔/海天 `UPDATE Basal_Equipment ... WHERE EquipmentId=@EquipmentId` 时 Id 仍为 **-1** | `uspEquimentCollection` 约 L180/L195（赋值在其后） | 主表状态更新为死代码 |
| 4 | Shot 清零/倒退未处理（已出现 15618→0） | 采集 SP：`Qty += 新-旧`、`UseCount += Δ` | 负产量/负模具计次；区间法仍算“在动” |
| 5 | 首采/跨天：`LastDateTime IS NULL` 时 `@RunTime` 从 0 点起算 | 采集 SP 首采分支 | Shot 有变化时可能把午夜起整段记为运行 |
| 6 | 原始机台 `@Status(0/3/4)` 判断被注释，只靠 Shot 相等判停 | 采集 SP 多处 `--IF @Status...` | 长节拍、调试出模、状态撒谎时误判 |

### P1 — 报表状态与诉求不一致

| # | 问题 | 说明 |
|---|------|------|
| 7 | 线上视图**不重新按 ΔShot 判产** | `Status` 只看 `CurrentStatus IN(1,4)` + 5 分钟心跳 |
| 8 | 状态码多套混用 | 机台 0/3/4、HMG 0/1、`Basal_EquipmentStatus` 1生产/5模具故障…、PES 出现 0/1/4/**5**；视图只认 1、4 |
| 9 | OEE 缺 Performance | `TotalRuntime/86400 × Ok/(Ok+Ng)`；当天 TimeRate 分母为已过秒、OEE 固定 86400，**口径不一致** |
| 10 | `tQty`/`OpenQty` 非机台 Shot | 来自 `vwEquipmentOutQty`（工单模穴×Qty、工单数量）；列名“开合模数”易误导 |
| 11 | 报表 `OR WorkDate='1900-01-01'` 未加括号 | `AND 日期 OR 1900` 优先级会**绕过设备/状态过滤** |
| 12 | `vwEquipmentOEE_Opt` 用 `PrevStatus IN(1,4)` 无条件算生产 | **不检查本段 ΔShot**；状态谎报会虚高稼动 |

### P2 — 结构/性能/安全

| # | 问题 |
|---|------|
| 13 | `Prod_CollectionEngelDataHistory` 千万级，缺 `(EquipmentCode, CreateDateTime)` 类索引 |
| 14 | `ShotCounter/Status` 为 varchar，比较/聚合成本高 |
| 15 | Opt 视图 History 窗口约 3 天，历史日期报表不可用 |
| 16 | 报表 SP 字符串拼接 SQL（注入面） |
| 17 | 不筛 `WorkDate` 时 `PES` 历史日扇出（报表 WHERE 通常已按日过滤） |

---

## 5. 改善建议（实施顺序）

### 第一步：采集侧最小补丁（收益最大）

1. **HMG**  
   - `SET @EquipmentCode=@EquiCode` 后再取 `@NowShotCounter`。  
   - 生产判定与注释对齐：`STS=0` **或** `TRY_CONVERT(bigint,@ShotCounter) > TRY_CONVERT(bigint,@NowShotCounter)` → 累加 `TotalRuntime`；否则累加 `TotalStop`。  
   - 去掉/修正 `ELSE IF @Status IN(2)`（与 0/1 语义冲突）。

2. **恩格尔/海天**  
   - **先**解析 `@EquipmentId`，再 `UPDATE Basal_Equipment`。  
   - Shot 用 `TRY_CONVERT`；**Δ<0 → Reset**：不写负 `Qty`/`UseCount`，本段可按停或按“复位待确认”计。  
   - 首采 `@RunTime` 从 `LastUpdateTime`/班次开始，禁止默认 0 点→现在整段记运行。  
   - 评估是否恢复机台原始状态与 Shot 的 **AND/OR** 组合（长节拍机台避免“没模就停、有模就跑”的极端）。

3. （可选）**&lt;30s 节流**是否也跳过状态更新，避免心跳超时误判通讯中断。

### 第二步：统一状态字典 + 视图按 ΔShot 判“当前状态”

1. 一张映射：机台原始码/采集码 → 展示态：`生产中 / 待机 / 故障 / 通讯中断 / 离线`。  
2. 视图当前状态改为窗口 ΔShot：  
   - 最近 N 分钟 `ΔShot≥1` → 生产中；  
   - 有采集且 Δ=0 → 待机/非生产；  
   - `PCE.UpdateDateTime` 超时 → 通讯中断。  
3. 先改 **`vwEquipmentOEE_Opt`**（去掉 `PrevStatus` 无条件 Prod），与原报表并行对比，再灰度切换。

### 第三步：OEE 口径

1. 补 Performance：`理论节拍 × 有效模次 / 运行秒`（或现有 `PerformanceTest` 口径对齐）。  
2. 当天与历史分母统一（均用已过秒或均用计划班次×日）。  
3. 报表列名拆开：`工单产量` vs `机台开关模次`。

### 第四步：报表 SP

1. 日期与 1900 包成：`((日期条件) OR WorkDate='1900-01-01')`，避免绕过状态过滤。  
2. 长期改参数化查询。

### 第五步：性能（可后置）

1. History 索引：`(EquipmentCode, CreateDateTime) INCLUDE (Status, ShotCounter)`。  
2. 按日预聚合 `Fact_EquipmentOEE_Daily`（参考 `M03_设备OEE报表全链路分析与优化建议.md` §7）。

---

## 6. 实施前待确认口径（阻塞改库）

1. **状态列是否改为“窗口内 ΔShot≥1 才算生产中”**（与业务诉求一致，推荐）？  
2. **Shot 清零**：算换模/复位（不计负产量）还是算生产？  
3. 计划时间：**86400 还是班次**？OEE 是否**必须补 P**？  
4. HMG **STS 真值是否确认为 0=生产、1=待机**（与代码 `IN(2)` 冲突）？

---

## 7. 关联文件

- `AGENTS.md` — 改原对象前强制备份规则  
- `M03_设备OEE报表全链路分析与优化建议.md` — 深度对比与预聚合方案  
- `144_OEE报表正向全链路报告.md` — 采集→报表全链路  
- `DataSql\OEE_144_OptReport\vwEquipmentOEE_Opt.sql`、`uspEquipmentOEEReport_Opt.sql` — 旁路优化  
- `DataSql\OEE_144_DualWrite179\new144_uspEquimentCollection.sql` 等 — 双写脚本（含 HMG 修复痕迹）  
- `DataSql\OEE_144_DualWrite179\bak144_*` — 已有备份；改原对象前须再导 `OBJECT_DEFINITION`  
