using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LeanMES.OrderControl.Dao;
using LeanMES.OrderControl.Engel;
using LeanMES.OrderControl.Haitian;
using LeanMES.OrderControl.Demag;
using LeanMES.OrderControl.Model;
using LeanMES.OrderControl.Utility;
using Quartz;

namespace LeanMES.OrderControl.Job
{
    /// <summary>
    /// 订单数量控制Job - 从MES系统同步工单并自动控制注塑机
    /// </summary>
    [DisallowConcurrentExecution]
    public class JobOrderControl : IJob
    {
        private readonly OrderControlDao _dao;
        private readonly EngelController _engelController;
        private readonly HaitianController _haitianController;
        private readonly DemagController _demagController;

        // 机台控制器缓存
        private Dictionary<string, object> _machineControllers = new Dictionary<string, object>();

        public JobOrderControl()
        {
            _dao = new OrderControlDao();
            _engelController = new EngelController();
            _haitianController = new HaitianController();
            _demagController = new DemagController();
        }

        public async Task Execute(IJobExecutionContext context)
        {
            try
            {
                Logger.Write("开始检查订单数量控制...");

                // 1. 先从MES系统同步工单
                SyncOrdersFromMES();

                // 2. 获取所有需要控制的机台订单
                List<OrderControlInfo> orderList = _dao.GetActiveOrderList();

                if (orderList == null || orderList.Count == 0)
                {
                    Logger.Write("没有需要控制的订单");
                    return;
                }

                Logger.Write($"共 {orderList.Count} 个订单需要检查");

                // 3. 逐个检查订单
                foreach (var order in orderList)
                {
                    try
                    {
                        ProcessOrder(order);
                    }
                    catch (Exception ex)
                    {
                        Logger.Write($"处理订单 {order.OrderNo} 异常: {ex.Message}", false);

                        _dao.AddLog(new OrderControlLogInfo
                        {
                            OrderControlID = order.ID,
                            MachineCode = order.MachineCode,
                            LogType = "ERROR",
                            Message = $"处理订单异常: {ex.Message}",
                            CreatedDate = DateTime.Now
                        });
                    }
                }

                Logger.Write("订单数量控制检查完成");
            }
            catch (Exception ex)
            {
                Logger.Write($"订单数量控制检查异常: {ex.Message}", false);
            }

            await Task.CompletedTask;
        }

        /// <summary>
        /// 从MES系统同步工单
        /// </summary>
        private void SyncOrdersFromMES()
        {
            try
            {
                int syncCount = _dao.SyncOrdersFromMES();
                if (syncCount > 0)
                {
                    Logger.Write($"从MES系统同步了 {syncCount} 个新工单");
                }
            }
            catch (Exception ex)
            {
                Logger.Write($"从MES同步工单失败: {ex.Message}", false);
            }
        }

        /// <summary>
        /// 处理单个订单
        /// </summary>
        private void ProcessOrder(OrderControlInfo order)
        {
            // 1. 读取机台当前生产数量
            int currentQuantity = ReadCurrentQuantity(order);

            if (currentQuantity < 0)
            {
                Logger.Write($"无法读取机台 {order.MachineCode} 的生产数量", false);
                return;
            }

            // 2. 更新完成数量
            _dao.UpdateCompletedQuantity(order.ID, currentQuantity);

            // 3. 比较是否达到订单数量
            if (currentQuantity >= order.OrderQuantity)
            {
                Logger.Write($"*** 机台 {order.MachineCode} 达到订单数量！当前: {currentQuantity}, 目标: {order.OrderQuantity} ***");

                // 记录日志
                _dao.AddLog(new OrderControlLogInfo
                {
                    OrderControlID = order.ID,
                    MachineCode = order.MachineCode,
                    LogType = "INFO",
                    Message = $"达到订单数量: 当前={currentQuantity}, 目标={order.OrderQuantity}",
                    CurrentQuantity = currentQuantity,
                    TargetQuantity = order.OrderQuantity,
                    CreatedDate = DateTime.Now
                });

                // 4. 发送停止命令
                bool stopped = SendStopCommand(order);

                if (stopped)
                {
                    // 5. 更新订单状态
                    _dao.MarkAsCompleted(order.ID);
                    _dao.MarkStopCommandSent(order.ID);

                    Logger.Write($"*** 机台 {order.MachineCode} 已发送停止命令并标记为已完成 ***");

                    _dao.AddLog(new OrderControlLogInfo
                    {
                        OrderControlID = order.ID,
                        MachineCode = order.MachineCode,
                        LogType = "COMMAND",
                        Message = "停止命令已发送，订单已完成",
                        CurrentQuantity = currentQuantity,
                        TargetQuantity = order.OrderQuantity,
                        CommandSent = "StopCommand",
                        CommandResult = "Success",
                        CreatedDate = DateTime.Now
                    });
                }
                else
                {
                    Logger.Write($"机台 {order.MachineCode} 停止命令发送失败", false);

                    _dao.AddLog(new OrderControlLogInfo
                    {
                        OrderControlID = order.ID,
                        MachineCode = order.MachineCode,
                        LogType = "ERROR",
                        Message = "停止命令发送失败",
                        CurrentQuantity = currentQuantity,
                        TargetQuantity = order.OrderQuantity,
                        CommandSent = "StopCommand",
                        CommandResult = "Failed",
                        CreatedDate = DateTime.Now
                    });
                }
            }
            else
            {
                // 计算进度
                double percentage = (double)currentQuantity / order.OrderQuantity * 100;
                int remaining = order.OrderQuantity - currentQuantity;

                // 每10%记录一次进度
                if (percentage % 10 < 1)
                {
                    Logger.Write($"机台 {order.MachineCode}: {currentQuantity}/{order.OrderQuantity} ({percentage:F1}%), 剩余: {remaining}");
                }

                // 检查是否达到预警告警阈值 (如90%)
                if (percentage >= 90 && percentage < 100)
                {
                    _dao.AddLog(new OrderControlLogInfo
                    {
                        OrderControlID = order.ID,
                        MachineCode = order.MachineCode,
                        LogType = "WARNING",
                        Message = $"生产进度达到{percentage:F1}%，即将完成",
                        CurrentQuantity = currentQuantity,
                        TargetQuantity = order.OrderQuantity,
                        CreatedDate = DateTime.Now
                    });
                }
            }
        }

