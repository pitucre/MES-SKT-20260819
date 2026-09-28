



/*****************************        
项目名称：        
功能描叙：获取设备开关模数   
创 建 人：kqq       
创建时间：2025-09-15        
更新信息:         
测试调试：        
*/
CREATE VIEW [dbo].[vwEquipmentOutQty]
AS
	SELECT EquipmentCode,WorkDate,CAST(sum(ISNULL(cc.MoldCavity*aa.Qty,0)) as int) as tQty,CAST(sum(ISNULL(aa.Qty,0)) as int) as OpenQty 
	FROM Prod_EquimentOrderPord aa  with(nolock)
	INNER JOIN Prod_Order oo  with(nolock) on oo.OrderNO=aa.OrderNo
	INNER JOIN  Basal_MoldFixtureItem cc  with(nolock) on cc.ItemId=oo.ItemId
	GROUP by EquipmentCode,WorkDate
