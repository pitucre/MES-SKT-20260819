-- ============================================================================
-- 179 测试库（172.16.5.179 / PROD_TEST_MES）预警功能测试数据准备
-- 工单 S260926003-1（ProdOrderID=61859，LotSize=14）
-- 原值：Qty_Released = 77（剩余 530，约 37 批，不触发预警）
-- 改为：Qty_Released = 579（剩余 28 = 2 批，触发「再打印 2 个批次即达工单数量」）
-- 测试完成后还原：UPDATE dbo.Prod_Order SET Qty_Released = 77 WHERE ProdOrderID = 61859;
-- ============================================================================
UPDATE dbo.Prod_Order SET Qty_Released = 579 WHERE ProdOrderID = 61859;

-- 验证
SELECT a.OrderNO, b.ItemCode, b.ItemName, b.ItemSpec, b.LotSize,
       a.Qty_to_Build OrderQty, a.Qty_Released PrintedQty,
       a.Qty_to_Build - a.Qty_Released NotReleasedQty,
       (a.Qty_to_Build - a.Qty_Released) / NULLIF(b.LotSize, 0) LeftBatches
FROM dbo.Prod_Order a
INNER JOIN dbo.Basal_Item b ON b.ItemID = a.ItemId
WHERE a.ProdOrderID = 61859;
