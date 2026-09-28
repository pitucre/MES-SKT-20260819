                                                                                                                                                                                                                                                                
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-04
 * Description: 粉碎机完成上料。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[FeedingHopperCompleteCrusher]
(
    @CrusherCode VARCHAR(50),
    @CreateBy VARCHAR(20)
)
AS
SET T
