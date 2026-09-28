-- 修复：FieldDfID 为标识列，需 IDENTITY_INSERT；DFDetail/LabelField 已用 1631
SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;
DECLARE @FieldDfID INT = 1631;

IF NOT EXISTS (SELECT 1 FROM dbo.Basal_LabelFieldDF WHERE FieldDfID = @FieldDfID)
BEGIN
    SET IDENTITY_INSERT dbo.Basal_LabelFieldDF ON;
    INSERT INTO dbo.Basal_LabelFieldDF
        (FieldDfID, FieldDfName, FieldDfDesc, Definition, Font, CreateBy, CreateDateTime, ModifyBy, ModifyDateTime, IsBold)
    VALUES
        (@FieldDfID, N'产品原料信息', N'机台当前工单产品及BOM原料',
         N'fn.UdfGetLBL_ProductRawMaterial()', N'', 'admin', GETDATE(), 'admin', GETDATE(), 0);
    SET IDENTITY_INSERT dbo.Basal_LabelFieldDF OFF;
    PRINT 'Inserted FieldDF 1631';
END
ELSE
    PRINT 'FieldDF 1631 exists';

SELECT FieldDfID, FieldDfName, Definition FROM dbo.Basal_LabelFieldDF WHERE FieldDfID = @FieldDfID;
