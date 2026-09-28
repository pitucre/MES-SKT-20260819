using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LeanMES.OrderControl.Utility;
using Opc.Ua;
using OpcUaHelper;

namespace LeanMES.OrderControl.Haitian
{
    /// <summary>
    /// 海天注塑机控制器 (基于OPC UA协议)
    /// </summary>
    public class HaitianController
    {
        private OpcUaClient _opcClient;
        private bool _isConnected = false;

        /// <summary>
        /// 连接状态
        /// </summary>
        public bool IsConnected
        {
            get { return _isConnected && _opcClient != null && _opcClient.Connected; }
        }

        /// <summary>
        /// 连接到海天注塑机
        /// </summary>
        public bool Connect(string ip, string port)
        {
            try
            {
                string url = $"opc.tcp://{ip}:{port}";
                _opcClient = new OpcUaClient();
                _opcClient.UserIdentity = new UserIdentity(new AnonymousIdentityToken());

                // 异步连接
                var task = Task.Run(async () => await _opcClient.ConnectServer(url));
                task.Wait(TimeSpan.FromSeconds(10));

                _isConnected = _opcClient.Connected;

                if (_isConnected)
                {
                    Logger.Write($"成功连接到海天注塑机: {url}");
                }
                else
                {
                    Logger.Write($"连接海天注塑机失败: {url}", false);
                }

                return _isConnected;
            }
            catch (Exception ex)
            {
                Logger.Write($"连接海天注塑机异常: {ex.Message}", false);
                _isConnected = false;
                return false;
            }
        }

        /// <summary>
        /// 断开连接
        /// </summary>
        public void Disconnect()
        {
            try
            {
                if (_opcClient != null)
                {
                    _opcClient.Disconnect();
                    _isConnected = false;
                    Logger.Write("已断开与海天注塑机的连接");
                }
            }
            catch (Exception ex)
            {
                Logger.Write($"断开海天注塑机连接异常: {ex.Message}", false);
            }
        }

        /// <summary>
        /// 读取单个节点值
        /// </summary>
        public T ReadNodeValue<T>(string nodeId)
        {
            if (!IsConnected)
            {
                Logger.Write("未连接到海天注塑机，无法读取数据", false);
                return default(T);
            }

            try
            {
                T value = _opcClient.ReadNode<T>(nodeId);
                return value;
            }
            catch (Exception ex)
            {
                Logger.Write($"读取海天注塑机节点 {nodeId} 失败: {ex.Message}", false);
                return default(T);
            }
        }

        /// <summary>
        /// 读取生产数据
        /// </summary>
        public HaitianProductionData ReadProductionData()
        {
            if (!IsConnected)
            {
                Logger.Write("未连接到海天注塑机，无法读取生产数据", false);
                return null;
            }

            try
            {
                HaitianProductionData data = new HaitianProductionData();
                data.ReadTime = DateTime.Now;

                // 读取各个参数
                data.PartSts = ReadNodeValue<string>("ns=2;s=PartSts");           // 生产状态
                data.MachineID = ReadNodeValue<string>("ns=2;s=MachineID");       // 机器号
                data.ActCntPrt = ReadNodeValue<string>("ns=2;s=ActCntPrt");       // 生产数量计数器
                data.ActTimCyc = ReadNodeValue<string>("ns=2;s=ActTimCyc");       // 周期时间
                data.ActFrcClp = ReadNodeValue<string>("ns=2;s=ActFrcClp");       // 注塑力

                Logger.Write($"成功读取海天注塑机数据: 状态={data.PartSts}, 数量={data.ActCntPrt}");
                return data;
            }
            catch (Exception ex)
            {
                Logger.Write($"读取海天注塑机生产数据失败: {ex.Message}", false);
                return null;
            }
        }

        /// <summary>
        /// 写入单个节点值
        /// </summary>
        public bool WriteNodeValue<T>(string nodeId, T value)
        {
            if (!IsConnected)
            {
                Logger.Write("未连接到海天注塑机，无法写入数据", false);
                return false;
            }

            try
            {
                bool success = _opcClient.WriteNode(nodeId, value);
                if (success)
                {
                    Logger.Write($"成功写入海天注塑机节点 {nodeId} = {value}");
                }
                else
                {
                    Logger.Write($"写入海天注塑机节点 {nodeId} 失败", false);
                }
                return success;
            }
            catch (Exception ex)
            {
                Logger.Write($"写入海天注塑机节点 {nodeId} 异常: {ex.Message}", false);
                return false;
            }
        }

        /// <summary>
        /// 发送停止命令
        /// </summary>
        public bool SendStopCommand()
        {
            // 海天注塑机通过OPC UA写入停止信号
            // 具体节点ID需要根据实际设备配置
            try
            {
                // 假设停止节点为 ns=2;s=StopCommand
                // 实际使用时需要根据设备文档调整
                bool success = WriteNodeValue("ns=2;s=StopCommand", true);
                
                if (success)
                {
                    Logger.Write("已向海天注塑机发送停止命令");
                }
                else
                {
                    Logger.Write("向海天注塑机发送停止命令失败", false);
                }

                return success;
            }
            catch (Exception ex)
            {
                Logger.Write($"向海天注塑机发送停止命令异常: {ex.Message}", false);
                return false;
            }
        }
    }

    /// <summary>
    /// 海天生产数据类
    /// </summary>
    public class HaitianProductionData
    {
        /// <summary>
        /// 生产状态 (0=不生产, 1=生产)
        /// </summary>
        public string PartSts { get; set; }

        /// <summary>
        /// 机器号
        /// </summary>
        public string MachineID { get; set; }

        /// <summary>
        /// 生产数量计数器
        /// </summary>
        public string ActCntPrt { get; set; }

        /// <summary>
        /// 周期时间
        /// </summary>
        public string ActTimCyc { get; set; }

        /// <summary>
        /// 注塑力
        /// </summary>
        public string ActFrcClp { get; set; }

        /// <summary>
        /// 读取时间
        /// </summary>
        public DateTime ReadTime { get; set; }

        /// <summary>
        /// 获取当前生产数量
        /// </summary>
        public int GetCurrentQuantity()
        {
            int.TryParse(ActCntPrt, out int quantity);
            return quantity;
        }
    }
}
