-- 新建标签字段函数：机台当前工单产品 + BOM 原料（编码 名称）
-- 首次创建，无需备份
IF OBJECT_ID('dbo.UdfGetLBL_ProductRawMaterial', 'FN') IS NOT NULL
    DROP FUNCTION dbo.UdfGetLBL_ProductRawMaterial;
GO
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
GO
CREATE FUNCTION dbo.UdfGetLBL_ProductRawMaterial
(
    @SN NVARCHAR(100),
    @StationID INT,
    @ResID INT,
    @LineID INT,
    @ItemId INT,
    @WOId INT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result NVARCHAR(MAX) = N'';
    DECLARE @EquipmentCode VARCHAR(20);
    DECLARE @MachineNo VARCHAR(10);
    DECLARE @OrderNO VARCHAR(50);
    DECLARE @ItemCode VARCHAR(50);
    DECLARE @ItemName NVARCHAR(200);
    DECLARE @BOMId INT;
    DECLARE @Product NVARCHAR(MAX) = N'';
    DECLARE @RawList NVARCHAR(MAX) = N'';

    IF ISNULL(@ResID, -1) <= 0
        RETURN @Result;

    -- ResName「N号注塑机通用资源」→ 号前数字
    SELECT @MachineNo = CASE
        WHEN PATINDEX('%[0-9]%', ResName) > 0
             AND CHARINDEX(N'号', ResName) > PATINDEX('%[0-9]%', ResName)
        THEN SUBSTRING(ResName, PATINDEX('%[0-9]%', ResName),
                       CHARINDEX(N'号', ResName) - PATINDEX('%[0-9]%', ResName))
        ELSE NULL
    END
    FROM dbo.Basal_Resource WITH (NOLOCK)
    WHERE ResourceId = @ResID;

    IF @MachineNo IS NULL
        RETURN @Result;

    SET @EquipmentCode = RIGHT('000' + @MachineNo, 3);

    -- 机台当前工单（与 usp_OrderControl_GetMachineCurrentOrder 口径对齐，并兼容测试库在制状态）
    SELECT TOP 1
        @OrderNO = o.OrderNO,
        @ItemCode = o.ItemCode,
        @BOMId = o.BOMId
    FROM dbo.ERP_Prod_Order o WITH (NOLOCK)
    WHERE o.MachineNumber = @EquipmentCode
      AND o.Status IN (1, 2, 0, 3)
      AND o.Qty_to_Build > 0
    ORDER BY CASE o.Status WHEN 1 THEN 0 WHEN 2 THEN 1 ELSE 2 END,
             o.Planned_Start_Time DESC;

    IF @OrderNO IS NULL
        RETURN @Result;

    SELECT @ItemName = ISNULL(i.ItemName, '')
    FROM dbo.Basal_Item i WITH (NOLOCK)
    WHERE i.ItemCode = @ItemCode;

    SET @Product = N'产品:' + ISNULL(@ItemCode, '') + N' ' + ISNULL(@ItemName, N'');

    -- BOMId 为空时按产品反查
    IF ISNULL(@BOMId, 0) = 0
    BEGIN
        SELECT TOP 1 @BOMId = b.ItemBomId
        FROM dbo.Basal_ItemBom b WITH (NOLOCK)
        WHERE b.ItemCode = @ItemCode
           OR b.ItemId IN (SELECT ItemId FROM dbo.Basal_Item WITH (NOLOCK) WHERE ItemCode = @ItemCode)
        ORDER BY b.ItemBomId DESC;
    END

    IF ISNULL(@BOMId, 0) > 0
    BEGIN
        SELECT @RawList = STUFF((
            SELECT N',' + c.ItemCode + N' ' + ISNULL(c.ItemName, N'')
            FROM dbo.Basal_ItemBomChild c WITH (NOLOCK)
            WHERE c.ItemBomId = @BOMId
              AND ISNULL(c.IsFictitious, 0) = 0
              AND (
                    c.ItemCode LIKE '03%'
                    OR (
                        NOT EXISTS (
                            SELECT 1 FROM dbo.Basal_ItemBomChild c2 WITH (NOLOCK)
                            WHERE c2.ItemBomId = @BOMId AND c2.ItemCode LIKE '03%'
                        )
                    )
              )
            ORDER BY c.ItemBomChildId
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, N'');
    END

    IF ISNULL(@RawList, N'') <> N''
        SET @Result = @Product + N' | 原料:' + @RawList;
    ELSE
        SET @Result = @Product;

    RETURN @Result;
END
GO
