/*****************************      
项目名称：山东亿辰      
功能描叙：设备报表      
创 建 人：xi.zhu      
创建时间：2024-09-22      
更新信息:       
测试调试：      
DECLARE @TotalCount INT;      
EXEC dbo.uspEquipmentOEEReport          @ExtFieldValue = '',                -- varchar(100)      
                                           @EquipmentCode = '',                     -- varchar(100)      
                                           @WorkDate = '2025-08-05',                      -- varchar(100)   
                                           @Status='',  
                                           @PageSize = 100,                   -- int      
                                           @PageIndex = 1,                  -- int      
                                           @TotalCount = @TotalCount OUTPUT -- int      
*/      
CREATE   PROCEDURE [dbo].[uspEquipmentOEEReport_20251118]      
 (      
 @ExtFieldValue varchar(100),      
 @EquipmentCode varchar(100),      
 @WorkStartDate VARCHAR(20),  
 @WorkEndDate VARCHAR(20),  
 @Status varchar(100),      
 @PageSize INT=-1,      
 @PageIndex INT=-1,      
 @TotalCount INT=-1 OUTPUT      
)      
   AS      
--20240202 Yang      
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;      
      
BEGIN      
 DECLARE @Where NVARCHAR(2000) = ' 1 = 1 '  --查询条件      
 DECLARE @TableOrViewName VARCHAR(4000)   --表名或者视图名称      
 DECLARE @Fields VARCHAR(4000)     --查询字段名      
 DECLARE @EquipmentCodeBy VARCHAR(100) = 'WorkDate asc,EquipmentCode asc' --排序字段68       
       
 --拼接 WHERE 条件       
       
 IF ISNULL(@ExtFieldValue,'') <> ''      
 BEGIN      
  SET @Where += ' and ExtFieldValue LIKE '''+@ExtFieldValue+'%''';      
 END      
 IF ISNULL(@EquipmentCode,'') <> ''      
 BEGIN      
  SET @Where += ' and EquipmentCode LIKE '''+@EquipmentCode+'%''';      
 END      
 IF ISNULL(@Status,'') <> ''      
 BEGIN      
  SET @Where += ' and Status = '''+@Status+'''';      
 END      
--  IF ISNULL(@WorkDate,'')<>''  
--  BEGIN   
--     SET @Where += ' and (WorkDate = '''+@WorkDate+''' or WorkDate=''1900-01-01'') ';     
--  END   
--  ELSE  
--  BEGIN   
--     SET @Where += ' and WorkDate = '''+CONVERT(VARCHAR(10),GETDATE(),120)+'''';     
--  END  
IF ISNULL(@WorkStartDate,'') <> ''
BEGIN
    SET @Where += ' AND WorkDate >= ''' + @WorkStartDate + ''' ';
END

IF ISNULL(@WorkEndDate,'') <> ''
BEGIN
    SET @Where += ' AND WorkDate <= ''' + @WorkEndDate + ''' ';
END

-- 只要传了任意一个日期，就带上1900-01-01
IF ISNULL(@WorkStartDate,'') <> '' OR ISNULL(@WorkEndDate,'') <> ''
BEGIN
    SET @Where += ' OR WorkDate = ''1900-01-01'' ';
END
ELSE
BEGIN
    SET @Where += ' AND WorkDate = ''' + CONVERT(VARCHAR(10), GETDATE(), 120) + '''';
END


 --select ExtFieldValue,EquipmentCode,CTTime,OkQty,NgQty,Status,TimeRate,OEE,TotalRuntime from vwEquipmentOEE order by EquipmentCode      
      
 --设置查询列      
 SET @Fields = 'Case when WorkDate=''1900-01-01'' then '''+@WorkStartDate+''' else WorkDate end  ''日期'',  
 ''<a href="javascript:void(0)" onclick="showPage(''''''+ExtFieldValue+'''''',''''''+CAST(WorkDate AS NVARCHAR(50))+'''''',1)" >''+EquipmentCode+''</a>''  
   ''设备编码''  
 ,ExtFieldValue ''机器编码'',OkQty ''良品数'',NgQty ''不良数'',Status ''状态'',TotalRuntime ''运行总时长'',TotalStopTime ''停机总时长''  
 , TimeRate ''设备时间稼动率'',OEE ''综合稼动率''  ,tQty ''开合模数''
 ,  
  ''<a href="javascript:void(0)" onclick="showPage(''''''+EquipmentCode+'''''',''''''+CAST(WorkDate AS NVARCHAR(50))+'''''',0)" >''+CurrentStatusdManger+''</a>'' ''管理状态''      
 '         
      
    PRINT @Fields  
 --设置查询表名      
 SET @TableOrViewName = 'vwEquipmentOEE_20251118'      
      
 --调用通用存储过程进行分页查询      
 EXEC @TotalCount = dbo.uspCommonPage @TableOrViewName, --@TableName = N'',        -- nvarchar(4000)      
                        '', --@PrimaryKey = N'',       -- nvarchar(50)      
                        @Fields, --@Fields = N'',           -- nvarchar(2000)      
                        @Where, --@SearchConditions = N'', -- nvarchar(4000)      
                        @EquipmentCodeBy, --@SortExpression = '',    -- varchar(100)      
                        @PageIndex, --@PageIndex = 0,          -- int      
                        @PageSize, --@PageSize = 0,           -- int      
                        2 --@Flag = 0                -- int （进行分页）      
               
END