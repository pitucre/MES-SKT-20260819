                                                                                                                                                                                                                                                                
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-04
 * Description: 粉碎机上料。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspFeedingHopperLoadCrusher]
(
    @CrusherCode VARCHAR(50),
	@BarCode VARCHAR(50),
	@CreateBy VARCHAR
