# 深科特 MES 系统 (LeanMES v8.5.7) 源码架构深度分析报告

> **项目**: 山东亿辰注塑MES系统
> **分析日期**: 2026-09-22
> **分析范围**: 全部源码、数据库对象、集成模块

---

## 一、系统总体架构

### 1.1 技术栈

| 层级 | 技术 |
|------|------|
| **Web层** | ASP.NET WebForms (.NET Framework 4.8) + AjaxPro |
| **API层** | ASP.NET WebAPI 2 + Swagger |
| **业务层** | C# BLL类库 (DLL模块) |
| **数据层** | SQL Server 存储过程 + Dapper ORM + SqlBulkCopy |
| **前端** | jQuery Mobile (PDA) + jQuery + ECharts/Highcharts |
| **ERP集成** | 金蝶K3云星空(E智联) + 用友U9 Cloud |
| **设备通信** | EUROMAP 63 / OPC UA / HTTP REST |
| **调度** | Quartz.NET (定时Job) |
| **日志** | log4net (Web) + NLog (WebAPI) |

### 1.2 项目结构

```
E:\source\MES\SKT\20260819\
├── Code/
│   ├── Web/                    # ASP.NET WebForms 主站点 (140+目录)
│   ├── WebAPI/                 # WebAPI 服务 (ERP同步/料塔/电子料架)
│   ├── Lib/                    # 227个预编译DLL
│   └── LeanMES.8.5.7.sln      # Web解决方案
├── DLL/                        # BLL/Model源码 (21个子模块)
│   ├── BLL/                    # 核心业务逻辑
│   ├── ERP/                    # ERP回写引擎 (WriteBackERP)
│   ├── Production/             # 生产管理
│   ├── Quality/                # 质量管理
│   ├── Transfers/              # 调拨管理
│   └── LeanMES.8.5.7.DLL.sln # DLL解决方案
├── DataSql/                    # 数据库脚本
│   ├── Stored Procedures/      # 存储过程
│   ├── Tables/                 # 表定义
│   └── Views/                  # 视图
├── LeanMES.OrderControl/       # 注塑机订单控制 (控制台程序)
├── Tools/                      # 授权工具/硬件采集
├── DataCapature/               # 设备采集文档
└── 迁移清单.md                 # 变更记录
```

### 1.3 请求处理流程

```
1. 请求进入 → SwitchModule (URL重写/API拦截)
2. Global.BeginRequest → 文件上传类型验证
3. Global.AcquireRequestState → 四重安全校验:
   ├─ License产线验证
   ├─ 登录超时检查
   ├─ XSS/SQL注入/CSRF防护
   └─ MES权限验证
4. 路由分发:
   ├─ AjaxPro请求 → AjaxServices/*.cs ([AjaxMethod])
   ├─ Handler请求 → Handler/*.ashx (IHttpHandler)
   └─ 页面请求 → *.aspx (WebForms)
5. 业务处理 → BLL → SQLHelper → SQL Server
6. 响应返回 → SwitchModule.EndRequest (耗时监控 >3秒记录日志)
```

---

## 二、核心模块架构

### 2.1 Web层 Handler处理器 (34个)

| 分类 | Handler | 功能 |
|------|---------|------|
| **认证** | Account.ashx | Session轮询、IP校验、License信息 |
| | MobileAppLogin.ashx | PDA登录(DES双层加密)、密码修改、多工厂切换 |
| **仓储** | InStock.ashx | IQC入库操作 |
| | WarehouseCheck.ashx | 仓库盘点 |
| | MoveLocation.ashx | 库位转移 |
| | CpOutStock.ashx | 成品出库 |
| **生产** | SMTLoadingMaterial.ashx | SMT上料操作 |
| | MenCallMaterial.ashx | 人工叫料 |
| **看板** | Kanban.ashx | 综合看板(产能/线体/UPPH等) |
| | IqcKanban.ashx | IQC看板 |
| | EnergyMonitoringKanBanData.ashx | 能源监控 |
| **报表** | ReportHandler.ashx | 通用报表(SP+JSON参数动态执行) |
| **文件** | UploadHander.ashx | 通用文件上传(FTP, 支持20+场景) |
| **设备** | EquipmentTree.ashx | 设备树结构 |

