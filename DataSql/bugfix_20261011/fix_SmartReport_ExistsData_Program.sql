/*****************************
Fix Bug62: SmartReport_ExistsData - trim input search value
Problem: Smart query cannot find data that normal query finds.
         Hand scanners often append trailing space/CR/LF to scanned values.
         SP uses strict equality (= @ScheduleValue) without trimming,
         so 'SN ' != 'SN' and no data matches.
Root cause: Missing LTRIM/RTRIM on @ScheduleValue
Fix: Add SET @ScheduleValue = LTRIM(RTRIM(@ScheduleValue)) at SP start
Backup: bak_179_SmartReport_ExistsData_20261010200515.sql
*****************************/
	
ALTER PROCEDURE [dbo].[SmartReport_ExistsData]
/*************************************************************************
存储过程名： [SmartReport_ExistsData]
功能描述 : 该存储过程用于搜索关键词是否存在
		   
参数说明:   @Flag int			1：物料编码  2：物料条码
			@ScheduleValue      搜索关键词
作者 ：qiquan.zhong
创建时间 : 2018.06.23
修改时间 :

*************************************************************************/
(
	@DataType int,  --1：物料编码  2：物料条码
	@ScheduleValue NVARCHAR(250),
	@UserId INT
)
AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
--Bug62 fix: trim whitespace from search value (scanners often append trailing space/CR/LF)
SET @ScheduleValue = LTRIM(RTRIM(@ScheduleValue));

BEGIN

	--物料编码
	IF(@DataType=1)
		BEGIN
			SELECT TOP 1   @DataType dataType, '物料编码' as [desc] FROM dbo.Basal_Item WITH(NOLOCK) WHERE ItemCode =@ScheduleValue
		END 

	--物料条码
	IF(@DataType=2)
		BEGIN
			SELECT TOP 1  @DataType dataType,'物料条码' as [desc] FROM dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE SerialNumber = @ScheduleValue
		END 

	--产品条码
	IF(@DataType=3)
		BEGIN
			SELECT TOP 1  @DataType dataType,'产品条码' as [desc] FROM dbo.Prod_SerialNumber WITH(NOLOCK) WHERE Value = @ScheduleValue
		END 

		--工单条码
	IF(@DataType=4)
		BEGIN
			SELECT TOP 1  @DataType dataType,'工单条码' as [desc] FROM  dbo.Prod_Order WITH(NOLOCK) WHERE OrderNO = @ScheduleValue
		END 

		--IQC单号
	IF(@DataType=5)
		BEGIN
			SELECT TOP 1  @DataType dataType,'IQC单号' as [desc] FROM  dbo.Prod_MaterialIQC WITH(NOLOCK) WHERE InspectionNo = @ScheduleValue
		END      

	--采购单号
	IF(@DataType=6)
		BEGIN
			SELECT TOP 1  @DataType dataType,'采购单号' as [desc] FROM  dbo.ERP_PurOrder WITH(NOLOCK) WHERE POCode = @ScheduleValue
		END 
		     
		--送货单号
	IF(@DataType=7)
		BEGIN
			SELECT TOP 1  @DataType dataType,'送货单号' as [desc] FROM  dbo.Prod_Deliver WITH(NOLOCK) WHERE DeliverNo = @ScheduleValue
		END      

	 --检验单号
	IF(@DataType=8)
		BEGIN
			SELECT TOP 1  @DataType dataType,'检验单号' as [desc] FROM  dbo.Prod_InspectionLot WITH(NOLOCK) WHERE InspectionLotNo = @ScheduleValue
		END     

	--产线名称
	IF(@DataType=9)
		BEGIN
			SELECT TOP 1  @DataType dataType,'产线名称' as [desc] FROM  dbo.Basal_Line WITH(NOLOCK) WHERE LineName = @ScheduleValue
		END   
		  
	--物料批次
	IF(@DataType=10)
		BEGIN
			SELECT  TOP 1  @DataType dataType,'物料批次' as [desc] FROM  dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE LotCode = @ScheduleValue
		END     

	--产品包装信息
	IF(@DataType=11)
		BEGIN
			SELECT TOP 1 @DataType dataType,'产品包装信息' as [desc] FROM  dbo.Prod_PackingData WITH(NOLOCK) WHERE SerialNumber = @ScheduleValue OR ContainerSN = @ScheduleValue
		END     

	--用户名或帐号
	IF(@DataType=16)
		BEGIN 
			SELECT TOP 1 @DataType dataType,'用户名' as [desc] FROM  dbo.SYS_Users WITH(NOLOCK) WHERE UserName = @ScheduleValue 
		END     
END





