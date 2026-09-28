# M03 设备OEE报表 全链路分析与优化建议

> 数据库：`172.16.5.179 / PROD_TEST_MES`（应用生效库）  
> 源码根：`E:\source\MES\SKT\20260819`  
> 分析日期：2026-09-23  
> **核心诉求**：通过注塑机采集的**开关模数（ShotCounter）是否在增加**，判断设备是否正常生产，并据此计算 OEE。

---

## 1. 结论摘要

| 项 | 现状 |
|---|---|
| 报表入口 | 报表模板库 `Report_Template`（HTML 模板加密存储），源码侧对应 `DataSql/m03OEEReport_template.txt`（页签标题现为 “E01 设备OEE报表”） |
| 查询链路 | 前端 `SktMesGrid(dataAction=PROC)` → `uspEquipmentOEEReport` → `uspCommonPage` → **`vwEquipmentOEE`** |
| 明细/下钻 | 设备编码 → `uspGetCollectionEngelDataHistoryReport`；管理状态 → `uspGetEquipmentShiftStatusTimeReport` |
| **线上 `vwEquipmentOEE`** | **完全不使用 ShotCounter 判断生产**；用 `Prod_EquipmentStatusCollectionCurrent.CurrentStatus∈(1,4)` + `PCE.UpdateDateTime>5分钟` 判通讯中断；OEE=`TotalRuntime/86400 × 良品率` |
| **新视图 `DataSql/vwEquipmentOEE_new.sql`** | **已实现 ShotCounter/LAG 区间法**，但 **尚未部署到 179 线上**（179 的 `vwEquipmentOEE` 仍是旧定义） |
| 开合模数列 `tQty` | 来自 `vwEquipmentOutQty` = **工单模穴数×工单数量**，**不是机台 ShotCounter** |
| 主数据体量 | `Prod_CollectionEngelDataHistory` ≈ **10,264,155** 行；仅 **HisDataId 聚簇主键**，无 `(EquipmentCode, CreateDateTime)` 索引 |
| Job | 179 仅 `注塑机台数据自动预警`（30s→`Proc_InsertOver5MinutesEquipmentData`）等；**状态补全 Job / 采集类 Job 缺失**；且 DB 名指向 `LeanMes_Test` |

**一句话**：核心诉求已写在 `vwEquipmentOEE_new.sql`，但线上仍在用“状态码 + 良品率”的旧算法；即便切换新视图，也必须先补索引、统一状态语义、修正 ShotCounter 归零/倒退与 gap 处理，否则结果与性能都不可用。

---

## 2. 端到端逻辑链

```
┌─────────────────────────────────────────────────────────────────────────┐
│ 采集层                                                                  │
│  恩格尔 EUROMAP63 文件 / 设备采集程序(Winform@150) / OPC-UA 采集程序     │
│  参数串 @ParamterStr + @ParamterVal，@EquipmentType=1恩格尔 2海天        │
└───────────────────────────────┬─────────────────────────────────────────┘
                                │ EXEC uspEquimentCollection
                                ▼
┌─────────────────────────────────────────────────────────────────────────┐
│ 落库 SP：uspEquimentCollection（~39KB）                                  │
│  · 解析 @32000→Status，@ShotCounter.sv_iShotCounter→@ShotCounter        │
│  · UPSERT Prod_CollectionEngelData（当前快照，每机 1 行，37 行）          │
│  · INSERT  Prod_CollectionEngelDataHistory（历史，1026 万行）            │
│  · 累加 Prod_EquimentOrderPord.Qty += ShotCounter 增量                  │
│  · 原始包进 Prod_EquipmentCollectionHistory（>1000 万截断）             │
└───────────┬─────────────────────────────┬───────────────────────────────┘
            │                             │
            │ 状态/工单/人工变更           │ 人工状态：uspEquipmentStatusEdit
            ▼                             ▼
┌──────────────────────────┐   ┌──────────────────────────────────────────┐
│ 状态累计                 │   │ Basal_Equipment.InjectionStatus         │
│ uspToalEquRunTime        │   │ Prod_EquipmentStatusData（日状态+时长） │
│ → Prod_EquipmentStatus   │   │ Prod_EquipmentStatusCollectionData      │
│   Data                   │   │   （班次 A/B 时长，明细下钻）           │
│ → Prod_EquipmentStatus   │   └──────────────────────────────────────────┘
│   CollectionData         │
│ Prod_EquipmentStatus     │
│   CollectionCurrent      │◄── uspAutoInsertEquipmentStatusCollectionCurrentJob
│ （当前状态+TotalRuntime）│    （补当天缺失机；>5min 累加 TotalStop）
└───────────┬──────────────┘
            │
            │ OK/NG：uspCollectionEquipmentProd → Prod_EquipmentDayProd
            │ 开合模(工单口径)：vwEquipmentOutQty
            ▼
┌─────────────────────────────────────────────────────────────────────────┐
│ 视图层                                                                   │
│  vwEquipmentOEE（线上旧版 = 179 当前定义）                               │
│  vwEquipmentOEE_new.sql（仓库新版 = ShotCounter 区间法，未上线）         │
│  并行：_20250909 / _20251118 / _byOperationPlatform / Test（5 版本）    │
└───────────────────────────────┬─────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────────────┐
│ 报表层                                                                   │
│  Report_Template.TemplateContent（加密 HTML，ReportPage InitPage 解密） │
│  SktMesGrid → uspEquipmentOEEReport → uspCommonPage → vwEquipmentOEE    │
│  导出 Excel：ReportPage.aspx PostBack → Report.GetDataTableToExcel       │
│  下钻1：showPage(...,1) → uspGetCollectionEngelDataHistoryReport        │
│         （当天 vwCollectionEngelDataHistory / 历史 ALL 视图）            │
│  下钻2：showPage(...,0) → uspGetEquipmentShiftStatusTimeReport          │
│         → vWGetEquipmentShiftStatusTime（班次状态时长）                 │
└─────────────────────────────────────────────────────────────────────────┘
```

