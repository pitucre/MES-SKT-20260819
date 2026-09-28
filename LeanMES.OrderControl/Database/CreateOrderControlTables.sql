-- ============================================================
-- LeanMES 注塑机订单数量控制系统 - 数据库脚本
-- 创建时间: 2026-09-17
-- 说明: 创建订单控制相关的表和存储过程
-- ============================================================

USE [PROD_TEST_MES]
GO

-- ============================================================
-- 1. 创建订单控制表
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='OrderControl' AND xtype='U')
BEGIN
    CREATE TABLE [dbo].[OrderControl](
        [ID] [int] IDENTITY(1,1) NOT NULL,
        [MachineCode] [nvarchar](50) NOT NULL,           -- 机台编号 (如: 212352)
        [MachineType] [nvarchar](20) NOT NULL,           -- 设备类型: Engel/Haitian/Demag
        [OrderNo] [nvarchar](50) NOT NULL,               -- 工单号
        [PartNumber] [nvarchar](100) NULL,               -- 产品编号
        [PartName] [nvarchar](200) NULL,                 -- 产品名称
        [OrderQuantity] [int] NOT NULL,                  -- 订单数量
        [CompletedQuantity] [int] NULL DEFAULT 0,        -- 已完成数量
        [GoodQuantity] [int] NULL DEFAULT 0,             -- 良品数量
        [RejectQuantity] [int] NULL DEFAULT 0,           -- 不良品数量
        [Status] [int] NOT NULL DEFAULT 0,               -- 状态: 0=待生产, 1=生产中, 2=已完成, 3=已暂停, 4=已取消
        [ControlEnabled] [bit] NOT NULL DEFAULT 1,       -- 是否启用自动控制
        [TargetReached] [bit] NOT NULL DEFAULT 0,        -- 是否达到目标数量
        [StopCommandSent] [bit] NOT NULL DEFAULT 0,      -- 是否已发送停止命令
        [StartTime] [datetime] NULL,                     -- 开始生产时间
        [EndTime] [datetime] NULL,                       -- 结束生产时间
        [CreatedDate] [datetime] NOT NULL DEFAULT GETDATE(),
        [ModifiedDate] [datetime] NOT NULL DEFAULT GETDATE(),
        [Remark] [nvarchar](500) NULL,                   -- 备注
        CONSTRAINT [PK_OrderControl] PRIMARY KEY CLUSTERED 
        (
            [ID] ASC
        )
    )
    
    -- 添加注释
    EXEC sp_addextendedproperty 'MS_Description', '订单控制表', 'SCHEMA', 'dbo', 'TABLE', 'OrderControl'
    EXEC sp_addextendedproperty 'MS_Description', '机台编号', 'SCHEMA', 'dbo', 'TABLE', 'OrderControl', 'COLUMN', 'MachineCode'
    EXEC sp_addextendedproperty 'MS_Description', '设备类型: Engel/Haitian/Demag', 'SCHEMA', 'dbo', 'TABLE', 'OrderControl', 'COLUMN', 'MachineType'
    EXEC sp_addextendedproperty 'MS_Description', '状态: 0=待生产, 1=生产中, 2=已完成, 3=已暂停, 4=已取消', 'SCHEMA', 'dbo', 'TABLE', 'OrderControl', 'COLUMN', 'Status'
    
    -- 创建索引
    CREATE NONCLUSTERED INDEX [IX_OrderControl_MachineCode] ON [dbo].[OrderControl]
    (
        [MachineCode] ASC
    )
    
    CREATE NONCLUSTERED INDEX [IX_OrderControl_Status] ON [dbo].[OrderControl]
    (
        [Status] ASC
    )
    
    CREATE NONCLUSTERED INDEX [IX_OrderControl_OrderNo] ON [dbo].[OrderControl]
    (
        [OrderNo] ASC
    )
    
    PRINT 'OrderControl 表创建成功'
END
ELSE
BEGIN
    PRINT 'OrderControl 表已存在'
END
GO