        /// <summary>
        /// 读取机台当前生产数量
        /// </summary>
        private int ReadCurrentQuantity(OrderControlInfo order)
        {
            int quantity = -1;

            try
            {
                // 确定设备类型
                string machineType = DetermineMachineType(order);

                switch (machineType.ToUpper())
                {
                    case "ENGEL":
                        var engelData = _engelController.ReadProductionData(order.MachineCode);
                        if (engelData != null)
                        {
                            quantity = engelData.GoodPartsCount;
                        }
                        break;

                    case "HAITIAN":
                        if (_haitianController.IsConnected)
                        {
                            var haitianData = _haitianController.ReadProductionData();
                            if (haitianData != null)
                            {
                                quantity = haitianData.GetCurrentQuantity();
                            }
                        }
                        else
                        {
                            // 尝试连接
                            if (!string.IsNullOrEmpty(order.EquipmentIP) && !string.IsNullOrEmpty(order.EquipmentPort))
                            {
                                _haitianController.Connect(order.EquipmentIP, order.EquipmentPort);
                                if (_haitianController.IsConnected)
                                {
                                    var haitianData = _haitianController.ReadProductionData();
                                    if (haitianData != null)
                                    {
                                        quantity = haitianData.GetCurrentQuantity();
                                    }
                                }
                            }
                        }
                        break;

                    case "DEMAG":
                        if (_demagController.IsConnected)
                        {
                            var demagData = _demagController.ReadProductionData();
                            if (demagData != null)
                            {
                                quantity = demagData.GetCurrentQuantity();
                            }
                        }
                        else
                        {
                            // 尝试连接
                            if (!string.IsNullOrEmpty(order.EquipmentIP) && !string.IsNullOrEmpty(order.EquipmentPort))
                            {
                                _demagController.Connect(order.EquipmentIP, order.EquipmentPort);
                                if (_demagController.IsConnected)
                                {
                                    var demagData = _demagController.ReadProductionData();
                                    if (demagData != null)
                                    {
                                        quantity = demagData.GetCurrentQuantity();
                                    }
                                }
                            }
                        }
                        break;

                    default:
                        Logger.Write($"未知的设备类型: {machineType}，机台: {order.MachineCode}", false);
                        break;
                }
            }
            catch (Exception ex)
            {
                Logger.Write($"读取机台 {order.MachineCode} 数量失败: {ex.Message}", false);
            }

            return quantity;
        }

        /// <summary>
        /// 确定设备类型
        /// </summary>
        private string DetermineMachineType(OrderControlInfo order)
        {
            // 优先使用已有的MachineType
            if (!string.IsNullOrEmpty(order.MachineType))
            {
                return order.MachineType;
            }

            // 根据MachineBrand判断
            if (!string.IsNullOrEmpty(order.MachineBrand))
            {
                if (order.MachineBrand.Contains("Engel") || order.MachineBrand.Contains("恩格尔"))
                    return "Engel";
                if (order.MachineBrand.Contains("Haitian") || order.MachineBrand.Contains("海天"))
                    return "Haitian";
                if (order.MachineBrand.Contains("Demag") || order.MachineBrand.Contains("德马格"))
                    return "Demag";
            }

            // 根据EquipmentTypeCode判断
            if (!string.IsNullOrEmpty(order.EquipmentTypeCode))
            {
                if (order.EquipmentTypeCode.Contains("Engel") || order.EquipmentTypeCode.Contains("恩格尔"))
                    return "Engel";
                if (order.EquipmentTypeCode.Contains("Haitian") || order.EquipmentTypeCode.Contains("海天"))
                    return "Haitian";
                if (order.EquipmentTypeCode.Contains("Demag") || order.EquipmentTypeCode.Contains("德马格"))
                    return "Demag";
            }

            return "Unknown";
        }

        /// <summary>
        /// 发送停止命令
        /// </summary>
        private bool SendStopCommand(OrderControlInfo order)
        {
            bool success = false;

            try
            {
                string machineType = DetermineMachineType(order);

                switch (machineType.ToUpper())
                {
                    case "ENGEL":
                        success = _engelController.SendStopCommand(order.MachineCode);
                        break;

                    case "HAITIAN":
                        success = _haitianController.SendStopCommand();
                        break;

                    case "DEMAG":
                        success = _demagController.SendStopCommand();
                        break;

                    default:
                        Logger.Write($"未知的设备类型: {machineType}，无法发送停止命令", false);
                        break;
                }
            }
            catch (Exception ex)
            {
                Logger.Write($"向机台 {order.MachineCode} 发送停止命令失败: {ex.Message}", false);
            }

            return success;
        }
    }
}
