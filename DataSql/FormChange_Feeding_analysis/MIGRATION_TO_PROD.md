# 迁移计划：粉碎机上料 / 形态转换 03·06 候选料

> 测试环境已实施：`172.16.5.179` / `PROD_TEST_MES`  
> 目标正式库：`172.16.5.144`（库名以现场为准，下文记为 `<PROD_DB>`）  
> 归档目录：`DataSql\FormChange_Feeding_analysis\`

## 1. 变更摘要

| 类型 | 对象 | 说明 |
|---|---|---|
| 表 | `Prod_SrapFeeding` | 新增列 `MaterialPartNumberCode VARCHAR(50) NULL` |
| 新建 SP | `uspGetMaterialCandidates` | 按条码返回 03/06 候选（L1字段+L2产品BOM+L3工单+L4 ERP，并集去重）；2026-09-26 增强见下 |
| 修改 SP | `uspFeedingHopperLoadCrusher` | 新增可选参 `@SelectedMaterial`；解析/校验 03；写入单头 |
| 修改 SP | `FeedingHopperCompleteCrusher` | 优先用单头 `MaterialPartNumberCode` 生成新 GRN |
| 修改 SP | `uspFromChangeMesScan` | Flag=0 解析 06；Flag=1 强校验必须命中候选；**0 候选时 Flag=0 返回 CandidateCount=0、Flag=1 允许手动输入 06 粉碎料**（2026-09-26）；**2026-09-27 起按 GRN 来源分叉：仅 `Remark='粉碎机上料生成'` 的条码走上述新逻辑，其它来源条码完全回归生产原版（不解析候选、无 06 限制、自由选转换后物料），返回列新增 `IsCrusherGRN`** |
| 修改 SP | `uspGetSrapFeedingDtl` | 优先返回单头所选原料 |
| 代码 | BLL/Ajax/aspx | 候选查询 + 下拉选择；06 无候选可手动输入；**转换后数量可编辑**（转换前=数量、转换后=重量，默认带出条码余额，可改填重量，须>0）；**按 `IsCrusherGRN` 切模式**：`normal`（非粉碎机条码）显示原版「选择物料」面板自由搜料、数量手工填不自动带余额 |

### 候选解析优先级（已确认）
L1 `Basal_Item` 字段 → L2 **工单对应产品的 BOM**（`Basal_ItemBomChild`）→ L3 工单 `Prod_OrderBom` → L4 ERP `MO_MOPickList`  
并集去重，L1 排最前。

> **2026-09-26 增强（`alter_uspGetMaterialCandidates.sql`，备份 `bak_uspGetMaterialCandidates_20260926154834.sql`）**  
> L2 原先只取条码物料自身 `Basal_Item.BomId`：粉碎机上料产出的 SL 条码（如 `SL2609260003`→0301-00017，`BomId=-1`）取不到 BOM → 06 候选为空。  
> 现改为：条码 → `Prod_MaterialUnit.SrapFeedingNo` → `Prod_SrapFeedingDtl.OrderNo`（条码自身在明细中时只取其所属工单，否则取该上料单全部工单）/ `Prod_Unit.ProdOrderID` → 工单 → 产品 → `Basal_Item.BomId` → `Basal_ItemBomChild`；定位不到时反查“产品BOM含本物料”兜底；L4 按工单产品编码查询。  
> 依据：工单BOM 的 06 粉碎料可能随时被删，06 必须以**产品BOM**为准（工单 `S260110B031-1` 无 06，产品 `0201-00337` BOM `1033` 有 `0601-00017/0601-00018`）。  
> 已验证：`SL2609260003` 06→2 条、`uspFromChangeMesScan` Flag=0→`CandidateCount=2`；45 条条码新旧对比仅“补入产品BOM候选”与“剔除无关工单L3”，L1/L2 主路径不变。

> **2026-09-27 按 GRN 来源分叉（`alter_uspFromChangeMesScan.sql`，备份 `bak_uspFromChangeMesScan_20260927112225.sql`）**  
> 判别字段：`Prod_MaterialUnit.Remark = '粉碎机上料生成'`（仅 `FeedingHopperCompleteCrusher` 写入；测试库 21 条，`Status=0` 可用 8 条）。  
> - **粉碎机上料生成的条码**（`IsCrusherGRN=1`）→ 走本需求新逻辑：06 候选走产品 BOM 链路、0 候选可手动输入、Flag=0 回填 1 条候选、Flag=1 强校验。  
> - **其它来源的条码**（`IsCrusherGRN=0`）→ 完全回归**生产原版** `uspFromChangeMesScan`（`172.16.5.144`，2026-03-30 未改）：不解析候选、无 06 开头限制、转换后物料可自由选择；仅保留“同一物料/同一仓库”校验。  
> - 前端 `FormChangeByMES.aspx` 据 `IsCrusherGRN` 切模式：`normal` 显示原版 disabled 输入框 +「选择物料」面板（`GetItemCode` 自由搜料）、`#Qty` 手工填且不自动带余额；`crusher` 维持下拉/手动输入与余额回填。  
> - `uspGetMaterialCandidates` **未改动**（非粉碎机分支不再调用它）；上料侧零改动结论不变。

