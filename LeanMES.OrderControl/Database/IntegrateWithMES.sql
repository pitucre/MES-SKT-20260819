-- ============================================================
-- LeanMES 注塑机订单数量控制系统 - 与MES系统集成脚本
-- 创建时间: 2026-09-17
-- 说明: 添加从MES系统同步工单的存储过程
-- ============================================================

USE [PROD_TEST_MES]
GO

-- ============================================================
-- 1. 创建从MES同步工单的存储过程
-- ============================================================
IF EXISTS (SELECT * FROM sysobjects WHERE name='usp_OrderControl_SyncFromMES' AND xtype='P')
    DROP PROCEDURE [dbo].[usp_OrderControl_SyncFromMES]
GO

CREATE PROCEDURE [dbo].[usp_OrderControl_SyncFromMES]
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @SyncCount INT = 0
    DECLARE @OrderNo NVARCHAR(50)
    DECLARE @MachineNumber NVARCHAR(50)
    DECLARE @ItemCode NVARCHAR(100)
    DECLARE @QtyToBuild INT
    DECLARE @MachineType NVARCHAR(20)
    
    -- 创建临时表存储MES工单
    CREATE TABLE #MESOrders (
        OrderNo NVARCHAR(50),
        MachineNumber NVARCHAR(50),
        ItemCode NVARCHAR(100),
        QtyToBuild INT,
        MachineType NVARCHAR(20)
    )
    
    -- 从MES系统获取活跃工单
    INSERT INTO #MESOrders (OrderNo, MachineNumber, ItemCode, QtyToBuild, MachineType)
    SELECT 
        o.OrderNO,
        o.MachineNumber,
        o.ItemCode,
        o.Qty_to_Build,
        CASE 
            WHEN e.Brand LIKE '%Engel%' OR e.Brand LIKE '%恩格尔%' THEN 'Engel'
            WHEN e.Brand LIKE '%Haitian%' OR e.Brand LIKE '%海天%' THEN 'Haitian'
            WHEN e.Brand LIKE '%Demag%' OR e.Brand LIKE '%德马格%' THEN 'Demag'
            WHEN e.EquipmentIP IS NOT NULL AND e.EquipmentIP != '' THEN 'Haitian'
            ELSE 'Unknown'
        END AS MachineType
    FROM ERP_Prod_Order o
    INNER JOIN Basal_Equipment e ON o.MachineNumber = e.EquipmentCode
    WHERE o.Status IN (1, 2)
      AND o.Qty_to_Build > 0
      AND o.MachineNumber IS NOT NULL
      AND o.MachineNumber != ''
      AND (e.Brand LIKE '%Engel%' 
           OR e.Brand LIKE '%Haitian%' 
           OR e.Brand LIKE '%海天%'
           OR e.Brand LIKE '%Demag%'
           OR e.Brand LIKE '%德马格%'
           OR (e.EquipmentIP IS NOT NULL AND e.EquipmentIP != ''))
    
    -- 遍历并同步
    DECLARE order_cursor CURSOR FOR
    SELECT OrderNo, MachineNumber, ItemCode, QtyToBuild, MachineType
    FROM #MESOrders
    
    OPEN order_cursor
    FETCH NEXT FROM order_cursor INTO @OrderNo, @MachineNumber, @ItemCode, @QtyToBuild, @MachineType
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- 检查是否已存在
        IF NOT EXISTS (SELECT 1 FROM OrderControl WHERE OrderNo = @OrderNo AND MachineCode = @MachineNumber)
        BEGIN
            -- 插入新订单
            INSERT INTO OrderControl 
            (MachineCode, MachineType, OrderNo, PartNumber, OrderQuantity, Status, ControlEnabled, CreatedDate, ModifiedDate)
            VALUES 
            (@MachineNumber, @MachineType, @OrderNo, @ItemCode, @QtyToBuild, 0, 1, GETDATE(), GETDATE())
            
            SET @SyncCount = @SyncCount + 1
        END
        
        FETCH NEXT FROM order_cursor INTO @OrderNo, @MachineNumber, @ItemCode, @QtyToBuild, @MachineType
    END
    
    CLOSE order_cursor
    DEALLOCATE order_cursor
    
    DROP TABLE #MESOrders
    
    -- 返回同步数量
    SELECT @SyncCount AS SyncCount
END
GO

-- ============================================================
-- 2. 创建获取机台当前工单的存储过程
-- ============================================================
IF EXISTS (SELECT * FROM sysobjects WHERE name='usp_OrderControl_GetMachineCurrentOrder' AND xtype='P')
    DROP PROCEDURE [dbo].[usp_OrderControl_GetMachineCurrentOrder]
GO

