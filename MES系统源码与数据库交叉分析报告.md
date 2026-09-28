# 深科特 MES (LeanMES v8.5.7) 源码 × 字典 × 数据库 三方交叉分析报告

> **项目**: 山东亿辰注塑 MES  
> **分析日期**: 2026-09-22  
> **三方数据源**:
> 1. **数据字典 Excel** — `深科特MES系统数据字典(山东亿辰) (3.18).xlsx`
> 2. **源码仓库** — `E:\source\MES\SKT\20260819`
> 3. **144 库实测** — `172.16.5.144 / LeanMes`（已验证连通）
>
> **姊妹报告**: 《MES系统源码架构分析报告.md》（11 章架构分析，本文不重复架构细节，聚焦三方数据交叉与生产问题定位）

---

## 一、结论摘要（先看这里）

| # | 结论 | 依据 |
|---|------|------|
| 1 | **字典 667 表在 144 库中 100% 存在**（DictOnly=0） | `compare_result.txt` |
| 144 库比字典多 **106 张表**，全部可归类为运行时/集成/测试残留，非字典漏登 | 106 张 DB_ONLY 分类见 §4.3 |
| 2 | **144 是「未打盘点移库迁移」的源库**；迁移目标是 `172.16.5.179 / PROD_TEST_MES` | 144 缺配置 911、缺 `RealBarCode` 列、缺 3 个新 SP、单号规则无 -25 |
| 3 | 字典字段 **9588** 行 / 667 表；类型以 int/varchar/nvarchar/datetime 为主 | `dict_count3.txt` + `verify_fields.txt` |
| 4 | 144 库对象规模：**773 表 / 3000 SP / 544 视图 / 286 函数 / 10 Job** | `stats_obj.txt` |
| 5 | 代码侧：**210 AjaxService / 35 Handler / 129 PDA 页 / 3432 Web.cs / 1865 DLL.cs / 224 预编译 DLL** | `code_counts.txt` |
| 6 | 安全高风险点集中在 WebAPI（`Runprocedure` 拼接、`IsEasyParamMode=true`、`IsAuth=false`） | `LeanController.cs:36`、`Web.config:68/74` |
| 7 | 本地 `DataSql/` **几乎没有 DDL/SP 源**（仅 7~9 个 SQL），数据库对象以库内为准，**变更不可从仓库追溯** | glob 实测 |

**一句话**：字典是 144 库的「子集快照」；144 是待迁移源；生产/测试真实差异体现在 179 的 `PROD_TEST_MES` 迁移清单上；代码量集中在 Web 层，业务逻辑几乎全在 3000 个存储过程里。

---

## 二、数据源与方法

### 2.1 三方数据源

| 源 | 路径/连接 | 提取方式 | 产物 |
|----|-----------|----------|------|
| 字典 Excel | `深科特MES系统数据字典(山东亿辰) (3.18).xlsx` | 解压 xlsx → 解析 sharedStrings + sheet1 | `dict_rows.tsv`（9589 行含表头）、`dict_tables.tsv`（667 表） |
| 源码 | `E:\source\MES\SKT\20260819` | 文件计数 + 目录结构 | `code_counts.txt` |
| 144 库 | `172.16.5.144,sa/SAsa123,LeanMes` | SQL 导出 sys.objects / sys.sql_modules / sysjobs | `db144_overview.txt`、`db144_jobs2.txt`、`key_objects2.txt`、`schema_probe.txt` |
| 迁移清单 | `迁移清单.md`、`DataSql/Migration_to_PROD_TEST_MES.sql` | 人工核对 | §5 |
| 179 参考 | `DataSql/Web_PROD_TEST_MES.config` | 连接串/配置 | §5.4 |

### 2.2 字典 Excel 结构（解析约定）

列结构：`行号 | 表名 | 表说明 | 字段名 | 数据类型 | 是否为空 | 默认值 | 字段说明`

**关键约定**：**表名只在每表首字段行出现**，续行 `p[1]` 为空。  
早期按 `p[1]` 计数得到 670 是错误的；正确计数脚本为 `dict_count3.ps1` / `compare_dict.ps1`。

```
行  表名                字段名     类型
2   ATE_Test_Input_JD   SN         varchar   ← 表起始
3                        Sdata      varchar   ← 续行
4                        Creation_date datetime
5                        Test_Input_JDID int
6   ATE_Test_Log_JD     SN         varchar   ← 下一表起始
```

### 2.3 复现脚本（均在 `Temp\opencode\`）

