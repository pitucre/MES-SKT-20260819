


  
  
  
  
  
  
/*****************************          
项目名称：          
功能描叙：获取设备OEE视图源数据          
创 建 人：xi.zhu          
创建时间：2025-04-08          
更新信息:           
测试调试：          
*/  
CREATE VIEW [dbo].[vwEquipmentOEE]  
AS  
SELECT CONVERT(VARCHAR(10),ISNULL(PES.WorkDate,''),120) WorkDate, TbEqu.ExtFieldValue,    
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
               '非生产中'   
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
       ISNULL(BES.StatusDesc, '未选择') CurrentStatusdManger  ,ISNULL(EOQ.tQty,0) tQty  
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
 LEFT JOIN vwEquipmentOutQty EOQ WITH(NOLOCK)  
  ON EOQ.EquipmentCode=TbEqu.ExtFieldValue AND EOQ.WorkDate=pes.WorkDate   