### 2.1 Job（179 实测）

| Job | 步骤命令 | 库 | 频率 | 与 OEE 关系 |
|---|---|---|---|---|
| 注塑机台数据自动预警 | `exec Proc_InsertOver5MinutesEquipmentData` | **LeanMes_Test** | 每 30 秒 | 扫 `LastUpdateTime>5min` → 插 `EquipmentStatusRecord`（见 §6 缺陷） |
| 自动发送注塑生产应急邮件 | `uspInjectionMoldingAutoSendEmail` | LeanMes_Test | — | 停机应急，旁路 |
| 开立标准出货自动获取 / 同步销售退回 | ERP 类 | LeanMes_Test | — | 无关 |
| （144 有、179 无）自动插入设备采集当前状态 | `uspAutoInsertEquipmentStatusCollectionCurrentJob` | — | 原约 00:10 / 注释写每 3 分钟 | **补 `Prod_EquipmentStatusCollectionCurrent` 缺机行** — **179 未挂 Job** |
| （144 有、179 无）定时执行设备状态变更时间等 | — | — | — | 状态时长链路在 179 可能不完整 |

> 注意：业务 Job 的 `database_name=LeanMes_Test`，与生效库 `PROD_TEST_MES` 不一致，存在“跑错库/跑空”风险。

---

## 3. 数据表字典（OEE 相关）

### 3.1 采集与快照

| 表 | 关键列 | 角色 | 179 规模 |
|---|---|---|---|
| **Prod_CollectionEngelDataHistory** | HisDataId PK; CollectionDate/Time varchar; EquipmentCode; **Status varchar**; **ShotCounter varchar**; PerformanceTest; OrderNo/MouldCode/MoldCavity; CreateDateTime | **ShotCounter 时序主源**；明细下钻 | **10,264,155**；仅 PK 聚簇 |
| **Prod_CollectionEngelData** | DataId PK; 同上字段 + UpdateDateTime | 每机最新快照；判“通讯中断”用 `UpdateDateTime` | 37 |
| Prod_EquipmentCollectionHistory | Hid; ParamterStr/Val | 原始报文审计 | 自清理 >1000 万截 5 万 |
| Prod_EquimentOrderPord | OrderNo, EquipmentCode, WorkDate, Qty, TotalRunTime/Stop | 工单维度 Shot 增量与运行时长 | — |

**Status 分布（History 全表）**：`4:3.59M, 1:3.29M, 0:2.41M, 2:0.94M, 3:24k, 7:1k, …`  
采集注释（`uspEquimentCollection`）：`@32000` → **0=停机 3=半自动 4=全自动**；与 `Basal_EquipmentStatus`（1=生产 2=换模 3=调试…）**不是同一套码表**，线上视图却把 `1,4` 当生产——语义必须对齐（见 §6）。

### 3.2 状态与产量

