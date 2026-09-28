# 注塑 BI 核心报表缺口分析与交付说明

- 日期：2026-09-25（首轮 P90/P91/Q90 + 二轮 P92–P96、Q91、D01–D06 全部交付）
- 目标库：`172.16.5.144 / LeanMes`（正式库）；站点：`http://172.16.5.144/`
- 范围：BI 中心新增 15 项（6 张业务报表 + 1 张质量增强 + 6 张模块驾驶舱 + 首轮 3 张），含存储过程、模板、注册、验证全链路
- 归档目录：`E:\source\MES\SKT\20260819\DataSql\BI_CoreReports\`

---

## 一、现有报表盘点（交付前 71 张 → 交付后 86 项）

按 `Report_Template.Report`（模块 GUID）分布（`inventory_cn.txt` / `report_templates.txt`）：

| 模块 | GUID | 交付前 | 交付后 | 代表报表 |
|---|---|---:|---:|---|
| 生产报表 | 16217B99-6CCC-456E-A0C3-8E5A3EF66F7E | 28 | **35** | P01 Aging、P02/P03 WIP、P04 生产统计、P22 生产不良、P25 注塑车间产量New、**P90/P91/P92/P93/P96、D01/D05 驾驶舱** |
| 品质报表 | BAF39F3A-9F5D-4AAA-9E9B-B2117AA08D71 | 12 | **15** | Q01/Q1 FPY、Q02/Q2 LAR、Q03/Q3 IQC、Q6 检验汇总、**Q90(增强)、P95、D02 驾驶舱** |
| 仓库报表 | C7A32644-8771-458D-88F3-9DF6CFB7E49B | 18 | **20** | W01 呆滞料、W02 齐套、W10 库存、W15 保质期预警、**Q91、D03 驾驶舱** |
| 设备报表 | 85F55665-3CA3-42B4-949B-F9496AFAD683 | 2 | **4** | E01 设备OEE、模具产品关系表、**P94、D04 驾驶舱** |
| 管理报表 | F0257AA3-4A50-44E6-912E-06FC4ED29F8D | 6 | **7** | M01/M02 粉碎料、M03 设备OEE、CT异常预警、OEE优化验证(2266)、**D06 驾驶舱** |
| 维修报表 | 55603DE7-F2D1-4810-BE70-CB42640663E9 | 4 | 4 | R01–R04 |
| 其他 | 78EB95E3-2B93-4DE3-BD0D-FD6FFAF8E37A | 1 | 1 | 2226（看板页，模板解密失败） |
| **合计** | | **71** | **86** | |

图表能力：交付前仅 7 张带 ECharts；本次 15 项全部带图（驾驶舱 3–4 图/页）→ **22/86 有图表**。

## 二、注塑行业需求对照（缺口分析）

| 需求项 | 现状 | 结论 |
|---|---|---|
| 每月产量汇总（按机台 × 月） | 只有注塑车间产量（日/明细类） | **缺失 → 新增 P90** |
| 每月质量分析（不良代码 × 月） | 有 FPY/LAR/IQC，无月度不良汇总 | **缺失 → 新增 Q90** |
| 每天报工（按班别汇总） | 无「日期 × 班别」汇总 | **缺失 → 新增 P91** |
| 上料与 BOM 用料核对 | 仅上料核对类（SMT/DIP/注塑上料），无差异分析 | **缺失 → 新增 P92** |
| 模具模次统计 | 仅模具产品关系表 | **缺失 → 新增 P93** |
| 设备停机时长/原因分析 | OEE 有状态占比，无停机明细分析 | **缺失 → 新增 P94** |
| 不良报废综合分析 | R03 仅不良报废一维 | **缺失 → 新增 P95** |
| 产能达成（计划 vs 实际） | 无 | **缺失 → 新增 P96** |
| 粉碎料来源分析 | M01/M02 为粉碎料进销存维度，无来源占比 | **缺失 → 新增 Q91**（销售退货并入 Q90 @ReportType=2） |
| 模块驾驶舱（生产/品质/仓库/设备/模具/管理） | 仅有零散看板，无模块综合页 | **缺失 → 新增 D01–D06** |
| 设备 OEE / 直通率 / 物料仓储 | E01/M03、Q01/Q2/Q6、W01–W16 | 已覆盖 |
| 能耗 / 水电气 | 无 | 需采集数据，后续建议 |

## 三、交付明细

### 3.1 存储过程（全新创建 `_Program` 结尾；Q90 为修改已备份）

| SP | 报表 | 业务参数 | 关键数据源 |
|---|---|---|---|
| `uspBI_MonthlyProductionReport` | P90 | `@StartDate @EndDate @EquipmentCode` | Prod_EquipmentDayProd + Basal_Equipment |
| `uspBI_MonthlyQualityReport` | Q90 | `@StartDate @EndDate @ReportType`（1生产不良/2销售退货/3全部，默认1） | Prod_NcData + Prod_ERPRMALine |
| `uspBI_DailyWorkReport` | P91 | `@StartDate @EndDate @Shift` | Prod_StatisticalData |
| `uspBI_LoadingBomAnalysis_Program` | P92 | `@StartDate @EndDate @MachineCode @ItemCode` | 上料记录 + BOM/工单用料 |
| `uspBI_MouldShotsReport_Program` | P93 | `@StartDate @EndDate @MachineCode @MouldCode` | Prod_CollectionEngelDataHistory + 模具主数据 |
| `uspBI_DowntimeAnalysis_Program` | P94 | `@StartDate @EndDate @MachineCode @Status @Category` | Prod_EquipmentStatusCollectionData（16 种状态码分类） |
| `uspBI_ScrapNcAnalysis_Program` | P95 | `@StartDate @EndDate @Source @NCCode @ItemCode @MachineCode` | Prod_NcData + 报废登记 |
| `uspBI_CapacityAchieveReport_Program` | P96 | `@StartDate @EndDate @MachineCode @OrderNo @Status` | Prod_EquimentOrderPord（计划）vs Prod_EquipmentDayProd（实际） |
| `uspBI_RegrindSourceAnalysis_Program` | Q91 | `@StartDate @EndDate @Source @Family` | vwMaterialHistoryAction（06% 粉碎料来源） |
| `uspBI_DashboardCore_Program` | D01–D06 | `@Role`（prod/qual/wh/equip/mold/mgmt）`@Days`（1–90，默认7）`@Date` | 上述各源，长表输出 `[区块][图表][横轴][系列][值][值2][文本]` |

- **双模式签名**（与 `SktMesGrid` 对接）：额外 `@PageSize INT=-1, @PageIndex INT=-1, @TotalCount INT=-1 OUTPUT`；`<=0` → 全量（图表/导出只传业务参数），否则 `ROW_NUMBER()` 分页回写 `@TotalCount`。
- 隔离级别 `READ UNCOMMITTED` + `SET NOCOUNT ON`，与现网报表 SP 一致。
- **Q90 为修改对象**：已按规矩先备份 `bak_uspBI_MonthlyQualityReport_20260925125630.sql` 再重建（SELECT..INTO 分支显式 CAST 定列宽，避免字符串截断）。

### 3.2 报表注册（`Report_Template_Edit`，15 项 failed=0；重复执行走 UPDATE 幂等）

| 报表 | 中文名 | TemplateId | TemplateName(GUID) | 模块 | Seq | 权限码 |
|---|---|---:|---|---|---:|---:|
| P90 | P90 每月产量情况 | 2268 | EC3D889B-8B49-4D9B-9D93-D6C3A39BD223 | 生产 | 27 | 50140040 |
| P91 | P91 每日报工数量 | 2269 | 341EA390-EDE1-4DEA-BB60-0394D8B395E9 | 生产 | 28 | 50140041 |
| Q90 | Q90 每月质量情况 | 2270 | F3282883-D6D1-41ED-B9F5-0ED18C55C593 | 品质 | 7 | 50130013 |
| P92 | P92 上料BOM分析报表 | 2271 | D4B53604-C8C5-4F0E-A838-BEBD5C27EC37 | 生产 | 29 | 50140042 |
| P93 | P93 模具模次报表 | 2272 | 633D4C5B-854A-442C-A543-B915F5F4BEE6 | 生产 | 30 | 50140043 |
| P96 | P96 产能达成报表 | 2273 | E383FB7A-31C6-493D-998C-7A4EE8992E8C | 生产 | 31 | 50140044 |
| D01 | D01 生产驾驶舱 | 2274 | 1A04670C-59CD-4276-BC67-6C3AED24520A | 生产 | 32 | 50140045 |
| D05 | D05 模具驾驶舱 | 2275 | D0962E54-47FB-4FFF-8A59-D0F148A0E08A | 生产 | 33 | 50140046 |
| P95 | P95 不良报废分析报表 | 2276 | 7DED4D4C-A9BA-4140-89BE-95D2C35A1B45 | 品质 | 8 | 50130014 |
| D02 | D02 品质驾驶舱 | 2277 | 29BFA2B3-7DAB-4B83-AD07-40109E952E70 | 品质 | 9 | 50130015 |
| Q91 | Q91 粉碎料来源报表 | 2278 | 94CF3D59-C864-4929-807A-E7A484BC8A9C | 仓库 | 17 | 50140047 |
| D03 | D03 仓库驾驶舱 | 2279 | 692076CF-D3C4-475B-B3F6-F52ED6DB6565 | 仓库 | 18 | 50140048 |
| P94 | P94 停机分析报表 | 2280 | 6EA8EF86-95C0-4391-8098-79817403DEA4 | 设备 | 4 | 50150006 |
| D04 | D04 设备驾驶舱 | 2281 | 6D5A140D-8CB1-4377-B72C-386805B18406 | 设备 | 5 | 50150007 |
| D06 | D06 管理驾驶舱 | 2282 | 0595752F-BD0E-4DA5-9B2E-ECFDCA06EC57 | 管理 | 5 | 50160006 |

直达 URL（登录后打开）：`http://172.16.5.144/Report/ReportPage.aspx?name=<TemplateName>&Flag=1`（上表 GUID 即 name 参数）。