| 脚本 | 作用 | 输出 |
|------|------|------|
| `extract_xlsx.ps1` | 解压 xlsx（中文名先复制为 ASCII） | `xlsx/` |
| `parse_dict.ps1` | 解析 sheet → TSV | `dict_rows.tsv` |
| `compare_dict.ps1` | 字典 ↔ 144 表集合比对 | `compare_result.txt`、`dict_tables.tsv` |
| `dict_count3.ps1` | 字段数 / Top25 / 类型分布 | `dict_count3.txt` |
| `stats.ps1` | 字典前缀 + DB_ONLY 分类 | `stats_out.txt` |
| `stats_obj.ps1` | 144 对象计数 + 前缀 + 关键 SP 模式 | `stats_obj.txt` |
| `verify_fields.ps1` | 字典前缀字段数校验（UTF8 权威版） | `verify_fields.txt` |
| `code_counts.ps1` | 源码文件计数 | `code_counts.txt` |

> **注意**：bash 工具实际执行 PowerShell；内联 PS 中 `$`/`\"` 会被剥离导致 ParserError → **必须写 `.ps1` 再 `-File` 执行**；中文输出用 `[IO.File]::ReadAllText(..., UTF8)` 读取。

---

## 三、字典统计（源 1）

### 3.1 总量

| 指标 | 值 |
|------|-----|
| 表数 | **667** |
| 字段行数 | **9588**（dict_rows 含表头 9589） |
| 共享字符串 | 8244 |
| 平均字段/表 | ≈ 14.4 |

> `dict_tables.tsv` 的 FieldCount 合计 9568，与 9588 差 20：因个别表名在字段行中重复出现导致 `compare_dict` 计数重置。**权威值取 `dict_count3` 的 9588**。

### 3.2 字段数 Top 25

| # | 表 | 字段数 | 业务含义 |
|---|----|--------|----------|
| 1 | Basal_Equipment | 111 | 设备主数据（超宽表） |
| 2 | Basal_Item | 91 | 产品编码 |
| 3 | ERP_Basal_Item | 87 | ERP 产品镜像 |
| 4 | Quality_InspectionOrder | 76 | 质检单 |
| 5 | ERP_Basal_Equipment | 69 | ERP 设备镜像 |
| 6 | SYS_Lookup | 66 | 数据配置项 |
| 7 | SYS_LookupDef | 65 | 配置项明细 |
| 8 | Prod_MaterialIQC | 63 | 物料 IQC |
| 9 | Prod_Order | 59 | 工单 |
| 10 | ERP_ERP_PurOrderDtl | 57 | 采购明细 |
| 11 | Quality_InspectionOrderOATemplateDetail | 57 | 点检项模板明细 |
| 12 | ERP_Prod_Order | 55 | ERP 工单镜像 |
| 13 | ERP_PurOrderDtl_History | 52 | 采购明细历史 |
| 14 | Basal_EquipmentRepair_JXN | 52 | 设备维修 |
| 15 | Prod_MaterialUnit | 50 | **物料单元/库存核心** |
| 16 | ERP_PurOrderDtl | 50 | 采购明细 |
| 17 | Prod_CollectionEngelDataHistory | 50 | ENGEL 采集历史 |
| 18 | ERP_ERP_PurOrder | 48 | 采购主表 |
| 19 | Prod_CollectionEngelData | 48 | ENGEL 采集实时 |
| 20 | Prod_AnormalSolution | 48 | 异常对策 |
| 21 | Prod_Unit | 47 | 产品 SN |
| 22 | ERP_Basal_ItemBomChild | 43 | ERP BOM 明细 |
| 23 | Prod_PTHWaveSoldering | 43 | 波峰焊 |
| 24 | ERP_PurOrder | 43 | 采购单 |
| 25 | ERP_Basal_ItemBom | 38 | ERP BOM |

**解读**：Top25 中 ERP 镜像表占 9 印，说明 ERP 同步是结构复杂度的主要来源；`Prod_MaterialUnit`（50 字段）是库存/移库/盘点的中心表。

### 3.3 数据类型分布（9588 字段）

| 类型 | 数量 | 占比 |
|------|------|------|
| int | 2950 | 30.8% |
| varchar | 2748 | 28.7% |
| nvarchar | 1600 | 16.7% |
| datetime | 1414 | 14.7% |
| decimal | 393 | 4.1% |
| bit | 218 | 2.3% |
| bigint | 151 | 1.6% |
| float | 43 | 0.4% |
| numeric | 20 | 0.2% |
| tinyint | 16 | 0.2% |
| smallint | 10 | 0.1% |
| date | 9 | 0.1% |
| 其他 (nchar/char/ntext/text/varbinary/uniqueidentifier/money/smalldatetime/xml) | 15 | 0.2% |

**解读**：
- 标识/枚举大量用 `int`，无统一 `tinyint` 约定；
- 字符串 `varchar` 多于 `nvarchar` → 历史包袱，中文字段需警惕排序规则；
- `datetime` 占 14.7%，无 `datetime2`，2026 年仍在用旧类型；
- 数值精度靠 `decimal`(393) + `float`(43) 混用 → 数量/金额字段需逐表确认。