| 表 | 关键列 | 角色 |
|---|---|---|
| **Prod_EquipmentStatusCollectionCurrent** | MachineCode, WorkDate, **CurrentStatus**, **TotalRuntime**, TotalWait, TotalStop, LastUpdateTime | 线上视图 TimeRate/OEE 的运行时长来源；7,514 行 |
| Prod_EquipmentStatusData | WorkDate, MachineCode, CurrentStatus, TotalRuntime/Stop, LastUpdateTime | 日状态累计；`uspToalEquRunTime` 维护；管理状态关联 |
| Prod_EquipmentStatusCollectionData | WorkDate, MachineCode, Status, **ATotalRuntime/BTotalRuntime** | 白班/晚班分状态时长；明细下钻 |
| Prod_EquipmentDayProd (+Dtl) | WorkDate, EquipmentCode, OkQty, NgQty | 良品/不良（OEE 质量因子）；`uspCollectionEquipmentProd` 写入 |
| Basal_EquipmentStatus | StatusId, StatusDesc | 管理状态字典（生产/换模/调试/故障…） |
| Basal_ExtensionFields + Basal_Equipment_Ext + Basal_Equipment | ExtFieldValue=机器编码(如 225086) | 设备主数据；视图驱动行集 TbEqu |
| EquipmentStatusRecord | EquipmentCode, CreateDate | 断流告警记录表 |

### 3.3 报表配置

| 对象 | 说明 |
|---|---|
| Report_Template | TemplateContent 为 **NText 加密 HTML**；`Report_GetTemplate` / `ReportPage.InitPage` 解密渲染 |
| 菜单/模板名 | 源码模板 `m03OEEReport_template.txt` 标题 “**E01 设备OEE报表**”；用户侧称 **M03** — 以库内 TemplateId/GUID 为准绑定 |

---

## 4. 视图逻辑

### 4.1 线上 `vwEquipmentOEE`（179 当前，len=4494）

```
WorkDate, ExtFieldValue(机器码), EquipmentCode,
CTTime = PCE.PerformanceTest,
OkQty/NgQty = PED.*（PCE 无行则强制 0）,
Status =
  PES.MachineCode IS NULL → '离线中'
  ELSE PES.CurrentStatus IN (1,4) → '生产中'
  ELSE DATEDIFF(MINUTE, PCE.UpdateDateTime, GETDATE()) > 5 → '通讯中断'
  ELSE '非生产中'
TimeRate = PES.TotalRuntime / (当天已过秒 or 86400) * 100
OEE      = PES.TotalRuntime/86400 * OkQty/(OkQty+NgQty) * 100
TotalRuntime / TotalStopTime = 格式化秒
CurrentStatusdManger = BES.StatusDesc（管理状态）
tQty = EOQ.tQty（工单口径开合模数）
FROM TbEqu
  LEFT JOIN Prod_CollectionEngelData PCE          ON EquipmentCode=ExtFieldValue
  LEFT JOIN Prod_EquipmentStatusCollectionCurrent PES ON MachineCode=ExtFieldValue
  LEFT JOIN Prod_EquipmentDayProd PED             ON EquipmentCode AND WorkDate=PES.WorkDate
  LEFT JOIN Prod_EquipmentStatusData PESD         ON MachineCode=EquipmentCode AND WorkDate=PES.WorkDate
  LEFT JOIN Basal_EquipmentStatus BES             ON StatusId=PESD.CurrentStatus
  LEFT JOIN vwEquipmentOutQty EOQ                 ON EquipmentCode=ExtFieldValue AND WorkDate=PES.WorkDate
```

**与核心诉求的差距**：

1. **生产中**只看 `CurrentStatus∈(1,4)`，**不看 ShotCounter 是否增加**。  
2. 机台 Status=0/2 但 Shot 在涨 → 线上可能显示非生产/通讯中断。  
3. `tQty` 是工单模穴×数量，**不是机台开关模次**。  
4. OEE 分母固定 86400（当天也按全天折算会偏低，TimeRate 当天用已过秒，**两者口径不一致**）。  
5. `PES` **未过滤 WorkDate=今天**（注释：lei.yu 20251229 注释获取当天）→ 可能 join 到历史日的 Current 行语义混乱（取决于 Current 是否只保留当天）。

### 4.2 新版 `DataSql/vwEquipmentOEE_new.sql`（未上线，len 仓库版完整）

实现与核心诉求一致的 **ShotCounter 差分区间法**：