-- ============================================================
-- 2. 创建订单控制日志表
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='OrderControlLog' AND xtype='U')
BEGIN
    CREATE TABLE [dbo].[OrderControlLog](
        [ID] [int] IDENTITY(1,1) NOT NULL,
        [OrderControlID] [int] NOT NULL,                 -- 关联订单ID
        [MachineCode] [nvarchar](50) NOT NULL,           -- 机台编号
        [LogType] [nvarchar](20) NOT NULL,               -- 日志类型: INFO/WARNING/ERROR/COMMAND
        [Message] [nvarchar](1000) NOT NULL,             -- 日志内容
        [CurrentQuantity] [int] NULL,                    -- 当时的生产数量
        [TargetQuantity] [int] NULL,                     -- 目标数量
        [CommandSent] [nvarchar](500) NULL,              -- 发送的命令内容
        [CommandResult] [nvarchar](500) NULL,            -- 命令执行结果
        [CreatedDate] [datetime] NOT NULL DEFAULT GETDATE(),
        CONSTRAINT [PK_OrderControlLog] PRIMARY KEY CLUSTERED 
        (
            [ID] ASC
        )
    )
    
    -- 添加注释
    EXEC sp_addextendedproperty 'MS_Description', '订单控制日志表', 'SCHEMA', 'dbo', 'TABLE', 'OrderControlLog'
    
    -- 创建索引
    CREATE NONCLUSTERED INDEX [IX_OrderControlLog_OrderControlID] ON [dbo].[OrderControlLog]
    (
        [OrderControlID] ASC
    )
    
    CREATE NONCLUSTERED INDEX [IX_OrderControlLog_MachineCode] ON [dbo].[OrderControlLog]
    (
        [MachineCode] ASC
    )
    
    CREATE NONCLUSTERED INDEX [IX_OrderControlLog_CreatedDate] ON [dbo].[OrderControlLog]
    (
        [CreatedDate] DESC
    )
    
    PRINT 'OrderControlLog 表创建成功'
END
ELSE
BEGIN
    PRINT 'OrderControlLog 表已存在'
END
GO

-- ============================================================
-- 3. 创建机台配置表
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='MachineConfig' AND xtype='U')
BEGIN
    CREATE TABLE [dbo].[MachineConfig](
        [ID] [int] IDENTITY(1,1) NOT NULL,
        [MachineCode] [nvarchar](50) NOT NULL,           -- 机台编号
        [MachineType] [nvarchar](20) NOT NULL,           -- 设备类型: Engel/Haitian/Demag
        [MachineName] [nvarchar](100) NULL,              -- 机台名称
        [EquipmentIP] [nvarchar](50) NULL,               -- 设备IP地址
        [EquipmentPort] [nvarchar](10) NULL,             -- 设备端口
        [Euromap63Path] [nvarchar](500) NULL,            -- EUROMAP 63路径 (恩格尔专用)
        [ControlEnabled] [bit] NOT NULL DEFAULT 1,       -- 是否启用控制
        [CollectEnabled] [bit] NOT NULL DEFAULT 1,       -- 是否启用采集
        [CollectInterval] [int] NOT NULL DEFAULT 5,      -- 采集间隔(秒)
        [CreatedDate] [datetime] NOT NULL DEFAULT GETDATE(),
        [ModifiedDate] [datetime] NOT NULL DEFAULT GETDATE(),
        CONSTRAINT [PK_MachineConfig] PRIMARY KEY CLUSTERED 
        (
            [ID] ASC
        )
    )
    
    -- 添加注释
    EXEC sp_addextendedproperty 'MS_Description', '机台配置表', 'SCHEMA', 'dbo', 'TABLE', 'MachineConfig'
    
    -- 创建唯一索引
    CREATE UNIQUE NONCLUSTERED INDEX [IX_MachineConfig_MachineCode] ON [dbo].[MachineConfig]
    (
        [MachineCode] ASC
    )
    
    PRINT 'MachineConfig 表创建成功'
END
ELSE
BEGIN
    PRINT 'MachineConfig 表已存在'
END
GO

-- ============================================================
-- 4. 插入示例机台配置数据
-- ============================================================
-- 恩格尔机台
IF NOT EXISTS (SELECT * FROM MachineConfig WHERE MachineCode = '212352')
BEGIN
    INSERT INTO MachineConfig (MachineCode, MachineType, MachineName, Euromap63Path, ControlEnabled, CollectEnabled)
    VALUES ('212352', 'Engel', '恩格尔注塑机-212352', 'C:\Engel\Euromap63\System\Access\MACHINES\212352', 1, 1)
END

IF NOT EXISTS (SELECT * FROM MachineConfig WHERE MachineCode = '220341')
BEGIN
    INSERT INTO MachineConfig (MachineCode, MachineType, MachineName, Euromap63Path, ControlEnabled, CollectEnabled)
    VALUES ('220341', 'Engel', '恩格尔注塑机-220341', 'C:\Engel\Euromap63\System\Access\MACHINES\220341', 1, 1)
END

IF NOT EXISTS (SELECT * FROM MachineConfig WHERE MachineCode = '223194')
BEGIN
    INSERT INTO MachineConfig (MachineCode, MachineType, MachineName, Euromap63Path, ControlEnabled, CollectEnabled)
    VALUES ('223194', 'Engel', '恩格尔注塑机-223194', 'C:\Engel\Euromap63\System\Access\MACHINES\223194', 1, 1)
END

