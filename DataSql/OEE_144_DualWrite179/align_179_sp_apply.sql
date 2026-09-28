USE [PROD_TEST_MES];
GO
IF OBJECT_ID('dbo.uspEquipmentOEEReport','P') IS NOT NULL DROP PROCEDURE [dbo].[uspEquipmentOEEReport];
GO

CREATE PROCEDURE [dbo].[uspEquipmentOEEReport] (    
@ExtFieldValue varchar(100),     @EquipmentCode varchar(100),    
@WorkStartDate VARCHAR(20),     @WorkEndDate VARCHAR(20),   
@Status varchar(100),    
@PageSize INT=-1,   
@PageIndex INT=-1,    
@TotalCount INT=-1 OUTPUT ) AS SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; BEGIN     DECLARE @Where NVARCHAR(2000) = ' 1 = 1 '    
DECLARE @TableOrViewName VARCHAR(4000)    
DECLARE @Fields VARCHAR(4000)     
DECLARE @EquipmentCodeBy VARCHAR(100) = 'WorkDate asc,EquipmentCode asc'    
IF ISNULL(@ExtFieldValue,'') <> '' 
SET @Where += ' and ExtFieldValue LIKE '''+@ExtFieldValue+'%''';   
IF ISNULL(@EquipmentCode,'') <> ''
SET @Where += ' and EquipmentCode LIKE '''+@EquipmentCode+'%''';   
IF ISNULL(@Status,'') <> '' SET @Where += ' and Status = '''+@Status+'''';   
IF ISNULL(@WorkStartDate,'') <> '' SET @Where += ' AND WorkDate >= ''' + @WorkStartDate + ''' ';   
IF ISNULL(@WorkEndDate,'') <> '' SET @Where += ' AND WorkDate <= ''' + @WorkEndDate + '
'' ';      IF ISNULL(@WorkStartDate,'') <> '' OR ISNULL(@WorkEndDate,'') <> ''        
SET @Where += ' OR WorkDate = ''1900-01-01'' ';    
ELSE        
SET @Where += ' AND WorkDate = ''' + CONVERT(VARCHAR(10), GETDATE(), 120) + '''';    

IF @PageSize=-1
BEGIN
	SET @Fields = 'Case when WorkDate=''1900-01-01'' then '''+@WorkStartDate+''' else WorkDate end ''日期'',     EquipmentCode ''设备编码'', 
    ExtFieldValue ''机器编码'' ,OpenQty ''开合模次数'',tQty ''实际产品数'',     OkQty ''良品数'',NgQty ''不良数'',Status ''状态'',   CurrentStatusdManger ''管理状态'',   TotalRuntime ''生产总时长'',     TotalStopTime ''在线未生产时长'',  TotalWaitTime ''离线总时长'', 
	      TimeRate ''设备生产稼动率'',OEE ''综合稼动率OEE''    '  
	SET @TableOrViewName = 'vwEquipmentOEE' 
END 
ELSE 
BEGIN 
 SET @Fields = 'Case when WorkDate=''1900-01-01'' then '''+@WorkStartDate+''' else WorkDate end ''日期'',     ''<a href="javascript:void(0)" onclick="showPage(''''''+ExtFieldValue+'''''',''''''+CAST(WorkDate AS NVARCHAR(50))+'''''',1)" >''+EquipmentCode+''</a>''  ''设备编码'', 
    ExtFieldValue ''外部编码'',     OkQty ''良品数'',NgQty ''不良数'',Status ''状态'',     TotalRuntime ''正常生产总时长'',     TotalStopTime ''在线未生产时长'',  TotalWaitTime ''停机总时长'',    '' <a href="javascript:void(0)" onclick="showPage(''''''+EquipmentCode+'''''',''''''+CAST(WorkDate AS NVARCHAR(50))+'''''',0)" >''+CurrentStatusdManger+''</a>'' ''管理状态'',     TimeRate ''设备生产稼动率'',OEE ''综合稼动率OEE'',tQty ''开合模数'' ,OpenQty ''开合数''    '  
	SET @TableOrViewName = 'vwEquipmentOEE' 
END 
  
	EXEC @TotalCount = dbo.uspCommonPage @TableOrViewName, '', @Fields, @Where, @EquipmentCodeBy, @PageIndex, @PageSize, 2 END


GO