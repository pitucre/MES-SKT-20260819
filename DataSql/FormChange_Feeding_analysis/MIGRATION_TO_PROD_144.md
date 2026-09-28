# 迁移计划：粉碎机上料 / 形态转换 候选原料（03/06）

> 测试环境：`172.16.5.179` / `PROD_TEST_MES`（已实施）  
> 目标正式库：`172.16.5.144`（库名以现场为准，下称 `<PROD_DB>`）  
> 归档目录：`DataSql\FormChange_Feeding_analysis\`

## 1. 变更清单

### 1.1 数据库

| 类型 | 对象 | 说明 |
|---|---|---|
| 表 | `Prod_SrapFeeding` | 新增列 `MaterialPartNumberCode VARCHAR(50) NULL` |
| 新建 SP | `uspGetMaterialCandidates` | 按条码返回 03/06 候选（L1字段+L2工单对应产品BOM+L3工单+L4 ERP）；2026-09-26 增强见 `alter_uspGetMaterialCandidates.sql` |
| 改 SP | `uspFeedingHopperLoadCrusher` | 新增可选参数 `@SelectedMaterial`；多候选校验；写入单头原料 |
| 改 SP | `FeedingHopperCompleteCrusher` | 完成上料优先用单头 `MaterialPartNumberCode` 生成新 GRN |
| 改 SP | `uspFromChangeMesScan` | Flag=0 解析 06 候选；Flag=1 **必须命中候选**否则报错；**0 候选时放开为可手动输入**（2026-09-26）；**2026-09-27 按 GRN 来源分叉：`Remark='粉碎机上料生成'` 的条码走新逻辑，其它条码回归生产原版（不解析候选、无 06 限制、同物料/同仓库校验），返回列新增 `IsCrusherGRN`**（备份 `bak_uspFromChangeMesScan_20260927112225.sql`） |
| 改 SP | `uspGetSrapFeedingDtl` | 优先返回单头所选原料 |

对应脚本（同目录）：

- `alter_Prod_SrapFeeding_add_MaterialPartNumberCode.sql`
- `uspGetMaterialCandidates.sql`（CREATE，已含 2026-09-26 产品BOM 增强）
- `alter_uspGetMaterialCandidates.sql`（仅当正式库已存在 09-24 旧版时执行；备份 `bak_uspGetMaterialCandidates_20260926154834.sql`）
- `alter_uspFeedingHopperLoadCrusher.sql`
- `alter_FeedingHopperCompleteCrusher.sql`
- `alter_uspFromChangeMesScan.sql`
- `alter_uspGetSrapFeedingDtl.sql`

### 1.2 代码（需随库一起发布）

| 文件 | 变更 |
|---|---|
| `DLL\...\FeedingHopperCrusherBLL.cs` | `GetMaterialCandidates`；`FeedingHopperLoadCrusher(..., SelectedMaterial)` |
| `DLL\...\FormChangeByMES.cs` | `GetMaterialCandidates` |
| `Code\Web\AjaxServices\Client\AjaxFeedingHoppeCrusher.cs` | 新 Ajax 方法 |
| `Code\Web\AjaxServices\Client\AjaxFromChangeByMES.cs` | 新 Ajax 方法 |
| `Code\Web\MobileApp\FeedingHopperCrusher.aspx` | 扫码先查 03 候选，多条下拉选择后上料 |
| `Code\Web\MobileApp\FormChangeByMES.aspx` | 扫码后加载 06 候选面板；`CheckItemlist` 取料号；**0 候选时切换为手动输入粉碎料**（回车或【入明细】提交）；**转换后数量可编辑**（默认带出条码余额，可改填重量，须>0）；**按返回的 `IsCrusherGRN` 切模式**：非粉碎机条码显示原版「选择物料」输入框+面板（`GetItemCode` 自由搜料、数量手工填不带余额），粉碎机条码维持下拉/手动输入 |

> 页面 code-behind 无需改（Ajax 类型已注册）。

### 1.3 L4 前置条件（正式库）

正式 MES 需能访问 U9 链接服务器。测试库已有：

```sql
-- 数据源 172.16.5.155 → 库名 001
[172.16.5.155].[001].dbo.MO_MOPickList
[172.16.5.155].[001].dbo.MO_MO
[172.16.5.155].[001].dbo.CBO_ItemMaster
```

若 `172.16.5.144` 无同名链接服务器，需先创建（名称必须为 `172.16.5.155` 或同步改 SP 中四段名）：

```sql
EXEC sp_addlinkedserver
  @server = N'172.16.5.155',
  @srvproduct = N'',
  @provider = N'SQLNCLI',
  @datasrc = N'172.16.5.155';