> 注：无「模具」模块，D05 模具驾驶舱挂 生产报表 模块（Seq 33）；Q91 权限码系统自动分配在 5014 段。

### 3.3 模板功能（`TemplateCategory=2` 高级模板，两 TAB）

- **表格 TAB**：`SktMesGrid`，`dataAction:'PROC'`、`isProcPage:true`、每页 50 行，支持排序/页码/导出 EXCEL（隐藏域带参 postback，导出走全量）。
- **图表 TAB**：ECharts
  - P90：月度产量堆叠柱 + 不良率折线（双 Y）；设备产量 TOP10
  - Q90：按类别堆叠柱（生产不良/销售退货）+ 项目 TOP10；报告类型下拉 1/2/3 与 8 列新形状（月份/类别/项目代码/项目名称/客户/发生件数/数量/月内占比%）
  - P91：按班别堆叠柱；每日报工笔数
  - P92：上料 vs BOM 用量对比柱 + 差异 TOP10；P93：每日模次趋势 + 模具模次 TOP10；P94：停机原因占比饼 + 每日停机时长；P95：每日不良趋势 + 不良代码 TOP10；P96：达成率趋势（计划/实际柱 + 达成率折线）+ 机台达成 TOP10；Q91：粉碎料来源堆叠柱 + 来源占比饼 + 物料入库趋势
  - D01–D06：2×2 槽位（ChartA–D），固定 @Role + 天数下拉（7/14/30 天）；长表网格展示区块/图表/横轴/系列/值；各页 3–4 图（mgmt 含核心 KPI 横条）
