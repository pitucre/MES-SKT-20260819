/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-04
 * Description: PDA碎料上料根据设备获取上料中的单据明细。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspGetSrapFeedingDtl]
(
    @EquipmentCode VARCHAR(50)
)
AS
SET TRANSACTION ISOLATION