### 2.2 AjaxServices (190+个服务)

所有方法标注 `[AjaxMethod]`，通过 AjaxPro 框架暴露给前端。

| 业务域 | 核心Ajax服务 | 数量 |
|--------|-------------|------|
| **生产管理** | AjaxShopOrder, AjaxStation, AjaxRouter, AjaxSN, AjaxPlan, AjaxSchedule, AjaxManufacture | ~30 |
| **物料管理** | AjaxMaterial, AjaxMaterialIQC, AjaxMaterialDelivery, AjaxStock, AjaxWarehouse | ~25 |
| **质量管理** | AjaxQuality, AjaxInspection, AjaxSPC, AjaxIPQC, AjaxAnormal | ~20 |
| **设备管理** | AjaxEquipment, AjaxMaintenance, AjaxSparepart | ~15 |
| **系统管理** | AjaxAccount, AjaxNavigation, AjaxLanguage, AjaxDictionary | ~15 |
| **看板报表** | AjaxKanban, AjaxReport | ~10 |
| **ERP集成** | AjaxSAP, AjaxFormChangePDA | ~10 |

**核心数据访问模板** — `ComMethodTemplate.cs`:
- `GetSpcParams()`: 动态获取存储过程参数(带缓存, 每5分钟刷新)
- `setParaValue()`: JSON参数自动映射到SqlParameter
- `GetList<T>()` / `GetPageList<T>()`: 泛型分页查询
- 全系统所有AjaxService都依赖此模板进行数据库操作

### 2.3 DLL业务逻辑层

#### ERP回写引擎 (`DLL/ERP/WriteBackERP.cs`, 2581行)

| 方法 | 功能 | 行号 |
|------|------|------|
| `SendPost()` | K3云星空E智联回写入口 | 第44行 |
| `SendPostU9()` | U9 Cloud回写入口(通过E智联中间件) | 第159行 |
| `SendPostU9InventoryList()` | U9盘点单直传 | 第289行 |
| `WriteERP()` | K3回写分发(18种业务场景) | 第403行 |
| `WriteERPU9()` | U9回写分发 | 第1250行 |
| `HttpPostU9Api<T>()` | U9C直连WebAPI | 第2259行 |
| `IsWriteBack()` | 检查回写开关(ERP_WriteBackConfig) | 第1951行 |
| `AddWriteBackLog()` | 记录回写日志 | 第2012行 |

**18种回写业务场景 (WriteBackEnum)**:

| 枚举值 | 业务 | K3接口码 | U9方法 |
|--------|------|---------|--------|
| `WarehouseReceipt` | 仓库收料 | MOM_PurRcv_ERP | -- |
| `FinishStorage` | 成品入库 | MOM_CompRpt_ERP | ?method=prodin |
| `MaterialStorage` | 物料入库 | MOM_RcvTrans_ERP | ?method=poin |
| `IQCReturn` | IQC退料 | MOM_RejecPurRcv_ERP | -- |
| `TransferStorage` | 调拨入库 | MOM_Transfer_ERP | ?method=mtrlinout |
| `MaterialPrepare` | 仓库备料(5种) | MOM_MaterialSupply_ERP | ?method=moout |
| `SaleExWarehouse` | 销售出库 | MOM_ApprovedShip_ERP | ?method=saleout |
| `FormChangeCheck` | 形态转换 | -- | ?method=mtrlchg |
| `InventoryList` | 盘点单 | -- | U9直传 |
| ... | ... | ... | ... |

#### 生产模块 (`DLL/Production/`)

| 子模块 | 核心类 | 核心存储过程 |
|--------|--------|-------------|
| **Order(工单)** | ShopOrder | Prod_Order_Edit, uspRouterBind, uspChangeSNCurrentStep |
| **SMT(贴片)** | TransferMaterial, LoadingList, Feeder, PickList | -- |
| **Rework(返工)** | Reworks | uspBatchRework, uspFinishedProductRework |
| **Shipment(出货)** | FinishProdShipment | Prod_finishprodshipment_edit |
| **MaterialDelivery(配送)** | MaterialPrepareInfo, PickMaterialInfo | -- |

