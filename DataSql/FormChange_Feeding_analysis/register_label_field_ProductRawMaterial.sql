-- 登记标签字段（新字段，无同名即无需备份）
-- FieldDfID 使用 MAX+1，当前库为 1631
SET NOCOUNT ON;
DECLARE @FieldDfID INT;
DECLARE @Exists INT;

SELECT @FieldDfID = MAX(FieldDfID) + 1 FROM dbo.Basal_LabelFieldDF;

IF EXISTS (SELECT 1 FROM dbo.Basal_LabelFieldDF WHERE FieldDfName = N'产品原料信息')
BEGIN
    SELECT @FieldDfID = FieldDfID FROM dbo.Basal_LabelFieldDF WHERE FieldDfName = N'产品原料信息';
    PRINT 'FieldDF already exists: ' + CAST(@FieldDfID AS VARCHAR(10));
END
ELSE
BEGIN
    INSERT INTO dbo.Basal_LabelFieldDF
        (FieldDfID, FieldDfName, FieldDfDesc, Definition, Font, CreateBy, CreateDateTime, ModifyBy, ModifyDateTime, IsBold)
    VALUES
        (@FieldDfID, N'产品原料信息', N'机台当前工单产品及BOM原料',
         N'fn.UdfGetLBL_ProductRawMaterial()', N'', 'admin', GETDATE(), 'admin', GETDATE(), 0);
    PRINT 'Inserted FieldDF: ' + CAST(@FieldDfID AS VARCHAR(10));
END

IF NOT EXISTS (SELECT 1 FROM dbo.Basal_LabelFieldDFDetail WHERE FieldDfID = @FieldDfID)
BEGIN
    INSERT INTO dbo.Basal_LabelFieldDFDetail
        (FieldDfID, DfContent, DfTableName, DfTableFieldFnName, DfFieldLen, DfType,
         CreateBy, CreateDateTime, ModifyBy, ModifyDateTime, JoinIndex)
    VALUES
        (@FieldDfID, N'fn.UdfGetLBL_ProductRawMaterial()', N'', N'UdfGetLBL_ProductRawMaterial',
         500, 2, 'admin', GETDATE(), 'admin', GETDATE(), 0);
    PRINT 'Inserted DFDetail';
END
ELSE
    PRINT 'DFDetail exists';

-- 挂到原料标签文档 DocId=2（FieldDesc 必须与 FieldDfName 一致，PrintData 才能匹配）
IF NOT EXISTS (SELECT 1 FROM dbo.Basal_LabelField WHERE LabelFieldID = 2 AND FieldDfID = @FieldDfID)
BEGIN
    INSERT INTO dbo.Basal_LabelField
        (LabelFieldID, FieldDfID, FieldSeq, FieldDesc, CreateBy, CreateDateTime, ModifyBy, ModifyDataTime)
    VALUES
        (2, @FieldDfID, 0, N'产品原料信息', 'admin', GETDATE(), 'admin', GETDATE());
    PRINT 'Inserted Basal_LabelField for doc 2';
END
ELSE
    PRINT 'Basal_LabelField exists';

SELECT @FieldDfID AS FieldDfID;
