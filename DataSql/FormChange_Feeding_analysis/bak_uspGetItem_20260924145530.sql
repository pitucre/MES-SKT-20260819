                                                                                                                                                                                                                                                                
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
SET NOC