```sql
HistoryWithLag:
  LAG(Status/Shot/CreateDateTime) OVER (PARTITION BY EquipmentCode, WorkDate ORDER BY CreateDateTime)

Intervals:
  DATEDIFF(SECOND, PrevTime, CreateDateTime) BETWEEN 1 AND 300   -- 丢弃 >300s 空洞
  CASE
    WHEN PrevStatus IN ('1','4')                    THEN 'Prod'      -- 上一段状态为生产
    WHEN PrevStatus IN ('0','2') AND Shot = PrevShot THEN 'Standby'  -- 状态停/待 且模数不变
    WHEN PrevStatus IN ('0','2') AND Shot <> PrevShot THEN 'CommInt' -- 状态停/待 但模数变了
    ELSE 'Other'
  END

StatusSums → ProdSec / StandbySec / CommSec
TimeCalc:
  OfflineSec = 86400 - Prod - Standby - Comm
  TotalProductionTime / TotalStandbyTime / TotalDowntime(Comm+Offline)
LatestStatus: 当日最后一条 → Running / Standby / CommInt（按 Shot vs PrevShot）
TimeRate = ProdSec / (当天已过秒 | 86400) * 100
OEE      = ProdSec/86400 * OkQty/(OkQty+NgQty) * 100
tQty     仍来自 vwEquipmentOutQty（未改成 ShotCounter 累计）
```

**该设计对核心诉求的覆盖与缺口**：

| 诉求点 | new 视图 |
|---|---|
| Shot 增加 → 生产 | **仅当 PrevStatus∈(0,2)** 时用 Shot 判 CommInt vs Standby；**PrevStatus∈(1,4) 无条件算 Prod**（Shot 不涨也记生产时长） |
| Shot 不涨 → 非生产 | 状态为 1/4 时 **不检查** Shot → **状态谎报生产时会虚高稼动** |
| 计数器清零/换模归零 | `Shot <> PrevShot` 即算变化 → **减小也被当作“在动”** → 可能误判 CommInt |
| varchar→bigint | 已 CAST；非数字会炸（需 TRY_CAST） |
| 性能 | 全表 History 双扫 + 无业务索引 → **1026 万行必超时风险极高** |

### 4.3 `vwEquipmentOutQty`

```sql
SUM(MoldCavity * Qty) AS tQty   -- 报表列名「开合模数/实际产品数」
FROM Prod_EquimentOrderPord
JOIN Prod_Order / Basal_MoldFixtureItem
GROUP BY EquipmentCode, WorkDate
```

工单计划口径，**不能**代替机台 ShotCounter。

### 4.4 并行版本（收敛前禁止混用）

`vwEquipmentOEE` / `_20250909` / `_20251118` / `_byOperationPlatform` / `vwEquipmentOEETest`  
`uspEquipmentOEEReport` / `_20251118`  
179 与 144 上述对象 **定义不同**（compare_procs）。

---

## 5. 存储过程与前端

### 5.1 `uspEquipmentOEEReport`（线上）

- 参数：`@ExtFieldValue,@EquipmentCode,@WorkStartDate,@WorkEndDate,@Status,@PageSize,@PageIndex,@TotalCount OUTPUT`
- 动态拼接 WHERE 后 `EXEC uspCommonPage @TableName='vwEquipmentOEE', @Flag=2`
- 输出列别名：日期/设备编码(超链接 showPage type=1)/机器编码/良品数/不良数/状态/运行总时长/停机总时长/设备时间稼动率/综合稼动率/**开合模数**/管理状态(type=0)
- **缺陷**：
  1. **SQL 拼接注入**（Like/日期未参数化）  
  2. 日期条件：`AND WorkDate>=@s ... OR WorkDate='1900-01-01'` **无括号**，依赖 `1=1 AND … OR …` 优先级，极脆弱  
  3. `@Status` 直接等值匹配视图 Status 中文（生产中/非生产中/通讯中断/离线中），与模板下拉一致，但与机台原始 Status 码无关  
  4. 若切换 `vwEquipmentOEE_new`，字段名需同步：`TotalProductionTime/TotalStandbyTime/TotalDowntime` ≠ 当前 SP 输出的 `TotalRuntime/TotalStopTime`

### 5.2 明细 SP

| SP | 数据源 | 说明 |
|---|---|---|
| uspGetCollectionEngelDataHistoryReport | 当日 `vwCollectionEngelDataHistory`（CollectionDate=今天）；非今日切 `vwCollectionEngelDataHistoryALL` | 列含 ShotCounter=开合模次；**PRINT 拼接 SQL** 残留 |
| uspGetEquipmentShiftStatusTimeReport | `vWGetEquipmentShiftStatusTime` | 班次×管理状态时长（生产/换模/调试…） |
| uspCommonPage | 通用分页 | READ UNCOMMITTED |

### 5.3 采集与状态 SP

