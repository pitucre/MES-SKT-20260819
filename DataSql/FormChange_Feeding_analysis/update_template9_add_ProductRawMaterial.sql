-- 为 TempId=9「原料标签-60*75」追加「产品原料信息」文本控件
-- 修改已有模板：必须先备份（本脚本内置备份到 bak_* 文件由外部生成；此处先做表内校验）
SET NOCOUNT ON;
DECLARE @FieldDfID INT;
DECLARE @TempSet NVARCHAR(MAX);
DECLARE @NewCtrl NVARCHAR(MAX);
DECLARE @HasKey BIT = 0;

SELECT @FieldDfID = FieldDfID FROM dbo.Basal_LabelFieldDF WHERE FieldDfName = N'产品原料信息';
IF @FieldDfID IS NULL
BEGIN
    RAISERROR('FieldDF 产品原料信息 不存在，请先执行 register 脚本', 16, 1);
    RETURN;
END

SELECT @TempSet = TempSet FROM dbo.Basal_PrintTemplate WHERE TempId = 9;
IF @TempSet IS NULL
BEGIN
    RAISERROR('TempId=9 不存在', 16, 1);
    RETURN;
END

IF CHARINDEX('"key":"' + CAST(@FieldDfID AS VARCHAR(10)) + '"', @TempSet) > 0
    SET @HasKey = 1;

IF @HasKey = 0
BEGIN
    -- 底部区域：面板高约 212，预留多行原料
    SET @NewCtrl =
        N',{"width":166.0,"height":28.0,"top":182.0,"left":2.0,"type":"text","rote":0,"origin":"center center",'
      + N'"zIndex":30,"text":"","borderColor":"#000","borderWidth":0,"borderStyle":"solid",'
      + N'"key":"' + CAST(@FieldDfID AS VARCHAR(10)) + N'","group":1,"fontFamily":"Arial",'
      + N'"wordBreak":"break-all","lineHeight":7,"radius":0,"overflow":"hidden","underline":false,'
      + N'"linethrough":false,"backgroundColor":"","fontSize":6.5,"fontSpace":0,"color":"#000",'
      + N'"fontWeight":"normal","textAlign":"left","paddingLeft":0,"paddingRight":0,"fontStyle":"normal",'
      + N'"fontSizeUnit":"pt","enaleAutoTextSize":true}';

    -- 去掉结尾 ]，拼接后补 ]
    SET @TempSet = LEFT(@TempSet, LEN(@TempSet) - 1) + @NewCtrl + N']';

    UPDATE dbo.Basal_PrintTemplate
    SET TempSet = @TempSet,
        ModifyBy = 'admin',
        ModifyDateTime = GETDATE()
    WHERE TempId = 9;

    PRINT 'Template 9 updated, added key=' + CAST(@FieldDfID AS VARCHAR(10));
END
ELSE
    PRINT 'Template 9 already has key=' + CAST(@FieldDfID AS VARCHAR(10));

SELECT TempId, LEN(TempSet) AS TempSetLen FROM dbo.Basal_PrintTemplate WHERE TempId = 9;
