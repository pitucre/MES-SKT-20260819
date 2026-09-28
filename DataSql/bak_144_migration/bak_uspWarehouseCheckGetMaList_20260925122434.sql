-- Backup of uspWarehouseCheckGetMaList on 144 LeanMes 20260925122434 (full, 1510 chars)

/*****************************
项目名称：山东亿辰
功能描叙：
创 建 人：xi.zhu
创建时间：2024-09-22
更新信息: 
测试调试：
EXEC dbo.uspWarehouseCheckGetMaList @GRN = 'GRN2022060200284',  -- varchar(50)
                                    @Status = -1 -- int

EXEC dbo.uspWarehouseCheckGetMaList @GRN = 'GRN2022051400120',  -- varchar(50)
                                    @Status = -1 -- int								
*/

CREATE PROC uspWarehouseCheckGetMaList
@GRN VARCHAR(50),
@Status INT =-1
AS
BEGIN  


DECLARE @ParenGRN VARCHAR(50);
SELECT  @ParenGRN=p.SerialNumber  FROM dbo.Prod_MaterialUnit t WITH(NOLOCK)
    LEFT JOIN Prod_MaterialUnit p WITH(NOLOCK)
        ON t.PID = p.MaterialUnitId 
WHERE t.SerialNumber = @GRN 
AND T.StatuS=CASE WHEN @Status>0 THEN @Status ELSE T.Status END 


SELECT t.SerialNumber AS GRN,
       t.cBarCode AS BarCode,
       t.BalanceQty AS StockQty,
       t1.ItemCode,
       ItemName,
       t.Flag,
       p.MaterialUnitId AS PID,
       p.SerialNumber AS PSN,
       p.Flag AS PFlag,
	   t.BalanceQty UsekQty,t1.CPN
FROM dbo.Prod_MaterialUnit t WITH(NOLOCK)
    JOIN dbo.Basal_Item t1 WITH(NOLOCK)
        ON t1.ItemID = t.PartId
    LEFT JOIN Prod_MaterialUnit p WITH(NOLOCK)
        ON t.PID = p.MaterialUnitId 
WHERE t.SerialNumber =CASE  WHEN @ParenGRN IS NULL THEN   @GRN  ELSE T.SerialNumber END 
AND ISNULL(p.SerialNumber,'') =CASE  WHEN @ParenGRN IS NULL THEN   ''  ELSE @ParenGRN END 

AND T.StatuS=CASE WHEN @Status>0 THEN @Status ELSE T.Status END 


END 
GO
