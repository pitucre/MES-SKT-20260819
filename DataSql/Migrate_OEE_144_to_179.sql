/*******************************************************************************
 Migrate_OEE_144_to_179.sql
 Source : 172.16.5.144 / LeanMes
 Target : 172.16.5.179 / PROD_TEST_MES
 Purpose: Copy OEE-related objects (144 defs) into 179 test DB
 Diff   : 6 procs + 4 views differ; 1 table missing column; jobs 5 vs 2
 Generated: 2026-09-23 10:50:59
 Backups: DataSql/OEE_179_BAK/ (previous 179 definitions)
 NOTE   : Job.database_name=PROD_TEST_MES; change if env uses LeanMes_Test
*******************************************************************************/
USE [PROD_TEST_MES];
GO
SET XACT_ABORT ON;
GO

/***** 1. Table: add Prod_EquimentOrderPord.ProdNum *****/
IF COL_LENGTH('dbo.Prod_EquimentOrderPord', 'ProdNum') IS NULL
BEGIN
    ALTER TABLE dbo.Prod_EquimentOrderPord ADD ProdNum int NULL;
    EXEC sp_addextendedproperty 'MS_Description', N'ProdNum', 'SCHEMA', 'dbo', 'TABLE', 'Prod_EquimentOrderPord', 'COLUMN', 'ProdNum';
    PRINT 'ALTER: Prod_EquimentOrderPord.ProdNum added';
END
ELSE PRINT 'SKIP: Prod_EquimentOrderPord.ProdNum already exists';
GO

/***** 2. Views (leaf first) *****/

PRINT '--- VIEW [dbo].[vwEquipmentOutQty] ---';
IF OBJECT_ID('dbo.vwEquipmentOutQty', 'V') IS NOT NULL DROP VIEW [dbo].[vwEquipmentOutQty];
GO
CREATE VIEW [dbo].[vwEquipmentOutQty]  
AS  
 --SELECT EquipmentCode,WorkDate,CAST(sum(ISNULL(cc.MoldCavity*aa.Qty,0)) as int) as tQty,CAST(sum(ISNULL(aa.Qty,0)) as int) as OpenQty   
 --FROM Prod_EquimentOrderPord aa  with(nolock)  
 --INNER JOIN Prod_Order oo  with(nolock) on oo.OrderNO=aa.OrderNo  
 --INNER JOIN  Basal_MoldFixtureItem cc  with(nolock) on cc.ItemId=oo.ItemId  
  
 --GROUP by EquipmentCode,WorkDate  


  SELECT aa.EquipmentCode,WorkDate,CAST(sum(ISNULL(D.Cavity*aa.Qty,0)) as int) as tQty,CAST(sum(ISNULL(aa.Qty,0)) as int) as OpenQty   
 FROM Prod_EquimentOrderPord aa  with(nolock)  
 INNER JOIN Prod_Order oo  with(nolock) on oo.OrderNO=aa.OrderNo  
 INNER JOIN dbo.Basal_Equipment b WITH(NOLOCK) ON oo.MachineNumber = b.EquipmentCode          
 INNER JOIN dbo.Prod_MoldFixtureUpLine c WITH(NOLOCK) ON c.EquipmentMoudleId = b.EquipmentId AND c.Status = 1          
 INNER JOIN dbo.Basal_Equipment d WITH(NOLOCK) ON d.EquipmentId = c.EquipmentID  
 --WHERE  aa.EquipmentCode='15070722' and aa.WorkDate='2026-09-20'
 GROUP by aa.EquipmentCode,WorkDate
GO

PRINT '--- VIEW [dbo].[vwCollectionEngelDataHistory] ---';
IF OBJECT_ID('dbo.vwCollectionEngelDataHistory', 'V') IS NOT NULL DROP VIEW [dbo].[vwCollectionEngelDataHistory];
GO
/*****************************      
项目名称：      
功能描叙： -M03_设备OEE报表 查询明细视图     
创 建 人：xi.zhu      
创建时间：2024-09-22      
更新信息:       
测试调试：      
<asp:BoundField DataField="SaleReturnNo" HeaderText="日期" SortExpression="SaleReturnNo" />      
*/        
CREATE VIEW [dbo].[vwCollectionEngelDataHistory]      
AS       
SELECT  HisDataId,      
        CollectionDate,      
     CollectionTime,      
     CASE WHEN  EquipmentType=1 THEN '1' ELSE  '2' END EquipmentType ,      
     A.EquipmentCode,      
     a.Status,      
     ShotCounter,      
     PerformanceTest,      
     ProcessFormulaName,      
     InjectionForce,      
     MoldProtectionTime,      
     ActualProtectionTime,      
     CycleTimeSetValue,      
     MaximumCycleTime,      
     PreviousCycleTime,      
     CoolingTime,      
     ActualBasketballTimeValue,      
     ActualValueOfMoldClosingTime,      
     RotationPositionMoldRotationCycleTime,      
     ConfirmCycleInsertTime,      
     ConfirmTheRemovalOfPositionCycleTime,      
     DryCycleTime,      
     ClosingTime,      
     ShutdownTimeBeforeRestartingProduction,      
     UnlockTime,      
     MoldOpeningTime,      
     LockingForceAndUnloadingTime,      
     ConstructionTimeOfLockingForce,      
     MoldOpeningCycleTime,      
     LockTime,      
     NeutronMotionTime,      
     MoldPauseTime,      
     UntilTheCompletionTimeOfDemolding,      
     TopOutTime,      
     NozzleAdvanceCycleTime,      
     ActualValueOfCleaningTime,      
     PressureHoldingCycleTime,      
     PressureHoldingCycleTimeSettingValue,      
     MoldNumber,      
     a.MachineNumber,      
     AutomatedProductionOfFirstPiece,      
     TotalProductionQuantity,      
     ActualValueOfProductCounter,      
     Temperature,      
     InternalCavityPressureDuringPressureConversion,      
     ReasonForShutdown,ISNULL(a.OrderNo,'') OrderNo,ISNULL(MouldCode,'') MouldCode,
	 A.MoldCavity
   --case when ISNULL(a.MoldCavity,'')='0.00' then cast (cc.MoldCavity as nvarchar(50)) else cast ( 1 as nvarchar(50)) end MoldCavity     
  FROM  Prod_CollectionEngelDataHistory  A    
  with(nolock) 
  --LEFT JOIN     
  --Prod_Order po with(nolock) on a.OrderNo=po.OrderNO    
  --left join  Basal_Equipment BE ON BE.EquipmentCode=MouldCode  
  --left join   Basal_MoldFixtureItem cc  with(nolock) on cc.ItemId=po.ItemId    AND BE.EquipmentId=CC.EquipmentId     
  WHERE CollectionDate=CONVERT(VARCHAR(10),GETDATE(),120)
GO

PRINT '--- VIEW [dbo].[vWGetEquipmentShiftStatusTime] ---';
IF OBJECT_ID('dbo.vWGetEquipmentShiftStatusTime', 'V') IS NOT NULL DROP VIEW [dbo].[vWGetEquipmentShiftStatusTime];
GO
  /*****************************  
项目名称：获取设备A B班制状态的运行时间  
功能描叙：  
创 建 人：xi.zhu  
创建时间：2025-04-08  
更新信息:   
测试调试：  
  
*/  
CREATE VIEW vWGetEquipmentShiftStatusTime  
as  
 select  CONVERT(VARCHAR(10),WorkDate,120) WorkDate,MachineCode,'晚班' ShiftType  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=1 then AtotalRunTime else 0 end)) '生产'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=2 then AtotalRunTime else 0 end)) '换模'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=3 then AtotalRunTime else 0 end)) '调试'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=4 then AtotalRunTime else 0 end)) '设备故障'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=5 then AtotalRunTime else 0 end)) '模具故障'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=6 then AtotalRunTime else 0 end)) '计划停机'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=7 then AtotalRunTime else 0 end)) '原材料缺料'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=8 then AtotalRunTime else 0 end)) '辅材缺料'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=9 then AtotalRunTime else 0 end)) '保养'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=10 then AtotalRunTime else 0 end)) '待换模'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=11 then AtotalRunTime else 0 end)) '试模'  
     ,[dbo].[fn_GetDateZH] (sum(case when Status=12 then AtotalRunTime else 0 end)) '人力不足'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=13 then AtotalRunTime else 0 end)) '烘料'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=14 then AtotalRunTime else 0 end)) '试料'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=15 then AtotalRunTime else 0 end)) '模具厂试模'
      ,[dbo].[fn_GetDateZH] (sum(case when Status=16 then AtotalRunTime else 0 end)) '生产挤模'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=17 then AtotalRunTime else 0 end)) '自动化故障'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=18 then AtotalRunTime else 0 end)) '清洗螺杆'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=19 then AtotalRunTime else 0 end)) '机台故障'
   ,[dbo].[fn_GetDateZH] (sum(case when Status=20 then AtotalRunTime else 0 end)) '周转车'
  , [dbo].[fn_GetDateZH] (sum(case when Status=21 then AtotalRunTime else 0 end)) '未生产中'  

  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=1 then BtotalRunTime else 0 end)) 'B生产'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=2 then BtotalRunTime else 0 end)) 'B换模'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=3 then BtotalRunTime else 0 end)) 'B调试'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=4 then BtotalRunTime else 0 end)) 'B设备故障'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=5 then BtotalRunTime else 0 end)) 'B模具故障'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=6 then BtotalRunTime else 0 end)) 'B计划停机'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=7 then BtotalRunTime else 0 end)) 'B原材料缺料'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=8 then BtotalRunTime else 0 end)) 'B辅材缺料'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=9 then BtotalRunTime else 0 end)) 'B保养'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=10 then BtotalRunTime else 0 end)) 'B待换模'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=11 then BtotalRunTime else 0 end)) 'B试模'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=12 then BtotalRunTime else 0 end)) 'B人力不足'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=13 then BtotalRunTime else 0 end)) 'B烘料'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=14 then BtotalRunTime else 0 end)) 'B试料'  
  
  from Prod_EquipmentStatusCollectionData PES with(nolock)  
  group by WorkDate,MachineCode  
  UNION   
    SELECT  CONVERT(VARCHAR(10),WorkDate,120) WorkDate,MachineCode,'白班' ShiftType  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=1 then AtotalRunTime else 0 end)) 'A生产'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=2 then AtotalRunTime else 0 end)) 'A换模'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=3 then AtotalRunTime else 0 end)) 'A调试'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=4 then AtotalRunTime else 0 end)) 'A设备故障'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=5 then AtotalRunTime else 0 end)) 'A模具故障'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=6 then AtotalRunTime else 0 end)) 'A计划停机'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=7 then AtotalRunTime else 0 end)) 'A原材料缺料'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=8 then AtotalRunTime else 0 end)) 'A辅材缺料'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=9 then AtotalRunTime else 0 end)) 'A保养'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=10 then AtotalRunTime else 0 end)) 'A待换模'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=11 then AtotalRunTime else 0 end)) 'A试模'  
  --   ,[dbo].[fn_GetDateZH] (sum(case when Status=12 then AtotalRunTime else 0 end)) 'A人力不足'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=13 then AtotalRunTime else 0 end)) 'A烘料'  
  --,[dbo].[fn_GetDateZH] (sum(case when Status=14 then AtotalRunTime else 0 end)) 'A试料'  
  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=1 then BtotalRunTime else 0 end)) '生产'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=2 then BtotalRunTime else 0 end)) '换模'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=3 then BtotalRunTime else 0 end)) '调试'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=4 then BtotalRunTime else 0 end)) '设备故障'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=5 then BtotalRunTime else 0 end)) '模具故障'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=6 then BtotalRunTime else 0 end)) '计划停机'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=7 then BtotalRunTime else 0 end)) '原材料缺料'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=8 then BtotalRunTime else 0 end)) '辅材缺料'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=9 then BtotalRunTime else 0 end)) '保养'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=10 then BtotalRunTime else 0 end)) '待换模'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=11 then BtotalRunTime else 0 end)) '试模'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=12 then BtotalRunTime else 0 end)) '人力不足'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=13 then BtotalRunTime else 0 end)) '烘料'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=14 then BtotalRunTime else 0 end)) '试料'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=15 then BtotalRunTime else 0 end)) '模具厂试模'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=16 then BtotalRunTime else 0 end)) '生产挤模'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=17 then BtotalRunTime else 0 end)) '自动化故障'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=18 then BtotalRunTime else 0 end)) '清洗螺杆'  
  ,[dbo].[fn_GetDateZH] (sum(case when Status=19 then BtotalRunTime else 0 end)) '机台故障'
  ,[dbo].[fn_GetDateZH] (sum(case when Status=20 then BtotalRunTime else 0 end)) '周转车'
  ,[dbo].[fn_GetDateZH] (sum(case when Status=21 then BtotalRunTime else 0 end)) '未生产中'  
  from Prod_EquipmentStatusCollectionData PES with(nolock)  
  group by WorkDate,MachineCode
