SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;

SELECT FieldDfID, FieldDfName, Definition FROM dbo.Basal_LabelFieldDF WHERE FieldDfID = 1631;
SELECT FieldDfID, DfTableFieldFnName, DfType, DfFieldLen, JoinIndex FROM dbo.Basal_LabelFieldDFDetail WHERE FieldDfID = 1631;
SELECT LabelFieldID, FieldDfID, FieldDesc FROM dbo.Basal_LabelField WHERE LabelFieldID = 2 ORDER BY FieldDfID;
SELECT TempId, LEN(TempSet) AS TempSetLen,
       CASE WHEN CHARINDEX('"key":"1631"', TempSet) > 0 THEN 'HAS_KEY' ELSE 'NO_KEY' END AS KeyCheck
FROM dbo.Basal_PrintTemplate WHERE TempId = 9;

-- 模拟标签取值：带 ResID / 不带 ResID
SELECT dbo.UdfGetLBL_ProductRawMaterial('', 0, 7390, 0, 0, 0) AS Res7390_1号机;
SELECT dbo.UdfGetLBL_ProductRawMaterial('', 0, 7391, 0, 0, 0) AS Res7391;
SELECT dbo.UdfGetLBL_ProductRawMaterial('', 0, -1, 0, 0, 0) AS NoRes;

-- 1号机当前工单（按 UDF 同口径）
SELECT TOP 3 o.OrderNO, o.MachineNumber, o.Status, o.ItemCode, o.BOMId, o.Qty_to_Build, o.Planned_Start_Time
FROM dbo.ERP_Prod_Order o WITH (NOLOCK)
WHERE o.MachineNumber = '001' AND o.Status IN (1,2,0,3) AND o.Qty_to_Build > 0
ORDER BY CASE o.Status WHEN 1 THEN 0 WHEN 2 THEN 1 ELSE 2 END, o.Planned_Start_Time DESC;

-- uspGetLabelContentForLabPrint 是否会取到 1631
SELECT FieldDfID, FieldDfName FROM dbo.Basal_LabelFieldDF
WHERE FieldDfID IN (SELECT FieldDfID FROM dbo.Basal_LabelField WHERE LabelFieldID = 2)
ORDER BY FieldDfID;
