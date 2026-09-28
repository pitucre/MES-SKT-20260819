/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-05
 * Description: PDA形态转换-MES 获取形态转换单。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspGetFromChangeNo]
(
    @Value NVARCHAR(50) 
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
	IF ISNULL(@Value,'') = ''
	BEGIN
	    SELECT FromChangeByMESNo FROM Prod_FromChangeByMES WITH(NOLOCK) WHERE Staues = 0
	END
	ELSE
	BEGIN
	    SELECT FromChangeByMESNo FROM Prod_FromChangeByMES WITH(NOLOCK) WHERE Staues = 0 AND FromChangeByMESNo LIKE '%'+@Value+'%'
	END
END
SET NOCOUNT OFF