GO

PRINT '--- VIEW [dbo].[vwEquipmentOEE] ---';
IF OBJECT_ID('dbo.vwEquipmentOEE', 'V') IS NOT NULL DROP VIEW [dbo].[vwEquipmentOEE];
GO
CREATE   VIEW [dbo].[vwEquipmentOEE] AS SELECT CONVERT(VARCHAR(10),ISNULL(PES.WorkDate,''),120) WorkDate, TbEqu.ExtFieldValue,      
       TbEqu.EquipmentCode,      
       ISNULL(PCE.PerformanceTest, 0.0) CTTime,      
       --CASE WHEN PCE.EquipmentCode IS NULL then 0 else ISNULL(PES.TotalRuntime, 0)  end  TotalRuntime,              
       CASE      
           WHEN PCE.EquipmentCode IS NULL THEN      
               0      
           ELSE      
               ISNULL(PED.OkQty, 0)      
       END OkQty,      
       CASE      
           WHEN PCE.EquipmentCode IS NULL THEN      
               0      
           ELSE      
               ISNULL(PED.NgQty, 0)      
       END NgQty    
    ,      
       CASE      
            
           WHEN PES.MachineCode IS NULL THEN      
               '离线中'      
           WHEN PES.CurrentStatus IN ( 1, 4 ) THEN      
               '生产中'       
    
           ELSE      
     CASE  WHEN DATEDIFF(MINUTE, PCE.UpdateDateTime, GETDATE()) > 5     
           THEN '通讯中断'    
     ELSE   
               '在线未生产'     
      END   
       END Status    
   --,PES.TotalRuntime    
   --,PCE.EquipmentCode    
   --,CAST(ISNULL(PES.TotalRuntime, 0) AS decimal(18, 2))     
      ,(CASE  WHEN ISNULL(PES.TotalRuntime, 0) > 0   AND PCE.EquipmentCode IS NOT NULL THEN      
                  
      CAST(CAST(CAST(ISNULL(PES.TotalRuntime, 0) AS DECIMAL(18, 2))   / CASE WHEN PES.WorkDate=CAST(GETDATE() AS DATE) THEN  DATEDIFF(SECOND, CONVERT(VARCHAR(10), GETDATE(), 120) + ' 00:00:00', GETDATE()) ELSE 86400 END  * 100 AS DECIMAL(18, 2)) AS VARCHAR(10))      
            ELSE      
                '0'      
        END      
       ) + '%' TimeRate    
    ,CAST(CASE      
                WHEN ( ISNULL(PED.OkQty, 0)   +  ISNULL(PED.NgQty, 0)  ) > 0      
                     AND PCE.EquipmentCode IS NOT NULL THEN      
                    CAST(CAST(ISNULL(PES.TotalRuntime, 0) AS DECIMAL(18, 2)) / 86400 * CAST(OkQty AS DECIMAL(18, 2))      
                         / (OkQty + NgQty) * 100 AS DECIMAL(18, 2))      
                ELSE      
                    0      
            END AS VARCHAR(10)) + '%' OEE,    
      
-- ,CAST(CASE      
--                 WHEN ( ISNULL(PED.OkQty, 0)   +  ISNULL(PED.NgQty, 0)  ) > 0      
--                      AND PCE.EquipmentCode IS NOT NULL and ISNULL(PES.TotalRuntime, 0)<>0 THEN      
--                     CAST(CAST(ISNULL(PES.TotalRuntime, 0) AS DECIMAL(18, 2)) / 86400 *  
--           CAST(CAST(ISNULL(PCE.PerformanceTest, 0.0) AS DECIMAL(18, 2)) * (OkQty + NgQty)/CAST(ISNULL(PES.TotalRuntime, 0) AS DECIMAL(18, 2)) AS DECIMAL(18, 2)) *  
--           CAST(OkQty AS DECIMAL(18, 2)) / (OkQty + NgQty) * 100 AS DECIMAL(18, 2))      
--                 ELSE      
--                     0      
--             END AS VARCHAR(10)) + '%' OEE,     
  
  
       CASE      
           WHEN ISNULL(PES.TotalRuntime, 0) > 0      
                AND PCE.EquipmentCode IS NOT NULL THEN      
               CAST(PES.TotalRuntime / 3600 AS VARCHAR(10)) + '小时' + CAST(PES.TotalRuntime % 3600 / 60 AS VARCHAR(10))      
               + '分'      
           ELSE      
               '0时0分'      
       END TotalRuntime    
 ,  CASE      
           WHEN ISNULL(PES.TotalStop, 0) > 0      
                AND PCE.EquipmentCode IS NOT NULL THEN      
               CAST(PES.TotalStop / 3600 AS VARCHAR(10)) + '小时' + CAST(PES.TotalStop % 3600 / 60 AS VARCHAR(10)) + '分'      
           ELSE      
               '0时0分'      
       END TotalStopTime,     
      CASE      
           WHEN ISNULL(PES.TotalWait, 0) > 0      
                AND PCE.EquipmentCode IS NOT NULL THEN      
               CAST(PES.TotalWait / 3600 AS VARCHAR(10)) + '小时' + CAST(PES.TotalWait % 3600 / 60 AS VARCHAR(10)) + '分'      
           ELSE      
               '0时0分'      
       END TotalWaitTime,       
       ISNULL(BES.StatusDesc, '未选择') CurrentStatusdManger 
	    ,ISNULL(EOQ.ProdNum,0) tQty  ,
	   isnull(EOQ.Qty,0) OpenQty
FROM      
(      
    SELECT B.ExtFieldValue,      
           c.EquipmentCode ,c.EquipmentId     
    FROM dbo.Basal_ExtensionFields A WITH (NOLOCK)      
        INNER JOIN Basal_Equipment_Ext B WITH (NOLOCK)      
            ON A.ExtensionFieldsId = B.ExtFieldsId      
        INNER JOIN dbo.Basal_Equipment c WITH (NOLOCK)      
            ON c.EquipmentId = B.TableDataId      
    WHERE TableName = 'Basal_Equipment'      
          AND A.ExtensionFieldName = 'ID'      
) TbEqu      
    LEFT JOIN dbo.Prod_CollectionEngelData PCE WITH (NOLOCK)      
        ON PCE.EquipmentCode = TbEqu.ExtFieldValue      
    LEFT JOIN Prod_EquipmentStatusCollectionCurrent PES WITH (NOLOCK)      
        ON PES.MachineCode = TbEqu.ExtFieldValue      
           --AND PES.WorkDate = CONVERT(VARCHAR(10), GETDATE(), 120)   --lei.yu 20251229 注释获取当天    
    LEFT JOIN Prod_EquipmentDayProd PED WITH (NOLOCK)      
        ON PED.EquipmentCode = TbEqu.EquipmentCode      
           AND PED.WorkDate =pes.WorkDate     
    LEFT JOIN dbo.Prod_EquipmentStatusData PESD      
        ON PESD.MachineCode = TbEqu.EquipmentCode      
           AND PESD.WorkDate = PES.WorkDate      
    LEFT JOIN Basal_EquipmentStatus BES WITH (NOLOCK)      
        ON BES.StatusId = PESD.CurrentStatus    
 LEFT JOIN Prod_EquimentOrderPord EOQ WITH(NOLOCK)    
  ON EOQ.EquipmentCode=TbEqu.ExtFieldValue AND EOQ.WorkDate=pes.WorkDate
GO

/***** 3. Stored procedures *****/

PRINT '--- PROC [dbo].[uspEquipmentOEEReport] ---';
IF OBJECT_ID('dbo.uspEquipmentOEEReport', 'P') IS NOT NULL DROP PROCEDURE [dbo].[uspEquipmentOEEReport];
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
	SET @Fields = 'Case when WorkDate=''1900-01-01'' then '''+@WorkStartDate+''' else WorkDate end ''日期'',
    EquipmentCode ''设备编码'',
    ExtFieldValue ''机器编码'',
    OkQty ''良品数'', NgQty ''不良数'', Status ''状态'',
    CurrentStatusdManger ''管理状态'',
    TotalRuntime ''运行总时长'',
    TotalStopTime ''停机总时长'',
    TimeRate ''设备时间稼动率'',
    OEE ''综合稼动率'',
    tQty ''开合模数'''
SET @TableOrViewName = 'vwEquipmentOEE' 
END 
ELSE 
BEGIN 
 SET @Fields = 'Case when WorkDate=''1900-01-01'' then '''+@WorkStartDate+''' else WorkDate end ''日期'',
    ''<a href="javascript:void(0)" onclick="showPage(''''''+ExtFieldValue+'''''',''''''+CAST(WorkDate AS NVARCHAR(50))+'''''',1)" >''+EquipmentCode+''</a>''  ''设备编码'',
    ExtFieldValue ''机器编码'',
    OkQty ''良品数'', NgQty ''不良数'', Status ''状态'',
    TotalRuntime ''运行总时长'',
    TotalStopTime ''停机总时长'',
    '' <a href="javascript:void(0)" onclick="showPage(''''''+EquipmentCode+'''''',''''''+CAST(WorkDate AS NVARCHAR(50))+'''''',0)" >''+CurrentStatusdManger+''</a>'' ''管理状态'',
    TimeRate ''设备时间稼动率'',
    OEE ''综合稼动率'',
    tQty ''开合模数'''
SET @TableOrViewName = 'vwEquipmentOEE' 
END 
  
	EXEC @TotalCount = dbo.uspCommonPage @TableOrViewName, '', @Fields, @Where, @EquipmentCodeBy, @PageIndex, @PageSize, 2 END