### 3.4 表前缀分布（字典，权威版 `verify_fields.txt`）

| 前缀 | 表数 | 字段数 | 业务域 |
|------|------|--------|--------|
| **Prod** | 300 | 4220 | 生产/库存/工单/上料/包装/入库出库 |
| **Basal** | 184 | 2201 | 基础数据（设备/产品/BOM/路由/仓库/条码规则） |
| **ERP** | 53 | 1455 | ERP 同步镜像 + 回写配置/日志 |
| **SYS** | 41 | 538 | 用户/角色/权限/字典/日志 |
| **Quality** | 32 | 526 | 检验/SPC/AQL/Hold |
| Equipment | 14 | 226 | 点检/检验计划 |
| KanBan | 14 | 136 | 看板配置 |
| SDP | 6 | 51 | 站位模板/数据源 |
| Framework | 5 | 67 | 菜单/按钮/页面权限 |
| Report | 4 | 41 | 报表模板 |
| 其他（Navigation/SmartReport/ATE/Custom/NLog/Test/…） | 14 | 146 | 导航/智能报表/测试等 |
| **合计** | **667** | **9568*** | *\*权威字段行 9588，见 §3.1* |

---

## 四、144 库全景（源 3）

### 4.1 对象总量

| 对象类型 | 数量 |
|----------|------|
| 表 (TABLE) | **773** |
| 存储过程 (PROC) | **3000** |
| 视图 (VIEW) | **544** |
| 函数 (FN) | **286** |
| Job | **10** |

### 4.2 表前缀分布（144 实际）

| 前缀 | 表数 | 与字典差 |
|------|------|----------|
| Prod | 338 | +38 |
| Basal | 188 | +4 |
| ERP | 74 | +21 |
| SYS | 43 | +2 |
| Quality | 32 | 0 |
| Equipment | 14 | 0 |
| KanBan | 14 | 0 |
| SKTCustom | 7 | +7 |
| Framework | 6 | +1 |
| SDP | 6 | 0 |
| temp* | 5+1 | +6 |
| Msd | 5 | +5 |
| Report | 4 | 0 |
| SAP | 3 | +3 |
| 其他散落 | ~26 | — |

### 4.3 字典 ↔ 144 表集合比对（核心结果）

```
DictTables   = 667
DbTables     = 773
InDictNotInDb = 0      ← 字典没有「幽灵表」
InDbNotInDict = 106    ← 144 多出 106 张
```

**DictOnly = 0 的含义**：字典是 144 的真子集；不存在字典写了但库里没有的表（迁移/建库一致性好）。

**106 张 DB_ONLY 分类**（`stats_out.txt`）：

| 分类 | 数量 | 代表表 | 性质 |
|------|------|--------|------|
| Production | 26 | Prod_SchedulOrder、Prod_TechnologyParam、Prod_SMT* 等 | 运行时生产扩展，字典未收录 |
| ERP sync/history | 21 | ERP_*History、ERP_BOM_LOG、ERP_DataPushConfig 等 | 同步历史/日志，设计上不进字典 |
| Test/Temp/Backup | 15 | MesTest*、temp_*、*_bak、Temp_ReportTable | **可清理** |
| SKT custom | 7 | SKTCustom_ProOrderListTemplate*、WWOrder 等 | 客户定制 |
| Other | 13 | BOM2、CC_Warehouse、FeederChangeLog、imp_mo 等 | 杂项 |
| SMT production | 6 | Prod_SMTLoadingMaterialCheck*、RefluxFurnace | SMT 产线 |
| MSD/moisture | 5 | Msd_BakeContion、Msd_Thermostat 等 | 湿敏元件管控 |
| Tower | 5 | Prod_MeterialTower*、Prod_TowerGRN | 智能料塔 |
| Scheduling | 3 | Basal_ScheduleRecord、Scheduling_* | 排程 |
| SAP | 3 | SAP_API、SAP_Config、SAP_Execlog | SAP 接口残留 |
| Framework/System | 2 | Sys_PreviewConfig、tbPagingTemplate | 框架 |

**生产问题定位提示**：
- 查「字典没有的表」→ 优先看 Production/ERP history 两类，属正常；
- Test/Temp/Backup 15 张 + SAP 3 张 → 清理候选；
- `Prod_PDAFunctionTempInDB`、`temp_user` 等出现在生产库 → 异常使用痕迹，值得排查。

### 4.4 存储过程前缀（3000）

| 前缀 | 数量 | 说明 |
|------|------|------|
| Basal | 390 | 基础数据 CRUD（Edit/Delete/GetInfo 三件套） |
| Prod | 299 | 生产业务 |
| ERP | 99 | 同步 `ERP_Sync*ByApi/ByTableOrView` |
| SYS | 74 | 用户/权限/字典 |
| Quality | 61 | 检验/SPC |
| SmartReport | 45 | 智能报表取数 |
| usp*（无统一模块前缀） | 40+ 大量 | 业务过程式 SP，命名不统一 |
| SP_* | 36 | 含 ATE/ERP 集成 |
| Equipment | 25 | 点检/OEE |
| SDP | 22 | 站位模板 |
| Kanban | 19 | 看板数据 |
| Msd | 15 | 湿敏 |
| 其余长尾 | ~1800+ | `usp*` 开头的大量业务 SP |

