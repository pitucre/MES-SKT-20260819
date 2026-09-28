SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspGetLabelContentForLabPrint')) AS SP_Def;
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.UdfGetLBL_CrusherCode')) AS SampleUDF_Crusher;
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.UdfGetLBL_SNRawMaterial')) AS SampleUDF_SNRaw;
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.UdfGetLBL_ProductRawMaterial')) AS NewUDF;
-- 已有字段的函数签名（取前几个）
SELECT TOP 5 FieldDfID, FieldDfName, Definition FROM dbo.Basal_LabelFieldDF
WHERE Definition LIKE '%UdfGetLBL_%' ORDER BY FieldDfID DESC;
