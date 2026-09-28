-- 料把标签 DocId=9 / TempId=18 增加「产品原料信息」
-- 修改已有模板/字段映射：先备份 bak_Basal_PrintTemplate_TempId18_*.sql
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @FieldDfID INT = 1631;
DECLARE @TempSet NVARCHAR(MAX);
DECLARE @NewCtrl NVARCHAR(MAX);
DECLARE @HasKey BIT = 0;

IF NOT EXISTS (SELECT 1 FROM dbo.Basal_LabelFieldDF WHERE FieldDfID = @FieldDfID)
BEGIN
    RAISERROR('FieldDF 1631 missing', 16, 1);
    RETURN;
END

IF NOT EXISTS (SELECT 1 FROM dbo.Basal_LabelField WHERE LabelFieldID = 9 AND FieldDfID = @FieldDfID)
BEGIN
    INSERT INTO dbo.Basal_LabelField (LabelFieldID, FieldDfID, FieldSeq, FieldDesc, CreateBy, CreateDateTime, ModifyBy, ModifyDataTime)
    VALUES (9, @FieldDfID, 0, N'产品原料信息', 'admin', GETDATE(), 'admin', GETDATE());
    PRINT 'Inserted Basal_LabelField for doc 9';
END
ELSE
    PRINT 'Basal_LabelField doc9 already has 1631';

SELECT @TempSet = TempSet FROM dbo.Basal_PrintTemplate WHERE TempId = 18;
IF @TempSet IS NULL
BEGIN
    RAISERROR('TempId=18 missing', 16, 1);
    RETURN;
END

IF CHARINDEX('"key":"' + CAST(@FieldDfID AS VARCHAR(10)) + '"', @TempSet) > 0
    SET @HasKey = 1;

IF @HasKey = 0
BEGIN
    SET @NewCtrl =
        N',{"width":166.0,"height":30.0,"top":180.0,"left":2.0,"type":"text","rote":0,"origin":"center center",'
      + N'"zIndex":30,"text":"","borderColor":"#000","borderWidth":0,"borderStyle":"solid",'
      + N'"key":"' + CAST(@FieldDfID AS VARCHAR(10)) + N'","group":1,"fontFamily":"Arial",'
      + N'"wordBreak":"break-all","lineHeight":7,"radius":0,"overflow":"hidden","underline":false,'
      + N'"linethrough":false,"backgroundColor":"","fontSize":6.5,"fontSpace":0,"color":"#000",'
      + N'"fontWeight":"normal","textAlign":"left","paddingLeft":0,"paddingRight":0,"fontStyle":"normal",'
      + N'"fontSizeUnit":"pt","enaleAutoTextSize":true}';

    SET @TempSet = LEFT(@TempSet, LEN(@TempSet) - 1) + @NewCtrl + N']';

    UPDATE dbo.Basal_PrintTemplate
    SET TempSet = @TempSet,
        ModifyBy = 'admin',
        ModifyDateTime = GETDATE()
    WHERE TempId = 18;

    PRINT 'Template 18 updated, added key=' + CAST(@FieldDfID AS VARCHAR(10));
END
ELSE
    PRINT 'Template 18 already has key=' + CAST(@FieldDfID AS VARCHAR(10));

SELECT t1.FieldDfID, t2.FieldDfName, t1.FieldDesc
FROM dbo.Basal_LabelField t1
INNER JOIN dbo.Basal_LabelFieldDF t2 ON t1.FieldDfID = t2.FieldDfID
WHERE t1.LabelFieldID = 9 AND t1.FieldDfID = @FieldDfID;

SELECT TempId, LEN(TempSet) AS TempSetLen,
       CASE WHEN CHARINDEX('"key":"1631"', TempSet) > 0 THEN 1 ELSE 0 END AS Has1631
FROM dbo.Basal_PrintTemplate WHERE TempId = 18;