## 2. 正式库迁移步骤（严格顺序）

### 2.1 迁移前备份（强制）

在 **正式库** 上先导出完整定义到带时间戳文件：

```sql
-- 每个对象执行一次，输出保存为 bak_<对象名>_<yyyyMMddHHmmss>.sql
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspFeedingHopperLoadCrusher'));
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspGetSrapFeedingDtl'));
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.FeedingHopperCompleteCrusher'));
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspFromChangeMesScan'));
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspGetItem'));
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Prod_SrapFeeding' ORDER BY ORDINAL_POSITION;
```

> 若 `uspGetMaterialCandidates` 在正式库已存在（同名覆盖），同样先导出备份。

### 2.2 确认正式库前置条件

1. **链接服务器**：正式 MES 是否已有指向 U9 的链接（测试为 `172.16.5.155`）。  
   若无，先创建，否则 L4 自动跳过（SP 内 TRY/CATCH 已容错）：
   ```sql
   -- 示例（按现场凭据调整）
   EXEC sp_addlinkedserver @server='172.16.5.155', @srvproduct='',
        @provider='SQLNCLI', @datasrc='172.16.5.155';
   EXEC sp_addlinkedsrvlogin @rmtsrvname='172.16.5.155',
        @useself='false', @rmtuser='sa', @rmtpassword='***';
   ```
2. 确认正式 ERP 库名仍为 `001`，表 `MO_MO` / `MO_MOPickList` / `CBO_ItemMaster` 存在。
3. 确认正式库已有 `Prod_OrderBom`、`Basal_ItemBomChild` 数据完整。

### 2.3 执行脚本（与测试同一套文件）

按顺序在 **172.16.5.144 / \<PROD_DB\>** 执行：

1. `alter_Prod_SrapFeeding_add_MaterialPartNumberCode.sql`
2. `uspGetMaterialCandidates.sql`（CREATE，已含 2026-09-26 产品BOM 增强；若正式库已有旧版同名对象，先按 2.1 备份，再执行 `alter_uspGetMaterialCandidates.sql`）
3. `alter_uspFeedingHopperLoadCrusher.sql`
4. `alter_FeedingHopperCompleteCrusher.sql`
5. `alter_uspFromChangeMesScan.sql`
6. `alter_uspGetSrapFeedingDtl.sql`

> `alter_*.sql` 文件头注释中的 Bak 文件名以**正式库备份时间戳**为准，不要沿用测试备份名。

### 2.4 正式库冒烟

