
CREATE VIEW [dbo].[vwProMaterialMember] 
 
AS
SELECT   a.materialunitid,
	   a.serialnumber,
       a.partid,
       ISNULL(b.itemname, '') AS itemname,
       ISNULL(b.[description], '') AS [description],
       a.cbarcode,
       a.vendorcode,
       ISNULL(a.balanceqty,0) AS balanceqty,
	   a.[status],
	   c.MaterialStatus,
	   ISNULL(c.MaterialStatus,'')  AS statusname,
       a.createdatetime,
       msm.CName createby, 
       a.storagedate, 
       a.lotcode, 
       ISNULL(a.quantity,0) AS quantity, 
       ISNULL(b.itemcode,'') itemcode, 
       CASE WHEN ISNULL(d.POrder,'') = '-1' THEN '' ELSE ISNULL(d.POrder,'')END AS POrder, 
	   d.DeliveryOrder,
       a.Flag 
	   ,ISNULL(a.DateCode,'')DateCode 
	   ,ISNULL(b.ItemModel,'') AS ItemModel 
	   ,ISNULL(b.ShelfLife,'') AS ShelfLife
	   ,ISNULL(E.ApplyNo,'') ApplyNo   ---2017-3-14新增显示该物料的领料单
	   ,ISNULL(W.CWhName,'')CWhName  ----仓库名字
	   ,ISNULL(w.CWhCode,'') CWhCode
	   ,ISNULL(IQCORDER,'')IQCOrder
	   --,ISNULL(a.MPN,'') AS MPN
	   ,'9999/12/31 0:00:00' AS MPN
	   ,ISNULL(a.WeekCode,'') AS WeekCode,
	   ISNULL(a.ExpiredDate, N'') AS ExpiredDate, 
	   a.WarehouseId,
	   ISNULL(Ed.SOCode,'') SOCode,
	   a.Remark
	   ,a.FormChangeNo, --Xudong.zhu,2024-08-26,新增
	  ISNULL(PMP.SerialNumber,'') BoxGrn,
	   ISNULL(A.SupplierOrderNumber,'') SupplierOrderNumber,
	   b.Units,
		D.SaleReturnCustomerCode,
		ISNULL(bc.CustomerName,'''') SaleReturnCustomerName,
		D.SaleReturnNo
FROM   dbo.prod_materialunit  AS a 
       INNER JOIN dbo.basal_item AS b ON a.partid=b.itemid 
       LEFT JOIN dbo.Prod_MaterialStatus  AS c  ON a.[Status] = c.ID
       LEFT JOIN dbo.Prod_MaterialUnitMember AS d ON a.MaterialUnitId = d.MaterialUnitId
	   LEFT JOIN dbo.Prod_Apply AS E ON A.ApplyId = E.ApplyId
	   LEFT JOIN dbo.Basal_WarehouseLocation AS WL ON A.cBarCode = WL.cBarCode
	   LEFT JOIN dbo.Basal_Warehouse AS W ON a.WarehouseId =  W.WarehouseId
	   LEFT JOIN dbo.ERP_PurOrderDtl AS ED ON  A.PartId=ED.ItemID  AND D.POrder=ed.POCode AND ED.AutoID = d.AutoId
	   LEFT JOIN dbo.SYS_Users msu ON msu.UserName = a.CreateBy
	   LEFT JOIN dbo.SYS_Membership msm ON msm.UserId = msu.UserId
		Left join Prod_MaterialUnit PMP WITH(NOLOCK) ON PMP.MaterialUnitId=A.pid and PMP.Flag>0
		LEFT JOIN dbo.Basal_Customer bc WITH(NOLOCK)ON D.SaleReturnCustomerCode = bc.CustomerCode