**关键 SP 模式统计**（`stats_obj.txt`）：

| 模式 | 数量 | 排查价值 |
|------|------|----------|
| `usp*Get*` | 514 | 查询类，性能问题高发 |
| `usp*Check*` | 212 | 校验类，业务规则集中地 |
| `usp*Save*` | 158 | 保存/事务类 |
| `usp*Equipment*` | 55 | 设备 |
| `usp*IQC*` | 47 | IQC |
| `usp*SMT*` | 44 | SMT |
| `usp*Warehouse*` | 36 | 仓库/盘点 |
| `*History*` | 30 | 历史表写入 |
| `usp*Transfer*` | 23 | 调拨 |
| `usp*Injec*` | 23 | 注塑 |
| `usp*ERP*` | 25 | ERP 相关 |
| `uspAuto*` / `uspJob*` | 7 | Job 调用入口 |

**定制/备份/新版 SP 清单**（迁移与回滚必看，节选）：

- 盘点移库相关（**144 有部分、目标库需打齐**）：`uspWarehouseCheckMoveMaterial*`、`uspWarehouseCheckTransferIn*`、`uspWarehouseCheckHandleLocationDiff_Program`、`uspSaveTransferIn`
- OEE：`uspEquipmentOEEReport`、`uspEquipmentOEEReport_20251118`
- SKT 定制：`upsSKTCustomProOrderListTemplate*`、`upsSKTSYS_Organization*`
- 备份后缀：`*_bak`、`*_BAK`、`*_NEW`、`*_2025*`、`*_2026*`、`_Program`

### 4.5 视图前缀（544，节选）

| 前缀 | 数量 |
|------|------|
| vwBasal | 41 |
| vw（无模块） | 34 |
| vwProd | 26 |
| udfvw | 14 |
| vwSYS | 12 |
| vwMsd / vwEquipmentOEE | 4+4 |
| 其余长尾 | ~500 |

**OEE 视图族**（生产排查高频）：`vwEquipmentOEE`、`vwEquipmentOEE_20250909`、`vwEquipmentOEE_20251118`、`vwEquipmentOEE_byOperationPlatform`、`vwEquipmentOEETest` — **多版本并存，确认线上绑定哪个**。

### 4.6 函数前缀（286）

| 前缀 | 数量 | 说明 |
|------|------|------|
| **UdfGetLBL_*** | **183** | 标签打印取值函数（超大长尾） |
| fn* | 74 | 通用工具（拆串/日期/BOM/状态） |
| UdfPrefixSuf* | 8 | 单号前后缀 |
| Tools* | 4 | 全文索引/定义名 |
| 其他 | ~17 | parseJSON、BOM 校验等 |

**解读**：286 函数里 64% 是标签打印 — 标签/条码打印是本系统的核心输出通道；`UdfGetLBL_*` 出问题 = 现场打印异常。

### 4.7 10 个 SQL Agent Job（`db144_jobs2.txt`）

| Job（中文名乱码，按命令识别） | 命令 | 调度 |
|------|------|------|
| 物料采集模式批量更新 | `update basal_item SET AcquisitionMode='2', IsSeniorBatch='1' ...` | Daily 00:00 |
| 系统策略清理 | `syspolicy_purge_history` | Daily 02:00 |
| U9 云端发货数据拉取 | `EXEC uspGetU9CloudShipData` | Daily 00:00 |
| 定时删除采集历史数据 | `uspJobDeleteEquipmentCollectionHistory` | Daily 00:00 |
| 定时执行设备状态运行时 | `uspAutoCollectionStatusRuntimeJob` | Daily 00:00 |
| 日常备份和复制 | `exec sp_AutoBackupAndCopy LeanMes` | Daily **01:00** |
| 同步U9退货单数据 | `EXEC ERP_SyncRMAByTableOrView` | Daily 00:00 |
| 注塑机后台自动预警 | `Proc_InsertOver5MinutesEquipmentData` | Daily 00:00 |
| 自动补全设备采集当前状态 | `uspAutoInsertEquipmentStatusCollectionCurrentJob` | Daily **00:10:10** |
| 自动发送注塑机应急开始邮件 | `uspInjectionMoldingAutoSendEmail` | Daily 00:00 |

**排查提示**：
- 备份 Job 在 144 库 01:00 跑 `sp_AutoBackupAndCopy` → 确认备份目标盘/保留策略；
- 6 个 Job 挤在 00:00 → **跨午夜批量窗口锁竞争**风险；
- Job 名中文乱码 = 导出编码问题，库内实际为中文名。

