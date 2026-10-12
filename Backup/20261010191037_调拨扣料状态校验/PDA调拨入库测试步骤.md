# PDA 调拨入库确认弹窗 — 测试步骤

## 前置条件（已就绪）

| 项目 | 值 | 状态 |
|---|---|---|
| 测试库 | 172.16.5.179 / PROD_TEST_MES | ✅ |
| 检查SP | uspCheckTransferInLoadingRecords_Program | ✅ 已部署 |
| 扣料SP | uspBoardCountPickListInjectionMaterial（含Status=2） | ✅ 已验证 |
| 前端改动 | TransferIn.aspx + TransferInAgv.aspx | ⚠️ 需部署到IIS |
| 编译产物 | Code\Web\bin\SKT.LeanMES.Web.dll | ⚠️ 需同步 |

## 需部署的文件

将以下文件复制到 localhost IIS 站点对应目录：
1. `Code\Web\MobileApp\TransferIn.aspx`
2. `Code\Web\MobileApp\TransferInAgv.aspx`
3. `Code\Web\bin\SKT.LeanMES.Web.dll`（如未自动同步）

部署后重启 IIS 应用程序池或执行 `iisreset`。

---

## 测试场景1：有上料记录 → 弹窗确认

### 目的
验证调拨入库前检测到上料记录时，弹窗展示并让用户确认。

### 步骤
1. 打开 PDA 调拨入库页面（TransferIn.aspx）
2. 选择一个调拨单（出库方向为非线边仓）
3. 扫描一个**有上料记录**的 GRN，例如：
   - `GRN250327000045`（手插上料，Status=2，料桶003）
   - `GRN251224000065`（注塑上料，Status=0）
4. 扫描库位条码
5. 点击"确认调拨"

### 预期结果
弹出确认框，显示类似：
```
以下GRN存在上料记录：
GRN:GRN250327000045  类型:手插上料  余量:2.00
GRN:GRN251224000065  类型:注塑上料  余量:133.80

调拨入库将自动删除这些上料记录，是否继续？
```

### 分支测试
- **点"确定"** → 继续调拨流程，最终提示"调拨成功！"，上料记录被删除
- **点"取消"** → 中止调拨，不做任何修改

---

## 测试场景2：无上料记录 → 直接调拨

### 步骤
1. 同上，但扫描一个**没有上料记录**的 GRN（例如仓库中Status=0且不在任何料桶/工位上的GRN）
2. 点击"确认调拨"

### 预期结果
- 不弹出上料记录确认框
- 直接弹出"是否确认调拨?"
- 确认后调拨成功

---

## 测试场景3：注塑扣料拦截（方案B回归）

### 步骤
1. 把料桶003上所有物料 Status 改为非2（如Status=1）
2. 用工单 S260110B032-1（32号注塑机）点"良品标签打印"
3. 测试完成后恢复 Status=2

### 预期结果
提示"没有可扣数物料,请及时续料!"

---

## 数据准备 SQL

### 恢复料桶003物料为可扣状态
```sql
UPDATE Prod_MaterialUnit SET Status = 2
WHERE MaterialUnitId IN (370464, 598918, 596190);
```

### 制造无可扣状态（测试场景3用）
```sql
UPDATE Prod_MaterialUnit SET Status = 1
WHERE MaterialUnitId IN (370464, 598918, 596190);
```

### 验证检查SP
```sql
-- 应返回有上料记录
EXEC uspCheckTransferInLoadingRecords_Program '[{"GRN":"GRN250327000045"},{"GRN":"GRN251224000065"}]';

-- 应返回空
EXEC uspCheckTransferInLoadingRecords_Program '[{"GRN":"GRN260316000119"}]';
```

---

## 回滚方案

### 179 测试库回滚SP
```sql
-- 回滚扣料SP（去掉Status=2校验）
-- 使用备份文件：Backup\20261010191037_调拨扣料状态校验\bak_uspBoardCountPickListInjectionMaterial_20261010191037.sql
-- 执行 DROP + CREATE 备份版本

-- 删除检查SP
DROP PROCEDURE IF EXISTS uspCheckTransferInLoadingRecords_Program;
```

### 前端回滚
恢复原始 `TransferIn.aspx` / `TransferInAgv.aspx` 并重新编译部署。

---

## 144 正式库上线清单（待批准后执行）

| 序号 | 对象 | 操作 | 备份文件 |
|---|---|---|---|
| 1 | uspBoardCountPickListMaterial | ALTER（加Status=2） | bak_uspBoardCountPickListMaterial_*.sql |
| 2 | uspBoardCountPickListInjectionMaterial | ALTER（加Status=2） | bak_uspBoardCountPickListInjectionMaterial_*.sql |
| 3 | uspBoardCountPickListInjectionMaterial_Old | ALTER（加Status=2） | bak_uspBoardCountPickListInjectionMaterial_Old_*.sql |
| 4 | uspSaveTransferIn | ALTER（加3.1节清理上料关系） | bak_uspSaveTransferIn_*.sql |
| 5 | uspCheckTransferInLoadingRecords_Program | CREATE（新SP） | 无（新建） |
| 6 | TransferIn.aspx | 替换 | 原文件备份 |
| 7 | TransferInAgv.aspx | 替换 | 原文件备份 |
| 8 | SKT.LeanMES.Web.dll | 替换 | 原DLL备份 |

备份目录：`Backup\20261010191037_调拨扣料状态校验\`