#### 质量模块 (`DLL/Quality/`)

| 子模块 | 核心类 | 核心存储过程 |
|--------|--------|-------------|
| **检验单** | InspectionOrder | Quality_InspectionOrder_Confirmation/GroupAffirm/ProjectAffirm |
| **Hold管理** | Hold | uspHoldOrUnHold, uspImportQHold |
| **RMA退货** | Rma | uspQualityRmaEidt |
| **SPC统计** | SPCProject, SPCGraph | Quality_SPCProject_Edit |
| **AQL抽样** | AQLRule, AQLPlan, AQLSample | -- |

#### 调拨模块 (`DLL/Transfers/`)

| 方法 | 功能 | 存储过程 |
|------|------|---------|
| `Edit()` | 调拨单编辑 | Prod_Transfers_Edit |
| `CheckGrnTransfer()` | 检查GRN可调拨 | uspCheckGrnCanTransfer |
| `SaveTransfer()` | 确认调拨出库 | uspSaveTransfer |

### 2.4 WebAPI项目

#### ERP同步控制器 (`ERPSyncController.cs`, 22个端点)

**核心流程**: `BaseController.SyncERPData<T>()` → BulkInsert中间表 → 存储过程同步

| 路由 | 同步内容 | 中间表 |
|------|---------|--------|
| `SyncDepartment` | 部门 | ERP_SYS_Organization |
| `SyncUser` | 用户 | ERP_SYS_Membership |
| `SyncWarehouse` | 仓库 | ERP_Basal_Warehouse |
| `SyncItem` | 物料 | ERP_Basal_Item |
| `SyncItemBom` | BOM(含明细) | ERP_Basal_ItemBom |
| `SyncOrder` | 工单(含BOM) | ERP_Prod_Order |
| `SyncPoCode` | 采购单(含明细) | ERP_ERP_PurOrder |
| `SyncDeliver` | 送货单(含明细) | ERP_Prod_Deliver |
| `SyncTransfer` | 调拨单(含明细) | ERP_Prod_Transfers |
| `SyncSalOrder` | 销售出库(含明细) | ERP_Prod_SalOrder |
| `SyncScrap` | 报废单(含明细) | ERP_Prod_Scrap |
| `SyncFormChange` | 形态转换(含3级明细) | ERP_Prod_FormChange |

#### 智能料塔 (`MeterialTowerController.cs`, 714行)

| 路由 | 功能 | 设备通信协议 |
|------|------|-------------|
| `MeterialTower/Save` | 存料(自动找空位) | HTTP POST → 料塔硬件 |
| `MeterialTower/TakeOut` | 取料亮灯 | HTTP POST |
| `MeterialTower/CallBack` | 料塔回调(MES业务) | 设备回调MES |
| `MeterialTower/CheckMeterial` | 查询储位状态 | HTTP POST |
| `MeterialTower/ClearAll` | 清空所有储位 | HTTP POST |

#### 其他控制器

| 控制器 | 功能 |
|--------|------|
| `ElectricLoctionController` | 瑞微电子料架(上架/下架回调) |
| `HWLicenseController` | 华为授权管理(刷新/释放) |
| `LeanController` | 通用SP执行/Token获取/AGV状态更新 |

---

## 三、数据库层分析

### 3.1 存储过程命名规范

| 前缀 | 模块 | 示例 |
|------|------|------|
| `Basal_` | 基础数据 | Basal_Warehouse_Edit, Basal_Jig_Edit |
| `Prod_` | 生产 | Prod_Order_Edit, Prod_Transfers_Edit |
| `Quality_` | 质量 | Quality_InspectionRule_Edit |
| `SYS_` | 系统 | SYS_Organization_Edit |
| `KanBan_` | 看板 | KanBan_CarouselConfig |
| `usp` | 通用 | uspHoldOrUnHold, uspBatchRework |
| `Common_` | 通用 | Common_GetPageRecords |

### 3.2 核心业务存储过程

#### 仓库盘点