```sql
-- 用正式库真实 GRN 替换
EXEC dbo.uspGetMaterialCandidates '<GRN>', '03';
EXEC dbo.uspGetMaterialCandidates '<GRN>', '06';
-- 粉碎机上料产出的 SL 条码：06 必须能取到产品BOM中的粉碎料（本次增强验收点）
EXEC dbo.uspGetMaterialCandidates '<SL条码>', '06';   -- 预期: >=1 条, Source=L2

-- 06 候选为 0 的条码：Flag=0 不报错并返回 CandidateCount=0，前端切手动输入
EXEC dbo.uspFromChangeMesScan '', '<0候选条码>', '', 0, 0, '<操作员>';  -- 预期: CandidateCount=0, ConvertedMaterial=''
-- Flag=1 手动输入：06开头且存在于 Basal_Item → 放行；非06 / 不存在 → 报错；有候选时仍必须命中候选
EXEC dbo.uspFromChangeMesScan '', '<0候选条码>', '0601-00017', 1, 1, '<操作员>';  -- 预期: 成功
EXEC dbo.uspFromChangeMesScan '', '<0候选条码>', '0699-99999', 1, 1, '<操作员>';  -- 预期: 报错"在物料主数据中不存在"
-- 多候选时应报错提示选择；单候选/带 @SelectedMaterial 应成功
```

> **sqlcmd 执行注意**：本目录脚本为 UTF-8（含中文、LF 换行），用 sqlcmd 执行必须加 `-f 65001`，否则会被按 GBK 解码导致整段不执行（exit=0 且无输出、`modify_date` 不变）。  
> 例：`sqlcmd -S <host> -U sa -P *** -d <db> -f 65001 -b -i alter_uspGetMaterialCandidates.sql`

### 2.5 代码/前端部署

需一并发布（本仓库已改）：

| 文件 |
|---|
| `DLL\Production\Client\ProductionCollection\Client\FeedingHopperCrusherBLL.cs` |
| `DLL\Production\Client\ProductionCollection\Client\FormChangeByMES.cs` |
| `Code\Web\AjaxServices\Client\AjaxFeedingHoppeCrusher.cs` |
| `Code\Web\AjaxServices\Client\AjaxFromChangeByMES.cs` |
| `Code\Web\MobileApp\FeedingHopperCrusher.aspx` |
| `Code\Web\MobileApp\FormChangeByMES.aspx` |

部署顺序建议：**先库后代码**（旧代码 + 新库兼容：`@SelectedMaterial` 有默认值 NULL）。  
回滚代码时可保留新库；回滚库需先恢复备份 SP/表结构。

## 3. 回滚

1. 用 `bak_*_<时间戳>.sql` 中的定义重新 `CREATE`/`ALTER` 各 SP。  
2. 若需删列：
   ```sql
   ALTER TABLE dbo.Prod_SrapFeeding DROP COLUMN MaterialPartNumberCode;
   ```
3. 回滚 Web/DLL 至变更前版本。

## 4. 测试环境验证记录（2026-09-24）

| 用例 | 结果 |
|---|---|
| `GRN260924000001` + `03` 候选 | `0301-00018`(L2)、`0302-00020`(L4) ✓ |
| 同 GRN + `06` 候选 | `0601-00018`(L2)、`0602-00020`(L4) ✓ |
| Load 不带所选原料 | 报「多个候选原料，请先选择」✓ |
| Load 带 `0301-00018` @ SL01 | 成功，单头 `MaterialPartNumberCode=0301-00018`，单号 `SLD2609240001` ✓ |
| Load 非法原料 `0399-00001` | 拒绝（不在候选）✓ |
| FromChange Flag=0 多候选 | 返回 `ConvertedMaterial=''`, `CandidateCount=2` ✓ |
| FromChange Flag=1 非法 `9999-99999` | 拒绝 ✓ |

> 测试遗留：`SL01` 上有未完成上料单 `SLD2609240001`（`Staues=0`），含 `GRN260924000001`。可 PDA 完成上料或删除该单后继续测。

## 4.1 测试环境验证记录（2026-09-26）