GO

PRINT '--- PROC [dbo].[uspEquipmentOEEReport_20251118] ---';
IF OBJECT_ID('dbo.uspEquipmentOEEReport_20251118', 'P') IS NOT NULL DROP PROCEDURE [dbo].[uspEquipmentOEEReport_20251118];
GO
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
GO

PRINT '--- PROC [dbo].[uspGetEquipmentShiftStatusTimeReport] ---';
IF OBJECT_ID('dbo.uspGetEquipmentShiftStatusTimeReport', 'P') IS NOT NULL DROP PROCEDURE [dbo].[uspGetEquipmentShiftStatusTimeReport];
GO

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
CREATE   PROCEDURE [dbo].uspGetEquipmentShiftStatusTimeReport        
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
     
  ,模具厂试模  
  ,生产挤模
  ,自动化故障
  ,清洗螺杆
  ,机台故障
  ,周转车
  ,未生产中
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
GO

PRINT '--- PROC [dbo].[uspToalEquRunTime] ---';
IF OBJECT_ID('dbo.uspToalEquRunTime', 'P') IS NOT NULL DROP PROCEDURE [dbo].[uspToalEquRunTime];
GO
/*****************************    
项目名称：山东亿辰    
功能描叙：统计设备当前运行时间    
创 建 人：xi.zhu    
创建时间：2025-08-08    
更新信息:     
测试调试：    
    
*/    
CREATE PROC uspToalEquRunTime    
@EquipmentCode VARCHAR(50)    
AS    
BEGIN     
    
     DECLARE @NowDateTime DATETIME=GETDATE();    
     DECLARE @EquimentExtNo VARCHAR(100) = '',    
            @WorkDate DATE = @NowDateTime;    
  DECLARE @LastDateTime DATETIME,    
            @LastStatus INT,    
            @TotalRuntime int = 0,    
            @TotalWait INT = 0,    
            @TotalStop INT = 0,    
            @RunTotalTime DECIMAL(18,2)=0,    
            @CollectionTime DATETIME = @NowDateTime;    
    
    --获取当天上一次的时间            
    SELECT @LastDateTime = LastUpdateTime,    
           @LastStatus = CurrentStatus    
    FROM Prod_EquipmentStatusData WITH (NOLOCK)    
    WHERE WorkDate = @WorkDate    
          AND MachineCode = @EquipmentCode;    
    
    --如果当天设备状态为空 则获取之前上一次的状态    
    IF  @LastStatus IS NULL     
 BEGIN     
  ---获取设备最新的上一次的状态            
  SELECT top 1 @LastStatus = CurrentStatus    
  FROM Prod_EquipmentStatusData WITH (NOLOCK)    
  WHERE MachineCode = @EquipmentCode order by  lastupdatetime desc  
 END     
    
    SET @LastStatus = ISNULL(@LastStatus, 1); --默认生产中            
    IF @LastDateTime IS NULL    
    BEGIN    
        IF @LastStatus = 1    
        BEGIN    
            SET @TotalRuntime = DATEDIFF(ss, @WorkDate, @NowDateTime);    
        END;    
        ELSE    
        BEGIN    
            SET @TotalStop = DATEDIFF(ss, @WorkDate, @NowDateTime);    
        END;    
    
        INSERT dbo.Prod_EquipmentStatusData    
        (    
            WorkDate,    
            MachineCode,    
            CurrentStatus,    
            TotalRuntime,    
            TotalWait,    
            TotalStop,    
            LastUpdateTime    
        )    
        VALUES    
        (   @WorkDate,      -- WorkDate - date            
            @EquipmentCode, -- MachineCode - varchar(100)            
            @LastStatus,    -- CurrentStatus - int            
            @TotalRuntime,  -- TotalRuntime - int            
            @TotalWait,     -- TotalWait - int            
            @TotalStop,     -- TotalStop - int            
            @NowDateTime       -- LastUpdateTime - datetime            
            );    
        IF @@ERROR <> 0    
        BEGIN    
            RAISERROR('新增设备运行时间发生错误!', 1, 12);    
            RETURN;    
        END;    
    END;    
    ELSE    
    BEGIN    
        ---上一次状态生产             
        IF @LastStatus = 1    
        BEGIN    
            SET @TotalRuntime = DATEDIFF(ss, @LastDateTime, @CollectionTime);    
        END;    
        ELSE    
        BEGIN    
            SET @TotalStop = DATEDIFF(ss, @LastDateTime, @CollectionTime);    
        END;    
    
        UPDATE dbo.Prod_EquipmentStatusData    
        SET TotalRuntime = TotalRuntime + @TotalRuntime,    
            TotalWait = TotalWait + @TotalWait,    
            TotalStop = TotalStop + @TotalStop,    
            LastUpdateTime = @CollectionTime    
        WHERE WorkDate = @WorkDate    
              AND MachineCode = @EquipmentCode;    
        IF @@ERROR <> 0    
        BEGIN    
            RAISERROR('更新设备运行时间发生错误!', 1, 12);    
            RETURN;    
        END;    
    END;    
 --当前小时    
 DECLARE @Hours INT=DATEPART(HOUR, @NowDateTime);    
 DECLARE @ATotalRuntime INT=0 ,@BTotalRuntime INT=0 ;    
     
    IF NOT  EXISTS( SELECT  1 FROM  Prod_EquipmentStatusCollectionData  WHERE  MachineCode=@EquipmentCode  AND WorkDate=@WorkDate AND Status=@LastStatus)    
 BEGIN     
    IF @LastDateTime IS NULL     
    BEGIN     
    --如果当前时间    
     IF (@Hours>=0  AND @Hours<8)       
     BEGIN     
      SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 00:00:00'    
      SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);    
     END      
     ELSE  IF (@Hours>=20 AND  @Hours<24)    
     BEGIN    
      SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 20:00:00'    
      SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);    
     END     
     ELSE    
     BEGIN      
      SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 08:00:00'    
      SET @BTotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);    
     END     
    END     
    ELSE      
    BEGIN     
        --上一次更新时间小时    
       DECLARE @HoursLast INT=DATEPART(HOUR, @LastDateTime);    
       --如果当前时间    
     IF (@Hours>=0  AND @Hours<8)        
     BEGIN     
                
      IF (@HoursLast >8 OR @HoursLast<24)    
      BEGIN     
         SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 00:00:00'    
         SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);    
      END     
      ELSE     
      BEGIN     
       SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);    
      END     
          
     END      
     ELSE  IF (@Hours>=20 AND  @Hours<24)      
     BEGIN    
         IF  (@HoursLast >24 OR  @HoursLast<20)    
      BEGIN     
      SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 20:00:00'    
         SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);    
      END     
      ELSE     
      BEGIN     
           SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);    
      END     
          
     END     
     ELSE IF (@Hours>=8 AND  @Hours<20)      
     BEGIN      
        IF  (@HoursLast >20 OR  @HoursLast<8)    
        BEGIN     
        SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 08:00:00'    
       SET @BTotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);    
        END     
        ELSE     
        BEGIN     
        SET @BTotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);    
        END     
     END     
        
    
    END     
    
    
    
   INSERT dbo.Prod_EquipmentStatusCollectionData    
   (    
       WorkDate,    
       MachineCode,    
       Status,    
       ATotalRuntime,    
       BTotalRuntime,    
       LastUpdateTime    
   )    
   VALUES    
   (   @WorkDate, -- WorkDate - date    
       @EquipmentCode,        -- MachineCode - varchar(100)    
       @LastStatus,         -- Status - int    
       @ATotalRuntime,         -- ATotalRuntime - int    
       @BTotalRuntime,         -- BTotalRuntime - int    
       @NowDateTime  -- LastUpdateTime - datetime    
       )    
   IF @@ERROR <> 0    
   BEGIN    
    RAISERROR('新增设备运行时间发生错误!', 1, 12);    
    RETURN;    
   END;    
 END     
 ELSE     
 BEGIN     
    IF (@Hours>=0  AND @Hours<8)    
    BEGIN     
      SET @ATotalRuntime=CASE WHEN @TotalRuntime>0 THEN @TotalRuntime ELSE @TotalStop END ;    
    END      
    ELSE IF  (@Hours>=20 AND  @Hours<24)    
    BEGIN     
         ---如果上次更新时间小于晚班开始时间20点则配置成    
          IF (@LastDateTime<CONVERT(VARCHAR(10),GETDATE(),120)+' 20:00:00')    
       BEGIN     
      SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 20:00:00'    
      SET @ATotalRuntime =DATEDIFF(ss, @LastDateTime, @CollectionTime);    
       END     
       ELSE     
       BEGIN     
             SET @ATotalRuntime=CASE WHEN @TotalRuntime>0 THEN @TotalRuntime ELSE @TotalStop END ;    
       END     
    END      
    ELSE     
    BEGIN     
    
         --如果上一次的时间小时    
         IF  DATEPART(HOUR, @NowDateTime)<8    
      BEGIN     
      SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 08:00:00'    
      SET @BTotalRuntime =DATEDIFF(ss, @LastDateTime, @CollectionTime);    
      END      
      ELSE     
      BEGIN     
            SET @BTotalRuntime=CASE WHEN @TotalRuntime>0 THEN @TotalRuntime ELSE @TotalStop END ;    
      END     
    END     
	print  '@lastStats :'+cast(@LastStatus as varchar(20))
    UPDATE Prod_EquipmentStatusCollectionData SET ATotalRuntime=ATotalRuntime+@ATotalRuntime ,BTotalRuntime=@BTotalRuntime+BTotalRuntime,LastUpdateTime=@CollectionTime WHERE  WorkDate=@WorkDate AND MachineCode=@EquipmentCode AND Status=@LastStatus    
 END     
END
GO

PRINT '--- PROC [dbo].[uspEquipmentStatusEdit] ---';
IF OBJECT_ID('dbo.uspEquipmentStatusEdit', 'P') IS NOT NULL DROP PROCEDURE [dbo].[uspEquipmentStatusEdit];
GO

/*****************************          
项目名称：山东亿辰          
功能描叙：          
创 建 人：xi.zhu          
创建时间：2024-09-22          
更新信息:           
测试调试：          
*/        
CREATE PROC [dbo].[uspEquipmentStatusEdit]        
    @EquipmentCode VARCHAR(50),        
    @Status INT,        
    @UserName VARCHAR(20)        