IF NOT EXISTS (SELECT * FROM MachineConfig WHERE MachineCode = '225086')
BEGIN
    INSERT INTO MachineConfig (MachineCode, MachineType, MachineName, Euromap63Path, ControlEnabled, CollectEnabled)
    VALUES ('225086', 'Engel', '恩格尔注塑机-225086', 'C:\Engel\Euromap63\System\Access\MACHINES\225086', 1, 1)
END

-- 海天机台
IF NOT EXISTS (SELECT * FROM MachineConfig WHERE MachineCode = 'HT001')
BEGIN
    INSERT INTO MachineConfig (MachineCode, MachineType, MachineName, EquipmentIP, EquipmentPort, ControlEnabled, CollectEnabled)
    VALUES ('HT001', 'Haitian', '海天注塑机-001', '172.16.215.101', '4842', 1, 1)
END

-- 德马格机台
IF NOT EXISTS (SELECT * FROM MachineConfig WHERE MachineCode = 'DMG001')
BEGIN
    INSERT INTO MachineConfig (MachineCode, MachineType, MachineName, EquipmentIP, EquipmentPort, ControlEnabled, CollectEnabled)
    VALUES ('DMG001', 'Demag', '德马格注塑机-001', '172.16.215.102', '4842', 1, 1)
END

PRINT '示例机台配置数据插入完成'
GO

-- ============================================================
-- 5. 创建存储过程: 获取活跃订单列表
-- ============================================================
IF EXISTS (SELECT * FROM sysobjects WHERE name='usp_OrderControl_GetActiveOrders' AND xtype='P')
    DROP PROCEDURE [dbo].[usp_OrderControl_GetActiveOrders]
GO

CREATE PROCEDURE [dbo].[usp_OrderControl_GetActiveOrders]
AS
BEGIN
    SET NOCOUNT ON;
    
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
        mc.EquipmentIP,
        mc.EquipmentPort,
        mc.Euromap63Path
    FROM OrderControl oc
    LEFT JOIN MachineConfig mc ON oc.MachineCode = mc.MachineCode
    WHERE oc.Status IN (0, 1)  -- 待生产或生产中
      AND oc.ControlEnabled = 1
      AND oc.TargetReached = 0
    ORDER BY oc.CreatedDate DESC
END
GO

-- ============================================================
-- 6. 创建存储过程: 更新订单完成数量
-- ============================================================
IF EXISTS (SELECT * FROM sysobjects WHERE name='usp_OrderControl_UpdateCompletedQuantity' AND xtype='P')
    DROP PROCEDURE [dbo].[usp_OrderControl_UpdateCompletedQuantity]
GO

CREATE PROCEDURE [dbo].[usp_OrderControl_UpdateCompletedQuantity]
    @OrderControlID INT,
    @CompletedQuantity INT,
    @GoodQuantity INT = 0,
    @RejectQuantity INT = 0
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE OrderControl
    SET 
        CompletedQuantity = @CompletedQuantity,
        GoodQuantity = @GoodQuantity,
        RejectQuantity = @RejectQuantity,
        ModifiedDate = GETDATE()
    WHERE ID = @OrderControlID
    
    -- 检查是否达到目标数量
    DECLARE @OrderQuantity INT
    SELECT @OrderQuantity = OrderQuantity
    FROM OrderControl
    WHERE ID = @OrderControlID
    
    IF @CompletedQuantity >= @OrderQuantity
    BEGIN
        UPDATE OrderControl
        SET 
            TargetReached = 1,
            Status = 2,  -- 已完成
            EndTime = GETDATE(),
            ModifiedDate = GETDATE()
        WHERE ID = @OrderControlID
    END
END
GO

-- ============================================================
-- 7. 创建存储过程: 记录控制日志
-- ============================================================
IF EXISTS (SELECT * FROM sysobjects WHERE name='usp_OrderControl_AddLog' AND xtype='P')
    DROP PROCEDURE [dbo].[usp_OrderControl_AddLog]
GO

CREATE PROCEDURE [dbo].[usp_OrderControl_AddLog]
    @OrderControlID INT,
    @MachineCode NVARCHAR(50),
    @LogType NVARCHAR(20),
    @Message NVARCHAR(1000),
    @CurrentQuantity INT = NULL,
    @TargetQuantity INT = NULL,
    @CommandSent NVARCHAR(500) = NULL,
    @CommandResult NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO OrderControlLog 
    (OrderControlID, MachineCode, LogType, Message, CurrentQuantity, TargetQuantity, CommandSent, CommandResult)
    VALUES 
    (@OrderControlID, @MachineCode, @LogType, @Message, @CurrentQuantity, @TargetQuantity, @CommandSent, @CommandResult)
END
GO

PRINT '============================================================'
PRINT '数据库脚本执行完成!'
PRINT '============================================================'
GO