| SP | 功能 | 涉及表 |
|----|------|--------|
| `uspSaveCheckOrder` | 盘点保存(初盘/复盘/平账) | Prod_WarehouseCheckOrder/Dtl, Prod_MaterialUnit |
| `uspWarehouseCheckCancel` | 盘点撤销(支持单SN) | Prod_WarehouseCheckOrderDtl |
| `uspWarehouseCheckCancelCheck` | 撤销前校验 | Prod_MaterialUnit |
| `uspWarehouseCheckBatch` | 批量盘点扫描 | Prod_WarehouseCheckOrderDtl |
| `uspGetWhMaterial` | 获取仓库物料 | Prod_MaterialUnit, Basal_Item |
| `uspWarehouseCheckHandleLocationDiff_Program` | 库位差异自动处理 | Prod_MaterialUnit, Prod_WarehouseCheckOrderDtl |
| `uspWarehouseCheckDifferenceList` | 盘点差异明细查询 | 6表联接 |
| `uspGetCheckOrderDetail` | 盘点单明细 | Prod_WarehouseCheckOrderDtl |
| `uspWarehouseCheckMoveMaterial_Program` | 盘点物料移动 | Prod_MaterialUnit, Prod_MaterialSysConfig |
| `uspWarehouseCheckTransferIn_Program` | 跨仓调拨入库 | Prod_Transfers/Dtl |

#### 物料/仓库

| SP | 功能 | 涉及表 |
|----|------|--------|
| `uspStorageTransfer` | 库位转移(含包装箱) | Prod_MaterialUnit |
| `uspSaveTransferIn` | 调拨入库 | Prod_Transfers/Dtl |
| `uspGenerateItemSN` | 单号生成 | Basal_SerialNumber |

#### 设备OEE

| SP | 功能 | 涉及视图 |
|----|------|---------|
| `uspEquipmentOEEReport` | OEE报表查询 | vwEquipmentOEE |
| `uspGetCollectionEngelDataHistoryReport` | 采集历史明细 | Prod_CollectionEngelDataHistory |
| `uspGetEquipmentShiftStatusTimeReport` | 班次状态时间 | -- |

### 3.3 核心业务表

| 表名 | 用途 | 关键列 |
|------|------|--------|
| `Prod_MaterialUnit` | 物料单元(库存) | MaterialUnitId, cBarCode, BalanceQty, Status, Flag, WarehouseId |
| `Prod_MaterialUnitHistory` | 物料操作历史 | ActionType(1=入库/2=移库/40=复盘/41=初盘/42=平账/43=盘点移库) |
| `Prod_WarehouseCheckOrder` | 盘点单主表 | CheckOrder, CheckOrderStatus(2=待初盘/3=初盘完成/4=复盘完成/5=已平账) |
| `Prod_WarehouseCheckOrderDtl` | 盘点单明细 | StockQty(初盘)/RepeatQty(复盘)/NowQty(实盘)/RealBarCode(实际库位) |
| `Prod_Transfers` | 调拨单主表 | TransfersNo, TransfersType(0=无/1=委外/2=销售/3=超期) |
| `Prod_TransfersDtl` | 调拨单明细 | ItemCode, ApplyQty, FinishQty |
| `ERP_WriteBackConfig` | ERP回写开关 | WriteBackCode, WriteBackFlag |
| `ERP_WriteBackLog` | ERP回写日志 | ERPResult(-1失败/0未写/1成功) |
| `Prod_MaterialSysConfig` | 系统配置 | ConfigTypeId, ConfigResult(如911=盘点移库方式) |
| `Basal_SerialNumber` | 单号规则 | Next_Number_Type, Prefix(如Tra%YEAR%%MONTH%) |

### 3.4 设备OEE视图 (vwEquipmentOEE)

**关键设计**:
- 使用CTE + `LAG()`窗口函数分析ENGEL设备采集历史状态
- 精确时间区间分析: Prod/Standby/CommInt(通讯中断)/Other
- OEE = 生产时间占比 × 良品率

---

## 四、ERP集成架构

### 4.1 三种集成模式

