# 完整测试手册（4个Bug）——深科特 MES 测试环境

- 测试环境：浏览器访问 **localhost IIS**（Web.config 已指向 `172.16.5.179 / PROD_TEST_MES`）
- 测试日期基线：2026-10-12
- 测试数据已全部由脚本预置，**开测前请先执行下方 SQL 复核数据**，若不一致联系开发重置

---

## 测试前数据复核（必做）

在 `PROD_TEST_MES` 库执行：

```sql
-- 期望结果：1张单、2条明细、2条明细物料、2条注塑上料记录、2个GRN状态均为20
SELECT t.TransfersId, t.TransfersNo, t.Statue, t.Auditing, t.OutWhouse, t.InWhouse
FROM Prod_Transfers t WHERE t.TransfersNo='TEST20261010001';
-- 期望：TransfersId=5303, Statue=0, Auditing=1, 出库107, 入库101

SELECT d.TransfersDtlId, d.ItemCode, d.ApplyQty, d.FinishQty, m.GRN
FROM Prod_TransfersDtl d
LEFT JOIN Prod_TransfersDtlMaterial m ON m.TransfersDtlId=d.TransfersDtlId
WHERE d.TransfersId=5303;
-- 期望：17762/0602-00034/133.8042/GRN251224000065；17763/0302-00045/80.2575/GRN260107000057

SELECT SerialNumber, BalanceQty, Status FROM Prod_MaterialUnit
WHERE SerialNumber IN ('GRN251224000065','GRN260107000057');
-- 期望：两行 Status 均 = 20（调拨中）

SELECT LoadId, MaterialBucketCode, ItemCode, GRN, MaterialUnitId
FROM Prod_InjectionLoadingMaterial WHERE MaterialUnitId IN (572697,596191);
-- 期望：2行（LoadId 9589/9590，料桶003，注塑上料）
```

若不一致，重置脚本见本文末尾「附：测试数据重置脚本」。

---

## Bug④ PDA调拨入库——上料记录确认弹窗（重点测试项）

### 测试数据速查

| 项目 | 值 |
|---|---|
| 调拨单号 | `TEST20261010001` |
| 出库仓库 | 107 线边仓库-注塑 |
| 调入仓库 | 101 一楼立体仓库 |
| 库位条码 | `A1-1`（101仓库） |
| 明细1 | 物料 `0602-00034`，GRN `GRN251224000065`，余量 133.8042 |
| 明细2 | 物料 `0302-00045`，GRN `GRN260107000057`，余量 80.2575 |
| 上料记录 | 两个 GRN 均有「注塑上料」记录（料桶003） |

### 前置条件

1. 已把 `Code\Web\MobileApp\TransferIn.aspx`、`TransferInAgv.aspx`、`bin\SKT.LeanMES.Web.dll` 部署到 localhost IIS，并**重启应用程序池**（否则弹窗逻辑不生效——DLL 未更新）。
2. 测试前数据复核通过。

### 页面入口

浏览器打开：`http://localhost/MobileApp/TransferIn.aspx`（PDA 调拨入库页，标题「调拨入库」）。

> **校验时机说明**：上料记录检查在**扫描 GRN 当场**弹窗（点「取消」= 不加入该 GRN）；点「确认调拨」时还有一次兜底检查（一般不会再弹）。

### 用例 4-1：正常流程 + 扫描时弹窗确认继续（主场景）

| 步骤 | 操作 | 预期结果 |
|---|---|---|
| 1 | 进入页面，「调拨单号」输入 `TEST20261010001`，按 **Enter** | 页面加载单据：来源单号为空；调入仓库显示「一楼立体仓库」；下方明细表出现 2 行：`0602-00034`（调拨数量133.8042，扫描数量0）、`0302-00045`（调拨数量80.2575，扫描数量0） |
| 2 | 「库位条码」输入 `A1-1`，按 **Enter** | 库位校验通过，无报错（焦点自动跳到 GRN 条码框） |
| 3 | 「GRN条码」输入 `GRN251224000065`，按 **Enter** | **立即弹出提示框**（扫描当场，不是等确认调拨）：`以下GRN存在上料记录：`<br>`GRN:GRN251224000065 类型:注塑上料 余量:133.804200`<br>`调拨入库将自动删除这些上料记录，是否继续？` |
| 4 | 点「**确定**」 | 提示框关闭；明细1「扫描数量」变为 133.8042；页面出现绿色文字「该物料条码【GRN251224000065】扫描成功！」 |
| 5 | 再次扫库位 `A1-1`（如需）；「GRN条码」输入 `GRN260107000057`，按 **Enter** | **再次弹出**提示框（内容为 GRN260107000057 的上料记录） |
| 6 | 点「**确定**」 | 明细2「扫描数量」变为 80.2575 |
| 7 | 点击底部按钮「**确认调拨**」 | **直接弹** `是否确认调拨？`（上料已在扫描时确认过，兜底检查不再弹） |
| 8 | 点「**确定**」 | 页面中部出现**绿色**文字「调拨成功！」，页面刷新、明细清空 |
| 9 | 数据库验证（见下方 SQL） | 调拨完成、上料记录被自动删除 |