AS        
BEGIN        
    DECLARE @InjectionStatus INT=-1;        
    DECLARE @NowDateTime DATETIME =GETDATE()      
    DECLARE @CollectionTime DATETIME = @NowDateTime;        
    DECLARE @CollectionDate DATE = @CollectionTime;        
    
    SELECT @InjectionStatus = ISNULL(InjectionStatus, -1)        
    FROM dbo.Basal_Equipment WITH (NOLOCK)        
    WHERE EquipmentCode = @EquipmentCode;        
    IF @InjectionStatus IS NULL        
    BEGIN        
        RAISERROR('设备编码不存在!', 1, 12);        
        RETURN;        
    END;        
        
    
    --获取当天上一次执行更新时间与状态          
    DECLARE @LastDateTime DATETIME,        
            @LastStatus INT,        
            @TotalRuntime INT = 0,        
            @TotalWait INT = 0,        
            @TotalStop INT = 0;        
      
    --获取当天上一次的时间          
    SELECT @LastDateTime = LastUpdateTime,        
           @LastStatus = CurrentStatus        
    FROM Prod_EquipmentStatusData WITH (NOLOCK)        
    WHERE WorkDate = @CollectionDate        
          AND MachineCode = @EquipmentCode;        
      
    IF @LastStatus IS NULL      
   BEGIN     
   ---获取设备最新的上一次的状态          
    SELECT top 1 @LastStatus = CurrentStatus        
    FROM Prod_EquipmentStatusData WITH (NOLOCK)        
    WHERE MachineCode = @EquipmentCode order  by  LastUpdateTime desc   
	
    SET @LastStatus = ISNULL(@LastStatus, 1); --默认生产中        
    
   END      
  IF @LastStatus = @Status  and @LastStatus is not null       
  BEGIN        
   RETURN;        
  END;      
     
    
     
        
    --生产状态切换的逻辑是：设备状态当前属于调试状态； --调试状态切换的逻辑是：设备状态当前属于停机/换模状态； --换模状态切换的逻辑是：设备状态当前属于停机状态； --停机状态的切换逻辑是：设备当前属于生产状态/调试状态          
    --DECLARE @ErrorMsg VARCHAR(500) = CASE        
    --                                     WHEN @Status = 1        
    --                                          AND @InjectionStatus != 3 THEN        
    --                                         '设备当前状态非调试状态！'        
    --                                     WHEN @Status = 3        
    --                                          AND @InjectionStatus NOT IN ( 3, 5 ) THEN        
    --                                         '设备当前状态非停机/换模状态！'        
    --                                     WHEN @Status = 2        
    --                                          AND @InjectionStatus != 5 THEN        
    --                                         '设备当前状态非停机状态！'        
    --                                     WHEN @Status = 5        
    --                                          AND @InjectionStatus NOT IN ( 1, 3 ) THEN        
    --                                         '设备当前状态非生产 / 调试状态！'        
    --                                     ELSE        
    --                                         ''        
    --                                 END;        
    --IF @ErrorMsg != ''        
    --BEGIN        
    --    RAISERROR(@ErrorMsg, 1, 12);        
    --    RETURN;        
    --END;        
        
       
        
        
    BEGIN TRAN;        
      
    UPDATE Basal_Equipment        
    SET InjectionStatus = @Status        
    WHERE EquipmentCode = @EquipmentCode;        
    IF @@ERROR <> 0        
    BEGIN        
        RAISERROR('变更设备状态发生错误!', 1, 12);     
        ROLLBACK TRAN;      
        RETURN;        
    END;        
        
  EXEC  uspToalEquRunTime @EquipmentCode  
  IF  @@ERROR<>0  
  BEGIN    
     RAISERROR('变更设备状态发生错误!', 1, 12);     
        ROLLBACK TRAN;      
        RETURN;    
  END   
  
  UPDATE dbo.Prod_EquipmentStatusData SET CurrentStatus=@Status   WHERE WorkDate=@CollectionDate AND MachineCode=@EquipmentCode;  
   IF  @@ERROR<>0  
    BEGIN  
       RAISERROR('更新设备运行时间发生错误!',1,12);  
       ROLLBACK TRAN;  
                RETURN;  
                END   
    
 --   IF @LastDateTime IS NULL        
 --   BEGIN        
 --       IF @Status = 1  OR @LastStatus = 1        
 --       BEGIN        
 --           SET @TotalRuntime = DATEDIFF(ss, @CollectionDate, @CollectionTime);        
 --       END;        
 --       ELSE        
 --       BEGIN        
 --           SET @TotalStop = DATEDIFF(ss, @CollectionDate, @CollectionTime);        
 --       END;        
 --       INSERT dbo.Prod_EquipmentStatusData        
 --       (        
 --           WorkDate,        
 --           MachineCode,        
 --           CurrentStatus,        
 --           TotalRuntime,        
 --           TotalWait,        
 --           TotalStop,        
 --           LastUpdateTime        
 --       )        
 --       VALUES        
 --       (   @CollectionDate, -- WorkDate - date          
 --           @EquipmentCode,  -- MachineCode - varchar(100)          
 --           @Status,         -- CurrentStatus - int          
 --           @TotalRuntime,   -- TotalRuntime - int          
 --           @TotalWait,      -- TotalWait - int          
 --           @TotalStop,      -- TotalStop - int          
 --           @CollectionTime  -- LastUpdateTime - datetime          
 --           );        
 --       IF @@ERROR <> 0        
 --       BEGIN        
 --           RAISERROR('新增设备运行时间发生错误!', 1, 12);        
 --           ROLLBACK TRAN;        
 --           RETURN;        
 --       END;        
 --   END;        
 --  ELSE        
 --   BEGIN        
 --       ---上一次状态生产           
 --       IF @LastStatus = 1        
 --       BEGIN        
 --           SET @TotalRuntime = DATEDIFF(ss, @LastDateTime, @CollectionTime);        
 --       END;        
 --       ELSE        
 --       BEGIN        
 --           SET @TotalStop = DATEDIFF(ss, @LastDateTime, @CollectionTime);        
 --       END;        
 --       PRINT @TotalRuntime      
 --       UPDATE dbo.Prod_EquipmentStatusData        
 --       SET CurrentStatus = @Status,        
 --           TotalRuntime = TotalRuntime + @TotalRuntime,        
 --           TotalWait = TotalWait + @TotalWait,        
 --           TotalStop = TotalStop + @TotalStop,        
 --           LastUpdateTime = @CollectionTime        
 --       WHERE WorkDate = @CollectionDate        
 --             AND MachineCode = @EquipmentCode;        
 --       IF @@ERROR <> 0        
 --       BEGIN        
 --           RAISERROR('更新设备运行时间发生错误!', 1, 12);        
 --           ROLLBACK TRAN;        
 --           RETURN;        
 --       END;        
 --   END;        
      
 ----当前小时      
 --DECLARE @Hours INT=DATEPART(HOUR, @NowDateTime);      
 --DECLARE @ATotalRuntime INT=0 ,@BTotalRuntime INT=0 ;      
       
 --   IF NOT  EXISTS( SELECT  1 FROM  Prod_EquipmentStatusCollectionData  WHERE  MachineCode=@EquipmentCode  AND WorkDate=@CollectionDate AND Status=@LastStatus)      
 --BEGIN       
      
 --         IF (@Hours>0  AND @Hours<8) OR (@Hours>20 AND  @Hours<24)      
 --   BEGIN       
 --    SET @ATotalRuntime=DATEDIFF(ss,CASE WHEN @LastDateTime IS NULL  THEN  @CollectionDate ELSE @LastDateTime END , @NowDateTime);      
 --   END        
 --   ELSE       
 --   BEGIN       
 --      SET @BTotalRuntime=DATEDIFF(ss, CASE WHEN @LastDateTime IS NULL  THEN  @CollectionDate ELSE @LastDateTime END, @NowDateTime);      
 --   END       
      
 --  INSERT dbo.Prod_EquipmentStatusCollectionData      
 --  (      
 --      WorkDate,      
 --      MachineCode,      
 --      Status,      
 --      ATotalRuntime,      
 --      BTotalRuntime,      
 --      LastUpdateTime      
 --  )      
 --  VALUES      
 --  (   @CollectionDate, -- WorkDate - date      
 --      @EquipmentCode,        -- MachineCode - varchar(100)      
 --      @LastStatus,         -- Status - int      
 --      @ATotalRuntime,         -- ATotalRuntime - int      
 --      @BTotalRuntime,         -- BTotalRuntime - int      
 --      @NowDateTime  -- LastUpdateTime - datetime      
 --      )      
 --  IF @@ERROR <> 0      
 --  BEGIN      
 --   RAISERROR('新增设备运行时间发生错误!', 1, 12);      
 --  ROLLBACK TRAN;        
 --   RETURN;      
 --  END;      
 --END       
 --ELSE       
 --BEGIN       
 --   IF (@Hours>0  AND @Hours<8) OR (@Hours>20 AND  @Hours<24)      
 --   BEGIN       
 --    SET @ATotalRuntime=CASE WHEN @TotalRuntime>0 THEN @TotalRuntime ELSE @TotalStop END ;      
 --   END        
 --   ELSE       
 --   BEGIN       
 --      SET @BTotalRuntime=CASE WHEN @TotalRuntime>0 THEN @TotalRuntime ELSE @TotalStop END ;      
 --   END       
 --   UPDATE Prod_EquipmentStatusCollectionData SET ATotalRuntime=ATotalRuntime+@ATotalRuntime ,BTotalRuntime=@BTotalRuntime+BTotalRuntime WHERE  WorkDate=@CollectionDate AND MachineCode=@EquipmentCode AND Status=@LastStatus      
 --       IF @@ERROR <> 0      
 --   BEGIN      
 --   RAISERROR('更新设备运行时间发生错误!', 1, 12);      
 --    ROLLBACK TRAN;        
 --   RETURN;      
 --  END;      
       
 --END       
      
        
    COMMIT TRAN;        
        
    DECLARE @InjectionStatusStr NVARCHAR(30) =''       
 SELECT  @InjectionStatusStr=ISNULL(StatusDesc,'')  FROM  Basal_EquipmentStatus  WHERE  StatusId=@InjectionStatus       
    DECLARE @StatusStr NVARCHAR(30) =''      
   SELECT  @StatusStr=ISNULL(StatusDesc,'')  FROM  Basal_EquipmentStatus  WHERE  StatusId=@Status       
      
    DECLARE @LogContent VARCHAR(500) = '变更设备状态由【' + @InjectionStatusStr + '】变更【' + @StatusStr + '】';        
    EXEC uspSaveOperationLog @UserName,        
                             '修改',        
                             '注塑采集',        
                             '注塑采集',        
                             @EquipmentCode,        
                             @LogContent;        
        
END;        
      
  
  
SET QUOTED_IDENTIFIER ON  
SET ANSI_NULLS ON
GO

PRINT '--- PROC [dbo].[uspEquimentCollection] ---';
IF OBJECT_ID('dbo.uspEquimentCollection', 'P') IS NOT NULL DROP PROCEDURE [dbo].[uspEquimentCollection];
GO
    
