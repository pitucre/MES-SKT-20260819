/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-05
 * Description: 获取物料。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspGetItem]
(
    @Value NVARCHAR(50) 
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
    IF ISNULL(@Value,'') = ''
	BEGIN
	    SELECT ItemCode,ItemName FROM dbo.Basal_Item WITH(NOLOCK)
	END
	ELSE
	BEGIN
	    SELECT ItemCode,ItemName FROM dbo.Basal_Item WITH(NOLOCK) WHERE ItemName LIKE '%'+@Value+'%' OR ItemCode LIKE '%'+@Value+'%'
	END
	
END
SET NOCOUNT OFF

