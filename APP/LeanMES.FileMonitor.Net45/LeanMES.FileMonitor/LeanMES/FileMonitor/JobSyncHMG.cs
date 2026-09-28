using System;
using System.Net;
using System.Text;
using LeanMES.FileMonitor.Dao;
using LeanMES.FileMonitor.Utility;
using Quartz;
using uPLibrary.Networking.M2Mqtt;
using uPLibrary.Networking.M2Mqtt.Messages;

namespace LeanMES.FileMonitor
{
[DisallowConcurrentExecution]
public class JobSyncHMG : IJob
{
private MqttClient mqttClient = null;

public void Execute(IJobExecutionContext context)
{
	try
	{
		Logger.Write("监控启动成功！");
		Logger.Write("开始采集海马格设备数据.....");
		if (mqttClient == null)
		{
			IPAddress brokerIpAddress = IPAddress.Parse("172.16.5.150");
			int brokerPort = 1883;
			string clientId = "CsharpClient";
			string username = "mqttadmin";
			string password = "Mqttadmin@123";
			string text = "201212025016356/spc";
			string text2 = "201011038012125/spc";
			string text3 = "13/spc";
			mqttClient = new MqttClient(brokerIpAddress, brokerPort, secure: false, null, null, MqttSslProtocols.None);
			mqttClient.Connect(clientId, username, password);
			mqttClient.MqttMsgPublishReceived += client_MqttMsgPublishReceived;
			mqttClient.Subscribe(new string[1] { text2 }, new byte[1] { 2 });
			mqttClient.Subscribe(new string[1] { text }, new byte[1] { 2 });
			mqttClient.Subscribe(new string[1] { text3 }, new byte[1] { 2 });
		}
	}
	catch (Exception ex)
	{
		Logger.Write("采集海马格设备数据发生异常：" + ex.Message, isOk: false);
	}
}

private static void client_MqttMsgPublishReceived(object sender, MqttMsgPublishEventArgs e)
{
	string text = new StationDao().HMGEquipmentCollection(Encoding.UTF8.GetString(e.Message));
	Logger.Write("采集到海马格设备数据：" + text);
}
}
}