| SP | 职责 |
|---|---|
| **uspEquimentCollection** | 解析 EUROMAP 参数；UPSERT 当前+INSERT History；工单 Qty+=ΔShot；历史报文清理 |
| uspEquimentCollection_250908 / HMG / HT… | 品牌变体 |
| uspCollectionEquipmentProd | 累加 DayProd Ok/Ng |
| uspToalEquRunTime | 按 LastStatus 累加 TotalRuntime/Stop；写 StatusData + 班次 CollectionData |
| uspEquipmentStatusEdit | 人工改状态：改 InjectionStatus → EXEC uspToalEquRunTime → UPDATE StatusData.CurrentStatus |
| uspAutoInsertEquipmentStatusCollectionCurrentJob | 当天缺机 INSERT Current；>5min 的行 `TotalStop+=间隔` 并刷新 LastUpdateTime |
| Proc_InsertOver5MinutesEquipmentData | 断流→EquipmentStatusRecord（逻辑有 bug，见下） |

### 5.4 前端模板要点（`m03OEEReport_template.txt`）

- 查询：起止日期、设备编码、机器编码、状态（生产中/非生产中/通讯中断）  
- 自动查询：`timeout=10` 秒轮询  
- 列：`实际产品数` **name=`开合模数`** ← 绑的是视图 `tQty`  
- 明细弹层 40+ 列来自 History 采集字段  

---

## 6. 问题清单（按优先级）

### P0 — 结果正确性 / 与核心诉求不符

1. **线上未启用 ShotCounter 判产**  
   核心诉求停留在 `vwEquipmentOEE_new.sql`，179 线上仍是状态码+UpdateDateTime 方案。  
2. **状态码两套语义混用**  
   机台 `@32000`：0/3/4…；`Basal_EquipmentStatus`：1生产/2换模…；视图 `IN(1,4)` 既像管理状态又像“全自动”。History 中 0/1/2/4 高分布，需一张**明确映射表**。  
3. **新视图逻辑仍不满足“必须 Shot 增加才算生产”**  
   - PrevStatus∈(1,4) → 无条件 Prod  
   - Shot 下降（换模清零）≠ 增加 → 会误判  
   - 建议：`Prod` 条件改为 `Shot > PrevShot`（或 ΔShot≥1）与状态**与**关系；下降单独标记 `Reset`  
4. **`Proc_InsertOver5MinutesEquipmentData` 逻辑错误**  
   `WHERE NOT EXISTS (... 当天任意一条记录 ...)` **未关联 EquipmentCode** + `TOP 1` → **全天最多只插 1 行**，告警漏设备。  
5. **179 未挂载状态 Current 补全 Job**  
   `uspAutoInsertEquipmentStatusCollectionCurrentJob` 存在但无 Job → 缺机行导致“离线中/TimeRate=0”。  
6. **Job 库名 `LeanMes_Test` ≠ `PROD_TEST_MES`**  
   采集/预警可能打到错误库。  

### P1 — 性能

7. **History 1026 万行无业务索引**  
   必建：  
   ```sql
   CREATE NONCLUSTERED INDEX IX_CEHistory_Eq_Date
     ON Prod_CollectionEngelDataHistory (EquipmentCode, CreateDateTime)
     INCLUDE (Status, ShotCounter);
   ```
   新版视图 LAG 全表分区扫描否则不可接受。  
8. **视图内多次聚合 History**（HistoryWithLag + LatestStatus 又扫一遍 + GROUP BY MAX）→ 应物化或先按日过滤。  
9. `ShotCounter/Status/日期` 全是 varchar → 排序/转换贵；建议影子列 `Shot BIGINT, Status TINYINT, WorkDate DATE, Ts DATETIME`。  
10. 通用分页每次 COUNT+页数据双扫视图；OEE 结果可**按日预聚合表**。  

### P2 — 工程与安全

11. `uspEquipmentOEEReport` 字符串拼接 SQL（注入）。  
12. 日期 OR 条件无括号。  
13. OEE 与 TimeRate 分母口径不一致（86400 vs 当天已过秒）。  
14. 5 个 OEE 视图 + 2 个报表 SP 并行，144/179 定义漂移。  
15. 明细 SP `PRINT SELECT ...` 残留。  
16. History `CollectionTime` 为 varchar 114 格式，排序脆弱。  
17. 空洞 `>300s` 整段丢弃 → Offline 被高估、生产被低估（若采集周期≈3s，5 分钟断网应算 Offline，但 1–300 外直接不算区间，Last 前空洞未闭合）。  

---

## 7. 优化建议（可落地）

### 7.1 业务口径（先定规则，再改码）

推荐 **“生产 = 窗口内 ΔShot≥1”**，状态仅作辅助/原因分类：

