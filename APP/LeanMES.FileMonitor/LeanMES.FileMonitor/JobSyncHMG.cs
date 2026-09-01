
using LeanMES.FileMonitor.Dao;
using LeanMES.FileMonitor.Model;
using LeanMES.FileMonitor.Utility;
using Newtonsoft.Json;
using Quartz;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using uPLibrary.Networking.M2Mqtt;
using uPLibrary.Networking.M2Mqtt.Messages;
using System.Net;
using System.Windows.Forms;
namespace LeanMES.FileMonitor
{
  
    [DisallowConcurrentExecution]
    /// <summary>
    /// 同步海马格设备数据
    /// </summary>
    public class JobSyncHMG :  IJob
    {
        private MqttClient mqttClient = null;

        public void Execute(IJobExecutionContext context)
        {
            
            try
            {
                Logger.Write("监控启动成功！");
                Logger.Write("开始采集海马格设备数据.....");
                if (mqttClient==null)
                {
                    IPAddress brokerAddress = IPAddress.Parse("172.16.5.150"); // MQTTX服务器地址
                    int brokerPort = 1883; // MQTTX服务器端口
                    string clientId = "CsharpClient"; // 客户端ID
                    string username = "mqttadmin"; // MQTTX用户名
                    string password = "Mqttadmin@123"; // MQTTX密码

                    string topic1 = "201212025016356/spc"; // 订阅的主题
                    string topic = "201011038012125/spc"; // 订阅的主题
                    string topic2 = "13/spc"; // 订阅的主题
                    mqttClient = new MqttClient(brokerAddress, brokerPort, false, null, null, MqttSslProtocols.None);
                    mqttClient.Connect(clientId, username, password);


                    mqttClient.MqttMsgPublishReceived += client_MqttMsgPublishReceived;

                    mqttClient.Subscribe(new string[] { topic }, new byte[] { MqttMsgBase.QOS_LEVEL_EXACTLY_ONCE });
                    mqttClient.Subscribe(new string[] { topic1 }, new byte[] { MqttMsgBase.QOS_LEVEL_EXACTLY_ONCE });
                    mqttClient.Subscribe(new string[] { topic2 }, new byte[] { MqttMsgBase.QOS_LEVEL_EXACTLY_ONCE });
                }
            }
            catch (Exception ex)
            {
                Logger.Write("采集海马格设备数据发生异常：" + ex.Message, false);
            }
        }

        static void client_MqttMsgPublishReceived(object sender, MqttMsgPublishEventArgs e)
        {

           string equiCode= new StationDao().HMGEquipmentCollection(System.Text.Encoding.UTF8.GetString(e.Message));
           Logger.Write("采集到海马格设备数据：" + equiCode);
            // 处理接收到的消息
            // Logger.Write("Received Message: " + System.Text.Encoding.UTF8.GetString(e.Message));
        }
    }

}