### 4.8 关键对象修改时间（`key_objects2.txt`，盘点/OEE 链路）

| 对象 | create_date | modify_date | 含义 |
|------|-------------|-------------|------|
| uspSaveCheckOrder | 2021-02-26 | **2026-03-30** | 盘点保存近期改过 |
| uspEquipmentOEEReport | 2025-08-01 | **2026-09-21** | OEE 报表昨天还在改 |
| uspEquipmentOEEReport_20251118 | 2025-11-26 | 2026-04-24 | 并行版本 |
| ruspGetBarCodeWarehouseCheck | **2025-08-20** | 2025-08-20 | 新建 |
| uspWarehouseCheckBatch / DifferenceList / GetMa* | 2024-12-09 | 2024-12-09 | 一批新建 |
| Basal/Prod_WarehouseCheck* CRUD | 2017 | 2024-02-02 | 老对象 2024 批量改 |

### 4.9 `Prod_MaterialSysConfig` 实测结构（`schema_probe.txt`）

```
ID int | ConfigTypeId int | ConfigCode varchar(20) | ConfigType varchar(50)
ConfigResult nvarchar(MAX) | ConfigDesc varchar(50) | IsGlobal bit | Remark varchar(200)
CreateBy/CreateDateTime/ModifyBy/ModifyDateTime
```

已见配置样例（乱码列已按语义归并）：IQC 扫码确认(25)、先进先出规则(33)、默认仓库(35)、Storage IQC 开关(36)、Period 维护(39)、IQC 合格确认(41)、Prepare 确认(42)、SMT 上料小数(50)、JIT 时间(56/1087/1072)、固定 NG/OK 字符串(1080/1081) 等。

**与迁移清单的关系**：配置 **911（盘点移库方式）在 144 未建立** → 再次印证 144 未打迁移。

---

## 五、144 与迁移目标（179/PROD_TEST_MES）差距

### 5.1 迁移方向判定

| 证据 | 144 (LeanMes) | 179 (PROD_TEST_MES) | 结论 |
|------|---------------|---------------------|------|
| 配置 911 | **无** | 迁移清单要求 INSERT/UPDATE | 144 未打 |
| `Prod_WarehouseCheckOrderDtl.RealBarCode` | **无**（schema_probe 确认 29 列无此列） | 迁移脚本 ALTER ADD | 144 未打 |
| `uspWarehouseCheckMoveMaterial` / `TransferIn` / `HandleLocationDiff_Program` | **缺 3 个** | Migration 脚本 CREATE/ALTER 共 12 SP | 144 未打 |
| `Basal_SerialNumber` 规则 -25 | **无** | 测试库已建 (SerialNumberID=24) | 144 未打 |
| `Web_PROD_TEST_MES.config` 连接 | 注释中保留 144 旧连接 | 生效连接指向 179 | **179 是当前应用库** |

**结论**：`172.16.5.144/LeanMes` = **未打「盘点自动移库」迁移的源库**；`172.16.5.179/PROD_TEST_MES` = 迁移目标（应用已切）。

### 5.2 迁移内容核对（`迁移清单.md` + `Migration_to_PROD_TEST_MES.sql`）

**数据库**：
1. `Prod_WarehouseCheckOrderDtl` + `RealBarCode varchar(50) NULL`
2. 配置 911（`Prod_MaterialSysConfig`，ConfigResult `'1'` 当场移 / `'2'` 只记录）
3. 单号规则 `Next_Number_Type = -25`（`Tra%YEAR%%MONTH%`）
4. **12 个 SP**（修改于 2026-08-18 后，排除 BAK_）：

| # | SP | 操作 |
|---|----|------|
| 1 | uspSaveCheckOrder | ALTER（复盘回写按 GRN 返回旧/新仓库） |
| 2 | uspWarehouseCheckCancel | ALTER（+@ScannedSN） |
| 3 | uspWarehouseCheckCancelCheck | ALTER（+@ScannedSN） |
| 4 | uspWarehouseCheckBatch | ALTER |
| 5 | uspGetWhMaterial | ALTER（去 Status=0） |
| 6 | uspWarehouseCheckHandleLocationDiff_Program | CREATE/ALTER |
| 7 | uspWarehouseCheckDifferenceList | ALTER |
| 8 | uspGetCheckOrderDetail | ALTER（去 CAST INT） |
| 9 | uspWarehouseCheckGetMaList | ALTER |
| 10 | uspStorageTransfer | ALTER（Status NOT IN (0,14)） |
| 11 | uspWarehouseCheckTransferIn_Program | CREATE |
| 12 | uspWarehouseCheckMoveMaterial_Program | CREATE |