用例 4-1 完成后数据库验证 SQL：

```sql
-- 期望：注塑上料 0 条（已被自动清理）
SELECT COUNT(*) FROM Prod_InjectionLoadingMaterial WHERE MaterialUnitId IN (572697,596191);
-- 期望：两个 GRN 状态变为入库对应状态（不再是 20）
SELECT SerialNumber, Status FROM Prod_MaterialUnit WHERE SerialNumber IN ('GRN251224000065','GRN260107000057');
```

### 用例 4-2：扫描时弹窗点「取消」——不加入该 GRN

1. 执行「附：测试数据重置脚本」恢复数据。
2. 重复用例 4-1 步骤 1~3，扫 `GRN251224000065` 弹出上料提示时点「**取消**」。
3. **预期**：
   - 明细1「扫描数量」仍为 **0**（GRN 未加入本次入库）
   - 页面出现红色文字：`该物料条码【GRN251224000065】存在上料记录，已取消扫描！`
   - GRN 条码框被清空、焦点回到 GRN 框，可继续扫其他 GRN
   - **不弹**「是否确认调拨」相关流程
4. 数据库验证：上料记录仍为 2 条（未删除）。

### 用例 4-3：取消后仍可重新扫描继续（可选恢复）

1. 接用例 4-2（GRN251224000065 已被取消、未加入）。
2. 重新扫 `GRN251224000065`，再次弹窗时点「**确定**」。
3. **预期**：明细1「扫描数量」变为 133.8042，后续可正常完成调拨。

### 用例 4-4：无上料记录时——不弹上料提示

1. 执行「附：测试数据重置脚本」。
2. 把其中一个 GRN 的上料记录临时删掉再测：
   ```sql
   DELETE FROM Prod_InjectionLoadingMaterial WHERE MaterialUnitId=572697;
   ```
3. 重复用例 4-1 步骤 1~4（只扫 GRN251224000065）。
4. **预期**：扫描**不弹**上料提示，直接显示「该物料条码【GRN251224000065】扫描成功！」；点「确认调拨」也**只弹** `是否确认调拨？`。

### 用例 4-5：回归——GRN 状态非调拨中时的拦截（负向）

1. 执行重置脚本后，把 GRN 改回在库状态：
   ```sql
   UPDATE Prod_MaterialUnit SET Status=0 WHERE SerialNumber='GRN251224000065';
   ```
2. 重复用例 4-1 步骤 1~2 后扫该 GRN。
3. **预期**：弹出 `只能操作状态为调拨中的物料!`（原有拦截逻辑未被破坏，且该提示先于上料记录弹窗）。

### 用例 4-6：AGV 页面同步验证（抽测）

同样步骤在 `http://localhost/MobileApp/TransferInAgv.aspx`（调拨入库-AGV）执行用例 4-1 步骤 1~8，预期结果完全一致。
> 注意：AGV 页面只测弹窗部分；调拨数据共用，测完 4-1 后需重置脚本再测 AGV。

---

## Bug② 注塑扣料 Status=2拦截 + 提示优化（回归）

### 测试数据速查（料桶003）

| GRN | MaterialUnitId | 物料 | 余量 | Status | 能否扣料 |
|---|---|---|---|---|---|
| GRN250805000055 | 370464 | 0602-00034 | 213.25 | 2 在产线 | ✅ 可扣 |
| GRN260109000022 | 598918 | 0602-00034 | 973.25 | 2 在产线 | ✅ 可扣 |
| GRN260107000056 | 596190 | 0302-00045 | 106.21 | 2 在产线 | ✅ 可扣 |
| GRN260107000057 | 596191 | 0302-00045 | 80.26 | 0（正常态） | ❌ 被拦截 |
| GRN251224000065 | 572697 | 0602-00034 | 133.80 | 0（正常态） | ❌ 被拦截 |

> 注意：测试 Bug④ 期间 GRN251224000065/GRN260107000057 被置为 Status=20。测 Bug② 前先重置（见脚本）。

### 用例 2-1：有余量但状态非在线 → 新提示（重点）

| 步骤 | 操作 | 预期结果 |
|---|---|---|
| 1 | 数据库把料桶003可扣物料全部改成不可扣：`UPDATE Prod_MaterialUnit SET Status=0 WHERE MaterialUnitId IN (370464,598918,596190);` | — |
| 2 | 打开 **32号注塑机** 的标签打印操作（良品标签打印，工单 `S260110B032-1`，料号 `0602-00034`），触发扣料 | 弹出提示：`物料编码[0602-00034]物料名称[SR150(85) HIPS OOV WHITE 粉碎料]有余量[xxx]但状态非在线(状态:0)，无法扣料，请检查物料状态!`（**不是**旧提示"没有可扣数物料"） |
| 3 | 数据库恢复：`UPDATE Prod_MaterialUnit SET Status=2 WHERE MaterialUnitId IN (370464,598918,596190);`，刷新页面重试 | 打印恢复正常（回归通过） |

### 用例 2-2：真没料 → 维持原提示

