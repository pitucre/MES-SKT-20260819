/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-05
 * Description: PDA形态转换-MES 获取形态转换单明细数据。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspGetFromChangeByNo]
(
    @FromChangeByMESNo VARCHAR(50)
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
	SELECT b.FromChangeByMESDtId,b.BarCode,b.ConvertedMaterial,b.PreConversionMaterial,b.ConvertedQty,c.ItemName FROM dbo.Prod_FromChangeByMES a WITH(NOLOCK) 
	INNER JOIN dbo.Prod_FromChangeByMESDt b WITH(NOLOCK) ON a.FromChangeByMESId = b.FromChangeByMESId
	INNER JOIN dbo.Basal_Item c WITH(NOLOCK) ON c.ItemCode = b.PreConversionMaterial
	WHERE a.FromChangeByMESNo = @FromChangeByMESNo

END
SET NOCOUNT OFF