**代码**：3 个 DLL 重编译（`SKT.LeanMES.Warehouse.BLL` / `Material.BLL` / `Web`）+ 2 个 PDA 页 + `WarehouseCheck.ashx.cs` + `WriteBackERP.cs` + Web.config CSRF 5→300s。

### 5.3 144 上盘点链路对象「已有但旧」的部分

即使 3 个新 SP 缺失，144 已有旧版盘点对象（modify 多在 2017~2024）：

`uspWarehouseCheck`、`uspWarehouseCheckEdit/Finish/Snap/ScanOperation`、`uspWarehouseCheckOrder_NEW`、`Prod_WarehouseCheckOrder_*` CRUD、`Basal_WarehouseCheckStatus/Type_*`、`ruspGetBarCodeWarehouseCheck`(2025-08-20 新建)…

→ **不要在 144 上直接验证新盘点移库功能**；验证必须去 179 或 LeanMes_Test。

### 5.4 连接与环境（`Web_PROD_TEST_MES.config`）

```
生效: server=172.16.5.179; uid=sa; pwd=SAsa123; database=PROD_TEST_MES
      Pooling=True; max pool size=500; Connect Timeout=600
注释历史: 172.16.5.144/LeanMes（旧）、SKTMES003、SKTMES009、192.168.2.100 等
ERPWriteUrl 等回写地址见同目录配置（E智联/U9C）
```

> 安全提醒：仓库内多处明文 `sa/SAsa123`；生产应改最小权限账号 + 加密连接串（`ConnStringEncrypt`）。

---

## 六、源码侧统计与「代码 ↔ 库对象」映射（源 2）

### 6.1 文件计数（`code_counts.txt`，实测）

| 类别 | 数量 | 路径 |
|------|------|------|
| AjaxServices `.cs` | **210** | `Code\Web\AjaxServices` |
| Handler `.ashx` | **35** | `Code\Web\Handler` |
| MobileApp `.aspx`（PDA） | **129** | `Code\Web\MobileApp` |
| Web 全部 `.cs` | **3432** | `Code\Web` |
| Web 全部 `.aspx` | **2942** | `Code\Web` |
| WebAPI `.cs` | **124** | `Code\WebAPI`（Controllers 8 个） |
| DLL `.cs` | **1865** | `DLL` |
| Lib 预编译 `.dll` | **224** | `Code\Lib` |
| OrderControl `.cs` | **13** | `LeanMES.OrderControl` |
| Tools `.cs` | **2** | `Tools` |
| DataSql `.sql` | **7** | `DataSql`（另有 OrderControl 2 个 = 全库约 9） |

### 6.2 WebAPI Controllers（8）

`ERPSyncController` · `ERPController` · `MeterialTowerController` · `ElectricLoctionController` · `HWLicenseController` · `LeanController` · `BaseController` · `HomeController`

### 6.3 代码 → 数据库对象 映射矩阵

| 代码入口 | 数量 | 典型调用方式 | 对应库对象 |
|----------|------|--------------|------------|
| AjaxServices | 210 | AjaxPro `[AjaxMethod]` → `ComMethodTemplate` → SP | `usp*Get*/Save*/Check*` + `Basal_*/Prod_*_Edit/GetInfo` |
| Handler.ashx | 35 | IHttpHandler | 混合：看板 SP、上传、登录 |
| PDA aspx | 129 | 调 AjaxService/Handler | 仓库/生产/设备/质量四大域 |
| WebAPI | 124 cs | REST + BulkInsert + SP | `ERP_Sync*`、料塔表、配置表 |
| DLL BLL | 1865 cs | SQLHelper/Dapper → SP | `WriteBackERP` → `ERP_WriteBackLog/Config`；业务 BLL → 各域 SP |
| OrderControl | 13 cs | 直连 + Quartz | 自建 OrderControl 表 + `ERP_Prod_Order` |
| 预编译 Lib DLL | 224 | 无源码 | **黑盒**，出问题只能反编译或替换 |

**映射规律（快速定位用）**：
1. 页面/Ajax 名 → 搜同名 SP：`AjaxWarehouseCheck` → `uspWarehouseCheck*` / `uspSaveCheckOrder`
2. 表前缀 → 模块：`Prod_*` 生产库存、`Basal_*` 主数据、`ERP_*` 同步镜像、`Quality_*` 质量
3. `uspGet*` 514 个 → 列表页慢查询优先看这里 + 对应视图
4. 标签打印异常 → `UdfGetLBL_*`（183 个函数）+ `Basal_Label*`

### 6.4 本地 SQL 与库的严重不对称

| 位置 | SQL 数量 |
|------|----------|
| `DataSql/` | 7（OEE 视图×2、盘点 SP 改动×3、uspSaveCheckOrder 原版、Migration） |
| `DataSql/Stored Procedures\|Tables\|Views\|Functions` | **空** |
| 144 库实际 SP/表/视图/函数 | 3000 / 773 / 544 / 286 |