CREATE PROC [dbo].[uspEquimentCollection]            
@ParamterStr VARCHAR(2000),            
@ParamterVal VARCHAR(2000),            
@EquipmentType INT  ,   --1=恩格尔  2=海天            
@EquiCode VARCHAR(100)='' OUTPUT            
AS             
BEGIN             
     DECLARE @CollectionTime DATETIME=GETDATE();            
     DECLARE @CollectionDate DATE=@CollectionTime;            
               
  DECLARE @HisTotal INT ;            
  DECLARE @HisMinId BIGINT ;            
            
  SELECT @HisTotal=  COUNT(0),@HisMinId=MIN(Hid) FROM Prod_EquipmentCollectionHistory WITH(NOLOCK)             
  --如果历史记录表大于10万条数据 则删除最早的5W条数据            
 IF  @HisTotal>10000000            
 BEGIN             
      DELETE Prod_EquipmentCollectionHistory WHERE Hid BETWEEN @HisMinId  AND @HisMinId+50000            
 END             
            
 INSERT dbo.Prod_EquipmentCollectionHistory            
 (            
     ParamterStr,            
     ParamterVal,            
  EquipmentCode            
 )            
 VALUES            
 (               
     @ParamterStr,       -- ParamterStr - varchar(2000)            
     @ParamterVal,       -- ParamterVal - varchar(2000)            
     @EquiCode            
 )            
            
    --SELECT * INTO #Temp  FROM dbo.Fn_convertstringtotablestring3('20240921,08:44:39,225086,0,81084,81203,"00329637_38",1.011,5.00,0.55,0.0,70.00,40.95,20,22.75,2.44,0.00,0.00,0.00,6.71,3.33,0.00,1.17,5.09,0.37,0.44,0.44,0.44,0.00,3.13,40.90,1.22,1.74,"Rekordergeh',',')             
  IF OBJECT_ID('tempdb..#Temp') IS NOT NULL            
            DROP TABLE #Temp;            
 SELECT seq,REPLACE(strvalue,'"','') strvalue INTO #Temp FROM dbo.Fn_convertstringtotablestring3(@ParamterVal,',')             
             
            
   IF OBJECT_ID('tempdb..##TempParms') IS NOT NULL            
            DROP TABLE #TempParms;            
 SELECT seq,REPLACE(strvalue,'"','') strvalue INTO #TempParms FROM dbo.Fn_convertstringtotablestring3(@ParamterStr,',')             
             
            
 DECLARE @Status INT ;            
 DECLARE @UpdateDate VARCHAR(8)  --采集日期            
 ,@UpdateTime VARCHAR(10),  --采集时间            
@WorkTime VARCHAR(100),            
@EquipmentCode VARCHAR(100),            
@ShotCounter VARCHAR(100),@NowShotCounter VARCHAR(100),  --  开合模次数  --  开合模次数            
@PerformanceTest VARCHAR(100),    --周期(节拍)计数器            
@ProcessFormulaName    VARCHAR(100),          --工艺配方（参数集）名称            
@InjectionForce    VARCHAR(100),         --注塑力            
@MoldProtectionTime   VARCHAR(100),         --模具保护时间            
@ActualProtectionTime  VARCHAR(100),         --模具保护时间实际值            
@CycleTimeSetValue   VARCHAR(100),         --周期时间设定值            
            
@MaximumCycleTime   VARCHAR(100),         --周期时间最大值            
@PreviousCycleTime   VARCHAR(100),         --上一节拍周期时间            
@CoolingTime     VARCHAR(100),         --冷却时间            
@ActualBasketballTimeValue VARCHAR(100),         --篮球时间实际值            
@ActualValueOfMoldClosingTime   VARCHAR(100),      --合模时间实际值            
            
@RotationPositionMoldRotationCycleTime VARCHAR(100),      --旋转位置转出模具循环时间              
@ConfirmCycleInsertTime     VARCHAR(100),      --确认镶件插入位置周期时间              
@ConfirmTheRemovalOfPositionCycleTime VARCHAR(100),      --确认去除位置周期时间            
@DryCycleTime       VARCHAR(100),      --干循环时间            
@ClosingTime        VARCHAR(100),      --合模时间            
            
@ShutdownTimeBeforeRestartingProduction VARCHAR(100),      --重启生产前停机时间            
@UnlockTime        VARCHAR(100),      --解锁时间            
@MoldOpeningTime       VARCHAR(100),      --开模时间            
@LockingForceAndUnloadingTime   VARCHAR(100),      --锁模力卸力时间            
@ConstructionTimeOfLockingForce   VARCHAR(100),      --锁模力建设时间            
            
@MoldOpeningCycleTime     VARCHAR(100),      --开模周期时间            
@LockTime        VARCHAR(100),      --锁定时间            
@NeutronMotionTime      VARCHAR(100),      --中子运动时间            
@MoldPauseTime       VARCHAR(100),      --模具暂停时间            
@UntilTheCompletionTimeOfDemolding  VARCHAR(100),      --至脱模完成时间            
            
@TopOutTime        VARCHAR(100),      --顶出时间            
@NozzleAdvanceCycleTime     VARCHAR(100),      --喷嘴前进周期时间            
@ActualValueOfCleaningTime    VARCHAR(100),      --清洗时间实际值            
@PressureHoldingCycleTime    VARCHAR(100),      --保压周期时间            
@PressureHoldingCycleTimeSettingValue VARCHAR(100),      --保压周期时间设定值            
            
@MoldNumber        VARCHAR(100),      --模具号            
@MachineNumber       VARCHAR(100),      --机器号            
@AutomatedProductionOfFirstPiece   VARCHAR(100),      --自动生产首件            
@TotalProductionQuantity    VARCHAR(100),          --总生产数量            
@ActualValueOfProductCounter    VARCHAR(100),      --产品计数器实际值            
            
@Temperature        VARCHAR(100),      --温度            
@InternalCavityPressureDuringPressureConversion VARCHAR(100),    --转压时模内型腔压力            
@ReasonForShutdown        VARCHAR(100)    --停机原因            
 --变更设备状态             
DECLARE @EquipmentId INT=-1            
declare @OrderNo varchar(50)='',@MouldCode VARCHAR(50)='',@MouldId INT=-1 ;          
DECLARE @ItemId INT=-1;          
DECLARE @MoldCavity DECIMAL(18,2)=0;  --模具模穴数     
  
DECLARE @Prodgroupid int ---订单组  
select @Prodgroupid=isnull(ProdOrderGroupID,0) FROM PROD_ORDER where orderno=@OrderNo  
        
          
--恩格尔获取数据            
IF  @EquipmentType=1            
BEGIN             
 SELECT @UpdateDate=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='DATE')            
 SELECT @UpdateTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='TIME')   --时间            
 SELECT @EquiCode=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='@32026')   --注塑机编码            
 SELECT @Status=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='@32000')   --注塑机状态  0=停机 3=半自动 4=全自动            
 SELECT @ShotCounter=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ShotCounter.sv_iShotCounter','@cc300://imm/cm#//c.ShotCounter/p.sv_iShotCounter/v'))   --开合模次数             
             
 SELECT @PerformanceTest=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@PerformanceTest.sv_iCyclicCountPDP','@cc300://imm/cm#//c.CycleTime/p.sv_CycleTime/v/p.dActvalLast/v'))   --周期节拍计数器             
            
 SELECT @ProcessFormulaName=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Host.sv_sActivePartData','@cc300://imm/cm#//c.DataManipulation/p.PartData/v/p.imm/v/p.default/v/p.name/v'))   --工艺配方（参数集）名称             
 SELECT @InjectionForce=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@InjectionUnit1.sv_rIntegralPHost','@cc300://imm/cm#//c.InjectionUnit1/p.sv_rIntegralPPart/v'))   --注塑力            
 SELECT @MoldProtectionTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Mold1.sv_dMldProtTimeSet','@cc300://imm/cm#//c.Mold1/p.sv_dMldProtTimeSet/v'))   --模具保护时间            
 SELECT @ActualProtectionTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Mold1.sv_dMldProtTimeActHost','@cc300://imm/cm#//c.Mold1/p.sv_dMldProtTimeAct/v'))   --模具保护时间实际值             
 SELECT @CycleTimeSetValue=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ShotCounter.sv_BDEParam.dCycleTimeSet','@cc300://imm/cm#//c.ShotCounter/p.sv_BDEParam/v/p.dCycleTimeSet/v'))   --周期时间设定值            
             
 SELECT @MaximumCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_CycleTime.dMaxval','@cc300://imm/cm#//c.CycleTime/p.sv_CycleTime/v/p.dMaxval/v'))   --周期时间最大值             
    SELECT @PreviousCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dCycleTimeActvalLastHost','@cc300://imm/cm#//c.CycleTime/p.sv_CycleTime/v/p.dActvalLast/v'))   --上一节拍周期时间             
    SELECT @CoolingTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@system.sv_CoolingTime.rSetVal','@cc300://imm/cm#//c.system/p.sv_CoolingTime/v/p.rSetVal/v'))  --冷却时间            
    SELECT @ActualBasketballTimeValue=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dCooling1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dCooling1PDP/v'))  --篮球时间实际值                       
    SELECT @ActualValueOfMoldClosingTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldCloseClPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldCloseClPDP/v'))                                        --合模时间实际值                      
             
    SELECT @RotationPositionMoldRotationCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldSwiv1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldSwiv1PDP/v'))            --旋转位置转出模具循环时间             
    SELECT @ConfirmCycleInsertTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dQuittInsert1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dQuittInsert1PDP/v'))           --确认镶件插入位置周期时间             
    SELECT @ConfirmTheRemovalOfPositionCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dQuittDemolding1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dQuittDemolding1PDP/v'))         --确认去除位置周期时间       
  
    
      
       
    SELECT @DryCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dDryCycle','@cc300://imm/cm#//c.CycleTime/p.sv_dDryCycle/v'))              --干循环时间                          
    SELECT @ClosingTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldClose1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldClose1PDP/v'))            --合模时间                          
                
    SELECT @ShutdownTimeBeforeRestartingProduction=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dTimeTillStartButton','@cc300://imm/cm#//c.CycleTime/p.sv_dTimeTillStartButton/v'))         --重启生产前停机时间    
  
    
             
    SELECT @UnlockTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldOpenUnlockPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldOpenUnlockPDP/v'))          --解锁时间                          
    SELECT @MoldOpeningTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldOpen1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldOpen1PDP/v'))            --开模时间                          
    SELECT @LockingForceAndUnloadingTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldOpenClmpRedPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldOpenClmpRedPDP/v'))         --锁模力卸力时间                  
  
    
    SELECT @ConstructionTimeOfLockingForce=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldCloseClmpBldPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldCloseClmpBldPDP/v'))         --锁模力建设时间              
  
             
    SELECT @MoldOpeningCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldCloseClmpBldPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldOpenOpPDP/v'))          --开模周期时间                      
    SELECT @LockTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldCloseLockPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldCloseLockPDP/v'))          --锁定时间                          
    SELECT @NeutronMotionTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dCoreMovements','@cc300://imm/cm#//c.CycleTime/p.sv_dCoreMovements/v'))            --中子运动时间                      
    SELECT @MoldPauseTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dDemolding1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dDemolding1PDP/v'))            --模具暂停时间                      
    SELECT @UntilTheCompletionTimeOfDemolding=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Demolding.sv_dCycleTimeTillEndOfDemolding','@cc300://imm/cm#//c.Demolding/p.sv_dCycleTimeTillEndOfDemolding/v'))     --至脱模完成时间                      
                
    SELECT @TopOutTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Ejector1.sv_dCycleTime','@cc300://imm/cm#//c.Ejector1/p.sv_dCycleTime/v'))              --顶出时间                          
    SELECT @NozzleAdvanceCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Nozzle1.sv_dCycleTimeForw','@cc300://imm/cm#//c.Nozzle1/p.sv_dCycleTimeForw/v'))             --喷嘴前进周期时间                  
    SELECT @ActualValueOfCleaningTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@InjectionUnit2.sv_dGasPurgingAct','@cc300://imm/cm#//c.InjectionUnit1/p.sv_dGasPurgingAct/v'))         --清洗时间实际值                     
 
    SELECT @PressureHoldingCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@InjectionUnit1.sv_dCycleTimePostPressure','@cc300://imm/cm#//c.InjectionUnit1/p.sv_dCycleTimePostPressure/v'))     --保压周期时间           
  
    
      
    SELECT @PressureHoldingCycleTimeSettingValue=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@InjectionUnit1.sv_rPostPressureTime','@cc300://imm/cm#//c.InjectionUnit1/p.sv_rPostPressureTime/v'))        --保压周期时间设定值   
  
        
    SELECT @MoldNumber=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Parts.sv_sMoldNumber','@cc300://imm/cm#//c.Parts/p.sv_sMoldNumber/v'))               --模具号                              
    SELECT @MachineNumber=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Parts.sv_sMachineNumber','@cc300://imm/cm#//c.Parts/p.sv_sMachineNumber/v'))              --机器号                              
    SELECT @AutomatedProductionOfFirstPiece=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@PDP.sv_bFirstCycleIsActivePDP','@cc300://imm/cm#//c.PDP/p.sv_bFirstCycleIsActivePDP/v'))           --自动生产首件                    
  
    SELECT @TotalProductionQuantity=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ShotCounter.sv_iPartCounter','@cc300://imm/cm#//c.ShotCounter/p.sv_iPartCounter/v'))            --总生产数量                          
    SELECT @ActualValueOfProductCounter=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@system.sv_iPartCounterActval','@cc300://imm/cm#//c.system/p.sv_iPartCounterActval/v'))           --产品计数器实际值                  
                
    SELECT @Temperature=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ChargeAmp1.sv_rCavTempOnCutOffHost',''))                       --温度                              
    SELECT @ReasonForShutdown=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Host.sv_iStandStillCode','@cc300://imm/cm#//c.Host/p.sv_iStandStillCode/v'))              --停机原因                          
            
    ---0=停机 3=半自动(可能是调试 所以也算停机) 4=全自动            
    UPDATE dbo.Basal_Equipment SET Status=CASE WHEN  @Status in(0,3) THEN 2 ELSE  1 END   WHERE EquipmentId=@EquipmentId            
            