- 兼容要点：JScript(ES3) 语法；模板禁用 `.on()`（jQuery 1.6.3），TAB 钩子用 `.live()` + `setTimeout`；`#divReport/#divChart{height:auto}` 覆盖 tabs.css；切回表格 TAB `onResize()`；URL/JS 无 `%xx`/`<%`（decodeURI 安全）。

## 四、验证结果（全部通过）

1. **SP 验数**（`test_all_new.txt`、`test_p93_p96.txt`、`test_q90v2b.txt`、`test_dash2.txt`）：P92–P96、Q91 全量/分页/筛选通过；Q90 三分支（1/2/3）通过；驾驶舱 6 角色全部出数（prod 40 / qual 34 / wh 23 / equip 51 / mold 24 / mgmt 169 行）。
2. **注册回验**（`verify_templates.txt`）：**15 项 content_decodeuri 全 PASS（fail=0）** —— 解密内容与源 HTML 逐字节一致；FRAMEWORK_PAGES（URL/模块/序号/InMenu/Flag）、SYS_Popedom 关联、Report_ResourcesMap 中英文名与 `IsKanban=0/Flag=2` 均正常。
3. **幂等**：`register_templates.ps1` 重复执行 → UPDATE 分支，TemplateId/页面/权限码不变。
4. **HTTP**：站点可达；未登录访问 ReportPage 触发登录墙，E2E 渲染需登录浏览器确认（见第八节）。

## 五、使用与权限