```
模式1: E智联中间件 (K3云星空)
  MES → HTTP POST(JSON/ESIPBean) → E智联中间件 → K3 API
  认证: HTTP Header (MD5 + authCode)

模式2: E智联中间件 (U9 Cloud)
  MES → HTTP POST(JSON/U9Bean) → E智联中间件 → U9 API
  认证: HTTP Header (MD5 + authCode)

模式3: U9C直连WebAPI
  MES → HTTP POST(JSON) + OAuth2 Token → U9 Cloud WebAPI
  认证: OAuth2 (clientid + clientsecret → Token)
```

### 4.2 ERP同步方向

```
ERP → MES (推送同步):
  ERP推送JSON → WebAPI(ERPSyncController) → BulkInsert中间表 → 存储过程执行同步

MES → ERP (回写):
  MES业务操作 → WriteBackERP.SendPost() → HTTP POST → ERP系统

集团总部 → 子工厂:
  SyncJob(Quartz定时) → 查询ERP_Json增量 → HTTP POST → 子工厂WebAPI
```

### 4.3 关键配置项 (Web.config)

| 配置键 | 用途 |
|--------|------|
| `ERPWriteUrl` | K3 E智联回写URL |
| `ERPWriteUrlInventoryList` | U9盘点直传URL |
| `ERPsType` | 服务类型(1001同步/2001异步无序/2002异步有序) |
| `ERPServerName` | 环境标识(测试/生产) |
| `ERPMD5` / `ERPAuthCode` | E智联认证参数 |
| `U9CUrl` / `U9Cclientid` | U9C直连配置 |
| `U9TokenUrl` / `U9ClientId` | U9 OAuth2认证 |
| `GroupHeadquartersFlag` | 集团总部标识(1=总部/0=子工厂) |
| `SubFactory` | 子工厂代码 |

---

## 五、订单控制监控模块 (LeanMES.OrderControl)

### 5.1 功能概述

独立控制台程序，监控注塑机生产数量，达到订单目标时自动发送停止命令。

### 5.2 设备通信

| 设备品牌 | 协议 | 读取方式 | 停止命令 |
|---------|------|---------|---------|
| 恩格尔(Engel) | EUROMAP 63 | 读取MESData.dat文件 | 写入SESS0001.REQ |
| 海天(Haitian) | OPC UA | 读取节点PartSts/ActCntPrt | 写入ns=2;s=StopCommand |
| 德马格(Demag) | OPC UA | 读取节点PartSts/ActCntPrt | 写入ns=2;s=StopCommand |

### 5.3 控制流程

```
ERP_Prod_Order → SyncOrdersFromMES → OrderControl表
    ↓
JobOrderControl (每30秒)
    ↓
读取机台数量 → 比较 ≥ 订单数量?
    ↓ YES
发送停止命令 → 更新状态 + 日志
```

---

## 六、移动端 (PDA) 模块

### 6.1 页面结构 (133个页面)

| 模块 | 页面数 | 核心页面 |
|------|--------|---------|
| **仓库管理(type=4)** | 30+ | InStock(入库), WarehouseCheck(盘点), MoveLocation(移库), CpInStock(成品入库), CpOutStock(成品出库), TransferOut/In(调拨) |
| **生产管理(type=5)** | 15+ | HandLoadingMaterial(上料), PDAProductionCollection(采集), CheckSMTLoadingMaterial(SMT校验) |
| **设备管理(type=6)** | 12+ | EQ_SteelNet(钢网上下线), EquipmentSendRepair(报修), EquipmentRepair(维修) |
| **品质管理(type=7)** | 5+ | Reinspection(送检), PDAQualityInStock(品质入库) |

### 6.2 PDA通信方式

```
PDA页面 → AjaxServices调用:
  AjaxWarehouseCheck.*, AjaxMaterial.*, AjaxEquipment.*
PDA页面 → Handler调用:
  Handler/SMTLoadingMaterial.ashx, Handler/MobileAppLogin.ashx
```

---

## 七、安全机制

### 7.1 四重安全防护