| 用例 | 结果 |
|---|---|
| `uspGetMaterialCandidates` L2 改造（备份 `bak_uspGetMaterialCandidates_20260926154834.sql`） | `modify_date=2026-09-26 16:07:26` ✓ |
| `SL2609260003` + `06` 候选 | `0601-00017`、`0601-00018`（Source=L2 产品BOM；旧版为 0 条）✓ |
| `SL2609260003` + `03` 候选 | `0301-00017`、`0301-00018` ✓ |
| 45 条条码新旧 SP 对比 | 仅“补入产品BOM候选 / 剔除无关工单 L3”，L1 主路径不变 ✓ |
| 粉碎机上料侧 6 种输入物料 | `1503-00004` 1→1、`1503-00002` 1→3、`0201-00007` 3→3、`0201-00345` 3→1、`0201-00125` 2→2、`0201-00337` 2→2 ✓ |
| 上料侧结论（用户确认） | SP 不改（已共用新候选 SP）、并集不扩、首扫多候选保持不预选 ✓ |
| `uspFromChangeMesScan` 0 候选改造（备份 `bak_uspFromChangeMesScan_20260926170613.sql`） | `modify_date=2026-09-26 17:09:40` ✓ |
| Flag=0 `GRN260914000010`（0 候选） | 不报错，`CandidateCount=0`、`ConvertedMaterial=''` ✓ |
| Flag=0 `GRN260924000004`（2 候选） | `CandidateCount=2`、`ConvertedMaterial=''` ✓ |
| Flag=1 0 候选手动 `0601-00017` | 成功（明细 `PreConversionMaterial=070101-00001`），测试后回滚，残留 0 行 ✓ |
| Flag=1 手动 `0699-99999` | 拒绝：在物料主数据中不存在 ✓ |
| Flag=1 手动 `0301-00017` | 拒绝：不是 06 开头 ✓ |
| Flag=1 有候选却选 `0603-00004` | 拒绝：不在该条码 06 候选中（强校验保持）✓ |
| `FormChangeByMES.aspx` 手动输入改造 | `node --check` JS 语法通过 ✓（页面需 VS/IIS 编译后 PDA 回归） |

> Flag=0 每次扫描会生成一个转换单号（如 `XT2609260010~0012`），仅号段前进，不落表数据，属原有行为。

## 4.2 测试环境验证记录（2026-09-27，按 GRN 来源分叉）

| 用例 | 结果 |
|---|---|
| SP 备份（AGENTS.md 强制） | `bak_uspFromChangeMesScan_20260927112225.sql`（10336 字节）✓ |
| `alter_uspFromChangeMesScan.sql` 应用 | `sqlcmd -f 65001 -b` exit=0，`modify_date=2026-09-27 11:24:45`，`CREATE` 版 `uspFromChangeMesScan.sql` 同步 ✓ |
| T1 Flag=0 非粉碎机 `GRN260927000016` | `IsCrusherGRN=0`、`ConvertedMaterial=''`、`CandidateCount=0`，不报候选错 ✓ |
| T2 Flag=0 粉碎机 `SL2609270007` | `IsCrusherGRN=1`、`CandidateCount=1`、回填 `0601-00018`(L1) ✓ |
| T3 Flag=1 非粉碎机 + **非 06** 料 `0301-00018` | **放行入明细**（原版无 06 校验），测试后回滚 ✓ |
| T4 Flag=1 粉碎机 + 非 06 料 `0301-00018` | 拒绝：`转换后粉碎料【0301-00018】不是 06 开头的粉碎料!` ✓ |
| T5 非粉碎机同单扫不同转换前物料 | 拒绝：`只能扫描同一物料的条码!`（原版同物料校验回归）✓ |
| T6 非粉碎机同物料第 2 条（同仓库） | 成功入明细，2 行；回滚后残留 0 ✓ |
| T7 粉碎机选候选外 `0602-00020` | 拒绝：`不在条码【SL2609270007】的 06 候选中!` ✓ |
| T8 粉碎机命中候选 `0601-00018` | 成功入明细（回滚）✓ |
| T9 非粉碎机 Flag=1 空转换后 | 拒绝：`必须选择转换后粉碎料!`（保留的空值保护）✓ |
| `FormChangeByMES.aspx` 分叉改造 | `node --check` 通过；span 4/4、td 33/33、无重复 id、BOM `EF-BB-BF`、全 LF ✓（页面需 VS/IIS 编译后 PDA 回归） |
| 测试残留单清理（用户批准） | 备份 `bak_Prod_FromChangeByMES_testResidue_20260927115914.sql` 后删除 `XT2609260001`(2行)、`XT2609260012`(1行)；`XT2609260007` 已在会话外删除；释放条码 `GRN260924000001/SL2609260001/SL2609260004` 均 `Status=0` 且不在任何单据 ✓ |

