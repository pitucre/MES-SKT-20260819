-- ============================================================
-- 新增：调拨入库前检查上料记录
-- 名称：uspCheckTransferInLoadingRecords_Program
-- 日期：2026-10-10
-- 说明：PDA调拨入库前调用，传入GRN JSON，返回该批GRN的上料记录。
--       返回空结果集=无上料记录，可直接调拨；
--       返回有记录=需前端弹窗确认是否清理。
-- ============================================================
CREATE PROCEDURE [dbo].[uspCheckTransferInLoadingRecords_Program]
    @GRNList NVARCHAR(MAX)  -- JSON: [{"GRN":"xxx"},...] 或 ["xxx","yyy"]
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    DECLARE @Tb TABLE(GRN VARCHAR(100));

    -- 解析JSON（兼容 [{"GRN":"a"},...] 格式，与 parseJSON 在 uspSaveTransferIn 中的用法一致）
    SELECT * INTO #Transfer_1 FROM dbo.parseJSON(@GRNList);

    INSERT INTO @Tb(GRN)
    SELECT DISTINCT T.StringValue
    FROM #Transfer_1 T
    WHERE T.NAME = 'GRN' AND T.StringValue IS NOT NULL AND T.StringValue <> '';

    DROP TABLE #Transfer_1;

    -- 返回有上料记录的GRN明细
    SELECT
        MU.SerialNumber AS GRN,
        MU.MaterialUnitId,
        MU.BalanceQty,
        MU.Status,
        '手插上料' AS LoadType,
        PLR.ProdOrderId,
        PLR.StationId,
        PLR.LineId,
        PLR.ResourceId
    FROM @Tb T
    INNER JOIN Prod_MaterialUnit MU WITH(NOLOCK) ON MU.SerialNumber = T.GRN
    INNER JOIN Prod_PickListResourceRecords PRR WITH(NOLOCK) ON PRR.MaterialUnitId = MU.MaterialUnitId
    INNER JOIN Prod_PickListResource PLR WITH(NOLOCK) ON PLR.PickListResourceId = PRR.PickListResourceId
    UNION
    SELECT
        MU.SerialNumber AS GRN,
        MU.MaterialUnitId,
        MU.BalanceQty,
        MU.Status,
        '注塑上料' AS LoadType,
        CAST(NULL AS INT) AS ProdOrderId,
        CAST(NULL AS INT) AS StationId,
        CAST(NULL AS INT) AS LineId,
        CAST(NULL AS INT) AS ResourceId
    FROM @Tb T
    INNER JOIN Prod_MaterialUnit MU WITH(NOLOCK) ON MU.SerialNumber = T.GRN
    INNER JOIN Prod_InjectionLoadingMaterial ILM WITH(NOLOCK) ON ILM.MaterialUnitId = MU.MaterialUnitId
    UNION
    SELECT
        MU.SerialNumber AS GRN,
        MU.MaterialUnitId,
        MU.BalanceQty,
        MU.Status,
        '工位上料' AS LoadType,
        MSM.ProdOrderId,
        MSM.ResID AS StationId,
        MSM.LineID,
        MSM.ResID AS ResourceId
    FROM @Tb T
    INNER JOIN Prod_MaterialUnit MU WITH(NOLOCK) ON MU.SerialNumber = T.GRN
    INNER JOIN Prod_MaterialStationMuMap MSM WITH(NOLOCK) ON MSM.MaterialUnitID = MU.MaterialUnitId
    ORDER BY GRN, LoadType;
END
