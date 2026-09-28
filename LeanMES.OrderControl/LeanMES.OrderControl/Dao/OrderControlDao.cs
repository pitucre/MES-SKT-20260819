using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LeanMES.OrderControl.Model;
using Dapper;

namespace LeanMES.OrderControl.Dao
{
    /// <summary>
    /// 订单控制数据访问类 - 与MES系统集成
    /// </summary>
    public class OrderControlDao
    {
        private readonly string _connectionString;

        public OrderControlDao()
        {
            _connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MESConnString"]?.ConnectionString
                ?? System.Configuration.ConfigurationManager.AppSettings["MESConnString"];
        }

        public OrderControlDao(string connectionString)
        {
            _connectionString = connectionString;
        }

        /// <summary>
        /// 从MES系统获取需要控制的工单列表
        /// 关联ERP_Prod_Order(工单表)和Basal_Equipment(设备表)
        /// </summary>
        public List<OrderControlInfo> GetActiveOrdersFromMES()
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                // 查询条件：
                // 1. 工单状态为已释放(Releaseable=1)或生产中
                // 2. 设备类型为注塑机
                // 3. 工单有分配机台号
                string sql = @"
                    SELECT 
                        o.OrderNO AS OrderNo,
                        o.ItemCode AS PartNumber,
                        o.Qty_to_Build AS OrderQuantity,
                        o.MachineNumber,
                        o.Status AS OrderStatus,
                        o.Planned_Start_Time,
                        o.Planned_Completed_Date,
                        e.EquipmentCode,
                        e.EquipmentName,
                        e.EquipmentTypeCode,
                        e.Brand AS MachineBrand,
                        e.Status AS EquipmentStatus,
                        -- 根据设备类型确定设备类型
                        CASE 
                            WHEN e.Brand LIKE '%Engel%' OR e.Brand LIKE '%恩格尔%' THEN 'Engel'
                            WHEN e.Brand LIKE '%Haitian%' OR e.Brand LIKE '%海天%' THEN 'Haitian'
                            WHEN e.Brand LIKE '%Demag%' OR e.Brand LIKE '%德马格%' THEN 'Demag'
                            WHEN e.EquipmentTypeCode LIKE '%Injection%' THEN 'Haitian'
                            ELSE 'Unknown'
                        END AS MachineType
                    FROM ERP_Prod_Order o
                    INNER JOIN Basal_Equipment e ON o.MachineNumber = e.EquipmentCode
                    WHERE o.Status IN (1, 2)  -- 1=Releasable, 2=Hold
                      AND o.Qty_to_Build > 0
                      AND o.MachineNumber IS NOT NULL
                      AND o.MachineNumber != ''
                      AND (e.Brand LIKE '%Engel%' 
                           OR e.Brand LIKE '%Haitian%' 
                           OR e.Brand LIKE '%海天%'
                           OR e.Brand LIKE '%Demag%'
                           OR e.Brand LIKE '%德马格%'
                           OR e.EquipmentTypeCode LIKE '%Injection%')
                    ORDER BY o.Planned_Start_Time DESC";