> 非粉碎机待测条码（`Remark<>'粉碎机上料生成' AND Status=0`）：`GRN260927000016`、`GRN260927000015`、`GRN260927000012`、`GRN260927000009`。  
> 粉碎机待测条码：`SL2609270007`(9)、`SL2609260003`(25)、`SL2609260002`(20)、`SL2609240001`(23)。

## 4.3 测试环境三页面并行对比（2026-09-27，@UiMode 参数）

用户要求把三个版本并排交给测试者对比选型（原版 / 09-26 不良料把版 / 09-27 综合分叉版）：

| 页面 | 文件 | 标题（显示名） | UI 行为 | 前端调用 | UiMode |
|---|---|---|---|---|---|
| 原版 | `MobileApp/FormChangeByMES.aspx`（git HEAD 还原，824 行，**零改动**） | 形态转换 / 形态转换MES | 禁用输入框+「选择物料」面板，数量不自动填 | `FromChangeMesScanGenerate`（旧方法 6 参） | 省略 → SP 默认 **0** |
| 不良和料把 | `MobileApp/FormChangeByMES_LB.aspx`（新增） | 不良和料把形态转换页面 | 一律 06 候选下拉 / 0 候选手动输入，数量=余额可改 | `FromChangeMesScanGenerateEx(..., 1)` | **1** |
| 综合 | `MobileApp/FormChangeByMES_All.aspx`（新增） | 形态转换综合页面 | 按 GRN 来源自动切换（粉碎机→下拉，其它→面板） | `FromChangeMesScanGenerateEx(..., 2)` | **2** |

- SP `uspFromChangeMesScan` 增加末位参数 `@UiMode TINYINT = 0`；`@IsCrusher` 取值 `0→0、1→1、2→按 Remark='粉碎机上料生成'`（候选解析、06 校验、Flag=0 回填、同物料校验全部由它门控）。**备份（强制）**：`bak_uspFromChangeMesScan_20260927153513.sql`（12070 字节），应用 `modify_date=2026-09-27 15:36:08`，库定义与 `uspFromChangeMesScan.sql` 逐行一致（仅尾行空行差异）。
- Web 层新增 `[AjaxMethod] FromChangeMesScanGenerateEx(..., int UiMode)`（`Code\Web\AjaxServices\Client\AjaxFromChangeByMES.cs`，内部 `ComMethod.GetList("uspFromChangeMesScan", parms)`，参数数组含 `@UiMode`）。**必须在 VS 里重新生成 Web 工程**才生效；`SKT.LeanMES.ProductionCollection.dll` 是 `Code\Lib` 预编译 DLL（09-24 15:22），本次未改、也不需要改。
- `Web.csproj` 登记两个新 aspx（`<Content Include>`）；`MenuList.aspx` 新增 `Check(167)`/`Check(168)` 两个入口（**测试期不走权限直接可见，测完删除**）。
- 三模式 SQL 回归（显式事务回滚，残留 0）：粉碎机 `SL2609270008` → UiMode0 `0/0`、UiMode1 `2/1`、UiMode2 `2/1`（CandidateCount/IsCrusherGRN）；非粉碎机 03 条码 `GRN260825000012` → UiMode0 `0/0`、UiMode1 **1 个候选并回填 `0601-00012`**、UiMode2 `0/0`。省略 `@UiMode` 的 6 参调用已验证可用（默认 0）。
- 校验：三个 aspx 内联脚本 `node --check` 通过；td/tr/div/span/select/script 标签配平。
- **入明细改为人工点击（2026-09-27 需求）**：`FormChangeByMES_LB.aspx` / `FormChangeByMES_All.aspx` 扫描 GRN 后**不再自动入明细**，只回填条码/候选/转换后数量并提示「请点【入明细】」。原自动提交的 5 处全部改为提示：单候选带出料号（`Scan`）、多候选选料（`onScrapChanged`）、候选面板选料（`CheckItemlist`）、0 候选手动输入回车（`#ConvertedScrapManual`）、`Save()` 确认转换；仍在待入明细时再扫条码只提示「请先点【入明细】提交 xxx」，不覆盖。唯一提交入口 = `#enterGrn`（`ScanQty()` → `confirmLine()`），按钮已从「转换后碎料」行**移到「转换后数量」输入框后面**。原版 `FormChangeByMES.aspx` 保持生产原行为（选料面板回填后人工点【入明细】）。
- 备注：`XT2609270022`（admin，15:03，挂 `GRN260927000015/16`，转 `010303-00002`）是测试者本人的草稿单，复测这两张条码前需先删单；`uspGetMaterialCandidates` 本身未改。

