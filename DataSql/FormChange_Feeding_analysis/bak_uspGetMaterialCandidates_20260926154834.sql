/**
 * Author: opencode
 * Create Date: 2026-09-24
 * Description: 根据条码解析 03/06 候选料（L1字段 + L2物料BOM + L3工单用料 + L4 ERP配料，并集去重）。
 *              @Prefix = '03' 原材料 / '06' 粉碎料
 * Env: 172.16.5.179 PROD_TEST_MES
 */
CREATE PROCEDURE [dbo].[uspGetMaterialCandidates]
(
    @BarCode VARCHAR(50),
    @Prefix VARCHAR(10)
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
    BEGIN TRY
        DECLARE @Msg NVARCHAR(500)
        DECLARE @ItemId INT = -1, @ItemCode NVARCHAR(50) = '', @BomId INT = -1
        DECLARE @ProdOrderId INT = -1, @OrderNo NVARCHAR(50) = ''

        IF ISNULL(@BarCode, '') = '' OR ISNULL(@Prefix, '') = ''
        BEGIN
            RAISERROR('条码或前缀不能为空!', 12, 1)
        END

        SELECT @ItemId = PartId FROM dbo.Prod_MaterialUnit WITH (NOLOCK) WHERE SerialNumber = @BarCode
        IF @ItemId = -1
            SELECT @ItemId = ItemID, @ProdOrderId = ISNULL(ProdOrderID, -1)
            FROM dbo.Prod_Unit WITH (NOLOCK) WHERE SN = @BarCode

        IF @ItemId = -1
        BEGIN
            SET @Msg = '条码【' + @BarCode + '】无效!'
            RAISERROR(@Msg, 12, 1)
        END

        SELECT @ItemCode = ItemCode, @BomId = ISNULL(BomId, -1)
        FROM dbo.Basal_Item WITH (NOLOCK) WHERE ItemID = @ItemId

        IF @ProdOrderId > -1
            SELECT TOP 1 @OrderNo = OrderNO FROM dbo.Prod_Order WITH (NOLOCK) WHERE ProdOrderID = @ProdOrderId

        IF @OrderNo = '' AND @ItemId > -1
            SELECT TOP 1 @OrderNo = OrderNO FROM dbo.Prod_Order WITH (NOLOCK)
            WHERE ItemId = @ItemId ORDER BY ProdOrderID DESC

        CREATE TABLE #Cand
        (
            ItemCode VARCHAR(50) NOT NULL,
            ItemName NVARCHAR(200) NULL,
            Source VARCHAR(10) NOT NULL,
            SrcOrder INT NOT NULL
        )

        /* L1: 物料主数据字段 */
        IF @Prefix = '03'
        BEGIN
            INSERT INTO #Cand (ItemCode, ItemName, Source, SrcOrder)
            SELECT i.MaterialPartNumberCode, bi.ItemName, 'L1', 1
            FROM dbo.Basal_Item i WITH (NOLOCK)
            LEFT JOIN dbo.Basal_Item bi WITH (NOLOCK) ON bi.ItemCode = i.MaterialPartNumberCode
            WHERE i.ItemID = @ItemId AND ISNULL(i.MaterialPartNumberCode, '') LIKE @Prefix + '%'
        END
        ELSE IF @Prefix = '06'
        BEGIN
            INSERT INTO #Cand (ItemCode, ItemName, Source, SrcOrder)
            SELECT i.ScrapMaterialNumberCode, bi.ItemName, 'L1', 1
            FROM dbo.Basal_Item i WITH (NOLOCK)
            LEFT JOIN dbo.Basal_Item bi WITH (NOLOCK) ON bi.ItemCode = i.ScrapMaterialNumberCode
            WHERE i.ItemID = @ItemId AND ISNULL(i.ScrapMaterialNumberCode, '') LIKE @Prefix + '%'
        END

        /* L2: 物料 BOM 子项 */
        IF @BomId > -1
        BEGIN
            INSERT INTO #Cand (ItemCode, ItemName, Source, SrcOrder)
            SELECT c.ItemCode, c.ItemName, 'L2', 2
            FROM dbo.Basal_ItemBomChild c WITH (NOLOCK)
            WHERE c.ItemBomId = @BomId AND c.ItemCode LIKE @Prefix + '%'
        END

        /* L3: 当时/最近工单用料 Prod_OrderBom */
        IF @OrderNo <> ''
        BEGIN
            INSERT INTO #Cand (ItemCode, ItemName, Source, SrcOrder)
            SELECT i.ItemCode, i.ItemName, 'L3', 3
            FROM dbo.Prod_OrderBom ob WITH (NOLOCK)
            INNER JOIN dbo.Basal_Item i WITH (NOLOCK) ON i.ItemID = ob.ItemID
            WHERE ob.OrderNo = @OrderNo AND i.ItemCode LIKE @Prefix + '%'
        END

        /* L4: ERP MO_MOPickList 配料（链接服务器 172.16.5.155），失败则跳过 */
        BEGIN TRY
            INSERT INTO #Cand (ItemCode, ItemName, Source, SrcOrder)
            SELECT TOP (50) CONVERT(VARCHAR(50), c.Code), CONVERT(NVARCHAR(200), c.Name), 'L4', 4
            FROM [172.16.5.155].[001].dbo.MO_MOPickList pl WITH (NOLOCK)
            INNER JOIN [172.16.5.155].[001].dbo.MO_MO mo WITH (NOLOCK) ON mo.ID = pl.MO
            INNER JOIN [172.16.5.155].[001].dbo.CBO_ItemMaster c WITH (NOLOCK) ON c.ID = pl.ItemMaster
            INNER JOIN [172.16.5.155].[001].dbo.CBO_ItemMaster ci WITH (NOLOCK) ON ci.ID = mo.ItemMaster
            WHERE ci.Code = @ItemCode AND c.Code LIKE @Prefix + '%'
            ORDER BY mo.ID DESC
        END TRY
        BEGIN CATCH
            /* linked server unavailable - ignore */
        END CATCH

        /* 并集去重，L1 优先 */
        ;WITH u AS (
            SELECT ItemCode, ItemName, Source, SrcOrder,
                   ROW_NUMBER() OVER (PARTITION BY ItemCode ORDER BY SrcOrder, Source) AS rn
            FROM #Cand
            WHERE ItemCode LIKE @Prefix + '%'
        )
        SELECT ItemCode, ItemName, Source
        FROM u
        WHERE rn = 1
        ORDER BY SrcOrder, ItemCode;

        DROP TABLE #Cand
    END TRY
    BEGIN CATCH
        IF OBJECT_ID('tempdb..#Cand') IS NOT NULL DROP TABLE #Cand
        DECLARE @Em NVARCHAR(4000) = ERROR_MESSAGE(), @Es INT = ERROR_SEVERITY(), @Est INT = ERROR_STATE()
        RAISERROR(@Em, @Es, @Est)
    END CATCH
END
SET NOCOUNT OFF

