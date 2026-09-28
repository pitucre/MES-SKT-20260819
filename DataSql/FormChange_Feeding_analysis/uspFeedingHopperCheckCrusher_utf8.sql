/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-04
 * Description: 粉碎机上料校验扫描的粉碎机。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspFeedingHopperCheckCrusher]
(
    @CrusherCode VARCHAR(50),
	@Flag INT
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
    IF @Flag = 0
	BEGIN
	    /*获取所有粉碎机*/
		SELECT a.EquipmentCode,a.EquipmentName FROM dbo.Basal_Equipment a WITH(NOLOCK) INNER JOIN dbo.Basal_EquipmentType b WITH(NOLOCK) ON a.EquipmentTypeId = b.EquipmentTypeId WHERE b.EquipmentTypeCode = '粉碎机'
	END

	IF @Flag = 1
	BEGIN
	    DECLARE @Msg NVARCHAR(MAX)
	    SELECT a.EquipmentCode,a.EquipmentName FROM dbo.Basal_Equipment a WITH(NOLOCK) INNER JOIN dbo.Basal_EquipmentType b WITH(NOLOCK) ON a.EquipmentTypeId = b.EquipmentTypeId WHERE b.EquipmentTypeCode = '粉碎机' AND a.EquipmentCode = @CrusherCode
		IF @@ROWCOUNT = 0
		BEGIN
		    SET @Msg = '扫描的粉碎机编号【'+@CrusherCode+'】无效!'
		    RAISERROR(@Msg,12,1)
			RETURN
		END
	END

	IF @Flag = 2
	BEGIN
	    SELECT a.EquipmentCode,a.EquipmentName FROM dbo.Basal_Equipment a WITH(NOLOCK) INNER JOIN dbo.Basal_EquipmentType b WITH(NOLOCK) ON a.EquipmentTypeId = b.EquipmentTypeId WHERE b.EquipmentTypeCode = '粉碎机' AND a.EquipmentCode LIKE '%'+@CrusherCode+'%'
	END
	
END
SET NOCOUNT OFF