CREATE PROCEDURE [dbo].[usp_OrderControl_GetMachineCurrentOrder]
    @MachineCode NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT TOP 1
        o.OrderNO AS OrderNo,
        o.ItemCode AS PartNumber,
        o.Qty_to_Build AS OrderQuantity,
        o.MachineNumber,
        o.Status AS OrderStatus,
        o.Planned_Start_Time,
        o.Planned_Completed_Date,
        e.EquipmentCode,
        e.EquipmentName,
        e.Brand AS MachineBrand,
        e.EquipmentIP,
        e.EquipmentPort,
        CASE 
            WHEN e.Brand LIKE '%Engel%' OR e.Brand LIKE '%恩格尔%' THEN 'Engel'
            WHEN e.Brand LIKE '%Haitian%' OR e.Brand LIKE '%海天%' THEN 'Haitian'
            WHEN e.Brand LIKE '%Demag%' OR e.Brand LIKE '%德马格%' THEN 'Demag'
            ELSE 'Unknown'
        END AS MachineType
    FROM ERP_Prod_Order o
    INNER JOIN Basal_Equipment e ON o.MachineNumber = e.EquipmentCode
    WHERE o.MachineNumber = @MachineCode
      AND o.Status IN (1, 2)
      AND o.Qty_to_Build > 0
    ORDER BY o.Planned_Start_Time DESC
END
GO

-- ============================================================
-- 3. 创建获取所有注塑机的存储过程
-- ============================================================
IF EXISTS (SELECT * FROM sysobjects WHERE name='usp_OrderControl_GetAllInjectionMachines' AND xtype='P')
    DROP PROCEDURE [dbo].[usp_OrderControl_GetAllInjectionMachines]
GO

CREATE PROCEDURE [dbo].[usp_OrderControl_GetAllInjectionMachines]
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        e.EquipmentCode AS MachineCode,
        CASE 
            WHEN e.Brand LIKE '%Engel%' OR e.Brand LIKE '%恩格尔%' THEN 'Engel'
            WHEN e.Brand LIKE '%Haitian%' OR e.Brand LIKE '%海天%' THEN 'Haitian'
            WHEN e.Brand LIKE '%Demag%' OR e.Brand LIKE '%德马格%' THEN 'Demag'
            ELSE 'Other'
        END AS MachineType,
        e.EquipmentName AS MachineName,
        e.Status,
        e.Brand,
        e.EquipmentIP,
        e.EquipmentPort
    FROM Basal_Equipment e
    WHERE e.Brand LIKE '%Engel%'
       OR e.Brand LIKE '%恩格尔%'
       OR e.Brand LIKE '%Haitian%'
       OR e.Brand LIKE '%海天%'
       OR e.Brand LIKE '%Demag%'
       OR e.Brand LIKE '%德马格%'
       OR (e.EquipmentIP IS NOT NULL AND e.EquipmentIP != '')
    ORDER BY e.EquipmentCode
END
GO

-- ============================================================
-- 4. 创建订单控制看板视图
-- ============================================================
IF EXISTS (SELECT * FROM sysobjects WHERE name='vw_OrderControlDashboard' AND xtype='V')
    DROP VIEW [dbo].[vw_OrderControlDashboard]
GO

CREATE VIEW [dbo].[vw_OrderControlDashboard]
AS
SELECT 
    oc.ID,
    oc.MachineCode,
    oc.MachineType,
    oc.OrderNo,
    oc.PartNumber,
    oc.PartName,
    oc.OrderQuantity,
    oc.CompletedQuantity,
    oc.GoodQuantity,
    oc.RejectQuantity,
    oc.Status,
    oc.ControlEnabled,
    oc.TargetReached,
    oc.StopCommandSent,
    oc.StartTime,
    oc.EndTime,
    oc.CreatedDate,
    oc.ModifiedDate,
    -- 计算字段
    CASE 
        WHEN oc.OrderQuantity > 0 
        THEN CAST(CAST(oc.CompletedQuantity AS FLOAT) / oc.OrderQuantity * 100 AS DECIMAL(5,1))
        ELSE 0 
    END AS CompletionPercentage,
    CASE oc.Status
        WHEN 0 THEN '待生产'
        WHEN 1 THEN '生产中'
        WHEN 2 THEN '已完成'
        WHEN 3 THEN '已暂停'
        WHEN 4 THEN '已取消'
        ELSE '未知'
    END AS StatusDescription,
    -- MES设备信息
    e.EquipmentName,
    e.Brand AS MachineBrand,
    e.EquipmentIP,
    e.EquipmentPort
FROM OrderControl oc
LEFT JOIN Basal_Equipment e ON oc.MachineCode = e.EquipmentCode
GO

PRINT '============================================================'
PRINT 'MES集成脚本执行完成!'
PRINT '============================================================'
GO