```
对每台机、每个采集间隔 [t0,t1]：
  ΔShot = Shot1 - Shot0   （TRY_CONVERT BIGINT）
  若 ΔShot >= 1 或 (ΔShot < 0 且 间隔很短) → Reset/换模，单列
  若 ΔShot >= 1 → 计入 ProdSec（即使 Status=0）
  若 ΔShot = 0 且 Status ∈ 生产类 → 计入 FakeRun（状态说生产、模不动）→ 单独告警列
  若 ΔShot = 0 且 Status ∈ 停机类 → StandbySec
  间隔 > T_gap(如 60s) 且无新样本 → OfflineSec
  当前状态：
    最近 1 个采集周期内 ΔShot≥1 → Running
    有样本、ΔShot=0、停机码 → Standby
    最近 N 分钟无样本（PCE.UpdateDateTime / History.CreateDateTime）→ CommInt/Offline
```

OEE：

```
时间稼动率 = ProdSec / 计划生产时间（班次日历，而非盲目 86400）
性能       = 理论节拍×总模次 / ProdSec   （有 CycleTimeSetValue/PreviousCycleTime 可算）
质量       = Ok / (Ok+Ng)
OEE        = A × P × Q   （当前实现实为 A×Q，缺 P，名称“综合稼动率”名不副实）
```

`tQty` 列建议拆成两列：`计划模穴数产量(vwEquipmentOutQty)` + **`机台累计开关模次(ShotCounter差分)`**。

### 7.2 对象改造顺序（建议）

| 步骤 | 动作 | 说明 |
|---|---|---|
| 1 | 加索引 + （可选）History 影子列 | 先保查询能跑 |
| 2 | 重写 `vwEquipmentOEE_new` 为 Shot 优先规则 + TRY_CAST + 状态映射 | 见 §7.1 |
| 3 | 新建预聚合表 `Fact_EquipmentOEE_Daily`（按日/机：ProdSec, StandbySec, OfflineSec, ShotDelta, Ok, Ng, A, P, Q, OEE） | Job 每 5 分钟或采集 SP 后增量更新 |
| 4 | `uspEquipmentOEEReport` 改参数化查询，读预聚合表；输出字段与 new 视图对齐 | 去掉注入与 OR 优先级问题 |
| 5 | 修复 `Proc_InsertOver5MinutesEquipmentData`：按设备 `NOT EXISTS (… AND EquipmentCode=O.MachineCode)`，去掉错误 TOP1 | |
| 6 | 179 挂回 Current 补全 Job；Job `database_name` 改为 `PROD_TEST_MES` | |
| 7 | 灰度：视图名切换或 SP 内 `@TableOrViewName` 配置化；旧视图归档 `_bak` | |
| 8 | 收敛 5 个 OEE 视图/2 个 SP 为唯一生产版本 | 与迁移清单一致 |

### 7.3 预聚合表示意

```sql
CREATE TABLE dbo.Fact_EquipmentOEE_Daily (
  WorkDate        DATE NOT NULL,
  EquipmentCode   VARCHAR(50) NOT NULL,   -- Basal_Equipment
  MachineCode     VARCHAR(100) NOT NULL,  -- ExtFieldValue
  ShotStart       BIGINT NULL,
  ShotEnd         BIGINT NULL,
  ShotDelta       BIGINT NULL,            -- 今日开关模增量（处理跨夜清零）
  ProdSec         INT NOT NULL DEFAULT 0,
  StandbySec      INT NOT NULL DEFAULT 0,
  FakeRunSec      INT NOT NULL DEFAULT 0, -- 状态生产但 Shot 不动
  OfflineSec      INT NOT NULL DEFAULT 0,
  OkQty           INT NOT NULL DEFAULT 0,
  NgQty           INT NOT NULL DEFAULT 0,
  TimeRate        DECIMAL(18,2) NULL,
  PerfRate        DECIMAL(18,2) NULL,
  QualRate        DECIMAL(18,2) NULL,
  OEE             DECIMAL(18,2) NULL,
  LastSampleAt    DATETIME NULL,
  ModifyAt        DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_Fact_EquipmentOEE_Daily PRIMARY KEY (WorkDate, MachineCode)
);
```

报表直接 `SELECT … FROM Fact_EquipmentOEE_Daily WHERE WorkDate BETWEEN @s AND @e`，彻底摆脱 1026 万行 LAG。

### 7.4 采集侧（可选增强）

- History 插入时写入 `Shot BIGINT`（TRY_CONVERT）、`Status TINYINT`、`Ts DATETIME`。  
- 采集周期与 `CreateDateTime` 用 `datetime2`，避免 varchar 时间。  
- `Prod_CollectionEngelData.UpdateDateTime` 作为通讯心跳；视图统一只用它判 CommInt。  
- 换模/清零：当 `Shot < PrevShot` 且 Δ| |合理时记 Reset，不计入 FakeRun/CommInt。  