| 防护层 | 实现位置 | 功能 |
|--------|---------|------|
| **SQL注入防护** | SqlInjectableHelper.cs | QueryString/Form参数校验, 关键字文件(SqlKeyword.txt)缓存30分钟 |
| **XSS防护** | Global.cs AcquireRequestState | 检测Cookie/QueryString/Form中的脚本注入 |
| **CSRF防护** | AntiXSRFHelper.cs | X-AjaxPro-Key时间戳验证(超时300秒) |
| **MES权限验证** | AccountController.CheckUserPopedom | 存储过程uspCheckUserPopedom |

### 7.2 文件安全验证

`FileValidator.cs`:
- 扩展名白名单验证
- 文件签名(Magic Numbers)验证
- 路径遍历防护

### 7.3 WebSafeSet配置

```json
{"sql":1, "xss":1, "auth":1, "csrf":300, "formAuth":0, "csrf-token":0}
```

---

## 八、常见问题排查指南

### 8.1 ERP回写问题

| 问题 | 排查步骤 |
|------|---------|
| 回写失败 | 1. 查 `ERP_WriteBackLog` 表日志 → 2. 检查 `ERP_WriteBackConfig` 开关 → 3. 检查网络连通性 |
| 回写超时 | 检查 `ERPsType` 配置(同步1001/异步2001) |
| K3返回错误 | 查ESIPBean日志, 检查sName接口码是否正确 |
| U9 Token过期 | 检查U9TokenUrl/U9ClientId配置, 确认OAuth2认证流程 |

### 8.2 盘点问题

| 问题 | 排查步骤 |
|------|---------|
| 盘点保存失败 | 检查盘点单状态(2=待初盘/3=初盘完成), 查看uspSaveCheckOrder执行结果 |
| 库位差异不处理 | 检查配置911(ConfigResult='1'当场移/'2'只记录) |
| 复盘数量异常 | 检查uspGetCheckOrderDetail是否已修复CAST(INT)截断问题 |
| 包装箱撤销异常 | 检查ScannedSN参数是否正确传递 |

### 8.3 设备OEE问题

| 问题 | 排查步骤 |
|------|---------|
| OEE数据异常 | 检查vwEquipmentOEE视图, 确认Prod_CollectionEngelDataHistory数据完整 |
| 状态判断错误 | 检查LAG()窗口函数的状态转换逻辑 |
| 设备通讯中断 | 检查Prod_EquipmentStatusCollectionCurrent表的CurrentStatus |

### 8.4 订单控制问题

| 问题 | 排查步骤 |
|------|---------|
| 工单未同步 | 检查usp_OrderControl_GetActiveOrders, 确认ERP_Prod_Order有数据 |
| 读取数量为0 | 检查MachineConfig配置(EquipmentIP/Euromap63Path), 测试连接 |
| 停止命令未发送 | 检查ControlEnabled=1, TargetReached=0, StopCommandSent=0 |

### 8.5 PDA页面问题

| 问题 | 排查步骤 |
|------|---------|
| 登录失败 | 检查MobileAppLogin.ashx, 确认DES加密正常 |
| 无法获取数据 | 检查AjaxService连接, 查看浏览器控制台AjaxPro请求 |
| CSRF超时(非法请求:024) | 检查Web.config WebSafeSet的csrf值(建议300秒) |

---

## 九、关键设计决策

1. **存储过程驱动**: 所有业务逻辑通过SQL Server存储过程实现, BLL层仅负责参数组装
2. **ERP双轨集成**: 同时支持金蝶K3(E智联)和用友U9(中间件+直连)两套ERP
3. **通用分页机制**: 全系统使用 Common_GetPageRecords + SearchSettings 统一分页
4. **ComMethodTemplate万能模板**: 90%的AjaxService通过此模板进行数据库操作
5. **盘点"以实物为准"**: GRN不存在/不在库时跳过物理移库, 仅记录实际库位
6. **包装箱内单个SN撤销**: uspWarehouseCheckCancel新增ScannedSN参数
7. **设备OEE精确计算**: 使用CTE+LAG()窗口函数分析设备状态历史

---

## 十、技术债务与优化建议

### 10.1 高优先级