1. 把料桶003所有上料记录的余量清零（或选一个余量为0的桶）：
   ```sql
   UPDATE Prod_MaterialUnit SET BalanceQty=0 WHERE MaterialUnitId IN (370464,598918,596190);
   ```
2. 触发同工单扣料。
3. **预期**：提示 `没有可扣数物料,请及时续料!`（原提示未变）。
4. 测完恢复余量（原值：213.25 / 973.25 / 106.21）。

### 用例 2-3：Status≠2 时扣料强制拦截（SP层回归）

1. 改 Status=1（在线边仓）后打印。
2. **预期**：无任何扣料发生（数据库 `Prod_PickSnapshotDetail` 无新增该料桶记录），提示同 2-1 或"没有可扣数物料"。

---

## Bug③ 生产日期不一致（待实施后测试，先跳过）

- 现状：物料列表「生产日期」= `Prod_MaterialUnit.DateCode`；标签「生产日期」= `UdfGetLBL_SNWorkDate()`（优先 `Prod_Unit.WorkDate`）。
- 实施后测试要点：同一 GRN 在①条码标签②Web物料列表 两处显示的生产日期必须一致。

---

## Bug① 出库单合并单元格（已上线，回归抽测）

- 页面：Web 端「销售出库单」打印预览（`CPSalePrint` 模板）。
- 预期：同一客户/单号多行明细的客户名称、单号等字段纵向合并单元格，不再重复显示。

---

## 附：测试数据重置脚本

Bug④ 每轮测试前执行（重置调拨单+上料记录+GRN状态）：

```sql
USE PROD_TEST_MES;
SET NOCOUNT ON;

-- 1. 删旧调拨单（按单号全清，避免重复单）
DELETE m FROM Prod_TransfersDtlMaterial m
  INNER JOIN Prod_TransfersDtl d ON d.TransfersDtlId=m.TransfersDtlId
  INNER JOIN Prod_Transfers t ON t.TransfersId=d.TransfersId
  WHERE t.TransfersNo='TEST20261010001';
DELETE d FROM Prod_TransfersDtl d
  INNER JOIN Prod_Transfers t ON t.TransfersId=d.TransfersId
  WHERE t.TransfersNo='TEST20261010001';
DELETE FROM Prod_Transfers WHERE TransfersNo='TEST20261010001';

-- 2. 建调拨单
INSERT INTO Prod_Transfers (TransfersNo, TransfersType, Statue, OutWhouse, InWhouse, CreateBy, CreateDateTime, Auditing, BillDate)
VALUES ('TEST20261010001', 0, 0, '107', '101', 'admin', GETDATE(), 1, GETDATE());
DECLARE @tid INT = SCOPE_IDENTITY();

-- 3. 明细
INSERT INTO Prod_TransfersDtl (TransfersId, ItemCode, ApplyQty, FinishQty, Statue, CreateBy, CreateDateTime, InWhouse, OutWhouse, OnPosQty)
VALUES (@tid, '0602-00034', 133.8042, 0, 0, 'admin', GETDATE(), '101', '107', 0);
DECLARE @d1 INT = SCOPE_IDENTITY();
INSERT INTO Prod_TransfersDtl (TransfersId, ItemCode, ApplyQty, FinishQty, Statue, CreateBy, CreateDateTime, InWhouse, OutWhouse, OnPosQty)
VALUES (@tid, '0302-00045', 80.2575, 0, 0, 'admin', GETDATE(), '101', '107', 0);
DECLARE @d2 INT = SCOPE_IDENTITY();

-- 4. 明细物料（TransfersId 必须与主单一致！）
INSERT INTO Prod_TransfersDtlMaterial (TransfersId, TransfersDtlId, GRN, IsOnShelf)
VALUES (@tid, @d1, 'GRN251224000065', 0), (@tid, @d2, 'GRN260107000057', 0);

-- 5. 恢复注塑上料记录（料桶003）
DELETE FROM Prod_InjectionLoadingMaterial WHERE MaterialUnitId IN (572697,596191);
INSERT INTO Prod_InjectionLoadingMaterial (MaterialBucketCode, ItemCode, GRN, MaterialUnitId, ItemId, IsComplete, CreateDateTime, UserId)
VALUES ('003','0602-00034','GRN251224000065',572697,5137,0,GETDATE(),1),
       ('003','0302-00045','GRN260107000057',596191,5099,0,GETDATE(),1);

-- 6. GRN 置调拨中（扫描前置条件）
UPDATE Prod_MaterialUnit SET Status=20 WHERE MaterialUnitId IN (572697,596191);
```

重置后复核：

```sql
SELECT t.TransfersId, t.TransfersNo, d.TransfersDtlId, d.ItemCode, m.GRN
FROM Prod_Transfers t
INNER JOIN Prod_TransfersDtl d ON d.TransfersId=t.TransfersId
LEFT JOIN Prod_TransfersDtlMaterial m ON m.TransfersDtlId=d.TransfersDtlId
WHERE t.TransfersNo='TEST20261010001';
-- 期望 TransfersId 只有一个值且两行相同；GRN 两行都有值
```
