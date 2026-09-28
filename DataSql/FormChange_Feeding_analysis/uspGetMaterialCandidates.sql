/**
 * Author: opencode
 * Create Date: 2026-09-24 (2026-09-26 更新)
 * Description: 根据条码解析 03/06 候选料（L1字段 + L2产品BOM + L3工单用料 + L4 ERP配料，并集去重）。
 *              @Prefix = '03' 原材料 / '06' 粉碎料
 *              2026-09-26: L2 改取“工单对应产品”的 BOM（条码->Prod_MaterialUnit.SrapFeedingNo->Prod_SrapFeedingDtl.OrderNo
 *                          / Prod_Unit.ProdOrderID -> 工单->产品->Basal_Item.BomId），定位不到时反查“产品BOM含本物料”兜底；
 *                          条码自身在上料明细中时 L3 只取其所属工单；L4 按工单产品编码查 ERP。
 *                          变更明细见 alter_uspGetMaterialCandidates.sql（备份 bak_uspGetMaterialCandidates_20260926154834.sql）。
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
        DECLARE @ProdOrderId INT = -1, @SrapFeedingNo VARCHAR(50) = ''

        IF ISNULL(@BarCode, '') = '' OR ISNULL(@Prefix, '') = ''
        BEGIN
            RAISERROR('条码或前缀不能为空!', 12, 1)
        END

        SELECT @ItemId = ISNULL(PartId, -1), @SrapFeedingNo = ISNULL(SrapFeedingNo, '')
        FROM dbo.Prod_MaterialUnit WITH (NOLOCK) WHERE SerialNumber = @BarCode

        IF @ItemId = -1
            SELECT @ItemId = ISNULL(ItemID, -1), @ProdOrderId = ISNULL(ProdOrderID, -1)
            FROM dbo.Prod_Unit WITH (NOLOCK) WHERE SN = @BarCode

        IF @ItemId = -1
        BEGIN
            SET @Msg = '条码【' + @BarCode + '】无效!'
            RAISERROR(@Msg, 12, 1)
        END

        SELECT @ItemCode = ItemCode, @BomId = ISNULL(BomId, -1)
        FROM dbo.Basal_Item WITH (NOLOCK) WHERE ItemID = @ItemId

        ---------------------------------------------------------------
        -- 相关工单集合（决定“工单对应产品”）
        ---------------------------------------------------------------
        CREATE TABLE #Order
        (
            OrderNo NVARCHAR(50) NOT NULL
        )

        /* 1) 产品 SN（Prod_Unit）自带工单 */
        IF @ProdOrderId > -1
            INSERT INTO #Order (OrderNo)
            SELECT OrderNO FROM dbo.Prod_Order WITH (NOLOCK) WHERE ProdOrderID = @ProdOrderId

        /* 2) 粉碎机上料生成的条码：条码 -> 上料单 -> 上料明细工单
              条码本身在明细中（料把等输入条码）只取其所属工单；
              条码不在明细中（SL 输出条码）取该上料单全部工单 */
        IF @SrapFeedingNo <> ''
            INSERT INTO #Order (OrderNo)
            SELECT DISTINCT ISNULL(d.OrderNo, '')
            FROM dbo.Prod_SrapFeeding f WITH (NOLOCK)
            INNER JOIN dbo.Prod_SrapFeedingDtl d WITH (NOLOCK) ON d.SrapFeedingId = f.SrapFeedingId
            WHERE f.SrapFeedingNo = @SrapFeedingNo AND ISNULL(d.OrderNo, '') <> ''
              AND (d.BarCode = @BarCode OR NOT EXISTS (
                      SELECT 1 FROM dbo.Prod_SrapFeedingDtl x WITH (NOLOCK)
                      WHERE x.SrapFeedingId = f.SrapFeedingId AND x.BarCode = @BarCode))

        /* 3) 产品自身条码且无工单上下文：取该产品最近工单（仅用于 L3 补充） */
        IF NOT EXISTS (SELECT 1 FROM #Order) AND @ItemId > -1
            INSERT INTO #Order (OrderNo)
            SELECT TOP 1 OrderNO FROM dbo.Prod_Order WITH (NOLOCK)
            WHERE ItemId = @ItemId ORDER BY ProdOrderID DESC

        ---------------------------------------------------------------
        -- 用于 L2 的产品 BOM 集合
        ---------------------------------------------------------------
        CREATE TABLE #Bom
        (
            ItemBomId INT NOT NULL
        )

        /* 条码物料/产品自身有 BOM（如产品类条码）先入列 */
        IF @BomId > -1
            INSERT INTO #Bom (ItemBomId) VALUES (@BomId)

        /* 工单对应产品的 BOM（本次需求重点：取产品下面对应的 BOM） */
        INSERT INTO #Bom (ItemBomId)
        SELECT DISTINCT ISNULL(i.BomId, -1)
        FROM #Order o
        INNER JOIN dbo.Prod_Order po WITH (NOLOCK) ON po.OrderNO = o.OrderNo
        INNER JOIN dbo.Basal_Item i WITH (NOLOCK) ON i.ItemID = po.ItemId
        WHERE ISNULL(i.BomId, -1) > -1

        /* 兜底：拿不到任何 BOM 时，反查“产品BOM含本物料”的产品 BOM */
        IF NOT EXISTS (SELECT 1 FROM #Bom)
        BEGIN
            INSERT INTO #Bom (ItemBomId)
            SELECT DISTINCT c.ItemBomId
            FROM dbo.Basal_ItemBomChild c WITH (NOLOCK)
            INNER JOIN dbo.Basal_ItemBom b WITH (NOLOCK) ON b.ItemBomId = c.ItemBomId
            WHERE c.ItemCode = @ItemCode
        END

        /* 工单产品编码（L4 ERP 配料按产品查）：条码自身即产品时优先用条码物料 */
        DECLARE @ProdItemCode NVARCHAR(50) = ''

        IF @BomId > -1
            SET @ProdItemCode = @ItemCode

        IF ISNULL(@ProdItemCode, '') = ''
            SELECT TOP 1 @ProdItemCode = i.ItemCode
            FROM #Order o
            INNER JOIN dbo.Prod_Order po WITH (NOLOCK) ON po.OrderNO = o.OrderNo
            INNER JOIN dbo.Basal_Item i WITH (NOLOCK) ON i.ItemID = po.ItemId

        IF ISNULL(@ProdItemCode, '') = ''
            SELECT TOP 1 @ProdItemCode = b.ItemCode
            FROM #Bom m INNER JOIN dbo.Basal_ItemBom b WITH (NOLOCK) ON b.ItemBomId = m.ItemBomId

        IF ISNULL(@ProdItemCode, '') = ''
            SET @ProdItemCode = @ItemCode

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

        /* L2: 产品 BOM 子项（工单对应产品 / 条码产品自身 / 反查兜底） */
        INSERT INTO #Cand (ItemCode, ItemName, Source, SrcOrder)
        SELECT c.ItemCode, c.ItemName, 'L2', 2
        FROM dbo.Basal_ItemBomChild c WITH (NOLOCK)
        INNER JOIN #Bom m ON m.ItemBomId = c.ItemBomId
        WHERE c.ItemCode LIKE @Prefix + '%'

        /* L3: 工单用料 Prod_OrderBom（多工单并集，作为补充） */
        INSERT INTO #Cand (ItemCode, ItemName, Source, SrcOrder)
        SELECT i.ItemCode, i.ItemName, 'L3', 3
        FROM #Order o
        INNER JOIN dbo.Prod_OrderBom ob WITH (NOLOCK) ON ob.OrderNo = o.OrderNo
        INNER JOIN dbo.Basal_Item i WITH (NOLOCK) ON i.ItemID = ob.ItemID
        WHERE i.ItemCode LIKE @Prefix + '%'

        /* L4: ERP MO_MOPickList 配料（链接服务器 172.16.5.155），失败则跳过 */
        BEGIN TRY
            INSERT INTO #Cand (ItemCode, ItemName, Source, SrcOrder)
            SELECT TOP (50) CONVERT(VARCHAR(50), c.Code), CONVERT(NVARCHAR(200), c.Name), 'L4', 4
            FROM [172.16.5.155].[001].dbo.MO_MOPickList pl WITH (NOLOCK)
            INNER JOIN [172.16.5.155].[001].dbo.MO_MO mo WITH (NOLOCK) ON mo.ID = pl.MO
            INNER JOIN [172.16.5.155].[001].dbo.CBO_ItemMaster c WITH (NOLOCK) ON c.ID = pl.ItemMaster
            INNER JOIN [172.16.5.155].[001].dbo.CBO_ItemMaster ci WITH (NOLOCK) ON ci.ID = mo.ItemMaster
            WHERE ci.Code = @ProdItemCode AND c.Code LIKE @Prefix + '%'
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
        DROP TABLE #Bom
        DROP TABLE #Order
    END TRY
    BEGIN CATCH
        IF OBJECT_ID('tempdb..#Cand') IS NOT NULL DROP TABLE #Cand
        IF OBJECT_ID('tempdb..#Bom') IS NOT NULL DROP TABLE #Bom
        IF OBJECT_ID('tempdb..#Order') IS NOT NULL DROP TABLE #Order
        DECLARE @Em NVARCHAR(4000) = ERROR_MESSAGE(), @Es INT = ERROR_SEVERITY(), @Est INT = ERROR_STATE()
        RAISERROR(@Em, @Es, @Est)
    END CATCH
END
SET NOCOUNT OFF