| 问题 | 风险 | 建议 |
|------|------|------|
| WebAPI SQL注入风险 | LeanController.Runprocedure使用字符串拼接 | 改用参数化查询 |
| Ult.CacheHelper非线程安全 | 静态Dictionary并发问题 | 改用ConcurrentDictionary或MemoryCache |
| WebAPI安全配置IsEasyParamMode=true | 跳过签名和Token验证 | 生产环境设为false |
| WebAPI IsAuth=false | 未启用Token授权 | 生产环境设为true |

### 10.2 中优先级

| 问题 | 风险 | 建议 |
|------|------|------|
| ASP.NET WebForms技术老旧 | 维护成本高, 无现代化框架支持 | 考虑逐步迁移到Blazor/Razor Pages |
| 227个预编译DLL无源码 | 无法调试/修改部分模块 | 将关键DLL源码纳入版本控制 |
| 数据库表结构无DDL脚本 | 表结构变更不可追溯 | 补充所有表的CREATE TABLE脚本 |
| 部分SP使用游标 | 性能问题(如HandleLocationDiff) | 改用集合操作 |

### 10.3 低优先级

| 问题 | 建议 |
|------|------|
| AjaxServices数量过多(190+) | 考虑按业务域拆分控制器 |
| 前端无统一状态管理 | 引入简单状态管理方案 |
| 日志框架不统一(Web用log4net, WebAPI用NLog) | 统一日志框架 |

---

## 十一、快速定位索引

### 按业务场景定位

| 场景 | 关键文件/存储过程 |
|------|-----------------|
| **物料入库** | Web/Material/MaterialInStorage.aspx, DLL/ERP/WriteBackERP.cs(Mode=MaterialStorage) |
| **成品出库** | Web/Warehouse/CpOutStock.aspx, DLL/ERP/WriteBackERP.cs(Mode=SaleExWarehouse) |
| **仓库盘点** | Web/MobileApp/WarehouseCheck.aspx, DataSql/uspSaveCheckOrder.sql, DataSql/uspWarehouseCheckCancel.sql |
| **调拨管理** | Web/Transfers/, DLL/Transfers/Transfers.cs, DataSql/uspSaveTransferIn.sql |
| **ERP数据同步** | Code/WebAPI/Controllers/ERPSyncController.cs, DataPushDao |
| **ERP回写** | DLL/ERP/WriteBackERP.cs, ERP_WriteBackLog表 |
| **设备OEE** | DataSql/vwEquipmentOEE_new.sql, DataSql/uspEquipmentOEEReport.sql |
| **订单控制** | LeanMES.OrderControl/Job/JobOrderControl.cs, Dao/OrderControlDao.cs |
| **料塔管理** | Code/WebAPI/Controllers/MeterialTowerController.cs, MaterialTower/MaterialTower.cs |
| **SMT上料** | Code/Web/Handler/SMTLoadingMaterial.ashx, MobileApp/js/skt.mobile.SMTCheckMaterial.js |
| **设备报修** | Web/MobileApp/EquipmentSendRepair.aspx, DLL/Equipment/ |
| **标签打印** | Web/Labels/Design.aspx, AjaxPrint服务 |

### 按模块定位

| 模块 | Web目录 | DLL目录 | 数据库对象 |
|------|---------|---------|-----------|
| 仓库 | Warehouse/, MobileApp/ | DLL/BasalData/Warehouse/ | Basal_Warehouse_*, uspStorageTransfer |
| 物料 | Material/ | DLL/BasalData/ | Prod_MaterialUnit, Basal_Item |
| 生产 | Manufacture/, Plan/ | DLL/Production/ | Prod_Order_*, uspBatchRework |
| 质量 | Quality/ | DLL/Quality/ | Quality_InspectionOrder_* |
| 设备 | Equipment/ | DLL/Equipment/ | Basal_Equipment*, vwEquipmentOEE |
| 调拨 | Transfers/ | DLL/Transfers/ | Prod_Transfers_* |
| 看板 | Kanban/ | DLL/Kanban/ | uspK*_Get* |
| 系统 | User/, Role/, Popedom/ | DLL/SystemInfo/ | SYS_* |
