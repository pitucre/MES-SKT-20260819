                                                                                                                                                                                                                                                                
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
SET TRANSACTION ISO
