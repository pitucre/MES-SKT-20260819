ALTER PROCEDURE [dbo].[uspGetFromChangeByNo]
(
    @FromChangeByMESNo VARCHAR(50)
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
	SELECT b.FromChangeByMESDtId,b.BarCode,b.ConvertedMaterial,b.PreConversionMaterial,b.ConvertedQty,c.ItemName FROM dbo.Prod_FromChangeByMES a WITH(NOLOCK) 
	INNER JOIN dbo.Prod_FromChangeByMESDt b WITH(NOLOCK) ON a.FromChangeByMESId = b.FromChangeByMESId
	LEFT JOIN dbo.Basal_Item c WITH(NOLOCK) ON c.ItemCode = b.PreConversionMaterial
	WHERE a.FromChangeByMESNo = @FromChangeByMESNo
	ORDER BY b.FromChangeByMESDtId
END
SET NOCOUNT OFF