**技术债**：数据库对象 **基本不在版本控制内**；变更只能靠：
- 库内 `modify_date`；
- `迁移清单.md` / `*_BAK_*` / `*_Program` 命名；
- `ERP_WriteBackLog`、`SYS_OperateLog` 等日志表。

**建议**：对生产库做一次性 `SCRIPT AS CREATE` 导出纳入 Git；新变更强制「库内改 + 脚本回写仓库」。

---

## 七、三方交叉总表

| 维度 | 字典 Excel | 源码仓库 | 144 库 | 一致性判断 |
|------|------------|----------|--------|------------|
| 表 | 667 | — | 773 | 字典 ⊂ 库（差 106，可解释） |
| 字段 | 9588 | — | 未全量导出 | 字典为字段权威说明 |
| 存储过程 | —（字典不含） | DataSql 仅 ~5 业务 SP | 3000 | **代码几乎不持有 SP 源** |
| 视图 | — | 2 个 OEE SQL | 544 | 同上 |
| 函数 | — | 0 | 286 | 同上 |
| Ajax 服务 | — | 210 | — | 对应大量 usp |
| Handler | — | 35 | — | — |
| PDA 页 | — | 129 | — | 盘点 2 页是迁移核心 |
| 预编译 DLL | — | 224 | — | 无源码黑盒 |
| Job | — | Quartz 3 个（代码内） | SQL Agent 10 个 | **两套调度并存** |
| ERP 集成 | ERP_* 53 表 | WriteBackERP 2581 行 + ERPSync 22 端点 | ERP_* 74 表 + 99 SP | 镜像表字典滞后 21 张（History 类） |

**双调度提醒**：
- 库内 10 Job（备份/U9 拉取/设备采集…）
- 代码内 Quartz：`JobSyncSupplierToAD`、`JobSyncHMG`、`JobOrderControl`、WebAPI `SyncJob`（需 `GroupHeadquartersFlag=1`）
→ 排查「定时任务没跑」必须两边都查。

---

## 八、生产问题快速定位指南（基于三方数据）

### 8.1 按症状 → 对象

| 症状 | 第一跳 | 第二跳 | 数据源依据 |
|------|--------|--------|------------|
| 盘点保存/平账异常 | `uspSaveCheckOrder`（144 修改至 2026-03-30） | 配置 911、`RealBarCode` 是否存在 | §5：144 未打迁移 |
| 包装箱撤销多删 SN | `uspWarehouseCheckCancel` @ScannedSN | DLL 是否为新版 | 迁移清单 |
| OEE 数值不对 | `uspEquipmentOEEReport`（**2026-09-21 仍在改**） | 绑定 `vwEquipmentOEE*` 哪个版本 | §4.5/4.8 |
| 标签打印空值/错值 | `UdfGetLBL_*`（183 个） | `Basal_LabelField*` 配置 | §4.6 |
| ERP 回写失败 | `ERP_WriteBackLog` | `ERP_WriteBackConfig` 开关、`ERPWriteUrl` | 架构报告 §4 |
| ERP 同步缺数据 | `ERP_Sync*` SP + `ERP_SyncLog` | WebAPI `ERPSyncController` 是否执行 | §6.2 |
| 列表页超时 | `usp*Get*`（514）+ 分页 `Common_GetPageRecords` | 对应 vw 索引 | §4.4 |
| 定时任务未执行 | SQL Agent 10 Job | 代码 Quartz 3~4 Job | §4.7 + §7 |
| 设备采集断流 | `uspAutoInsertEquipmentStatusCollectionCurrentJob` | `Prod_EquipmentStatusCollectionCurrent` | Job 表 |
| PDA 非法请求:024 | Web.config `WebSafeSet` csrf | 5s→300s 是否已改 | 迁移清单 |
| 「字典没有的表」报错 | §4.3 DB_ONLY 106 清单 | 是否 Test/Temp 残留 | §4.3 |

### 8.2 环境三层勿混

```
144/LeanMes          ← 源库快照，无 911/RealBarCode/3新SP/-25，勿测新盘点功能
179/PROD_TEST_MES    ← 应用当前连接（Web_PROD_TEST_MES.config 生效），迁移目标
LeanMes_Test         ← 迁移清单第六节测试已通过的库（PDD260106001 等）
```

### 8.3 高危配置/代码（架构报告交叉确认）

| 项 | 位置 | 风险 |
|----|------|------|
| `Runprocedure` 字符串拼接执行任意 SP | `Code\WebAPI\Controllers\LeanController.cs:36` | SQL 注入 |
| `IsEasyParamMode=true` | `Code\WebAPI\Web.config:68` | 跳过签名/Token |
| `IsAuth=false` | `Code\WebAPI\Web.config:74` | 未启授权 |
| 明文 sa 密码多处 | Web.config 系列 | 凭据泄露 |
| `Ult.CacheHelper` 静态 Dictionary | 非线程安全 | 并发偶发错 |
| 224 个无源码 DLL | `Code\Lib` | 不可调试 |