END             
---获取海天设备数据            
ELSE IF  @EquipmentType=2            
BEGIN             
 SELECT @EquiCode=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='@MachineID')   --注塑机编码            
 SELECT @Status=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='@PartSts')   --注塑机状态   0=不生产  1=生产            
 SELECT @ShotCounter=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ActCntPrt'))   --开合模次数             
 SELECT @PerformanceTest=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ActTimCyc'))   --周期节拍计数器             
 SELECT @InjectionForce=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ActFrcClp'))   --注塑力            
            
 SET @UpdateDate=CONVERT(VARCHAR(8),@CollectionDate,112);            
 SET @UpdateTime=CONVERT(VARCHAR(8),@CollectionTime,114);            
            
 UPDATE dbo.Basal_Equipment SET Status=CASE WHEN  @Status=0 THEN 2 ELSE  1 END   WHERE EquipmentId=@EquipmentId            
            
END             
        
 DECLARE @MesEquiCode VARCHAR(50);       
 SELECT @EquipmentId=b.TableDataId,@MesEquiCode=be.EquipmentCode  FROM  dbo.Basal_ExtensionFields A  WITH(NOLOCK)    
 INNER JOIN Basal_Equipment_Ext B  WITH(NOLOCK) ON A.ExtensionFieldsId=B.ExtFieldsId        
 INNER JOIN  dbo.Basal_Equipment BE WITH(NOLOCK) ON be.EquipmentId=b.TableDataId  
 WHERE  TableName='Basal_Equipment' AND ExtensionFieldName='ID' AND B.ExtFieldValue=@EquiCode             
   
   --获取工单号与工单产品ID          
 SELECT @OrderNo=B.OrderNO,@ItemId=B.ItemId from Prod_EquimentInOrder  A WITH(NOLOCK) INNER JOIN dbo.Prod_Order B WITH(NOLOCK) ON a.ProdOrderId=b.ProdOrderID WHERE EquipmentId=@EquipmentId          
           
  --获取模具编码与模具ID          
  DECLARE @UseMoldCavity DECIMAL(18,6) = 0  

  
 SELECT TOP 1 @MouldCode = d.EquipmentCode,@MouldId = d.EquipmentId ,@UseMoldCavity = CASE  WHEN ISNULL(a.CurrMoldCavity,0)=0 THEN D.Cavity ELSE ISNULL(a.CurrMoldCavity,1) END   FROM Prod_Order a WITH(NOLOCK)           
 INNER JOIN dbo.Basal_Equipment b WITH(NOLOCK) ON a.MachineNumber = b.EquipmentCode          
 INNER JOIN dbo.Prod_MoldFixtureUpLine c WITH(NOLOCK) ON c.EquipmentMoudleId = b.EquipmentId AND c.Status = 1          
 INNER JOIN dbo.Basal_Equipment d WITH(NOLOCK) ON d.EquipmentId = c.EquipmentID          
 WHERE a.OrderNO = @OrderNo          
        
 select  @NowShotCounter=ShotCounter from Prod_CollectionEngelData with(nolock) where EquipmentCode=@EquiCode        
        
 --获取模穴数          
 --SELECT @MoldCavity=MoldCavity FROM dbo.Basal_MoldFixtureItem WITH(NOLOCK)  WHERE EquipmentId=@EquipmentId AND ItemId=@ItemId          
 SET @MoldCavity=@UseMoldCavity  

 if isnull(@MoldCavity,0)=0
 begin 
        set  @MoldCavity=1;
 end 
  
 --根据开合模次数 更新模具使用次数  
 update dbo.Basal_Equipment SET UseCount=UseCount+@ShotCounter-@NowShotCounter WHERE EquipmentId=@MouldId  
    
            
 --获取当天上一次执行更新时间与状态            
 DECLARE  @LastDateTime DATETIME,@LastStatus INT ,@TotalRuntime  INT=0 ,@TotalWait INT=0 ,@TotalStop int=0 ,@RunTime int =0,@LastDataStatus INT ;            
 
 SELECT @LastDateTime=LastUpdateTime,@LastStatus=CurrentStatus FROM Prod_EquipmentStatusCollectionCurrent  WHERE WorkDate=@CollectionDate AND MachineCode=@EquiCode            
 SET @Status=ISNULL(@Status,0)            
      
      
 IF @LastDateTime IS NULL            
 BEGIN             
    set @RunTime=DATEDIFF(ss,@CollectionDate,@CollectionTime);      
    IF @EquipmentType=1            
    BEGIN            
   --IF @Status in(0 ,3) OR @NowShotCounter=@ShotCounter or @RunTime>120    
    IF  @NowShotCounter=@ShotCounter   
   BEGIN             
     SET @Status=0;        
     SET @TotalStop=@RunTime;          
   END             
   --ELSE  IF @Status IN(4)   
   ELSE
   BEGIN 
    Set @Status=4
    SET @TotalRuntime=@RunTime;            
   END             
   END             
   ELSE  IF @EquipmentType=2            
   BEGIN             
    --IF @Status=0  OR @NowShotCounter=@ShotCounter  or @RunTime>120   
    IF  @NowShotCounter=@ShotCounter    
    BEGIN             
        SET @Status=0;        
        SET @TotalStop=@RunTime          
    END             
   -- ELSE  IF @Status=1       
   Else 
    BEGIN      
         set @Status=1;
         SET @TotalRuntime=@RunTime;           
    END             
   END             
   INSERT dbo.Prod_EquipmentStatusCollectionCurrent            
   (            
       WorkDate,            
       MachineCode,       
       MachineIP,            
       CurrentStatus,            
       TotalRuntime,            
       TotalWait,            
       TotalStop,            
       LastUpdateTime            
   )            
   VALUES            
   (   @CollectionDate, -- WorkDate - date            
       @EquiCode,        -- MachineCode - varchar(100)            
       '',        -- MachineIP - varchar(20)            
       @Status,         -- CurrentStatus - int            
       @TotalRuntime,         -- TotalRuntime - int            
       @TotalWait,         -- TotalWait - int            
       @TotalStop,         -- TotalStop - int            
       @CollectionTime  -- LastUpdateTime - datetime            
       )            
 END             
 ELSE             
 BEGIN             
 set @RunTime=DATEDIFF(ss,@LastDateTime,@CollectionTime);        
 IF @EquipmentType=1            
    BEGIN            
      --0=停机 3=半自动 4=全自动            
      -- 上一状态是停机或者待机状态和当前状态是生产状态计算运行时间            
           
     -- 上一状态是生产状态和当前状态是停机算运行时间            
    --IF  @Status in(0,3) OR @NowShotCounter=@ShotCounter or  @RunTime>120  
    IF  @NowShotCounter=@ShotCounter 
    BEGIN             
   SET @Status=0        
   SET @TotalStop= @RunTime            
    END          
    ELSE         
    BEGIN    
        set  @Status=4;
       SET @TotalRuntime=@RunTime;          
    END        
   END             
   ELSE  IF @EquipmentType=2            
     BEGIN             
     --IF  @Status=0  OR @NowShotCounter=@ShotCounter  or  @RunTime>120  
     IF  @NowShotCounter=@ShotCounter  
  BEGIN             
       SET @Status=0        
        SET @TotalStop= @RunTime;           
    END             
    --ELSE IF  @Status =1     
    Else 
   BEGIN    
    set  @Status=1
    SET @TotalRuntime=@RunTime;          
   END             
     -- 上一状态是生产状态和当前状态是停机算运行时间           
     END             
              
   UPDATE dbo.Prod_EquipmentStatusCollectionCurrent SET CurrentStatus=@Status,TotalRuntime=TotalRuntime+@TotalRuntime,            
   TotalWait=TotalWait+@TotalWait,TotalStop=TotalStop+@TotalStop ,LastUpdateTime=@CollectionTime            
   WHERE WorkDate=@CollectionDate AND MachineCode=@EquiCode            
 END             
            
  SELECT TOP 1 @LastDataStatus = CurrentStatus   FROM Prod_EquipmentStatusData WITH (NOLOCK)  WHERE MachineCode = @MesEquiCode ORDER BY WorkDate DESC    
    
 --如果当前采集设备状态是生产中 实际管理状态非生产中 则自动更新管理状态为生产中 禅道需求：24543    
 IF (@Status=1 OR @Status=4) AND @LastDataStatus!=1    
 BEGIN     
   EXEC uspEquipmentStatusEdit @MesEquiCode,1,'admin'    
 END   
 
 IF @Status IN(0,4) AND @LastDataStatus=1    
 BEGIN     
   EXEC uspEquipmentStatusEdit @MesEquiCode,21,'admin'    
 END     
     
 --20250908 吴锋文修改，增加一个工单按组进行收集数据  
 if @Prodgroupid>0  
 BEGIN  
  IF ISNULL(@OrderNo,'')!=''  
   BEGIN   
  IF NOT EXISTS(SELECT  1 FROM Prod_EquimentOrderPord a inner join Prod_ORDER b on a.OrderNo=b.OrderNo  WHERE b.ProdOrderGroupID=@Prodgroupid AND a.WorkDate=@CollectionDate AND a.EquipmentCode=@EquiCode)   
   BEGIN   
    INSERT dbo.Prod_EquimentOrderPord  
    (  
        OrderNo,  
        TotalRunTime,  
        TotalStopTime,  
        EquipmentCode,  
        WorkDate,  
        Qty,
        ProdNum
    )  
    SELECT  OrderNo, -- OrderNo - varchar(50)  
        @TotalRuntime,  -- TotalRunTime - int  
        @TotalStop,  -- TotalStopTime - int  
        @EquiCode, -- EquipmentCode - varchar(50)  
        @CollectionDate, -- WorkDate - varchar(10)  
        CAST(@ShotCounter AS INT)-@NowShotCounter,
        (CAST(@ShotCounter AS INT)-@NowShotCounter)*@MoldCavity
       FROM Prod_Order WHERE ProdOrderGroupID=@Prodgroupid  
   END   
  ELSE   
   BEGIN   
    UPDATE  Prod_EquimentOrderPord SET TotalRunTime=TotalRunTime+@TotalRuntime,TotalStopTime=TotalStopTime+@TotalStop,Qty=qty+@ShotCounter-@NowShotCounter,ProdNum=ProdNum+(cast(@ShotCounter as int)-@NowShotCounter)*@MoldCavity WHERE EquipmentCode=@EquiCode AND WorkDate=@CollectionDate AND OrderNo IN (SELECT ORDERNO FROM PROD_ORDER WHERE ProdOrderGroupID=@Prodgroupid)  
   END   
  END   
 END  