### 7.5 验证 SQL（改造后回归）

```sql
-- 1) 某日某机：Shot 是否单调、增量是否与明细一致
SELECT EquipmentCode, CAST(ShotCounter AS BIGINT) s, CreateDateTime
FROM Prod_CollectionEngelDataHistory
WHERE EquipmentCode='225086' AND CAST(CreateDateTime AS DATE)='2026-01-10'
ORDER BY CreateDateTime;

-- 2) 状态说生产但 Shot 不动的时长（应≈FakeRunSec）
-- 3) TimeRate/OEE 与手算 ProdSec 对比
-- 4) 预聚合 vs 新视图 同日 diff
```

---

## 8. 对象清单速查

| 类型 | 对象 | 线上角色 |
|---|---|---|
| 报表模板 | Report_Template（m03/E01 OEE HTML） | UI |
| SP | uspEquipmentOEEReport (+_20251118) | 主查询 |
| SP | uspCommonPage | 分页 |
| SP | uspGetCollectionEngelDataHistoryReport | 采集明细下钻 |
| SP | uspGetEquipmentShiftStatusTimeReport | 班次状态下钻 |
| 视图 | **vwEquipmentOEE**（线上旧）/ **vwEquipmentOEE_new.sql**（未上线） | OEE 源 |
| 视图 | vwEquipmentOutQty | 工单口径 tQty |
| 视图 | vwCollectionEngelDataHistory / ALL | 明细 |
| 视图 | vWGetEquipmentShiftStatusTime | 班次 |
| 表 | Prod_CollectionEngelData(History) | Shot/Status 源 |
| 表 | Prod_EquipmentStatusCollectionCurrent | 运行时长/当前状态 |
| 表 | Prod_EquipmentStatusData / CollectionData | 日/班次状态 |
| 表 | Prod_EquipmentDayProd | Ok/Ng |
| 表 | Prod_EquimentOrderPord | 工单 Shot 累计 |
| SP写 | uspEquimentCollection / uspToalEquRunTime / uspEquipmentStatusEdit / uspCollectionEquipmentProd | 写入链 |
| SP写 | uspAutoInsertEquipmentStatusCollectionCurrentJob | Current 补行（179 无 Job） |
| Job | 注塑机台数据自动预警 → Proc_InsertOver5MinutesEquipmentData | 断流（有 bug） |
| 代码 | Report/ReportPage.aspx.cs, DLL/Report/BLL/Template.cs | 模板解密与导出 |
| 代码 | DataSql/m03OEEReport_template.txt | 模板源 |

---

## 9. 已执行修复（2026-09-23）

### 9.1 空列根因与别名修正（已完成）

| 项 | 结论 |
|---|---|
| 根因 | 线上模板 2230/2249/2251 `name` 仍绑旧别名；迁移后的 144 版 `uspEquipmentOEEReport` 分页分支输出新别名 → grid 列空白 |
| 修正 | `DataSql/OEE_179_Fix_Aliases.sql`：重建 179 `uspEquipmentOEEReport`，分页/导出分支别名对齐模板 |
| 映射 | `外部编码→机器编码`；`正常生产总时长→运行总时长`；`设备生产稼动率→设备时间稼动率`；`综合稼动率OEE→综合稼动率`；`停机总时长←TotalStopTime` |
| 回验 | 模板 12 列与 SP 输出 **codepoint 全匹配**（见 `oee_aliasfix_verify4.txt`）；主表有数据行 |
| 同步 | `Migrate_OEE_144_to_179.sql` 内 `@Fields` 已同步为同一别名口径 |
| 备份 | 修正前定义：`DataSql/OEE_179_BAK/179_uspEquipmentOEEReport_pre_aliasfix_*.sql` |

**仍空/为 0 的列**：非别名问题，属 **179 采集停更**（状态=通讯中断、Ok/Ng/tQty=0、TimeRate=0%）。已选方案：从 144 拷近期数据。

### 9.2 从 144 拷近期数据（已完成）