> 三页面待测条码：粉碎机 `SL2609270008`(0302-00020, 余额11, **2** 个06候选)、`SL2609270007`(0301-00018, 9, 1个)、`SL2609270001`(0301-00017, 32, 2个)；不良/料把非粉碎机 03：`GRN260825000012`(0301-00012, 2200, 1候选 `0601-00012`)；06 对照：`GRN260927000003`、`GRN260927000005`。

## 5. 环境备注

- 测试 MES：`172.16.5.179` / `PROD_TEST_MES` / `sa`  
- 测试 ERP：`172.16.5.155` / `001`  
- 正式 MES 用户称：`172.16.5.144`（**库名待确认**）  
- 本机仅有 VS18 MSBuild；`ERP.csproj` 等旧工程在低版本 C# 下有既有编译错误，与本次改动无关；Web 工程缺 `v11.0\WebApplications` targets 时需完整 VS 环境编译。

## 6. 遗留待办（2026-09-26 注塑不良标签打印）

**根因**：提交 `1907c5ee`（2026-09-21）把 `Code\Web\Client\InjectionMoldingBatchPrintCollection.aspx` 的 `UpdateList()` 打印类型由 `labelType=-36` 改为 `-39`，但 `Basal_ItemDocuments` 无 TypeId=-39 映射 → `uspProdGetLableDocumentId` 抛「该注塑碎料单号还没维护对应的产品标签」→ 不良登记成功但标签未打印。

**已完成**
- 配置补齐（2026-09-26 14:09，admin 手工）：正式 `172.16.5.144/LeanMes` → DocID 11（碎料标签）；测试 `172.16.5.179/PROD_TEST_MES` → DocID 10。
- 脚本 `insert_itemdocument_typeid_m39.sql`（按文档名解析 DocID，可重复执行，含回滚），建议纳入正式发布脚本以保证环境一致。
- 备份 `bak_Basal_ItemDocuments_nglabel_20260926143850.sql`。
- 受影响清单 `affected_ng_sn_no_label_20260921_20260926.csv`（09-21~09-26 14:09 共 91 笔 / 38 工单 / NG 合计 2599），补打由业务手工处理。

**待办（本次不改，另开需求）**
1. `InjectionMoldingBatchPrintCollection.aspx` `UpdateList()`：先清 `labelDocumentId=-1`、检查 `getDocumentInfo()` 返回值，失败即中止，避免复用上一次模板打出错误标签。
2. 同页打印成功后调用已有但从未被调用的 `recordPrint()`，让 `Prod_PrintRecord` 有记录——当前该页无论打印成功与否都不写打印记录，「打印记录查询」查不到。
3. 「条码重印」`uspGetReprintSNInfo` 只返回 `TypeId=-2`，无法补打 -39 碎料标签；如需系统化补打需扩展该 SP/页面。