---

## 九、技术债与优化建议（按优先级）

### P0 — 安全与数据正确性

1. WebAPI：`Runprocedure` 参数化；生产 `IsEasyParamMode=false`、`IsAuth=true`。
2. 连接串去 sa、启用加密；仓库内历史明文密码轮换。
3. 确认 179 生产前完成迁移清单 §三 全部验证步骤（尤其 32 位应用池 / sapnco）。

### P1 — 可追溯性

4. 144 与 179 全对象 `SCRIPT AS CREATE` 导出入 Git；建立「SP 变更 = 仓库文件」流程。
5. 清理 144 中 Test/Temp/Backup 15 表 + SAP 3 表 + MesTest* ；评估 `temp_user` 等异常表。
6. OEE 视图多版本收敛：明确唯一生产视图，删除/归档 `_Test/_2025*`。
7. Job 双调度清单化：SQL Agent 10 + Quartz 全量登记负责人与告警。

### P2 — 结构治理

8. 超宽表治理：`Basal_Equipment`(111)、`Basal_Item`(91) 考虑扩展表模式（已有 `*_Ext` 先例）。
9. 类型规范：新字段禁用 float，数量统一 decimal；逐步 datetime→datetime2。
10. SP 命名收敛：`usp*` 长尾 1800+ 按域加前缀；`usp*Get*` 514 做慢查询审计。
11. 字典刷新：把 106 张 DB_ONLY 中仍在线的表补录进 Excel，消灭 Dict/DB 认知差。
12. AjaxService 210 → 按业务域拆分；日志框架统一（log4net/NLog）。

### P3 — 前端/体验

13. PDA 129 页与 Web 2942 页重复能力盘点；WebForms 长期迁移评估。

---

## 十、附录

### 10.1 产物文件索引

| 文件 | 内容 |
|------|------|
| `MES系统源码架构分析报告.md` | 第一版 11 章架构报告（不动） |
| **本文件** `MES系统源码与数据库交叉分析报告.md` | 三方交叉详细报告 |
| `迁移清单.md` | 盘点移库迁移确认清单 |
| `DataSql/Migration_to_PROD_TEST_MES.sql` | 179 迁移脚本（1577 行） |
| `Temp\opencode\dict_rows.tsv` | 字典 9589 行原始 |
| `Temp\opencode\dict_tables.tsv` | 667 表目录 |
| `Temp\opencode\compare_result.txt` | DictOnly/DbOnly 比对 |
| `Temp\opencode\dict_count3.txt` | 字段 Top25/类型 |
| `Temp\opencode\verify_fields.txt` | 前缀字段权威统计 |
| `Temp\opencode\stats_out.txt` | 字典前缀 + DB_ONLY 分类 |
| `Temp\opencode\stats_obj.txt` | 144 对象/前缀/SP 模式（2340 行） |
| `Temp\opencode\db144_overview.txt` | 144 全对象清单 |
| `Temp\opencode\db144_jobs2.txt` | 10 Job |
| `Temp\opencode\key_objects2.txt` | 盘点/OEE 对象日期 |
| `Temp\opencode\schema_probe.txt` | MaterialSysConfig + Dtl 列 |
| `Temp\opencode\code_counts.txt` | 源码计数 |

### 10.2 环境连接（分析用）

```
144: 172.16.5.144 / sa / SAsa123 / LeanMes          ← 源库（已验证）
179: 172.16.5.179 / sa / SAsa123 / PROD_TEST_MES    ← 应用生效库
U9:  172.16.5.155:55535/U9C
回写: http://172.16.5.179:8099/default.aspx
MQTT: 172.16.5.150
```

### 10.3 关键数字速查

```
字典: 667 表 / 9588 字段 / Top表 Basal_Equipment(111)
类型: int 2950, varchar 2748, nvarchar 1600, datetime 1414, decimal 393, bit 218
前缀(字典): Prod 300, Basal 184, ERP 53, SYS 41, Quality 32
144:  773 表 / 3000 SP / 544 视图 / 286 函数 / 10 Job
比对: DictOnly 0, DbOnly 106 (Prod26, ERP-History21, Test15, SKT7, ...)
SP模式: Get 514, Check 212, Save 158, Equipment 55, IQC 47, SMT 44
函数: UdfGetLBL_* 183 / 286
代码: Ajax 210, Handler 35, PDA 129, Web.cs 3432, WebAPI 124, DLL.cs 1865, Lib.dll 224
迁移差: 144 缺 911 + RealBarCode + 3 SP + 单号-25 → 目标 179
```

---

*报告生成：2026-09-22 · 数据均已用脚本复核 · 与架构报告互补，不重复章节正文*