ELSE  
 BEGIN  
  IF ISNULL(@OrderNo,'')!=''  
   BEGIN   
  IF NOT EXISTS(SELECT  1 FROM Prod_EquimentOrderPord  WHERE OrderNo=@OrderNo AND WorkDate=@CollectionDate AND EquipmentCode=@EquiCode)   
   BEGIN   
    INSERT dbo.Prod_EquimentOrderPord  
    (  
        OrderNo,  
        TotalRunTime,  
        TotalStopTime,  
        EquipmentCode,  
        WorkDate,  
        Qty  ,
        ProdNum

    )  
    VALUES  
    (   @OrderNo, -- OrderNo - varchar(50)  
        @TotalRuntime,  -- TotalRunTime - int  
        @TotalStop,  -- TotalStopTime - int  
        @EquiCode, -- EquipmentCode - varchar(50)  
        @CollectionDate, -- WorkDate - varchar(10)  
       CAST(@ShotCounter AS INT)-@NowShotCounter,
       (CAST(@ShotCounter AS INT)-@NowShotCounter)*@MoldCavity
       
      )  
   END   
  ELSE   
   BEGIN   
    UPDATE  Prod_EquimentOrderPord SET TotalRunTime=TotalRunTime+@TotalRuntime,TotalStopTime=TotalStopTime+@TotalStop,Qty=qty+@ShotCounter-@NowShotCounter,ProdNum=ProdNum+(cast(@ShotCounter as int)-@NowShotCounter)*@MoldCavity WHERE EquipmentCode=@EquiCode AND WorkDate=@CollectionDate AND OrderNo=@OrderNo  
   END   
  END   
 END  
   
  
  
  
    
             
 IF NOT  EXISTS(SELECT 1 FROM Prod_CollectionEngelData WITH(NOLOCK) WHERE EquipmentCode=@EquiCode)            
 BEGIN             
   INSERT dbo.Prod_CollectionEngelData            
   (            
       CollectionDate,            
       CollectionTime,            
       EquipmentType,            
       EquipmentCode,            
       Status,            
       ShotCounter,            
       PerformanceTest,            
       ProcessFormulaName,            
       InjectionForce,            
       MoldProtectionTime,            
       ActualProtectionTime,            
       CycleTimeSetValue,            
       MaximumCycleTime,            
       PreviousCycleTime,            
       CoolingTime,            
       ActualBasketballTimeValue,            
       ActualValueOfMoldClosingTime,            
       RotationPositionMoldRotationCycleTime,            
       ConfirmCycleInsertTime,            
       ConfirmTheRemovalOfPositionCycleTime,            
       DryCycleTime,            
       ClosingTime,            
       ShutdownTimeBeforeRestartingProduction,            
       UnlockTime,            
       MoldOpeningTime,            
       LockingForceAndUnloadingTime,            
      ConstructionTimeOfLockingForce,            
       MoldOpeningCycleTime,            
       LockTime,            
       NeutronMotionTime,            
       MoldPauseTime,            
       UntilTheCompletionTimeOfDemolding,            
       TopOutTime,            
       NozzleAdvanceCycleTime,            
       ActualValueOfCleaningTime,            
       PressureHoldingCycleTime,            
       PressureHoldingCycleTimeSettingValue,            
       MoldNumber,            
       MachineNumber,            
       AutomatedProductionOfFirstPiece,            
       TotalProductionQuantity,            
       ActualValueOfProductCounter,            
       Temperature,            
       InternalCavityPressureDuringPressureConversion,            
       ReasonForShutdown,            
       CreateDateTime            
                  
   )            
   VALUES            
   (   @UpdateDate,            
       @UpdateTime,            
       @EquipmentType,            
       @EquiCode,            
       @Status,            
       @ShotCounter,            
       @PerformanceTest,            
       @ProcessFormulaName,            
       @InjectionForce,            
       @MoldProtectionTime,            
       @ActualProtectionTime,            
       @CycleTimeSetValue,            
       @MaximumCycleTime,            
       @PreviousCycleTime,            
       @CoolingTime,            
       @ActualBasketballTimeValue,            
       @ActualValueOfMoldClosingTime,            
       @RotationPositionMoldRotationCycleTime,            
       @ConfirmCycleInsertTime,            
       @ConfirmTheRemovalOfPositionCycleTime,            
       @DryCycleTime,            
       @ClosingTime,            
       @ShutdownTimeBeforeRestartingProduction,            
       @UnlockTime,            
       @MoldOpeningTime,            
       @LockingForceAndUnloadingTime,            
       @ConstructionTimeOfLockingForce,            
       @MoldOpeningCycleTime,            
       @LockTime,            
       @NeutronMotionTime,            
       @MoldPauseTime,            
       @UntilTheCompletionTimeOfDemolding,     
       @TopOutTime,            
       @NozzleAdvanceCycleTime,            
       @ActualValueOfCleaningTime,            
       @PressureHoldingCycleTime,            
       @PressureHoldingCycleTimeSettingValue,            
       @MoldNumber,            
       @MachineNumber,            
       @AutomatedProductionOfFirstPiece,            
       @TotalProductionQuantity,            
       @ActualValueOfProductCounter,            
       @Temperature,            
       @InternalCavityPressureDuringPressureConversion,            
       @ReasonForShutdown,            
       GETDATE()            
        )          
 END             
 ELSE             
 BEGIN             
     UPDATE dbo.Prod_CollectionEngelData             
  SET             
       CollectionDate=@UpdateDate,            
       CollectionTime=@UpdateTime,            
       Status=@Status,            
       ShotCounter=@ShotCounter,            
       ProcessFormulaName=@ProcessFormulaName,            
       InjectionForce=@InjectionForce,            
       MoldProtectionTime=@MoldProtectionTime,            
       ActualProtectionTime=@ActualProtectionTime,            
       CycleTimeSetValue=@CycleTimeSetValue,            
       MaximumCycleTime=@MaximumCycleTime,            
       PreviousCycleTime=@PreviousCycleTime,            
       CoolingTime=@CoolingTime,            
       ActualBasketballTimeValue=@ActualBasketballTimeValue,            
       ActualValueOfMoldClosingTime=@ActualValueOfMoldClosingTime,            
       RotationPositionMoldRotationCycleTime=@RotationPositionMoldRotationCycleTime,            
       ConfirmCycleInsertTime=@ConfirmCycleInsertTime,            
       ConfirmTheRemovalOfPositionCycleTime=@ConfirmTheRemovalOfPositionCycleTime,            
       DryCycleTime=@DryCycleTime,            
       ClosingTime=@ClosingTime,            
       ShutdownTimeBeforeRestartingProduction=@ShutdownTimeBeforeRestartingProduction,            
       UnlockTime=@UnlockTime,            
       MoldOpeningTime=@MoldOpeningTime,            
       LockingForceAndUnloadingTime=@LockingForceAndUnloadingTime,            
       ConstructionTimeOfLockingForce=@ConstructionTimeOfLockingForce,            
       MoldOpeningCycleTime=@MoldOpeningCycleTime,            
       LockTime=@LockTime,            
       NeutronMotionTime=@NeutronMotionTime,            
       MoldPauseTime=@MoldPauseTime,            
       UntilTheCompletionTimeOfDemolding=@UntilTheCompletionTimeOfDemolding,            
       TopOutTime=@TopOutTime,            
       NozzleAdvanceCycleTime=@NozzleAdvanceCycleTime,            
       ActualValueOfCleaningTime=@ActualValueOfCleaningTime,            
       PressureHoldingCycleTime=@PressureHoldingCycleTime,            
       PressureHoldingCycleTimeSettingValue=@PressureHoldingCycleTimeSettingValue,            
       MoldNumber=@MoldNumber,            
       MachineNumber=@MachineNumber,            
       AutomatedProductionOfFirstPiece=@AutomatedProductionOfFirstPiece,            
       TotalProductionQuantity=@TotalProductionQuantity,            
       ActualValueOfProductCounter=@ActualValueOfProductCounter,            
       Temperature=@Temperature,            
       InternalCavityPressureDuringPressureConversion=@InternalCavityPressureDuringPressureConversion,            
       ReasonForShutdown=@ReasonForShutdown,            
       UpdateDateTime=@CollectionTime WHERE EquipmentCode=@EquiCode            
            
 END   
   
 --20250908 吴锋文修改，增加一个工单按组收集历史记录  
 if @Prodgroupid>0  
 begin  
   