EXEC sp_addlinkedsrvlogin
  @rmtsrvname = N'172.16.5.155',
  @useself = N'false',
  @rmtuser = N'sa',
  @rmtpassword = N'***';
```

> L4 在 SP 内 TRY/CATCH，**链接不可用时自动跳过**，不影响 L1–L3。

---

## 2. 迁移步骤（建议窗口）

### 步骤 0：备份（强制）

在 **172.16.5.144 / \<PROD_DB\>** 执行，输出保存为 `bak_<对象>_<yyyyMMddHHmmss>.sql`：

```sql
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspFeedingHopperLoadCrusher'));
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspGetSrapFeedingDtl'));
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.FeedingHopperCompleteCrusher'));
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspFromChangeMesScan'));
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspGetItem'));
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Prod_SrapFeeding';
```

若 `uspGetMaterialCandidates` 已存在，一并备份其定义。

### 步骤 1：改表

```sql
-- 脚本: alter_Prod_SrapFeeding_add_MaterialPartNumberCode.sql
IF COL_LENGTH('dbo.Prod_SrapFeeding', 'MaterialPartNumberCode') IS NULL
    ALTER TABLE dbo.Prod_SrapFeeding ADD MaterialPartNumberCode VARCHAR(50) NULL;
```

### 步骤 2：新建候选 SP

```sql
-- 脚本: uspGetMaterialCandidates.sql（CREATE，已含 2026-09-26 产品BOM 增强）
-- 若正式库已存在同名对象（09-24 旧版），先导出备份再执行 alter_uspGetMaterialCandidates.sql
```

### 步骤 3：按序改 4 个 SP

1. `alter_uspFeedingHopperLoadCrusher.sql`
2. `alter_FeedingHopperCompleteCrusher.sql`
3. `alter_uspFromChangeMesScan.sql`
4. `alter_uspGetSrapFeedingDtl.sql`

> 脚本头部注释为 `ALTER PROCEDURE`，可重复执行；`CREATE PROCEDURE` 仅用于首次。

### 步骤 4：验证 SQL

```sql
-- 应返回 ≥1 行 03/06
EXEC dbo.uspGetMaterialCandidates '<正式库真实GRN>', '03';
EXEC dbo.uspGetMaterialCandidates '<正式库真实GRN>', '06';

-- 验收点：粉碎机上料产出的 SL 条码，06 必须能取到“产品BOM”中的粉碎料（Source=L2）
EXEC dbo.uspGetMaterialCandidates '<正式库真实SL条码>', '06';
-- 测试库基准: SL2609260003 → 0601-00017, 0601-00018（均 L2）

-- 06 候选为 0 的条码（2026-09-26 增强）：Flag=0 不报错、返回 CandidateCount=0
EXEC dbo.uspFromChangeMesScan '', '<0候选条码>', '', 0, 0, '<操作员>';
-- 预期: CandidateCount=0, ConvertedMaterial=''
-- Flag=1 手动输入: 06开头+存在于 Basal_Item → 放行；否则报错；候选>0 时仍必须命中候选
EXEC dbo.uspFromChangeMesScan '', '<0候选条码>', '0601-00017', 1, 1, '<操作员>';  -- 成功
EXEC dbo.uspFromChangeMesScan '', '<0候选条码>', '0699-99999', 1, 1, '<操作员>';  -- 报错: 不存在
EXEC dbo.uspFromChangeMesScan '', '<0候选条码>', '0301-00017', 1, 1, '<操作员>';  -- 报错: 非06