                var result = conn.Query<OrderControlInfo>(sql).ToList();
                return result;
            }
        }

        /// <summary>
        /// 获取指定机台的当前工单
        /// </summary>
        public OrderControlInfo GetActiveOrderByMachine(string machineCode)
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = @"
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
                        e.EquipmentTypeCode,
                        e.Brand AS MachineBrand,
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
                    ORDER BY o.Planned_Start_Time DESC";

                return conn.QueryFirstOrDefault<OrderControlInfo>(sql, new { MachineCode = machineCode });
            }
        }

        /// <summary>
        /// 获取订单控制列表 (本地OrderControl表)
        /// </summary>
        public List<OrderControlInfo> GetActiveOrderList()
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = @"
                    SELECT 
                        oc.*,
                        mc.EquipmentIP,
                        mc.EquipmentPort,
                        mc.Euromap63Path
                    FROM OrderControl oc
                    LEFT JOIN MachineConfig mc ON oc.MachineCode = mc.MachineCode
                    WHERE oc.Status IN (0, 1)
                      AND oc.ControlEnabled = 1
                      AND oc.TargetReached = 0
                    ORDER BY oc.CreatedDate DESC";

                return conn.Query<OrderControlInfo>(sql).ToList();
            }
        }

        /// <summary>
        /// 根据ID获取订单信息
        /// </summary>
        public OrderControlInfo GetByID(int id)
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = @"
                    SELECT 
                        oc.*,
                        mc.EquipmentIP,
                        mc.EquipmentPort,
                        mc.Euromap63Path
                    FROM OrderControl oc
                    LEFT JOIN MachineConfig mc ON oc.MachineCode = mc.MachineCode
                    WHERE oc.ID = @ID";

                return conn.QueryFirstOrDefault<OrderControlInfo>(sql, new { ID = id });
            }
        }

        /// <summary>
        /// 更新完成数量
        /// </summary>
        public bool UpdateCompletedQuantity(int orderControlID, int completedQuantity, int goodQuantity = 0, int rejectQuantity = 0)
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = @"
                    UPDATE OrderControl
                    SET 
                        CompletedQuantity = @CompletedQuantity,
                        GoodQuantity = @GoodQuantity,
                        RejectQuantity = @RejectQuantity,
                        ModifiedDate = GETDATE()
                    WHERE ID = @ID";

                int result = conn.Execute(sql, new
                {
                    ID = orderControlID,
                    CompletedQuantity = completedQuantity,
                    GoodQuantity = goodQuantity,
                    RejectQuantity = rejectQuantity
                });

                return result > 0;
            }
        }

        /// <summary>
        /// 标记订单已完成
        /// </summary>
        public bool MarkAsCompleted(int orderControlID)
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = @"
                    UPDATE OrderControl
                    SET 
                        Status = 2,
                        TargetReached = 1,
                        EndTime = GETDATE(),
                        ModifiedDate = GETDATE()
                    WHERE ID = @ID";

                int result = conn.Execute(sql, new { ID = orderControlID });
                return result > 0;
            }
        }

        /// <summary>
        /// 标记已发送停止命令
        /// </summary>
        public bool MarkStopCommandSent(int orderControlID)
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = @"
                    UPDATE OrderControl
                    SET 
                        StopCommandSent = 1,
                        ModifiedDate = GETDATE()
                    WHERE ID = @ID";

                int result = conn.Execute(sql, new { ID = orderControlID });
                return result > 0;
            }
        }

        /// <summary>
        /// 更新订单状态
        /// </summary>
        public bool UpdateStatus(int orderControlID, int status)
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = @"
                    UPDATE OrderControl
                    SET 
                        Status = @Status,
                        ModifiedDate = GETDATE()
                    WHERE ID = @ID";

                int result = conn.Execute(sql, new { ID = orderControlID, Status = status });
                return result > 0;
            }
        }

        /// <summary>
        /// 创建新订单
        /// </summary>
        public int CreateOrder(OrderControlInfo order)
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = @"
                    INSERT INTO OrderControl 
                    (MachineCode, MachineType, OrderNo, PartNumber, PartName, OrderQuantity, Status, ControlEnabled, Remark)
                    VALUES 
                    (@MachineCode, @MachineType, @OrderNo, @PartNumber, @PartName, @OrderQuantity, @Status, @ControlEnabled, @Remark);
                    SELECT CAST(SCOPE_IDENTITY() AS INT)";

                return conn.ExecuteScalar<int>(sql, order);
            }
        }

        /// <summary>
        /// 从MES同步工单到OrderControl表
        /// </summary>
        public int SyncOrdersFromMES()
        {
            int syncCount = 0;

            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                // 获取MES中的活跃工单
                string getOrdersSql = @"
                    SELECT 
                        o.OrderNO,
                        o.ItemCode,
                        o.Qty_to_Build,
                        o.MachineNumber,
                        e.Brand,
                        CASE 
                            WHEN e.Brand LIKE '%Engel%' OR e.Brand LIKE '%恩格尔%' THEN 'Engel'
                            WHEN e.Brand LIKE '%Haitian%' OR e.Brand LIKE '%海天%' THEN 'Haitian'
                            WHEN e.Brand LIKE '%Demag%' OR e.Brand LIKE '%德马格%' THEN 'Demag'
                            ELSE 'Unknown'
                        END AS MachineType
                    FROM ERP_Prod_Order o
                    INNER JOIN Basal_Equipment e ON o.MachineNumber = e.EquipmentCode
                    WHERE o.Status IN (1, 2)
                      AND o.Qty_to_Build > 0
                      AND o.MachineNumber IS NOT NULL";

                var mesOrders = conn.Query(getOrdersSql).ToList();

                foreach (var order in mesOrders)
                {
                    string orderNo = order.OrderNO;
                    string machineCode = order.MachineNumber;

                    // 检查是否已存在
                    string checkSql = @"
                        SELECT COUNT(1) 
                        FROM OrderControl 
                        WHERE OrderNo = @OrderNo AND MachineCode = @MachineCode";

                    int exists = conn.ExecuteScalar<int>(checkSql, new { OrderNo = orderNo, MachineCode = machineCode });

                    if (exists == 0)
                    {
                        // 插入新订单
                        string insertSql = @"
                            INSERT INTO OrderControl 
                            (MachineCode, MachineType, OrderNo, PartNumber, OrderQuantity, Status, ControlEnabled)
                            VALUES 
                            (@MachineCode, @MachineType, @OrderNo, @PartNumber, @OrderQuantity, 0, 1)";

                        conn.Execute(insertSql, new
                        {
                            MachineCode = machineCode,
                            MachineType = order.MachineType?.ToString(),
                            OrderNo = orderNo,
                            PartNumber = order.ItemCode?.ToString(),
                            OrderQuantity = (int)order.Qty_to_Build
                        });

                        syncCount++;
                    }
                }
            }

            return syncCount;
        }

        /// <summary>
        /// 添加控制日志
        /// </summary>
        public bool AddLog(OrderControlLogInfo log)
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = @"
                    INSERT INTO OrderControlLog 
                    (OrderControlID, MachineCode, LogType, Message, CurrentQuantity, TargetQuantity, CommandSent, CommandResult)
                    VALUES 
                    (@OrderControlID, @MachineCode, @LogType, @Message, @CurrentQuantity, @TargetQuantity, @CommandSent, @CommandResult)";

                int result = conn.Execute(sql, log);
                return result > 0;
            }
        }

        /// <summary>
        /// 获取订单日志列表
        /// </summary>
        public List<OrderControlLogInfo> GetLogsByOrderID(int orderControlID, int topCount = 100)
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = $@"
                    SELECT TOP {topCount} *
                    FROM OrderControlLog
                    WHERE OrderControlID = @OrderControlID
                    ORDER BY CreatedDate DESC";

                return conn.Query<OrderControlLogInfo>(sql, new { OrderControlID = orderControlID }).ToList();
            }
        }

        /// <summary>
        /// 获取机台配置
        /// </summary>
        public MachineConfigInfo GetMachineConfig(string machineCode)
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = @"
                    SELECT *
                    FROM MachineConfig
                    WHERE MachineCode = @MachineCode";

                return conn.QueryFirstOrDefault<MachineConfigInfo>(sql, new { MachineCode = machineCode });
            }
        }

        /// <summary>
        /// 获取所有注塑机设备列表
        /// </summary>
        public List<MachineConfigInfo> GetAllInjectionMachines()
        {
            using (IDbConnection conn = new SqlConnection(_connectionString))
            {
                string sql = @"
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
                        e.Brand
                    FROM Basal_Equipment e
                    WHERE e.EquipmentTypeCode LIKE '%Injection%'
                       OR e.Brand LIKE '%Engel%'
                       OR e.Brand LIKE '%恩格尔%'
                       OR e.Brand LIKE '%Haitian%'
                       OR e.Brand LIKE '%海天%'
                       OR e.Brand LIKE '%Demag%'
                       OR e.Brand LIKE '%德马格%'
                    ORDER BY e.EquipmentCode";

                return conn.Query<MachineConfigInfo>(sql).ToList();
            }
        }
    }
}