| 项 | 结果 |
|---|---|
| 窗口 | 近 14 天（`WorkDate >= today-14`） |
| 已拷表 | `Prod_EquipmentStatusCollectionCurrent` 480；`Prod_EquipmentDayProd` 391；`Prod_EquipmentStatusData` 482；`Prod_EquimentOrderPord` 840；`Prod_CollectionEngelData` 37（心跳已刷 `UpdateDateTime=GETDATE()`） |
| 脚本 | `oee_copy_run.ps1` / `oee_copy_run.txt`（SqlBulkCopy + KeepIdentity） |
| 回验 | 当日 Ok≈51101 / Ng≈365；视图每日 32 台无扇出；`生产中/在线未生产`、`运行总时长`/`设备时间稼动率`/`综合稼动率`/`开合模数` 均非 0；SP `TotalCount=32` |
| 视图修复 | `OEE_179_fix_view_fanout.sql`：`Prod_EquimentOrderPord` 改为按 `(EquipmentCode,WorkDate)` **SUM 聚合**再 JOIN，消除同机多行重复（修复前 53 行含扇出） |

**注意**：拷贝只补历史/当日报表数据，本身不恢复 179 实时采集；已另做 144→179 双写（见 §9.3）。

### 9.3 页面列名对齐 144（已完成）

| 项 | 结果 |
|---|---|
| 差异 | 179 曾用新别名（`机器编码/运行总时长/设备时间稼动率/综合稼动率`），144 线上模板仍为旧别名（`外部编码/正常生产总时长/设备生产稼动率/综合稼动率OEE/开合数` 等）→ 两库页面列名不一致 |
| 做法 | **以 144 为准**：将 144 `Report_Template`（GUID `615562BE-…`）密文原样覆盖 179；将 144 `uspEquipmentOEEReport` 定义原样重建到 179 |
| 回验 | 179 主表 `name[]` 与 144 **完全一致**；179 SP 分页分支别名与模板 **COLL_equal=True**；`TMPL_144_eq_179=True`（`verify_align_cols.txt` / `final_verify_dw_cols.txt`） |
| 备份 | 179 修正前模板/SP：`Temp\opencode\bak_179_*`、`OEE_179_BAK\179_uspEquipmentOEEReport_pre_aliasfix_*.sql` |

### 9.4 144→179 实时双写（已完成）

| 项 | 结果 |
|---|---|
| 背景 | 采集程序 `LeanMES.FileMonitor.exe` 仅写 144；179 无独立采集源，`Prod_CollectionEngelData` 心跳停更 |
| 前提 | 144 已有 Linked Server `172.16.5.179`（`rpc out`/`data access`=True），179 侧采集 SP 齐全 |
| 做法 | 在 144 四个采集 SP **末尾**、正式逻辑之后追加 `DualWrite179`：`BEGIN TRY EXEC [172.16.5.179].[PROD_TEST_MES].dbo.<同名SP>(原参数) … END CATCH`（**不带 OUTPUT 回写**，失败只 `PRINT`，不影响 144） |
| 覆盖 SP | `uspEquimentCollection`、`uspEquimentCollection_250908`、`uspEquimentCollectionHMG`、`uspEquimentCollectionHT` |
| 回验 | 连续 3 个采样点：179 `MaxEngel`/`MaxHid` 与 144 **同秒级推进**；`Engel2m=26`、`Equip2m=26` 两侧一致（`live_dw_confirm.txt`） |
| 产物 | `DataSql/OEE_144_DualWrite179/`（定义备份、双写修正脚本、回验日志） |
| 踩坑 | 首版双写 `@EquiCode` 重复传参 → 远程 EXEC 报错被 CATCH 吞掉；已改为单次按值传递并 `dup=False` 回验 |

**效果**：179 不需第二套采集程序即可与 144 **同步拿到注塑机原始报文**（`Prod_EquipmentCollectionHistory` / `Prod_CollectionEngelData` / 状态心跳），设备编码等列可持续有数。

---

## 10. 建议决策（给业务/开发）

1. **是否接受“Shot 增量即生产”覆盖状态码？**（推荐：Shot 为主、状态为辅 + FakeRun 告警）  
2. **计划生产时间用自然日 86400 还是班次日历？**  
3. **OEE 是否要补性能因子 P（理论节拍）？** 当前只有 A×Q。  
4. 确认 179 生效模板 GUID 与标题（M03 vs E01），避免改错模板。  
5. 确认机台 Status 码表与 `Basal_EquipmentStatus` 映射后再上线 new 视图。  

---

*本文依据：179 库 live 对象定义、`DataSql/vwEquipmentOEE_new.sql`、`uspEquipmentOEEReport_BAK_20260917.sql`、`m03OEEReport_template.txt`、`uspEquimentCollection` 全文、Job/索引/行数/状态分布实测；模板解密 `EncryptHelper.Decrypt`；别名回验 `oee_aliasfix_verify4.txt`；列名对齐 `verify_align_cols.txt`/`final_verify_dw_cols.txt`；双写回验 `live_dw_confirm.txt`。*