-- 按 GRN 来源分叉（2026-09-27）
-- ① 粉碎机上料生成的条码（Remark='粉碎机上料生成'）
EXEC dbo.uspFromChangeMesScan '', '<粉碎机SL条码>', '', 0, 0, '<操作员>';
-- 预期: IsCrusherGRN=1，按候选回填/下拉；CandidateCount>0
-- ② 其它来源条码（Remark<>该值）
EXEC dbo.uspFromChangeMesScan '', '<普通GRN>', '', 0, 0, '<操作员>';
-- 预期: IsCrusherGRN=0, ConvertedMaterial='', CandidateCount=0（前端切「选择物料」面板）
EXEC dbo.uspFromChangeMesScan '', '<普通GRN>', '0301-00018', 1, 1, '<操作员>';
-- 预期: 放行（生产原版无 06/候选校验）；同单扫不同转换前物料 → 报"只能扫描同一物料的条码!"

-- 参数签名含 @SelectedMaterial（默认 NULL，旧调用兼容）
SELECT p.name FROM sys.parameters p
WHERE p.object_id = OBJECT_ID('dbo.uspFeedingHopperLoadCrusher');
```

> 本目录脚本为 UTF-8（含中文、LF 换行），sqlcmd 执行必须加 `-f 65001`，否则被按 GBK 解码导致整段不执行（exit=0、无输出、`modify_date` 不变）。

### 步骤 5：发布代码

1. 编译 `ProductionCollection` + `Web`（完整 VS 环境）。
2. 替换正式站点：
   - `SKT.LeanMES.ProductionCollection.dll`（及 `Code\Lib` / 站点 `bin`）
   - `Web.dll`（若 Ajax 在其中编译）
   - `MobileApp\FeedingHopperCrusher.aspx`
   - `MobileApp\FormChangeByMES.aspx`
3. 回收应用程序池 / 重启站点。

### 步骤 6：业务冒烟

| 场景 | 预期 |
|---|---|
| 粉碎机扫 GRN，候选 1 条 | 直接上料成功 |
| 候选 >1 条 | 下拉选择后回车才上料 |
| 不选直接提交 | 报「有多个候选原料，请先选择原料」 |
| 选错 03 | 报「不在候选原料中」 |
| 完成上料 | 新 GRN 料号 = 单头 `MaterialPartNumberCode` |
| 形态转换扫 GRN，06 候选 0 条 | 报错「未找到 06 粉碎料候选」 |
| 06 候选 >1 | 面板列出候选，选定后可确认 |
| 确认时传入非候选 06 | 强校验失败 |

---

## 3. 回滚

1. 用步骤 0 的备份恢复 4+1 个 SP 定义（`CREATE`/`ALTER` 回原体）。
2. 若需回滚表列（谨慎，可能丢已写入的单头原料）：

```sql
ALTER TABLE dbo.Prod_SrapFeeding DROP COLUMN MaterialPartNumberCode;
```

3. 回滚 DLL / aspx 到上一版本。
4. `uspGetMaterialCandidates` 可 `DROP PROCEDURE`（确认无其它引用）。

---

## 4. 测试环境验证记录（2026-09-24）

| 项 | 结果 |
|---|---|
| 加列 `MaterialPartNumberCode` | 成功 |
| `uspGetMaterialCandidates` 03 | `0301-00018`(L2), `0302-00020`(L4) |
| 同 GRN 06 | `0601-00018`(L2), `0602-00020`(L4) |
| Load 不带原料 | 报「有多个候选原料，请先选择原料」 |
| Load 带 `0301-00018` @ SL01 | 成功，单头 `MaterialPartNumberCode=0301-00018`，单号 `SLD2609240001` |
| Load 非法原料 | 报「不在候选原料中」 |
| FromChange Flag=0 多候选 | 返回空 ConvertedMaterial + CandidateCount=2 |
| FromChange Flag=1 非法 06 | 强校验失败 |
| FromChange Flag=1 合法 06 | 插入成功（事务内验证后回滚语义） |

**测试遗留数据（可选清理）：**

- `Prod_SrapFeeding` 单号 `SLD2609240001`（SL01，状态0，含 GRN260924000001）
- 清理脚本：

```sql
DELETE FROM dbo.Prod_SrapFeedingDtl WHERE SrapFeedingId = 10;
DELETE FROM dbo.Prod_SrapFeeding WHERE SrapFeedingId = 10;
```

（以实际 `SrapFeedingId` 为准。）

## 4.1 测试环境验证记录（2026-09-26）

| 项 | 结果 |
|---|---|
| `uspGetMaterialCandidates` L2 改为「工单对应产品 BOM」（`bak_uspGetMaterialCandidates_20260926154834.sql`） | `modify_date=16:07:26`；`SL2609260003` 06→`0601-00017/0601-00018`(L2) |
| 45 条条码新旧对比 / 上料侧 6 种物料 | 仅补入产品BOM候选与剔除无关工单L3；上料侧结论 SP 不改、并集不扩、多候选不预选 |
| `uspFromChangeMesScan` 0 候选放开（`bak_uspFromChangeMesScan_20260926170613.sql`） | `modify_date=17:09:40`；Flag=0 返回 `CandidateCount=0`，Flag=1 手动 `0601-00017` 成功（回滚） |
| Flag=1 错误分支 | `0699-99999` 不存在 / `0301-00017` 非06 / 有候选选非候选 三类均拒绝 |
| `FormChangeByMES.aspx` 0 候选手动输入 | `node --check` 语法通过，待 VS 编译 + PDA 回归 |

---

## 4.2 测试环境验证记录（2026-09-27，按 GRN 来源分叉）

| 项 | 结果 |
|---|---|
| SP 备份（AGENTS.md 强制） | `bak_uspFromChangeMesScan_20260927112225.sql`（10336 字节） |
| `alter_uspFromChangeMesScan.sql` 应用 | `sqlcmd -f 65001 -b` exit=0；`modify_date=2026-09-27 11:24:45`；`uspFromChangeMesScan.sql`(CREATE) 已同步（11360 字节） |
| 判别字段 | `Prod_MaterialUnit.Remark='粉碎机上料生成'`（仅 `FeedingHopperCompleteCrusher` 写入）；测试库 21 条、`Status=0` 可用 8 条；`SrapFeedingNo<>''` 但非粉碎机且 `Status=0` 的记录 0 条 |
| Flag=0 非粉碎机 `GRN260927000016` | `IsCrusherGRN=0`、`ConvertedMaterial=''`、`CandidateCount=0` |
| Flag=0 粉碎机 `SL2609270007` | `IsCrusherGRN=1`、`CandidateCount=1`、回填 `0601-00018`(L1) |
| Flag=1 非粉碎机 + 非 06 料 | 放行入明细（原版无 06 校验），测试后回滚 |
| Flag=1 粉碎机 + 非 06 料 | 拒绝：`不是 06 开头的粉碎料!` |
| Flag=1 非粉碎机同单不同转换前物料 | 拒绝：`只能扫描同一物料的条码!` |
| Flag=1 粉碎机候选外 06 | 拒绝：`不在条码【SL2609270007】的 06 候选中!` |
| Flag=1 非粉碎机空转换后 | 拒绝：`必须选择转换后粉碎料!`（保留的空值保护） |
| `FormChangeByMES.aspx` 分叉 | `node --check` 通过；标签配平（span 4/4、td 33/33）、无重复 id、BOM `EF-BB-BF`、全 LF；待 VS 编译 + PDA 回归 |
| 测试残留单清理（用户批准） | 备份 `bak_Prod_FromChangeByMES_testResidue_20260927115914.sql` 后删除 `XT2609260001`、`XT2609260012`（`XT2609260007` 已在会话外删除）；`GRN260924000001/SL2609260001/SL2609260004` 已释放（`Status=0`、不在任何单据） |

> 可复测条码：非粉碎机 `GRN260927000016/000015/000012/000009`；粉碎机 `SL2609270007/SL2609260003/SL2609260002/SL2609240001`。

---

## 4.3 三页面并行对比（2026-09-27，@UiMode 参数）

| 页面 | 文件 | 显示名 | 前端调用 | UiMode |
|---|---|---|---|---|
| 原版（生产基线） | `MobileApp/FormChangeByMES.aspx`（git HEAD 还原，824 行，零改动） | 形态转换 / 形态转换MES | 旧方法 `FromChangeMesScanGenerate`（6 参） | 省略 → 默认 **0**（不解析候选、无 06 校验） |
| 不良和料把 | `MobileApp/FormChangeByMES_LB.aspx`（新增） | 不良和料把形态转换页面 | `FromChangeMesScanGenerateEx(..., 1)` | **1**（所有条码都解析 06 候选 = 09-26 行为） |
| 综合 | `MobileApp/FormChangeByMES_All.aspx`（新增） | 形态转换综合页面 | `FromChangeMesScanGenerateEx(..., 2)` | **2**（按 `Remark='粉碎机上料生成'` 分叉） |

- SP `uspFromChangeMesScan` 增末位参数 `@UiMode TINYINT = 0`，`@IsCrusher`：`0→0、1→1、2→按 Remark`。备份 `bak_uspFromChangeMesScan_20260927153513.sql`（12070 字节），应用 `modify_date=2026-09-27 15:36:08`，库定义与 `uspFromChangeMesScan.sql` 逐行一致。
- Web 层新增 `AjaxFromChangeByMES.FromChangeMesScanGenerateEx(..., int UiMode)`（`ComMethod.GetList` 直传 7 个参数）；`Web.csproj` 已登记两个新 aspx；`MenuList.aspx` 加 `Check(167)`/`Check(168)` 入口（测试期免权限可见，测完删）。
- **重新生成 Web 工程后才生效**；`SKT.LeanMES.ProductionCollection.dll`（Lib 预编译）本次未改。
- 三模式回归（事务回滚，残留 0）：粉碎机 `SL2609270008` → 0:`0/0`、1:`2/1`、2:`2/1`；非粉碎机 03 `GRN260825000012` → 0:`0/0`、1:**1候选回填 `0601-00012`**、2:`0/0`。6 参省略 `@UiMode` 的调用已验证可用。
- **正式库决策待定**：三页面 + `@UiMode` 是对比测试用，正式上线只保留其中一个时，需回退 `@UiMode`、删除另外两个 aspx 与菜单项（回滚见 §3）。
- `XT2609270022`（admin 15:03，挂 `GRN260927000015/16`）为测试者本人草稿单，复测前需先删单。

---

## 5. 注意事项

1. **先备份再改**（AGENTS.md 强制）。
2. 本机当前仅有 .NET Framework 4.0 MSBuild / VS18 路径，完整编译需原开发机 VS 环境；`ERP.csproj` 存在与本次无关的既有语法/依赖错误。
3. L4 四段名依赖链接服务器名称 `172.16.5.155`；正式环境名称不同则改 `uspGetMaterialCandidates` 内引用。
4. 旧客户端仍调 3 参 `uspFeedingHopperLoadCrusher` → `@SelectedMaterial` 默认 NULL，兼容。