- **admin** 账号直接可见全部新报表/驾驶舱。
- **其他角色**需在「系统管理 → 角色权限」勾选新权限码（见 3.2 表；`Report_Template_Edit` 不自动授权角色，`SYS_PopedomInRole` 对既有 BI 报表同样为空）。
- 查询参数：业务报表均为起止日期 + 各自维度筛选；驾驶舱仅「统计天数」下拉（7/14/30，默认7）。

## 六、数据口径与 Caveats

1. **P96 产能达成口径**：计划取 `Prod_EquimentOrderPord.Qty`（日计划），实际取 `Prod_EquipmentDayProd`（`ActQty>0` 优先，否则 `PordProd`）。比值 avg 2.57、区间 0.115–58.85 —— **计划录入量偏低导致达成率普遍远超 100%，属数据现状非计算错误**；报表按现口径如实呈现，建议业务侧核对计划量录入。
2. **Q90 未分类占比高**：`Prod_NcData.NCID=-1` 归 `NA / 未分类`，近 6 月约 24.7%，需业务侧补录 NC 代码。
3. **Q90 销售退货分支**：`Prod_ERPRMALine` 自带 CreateDateTime，与主表按 `DocId` 关联；客户列取自主表。
4. **Q91 粉碎料来源**：以 `vwMaterialHistoryAction` 中 `06%` 记录为「粉碎料」，来源 = 「物料入库 / 形态转换物料打印入库 / 历史物料打印入库」，勿与 M01/M02（uspSmashItemUpDetail / WarhouseDetail）混淆。
5. **P94 停机状态分类**：1生产 / 21未生产 / 6计划停机 / 2,10换模 / 5,19,4,17故障 / 12人力 / 15,11,14,3调试试模 / 13烘料 / 7缺料。
6. **机台号映射**：'001'–'032' 为 DayProd 真机号，Pord/Engel 用 legacy 号（`Basal_Equipment_Ext` ExtFieldsId=1），报表内部已做映射。
7. P91 不良数多为 0（`Fail_qty` 现网基本未写入）；数据起点：DayProd 2025-03-21、Unit 2024-10-14。
8. 驾驶舱状态饼含 16 种状态码，图例开启 scroll；达成率折线 null 值不连线。

## 七、归档清单（`DataSql\BI_CoreReports\`）

- 首轮 SP：`uspBI_MonthlyProductionReport.sql`、`uspBI_MonthlyQualityReport.sql`、`uspBI_DailyWorkReport.sql`
- 二轮 SP：`new_reports_20260925\uspBI_{LoadingBomAnalysis,MouldShotsReport,DowntimeAnalysis,ScrapNcAnalysis,CapacityAchieveReport,RegrindSourceAnalysis}_Program.sql`、`uspBI_DashboardCore_Program.sql`（含各 `bak_*.sql`）
- 模板：`templates\P90/P91/Q90/P92/P93/P94/P95/P96/Q91/*.html`、`templates\D01_prod/D02_quality/D03_wh/D04_equip/D05_mold/D06_mgmt_dashboard.html`
- 注册/验证：`register_config.json`（15 项）、`register_templates.ps1`、`register_log.txt`、`verify_templates.ps1/.txt`
- 部署：`deploy_sp.ps1`（`-Names` 单名或不传全量）、`new_reports_20260925\deploy_new_sp.ps1`（**注意：`-Names` 多名会被 PowerShell 拼成单串，传单个名字或不传**）
- 盘点：`report_templates.txt`、`inventory_cn.txt`

复现顺序：`deploy_sp.ps1` → SP 验数 → `register_templates.ps1` → `verify_templates.ps1`。

## 八、遗留与后续建议

1. **OEE 优化验证报表（TemplateId 2266 / 97027F71-…）未接线**（前次交付遗留）：缺 `FRAMEWORK_PAGES`/`Report_ResourcesMap`/`SYS_Popedom` → 菜单不可见。补建需先确认中文名（建议 `M04 设备OEE优化验证报表`，管理报表模块）。
2. OEE 状态口径 4 项待确认（状态窗口 ΔShot、Shot 清零、计划时间是否补 P、HMG STS 0/1），见《OEE状态判断逻辑改善分析》。
3. P96 计划量录入偏低问题建议业务侧核对（见第六节 1）。
4. 建议用登录账号在浏览器打开 3.2 表各 URL 做渲染确认（表格 TAB + 图表 TAB + 导出）；如提供测试账号，可补完整 HTTP E2E。
