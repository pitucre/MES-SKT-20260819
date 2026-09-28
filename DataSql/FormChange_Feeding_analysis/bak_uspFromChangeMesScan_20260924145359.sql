/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-05
 * Description: PDA形态转换-MES 条码扫描。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspFromChangeMesScan]
(
    @FromChangeByMESNo VARCHAR(50),
    @BarCode VARCHAR(50),
	@Con