INSERT dbo.Prod_CollectionEngelDataHistory         
 (            
     CollectionDate,            
     CollectionTime,            
     EquipmentType,            
     EquipmentCode,            
     Status,            
     ShotCounter,            
     PerformanceTest,            
     ProcessFormulaName,            
     InjectionForce,            
     MoldProtectionTime,            
     ActualProtectionTime,            
     CycleTimeSetValue,            
     MaximumCycleTime,            
     PreviousCycleTime,            
     CoolingTime,            
     ActualBasketballTimeValue,            
     ActualValueOfMoldClosingTime,            
     RotationPositionMoldRotationCycleTime,            
     ConfirmCycleInsertTime,            
     ConfirmTheRemovalOfPositionCycleTime,            
     DryCycleTime,            
     ClosingTime,            
     ShutdownTimeBeforeRestartingProduction,            
     UnlockTime,            
     MoldOpeningTime,            
     LockingForceAndUnloadingTime,            
     ConstructionTimeOfLockingForce,            
     MoldOpeningCycleTime,            
     LockTime,            
     NeutronMotionTime,            
     MoldPauseTime,            
     UntilTheCompletionTimeOfDemolding,            
     TopOutTime,            
     NozzleAdvanceCycleTime,            
     ActualValueOfCleaningTime,            
     PressureHoldingCycleTime,            
     PressureHoldingCycleTimeSettingValue,            
     MoldNumber,            
     MachineNumber,            
     AutomatedProductionOfFirstPiece,            
     TotalProductionQuantity,            
     ActualValueOfProductCounter,            
     Temperature,            
     InternalCavityPressureDuringPressureConversion,            
     ReasonForShutdown,          
     OrderNo,          
     MouldCode,          
     MoldCavity          
 )   select    
   @CollectionDate,            
     CONVERT(VARCHAR(100),GETDATE(),114),            
     @EquipmentType,            
     @EquiCode,            
     @Status,            
     @ShotCounter,            
     @PerformanceTest,            
     @ProcessFormulaName,            
     @InjectionForce,            
     @MoldProtectionTime,            
     @ActualProtectionTime,            
     @CycleTimeSetValue,            
     @MaximumCycleTime,            
     @PreviousCycleTime,            
     @CoolingTime,            
     @ActualBasketballTimeValue,            
     @ActualValueOfMoldClosingTime,            
     @RotationPositionMoldRotationCycleTime,            
     @ConfirmCycleInsertTime,            
     @ConfirmTheRemovalOfPositionCycleTime,            
     @DryCycleTime,            
     @ClosingTime,            
     @ShutdownTimeBeforeRestartingProduction,            
     @UnlockTime,            
     @MoldOpeningTime,            
     @LockingForceAndUnloadingTime,            
     @ConstructionTimeOfLockingForce,            
     @MoldOpeningCycleTime,            
     @LockTime,            
     @NeutronMotionTime,            
     @MoldPauseTime,            
     @UntilTheCompletionTimeOfDemolding,            
     @TopOutTime,            
     @NozzleAdvanceCycleTime,            
     @ActualValueOfCleaningTime,            
     @PressureHoldingCycleTime,            
     @PressureHoldingCycleTimeSettingValue,            
     @MoldNumber,            
     @MachineNumber,            
     @AutomatedProductionOfFirstPiece,            
     @TotalProductionQuantity,            
     @ActualValueOfProductCounter,            
     @Temperature,            
     @InternalCavityPressureDuringPressureConversion,            
     @ReasonForShutdown,          
     OrderNo,          
     @MouldCode,          
     @MoldCavity          
      from prod_order where ProdOrderGroupID=@Prodgroupid           
     
 end  
 else  
 begin  
 INSERT dbo.Prod_CollectionEngelDataHistory         
 (            
     CollectionDate,            
     CollectionTime,            
     EquipmentType,            
     EquipmentCode,            
     Status,            
     ShotCounter,            
     PerformanceTest,            
     ProcessFormulaName,            
     InjectionForce,            
     MoldProtectionTime,            
     ActualProtectionTime,            
     CycleTimeSetValue,            
     MaximumCycleTime,            
     PreviousCycleTime,            
     CoolingTime,            
     ActualBasketballTimeValue,            
     ActualValueOfMoldClosingTime,            
     RotationPositionMoldRotationCycleTime,            
     ConfirmCycleInsertTime,            
     ConfirmTheRemovalOfPositionCycleTime,            
     DryCycleTime,            
     ClosingTime,            
     ShutdownTimeBeforeRestartingProduction,            
     UnlockTime,            
     MoldOpeningTime,            
     LockingForceAndUnloadingTime,            
     ConstructionTimeOfLockingForce,            
     MoldOpeningCycleTime,            
     LockTime,            
     NeutronMotionTime,            
     MoldPauseTime,            
     UntilTheCompletionTimeOfDemolding,            
     TopOutTime,            
     NozzleAdvanceCycleTime,            
     ActualValueOfCleaningTime,            
     PressureHoldingCycleTime,            
     PressureHoldingCycleTimeSettingValue,            
     MoldNumber,            
     MachineNumber,            
     AutomatedProductionOfFirstPiece,            
     TotalProductionQuantity,            
     ActualValueOfProductCounter,            
     Temperature,            
     InternalCavityPressureDuringPressureConversion,            
     ReasonForShutdown,          
     OrderNo,          
     MouldCode,          
     MoldCavity          
 )            
 VALUES            
 (   @CollectionDate,            
     CONVERT(VARCHAR(100),GETDATE(),114),            
     @EquipmentType,            
     @EquiCode,            
     @Status,            
     @ShotCounter,            
     @PerformanceTest,            
     @ProcessFormulaName,            
     @InjectionForce,            
     @MoldProtectionTime,            
     @ActualProtectionTime,            
     @CycleTimeSetValue,            
     @MaximumCycleTime,            
     @PreviousCycleTime,            
     @CoolingTime,            
     @ActualBasketballTimeValue,            
     @ActualValueOfMoldClosingTime,            
     @RotationPositionMoldRotationCycleTime,            
     @ConfirmCycleInsertTime,            
     @ConfirmTheRemovalOfPositionCycleTime,            
     @DryCycleTime,            
     @ClosingTime,            
     @ShutdownTimeBeforeRestartingProduction,            
     @UnlockTime,            
     @MoldOpeningTime,            
     @LockingForceAndUnloadingTime,            
     @ConstructionTimeOfLockingForce,            
     @MoldOpeningCycleTime,            
     @LockTime,            
     @NeutronMotionTime,            
     @MoldPauseTime,            
     @UntilTheCompletionTimeOfDemolding,            
     @TopOutTime,            
     @NozzleAdvanceCycleTime,            
     @ActualValueOfCleaningTime,            
     @PressureHoldingCycleTime,            
     @PressureHoldingCycleTimeSettingValue,            
     @MoldNumber,            
     @MachineNumber,            
     @AutomatedProductionOfFirstPiece,            
     @TotalProductionQuantity,            
     @ActualValueOfProductCounter,            
     @Temperature,            
     @InternalCavityPressureDuringPressureConversion,            
     @ReasonForShutdown,          
     @OrderNo,          
     @MouldCode,          
     @MoldCavity          
     )            
 end            
  
  
    
   
END
GO

/***** 4. SQL Agent Jobs (missing on 179) *****/
-- 144 has / 179 lacks: delete history, status runtime, insert status current
-- 144 injection alert every 5min vs 179 every 30s: keep 179 job as-is
-- both have send injection email
USE [msdb];
GO

PRINT '--- JOB [定时删除采集历史表数据] ---';
IF EXISTS (SELECT 1 FROM dbo.sysjobs WHERE name = N'定时删除采集历史表数据')
BEGIN
    PRINT 'SKIP: job already exists';
END
ELSE
BEGIN
    DECLARE @jobId BINARY(16);
    EXEC dbo.sp_add_job
        @job_name = N'定时删除采集历史表数据',
        @enabled = 1,
        @description = N'OEE/equipment collection job migrated from 144',
        @job_id = @jobId OUTPUT;
    EXEC dbo.sp_add_jobstep
        @job_id = @jobId,
        @step_name = N'execute delete history',
        @subsystem = N'TSQL',
        @database_name = N'PROD_TEST_MES',
        @command = N'Excel uspJobDeleteEquipmentCollectionHistory';
    EXEC dbo.sp_add_jobschedule
        @job_id = @jobId,
        @name = N'execute delete history',
        @freq_type = 4,
        @freq_interval = 1,
        @freq_subday_type = 4,
        @freq_subday_interval = 5,
        @active_start_time = 0;
    EXEC dbo.sp_add_jobserver
        @job_id = @jobId,
        @server_name = N'(local)';
    PRINT 'CREATED: 定时删除采集历史表数据';
END
GO

PRINT '--- JOB [定时执行设备状态变更时间] ---';
IF EXISTS (SELECT 1 FROM dbo.sysjobs WHERE name = N'定时执行设备状态变更时间')
BEGIN
    PRINT 'SKIP: job already exists';
END
ELSE
BEGIN
    DECLARE @jobId BINARY(16);
    EXEC dbo.sp_add_job
        @job_name = N'定时执行设备状态变更时间',
        @enabled = 1,
        @description = N'OEE/equipment collection job migrated from 144',
        @job_id = @jobId OUTPUT;
    EXEC dbo.sp_add_jobstep
        @job_id = @jobId,
        @step_name = N'execute',
        @subsystem = N'TSQL',
        @database_name = N'PROD_TEST_MES',
        @command = N'Exec uspAutoCollectionStatusRuntimeJob';
    EXEC dbo.sp_add_jobschedule
        @job_id = @jobId,
        @name = N'execute',
        @freq_type = 4,
        @freq_interval = 1,
        @freq_subday_type = 4,
        @freq_subday_interval = 2,
        @active_start_time = 0;
    EXEC dbo.sp_add_jobserver
        @job_id = @jobId,
        @server_name = N'(local)';
    PRINT 'CREATED: 定时执行设备状态变更时间';
END
GO

PRINT '--- JOB [自动插入设备采集当前状态表数据] ---';
IF EXISTS (SELECT 1 FROM dbo.sysjobs WHERE name = N'自动插入设备采集当前状态表数据')
BEGIN
    PRINT 'SKIP: job already exists';
END
ELSE
BEGIN
    DECLARE @jobId BINARY(16);
    EXEC dbo.sp_add_job
        @job_name = N'自动插入设备采集当前状态表数据',
        @enabled = 1,
        @description = N'OEE/equipment collection job migrated from 144',
        @job_id = @jobId OUTPUT;
    EXEC dbo.sp_add_jobstep
        @job_id = @jobId,
        @step_name = N'batch insert missing equipment current',
        @subsystem = N'TSQL',
        @database_name = N'PROD_TEST_MES',
        @command = N'Exec uspAutoInsertEquipmentStatusCollectionCurrentJob';
    EXEC dbo.sp_add_jobschedule
        @job_id = @jobId,
        @name = N'batch insert missing equipment current',
        @freq_type = 4,
        @freq_interval = 1,
        @freq_subday_type = 4,
        @freq_subday_interval = 3,
        @active_start_time = 1010;
    EXEC dbo.sp_add_jobserver
        @job_id = @jobId,
        @server_name = N'(local)';
    PRINT 'CREATED: 自动插入设备采集当前状态表数据';
END
GO

/***** 5. Verify *****/
USE [PROD_TEST_MES];
GO
SELECT OBJECT_NAME(object_id) AS ObjName, LEN(CAST(OBJECT_DEFINITION(object_id) AS NVARCHAR(MAX))) AS DefLen, modify_date
FROM sys.objects
WHERE OBJECT_NAME(object_id) IN (
  'uspEquipmentOEEReport','uspEquipmentOEEReport_20251118','uspGetEquipmentShiftStatusTimeReport',
  'uspEquimentCollection','uspToalEquRunTime','uspEquipmentStatusEdit',
  'vwEquipmentOEE','vwEquipmentOutQty','vwCollectionEngelDataHistory','vWGetEquipmentShiftStatusTime'
) ORDER BY type, name;
GO
SELECT COL_LENGTH('dbo.Prod_EquimentOrderPord','ProdNum') AS ProdNum_Exists;
GO
SELECT name, enabled FROM msdb.dbo.sysjobs ORDER BY name;
GO
PRINT 'MIGRATION SCRIPT READY';
GO
