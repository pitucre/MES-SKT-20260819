/*****************************      
项目名称：山东亿辰      
功能描叙：设备报表      
创 建 人：xi.zhu      
创建时间：2024-09-22      
更新信息:       
测试调试：      
DECLARE @TotalCount INT;  
EXEC dbo.uspGetEquipmentShiftStatusTimeReport @WorkDate = '',                  -- varchar(10)  
                                              @EquipmentCode = '',             -- varchar(100)  
                                              @PageSize = 11,                   -- int  
                                              @PageIndex = 1,                  -- int  
                                              @TotalCount = @TotalCount OUTPUT -- int  
  
*/      
CREATE   PROCEDURE [dbo].[uspGetEquipmentShiftStatusTimeReport]      
 (      
 @WorkDate varchar(10),      
 @EquipmentCode varchar(100),       
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
 DECLARE @EquipmentCodeBy VARCHAR(100) = 'WorkDate asc' --排序字段68       
       
 --拼接 WHERE 条件          
 IF ISNULL(@WorkDate,'') <> ''      
 BEGIN      
  SET @Where += ' and WorkDate = '''+@WorkDate+'''';      
 END      
 IF ISNULL(@EquipmentCode,'') <> ''      
 BEGIN      
  SET @Where += ' and MachineCode = '''+@EquipmentCode+'''';      
 END      
  
 --设置查询列      
 SET @Fields = 'WorkDate ''日期''
 ,MachineCode ''设备编码''  
 ,ShiftType ''班制''  
 ,生产  
 ,换模  
 ,调试  
 ,设备故障  
 ,模具故障  
 ,计划停机  
 ,原材料缺料  
 ,辅材缺料  
 ,保养  
 ,待换模  
 ,试模  
 ,模具厂试模 
 ,人力不足  
 ,烘料  
 ,试料  
   
 '    
  
  
  
                     
 --设置查询表名      
 SET @TableOrViewName = 'vWGetEquipmentShiftStatusTime'      
      
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
