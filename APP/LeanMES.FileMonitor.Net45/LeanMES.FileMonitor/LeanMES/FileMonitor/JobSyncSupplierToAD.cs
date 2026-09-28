using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using LeanMES.FileMonitor.Dao;
using LeanMES.FileMonitor.Model;
using LeanMES.FileMonitor.Utility;
using Quartz;

namespace LeanMES.FileMonitor
{
[DisallowConcurrentExecution]
public class JobSyncSupplierToAD : IJob
{
private OPCUAHelper opcClient;

private List<OPCUAHelper> oPCUAHelpers;

public void JobSyncSupplierToADA(List<OPCUAHelper> list)
{
	oPCUAHelpers = list;
}

public async void Execute(IJobExecutionContext context)
{
	try
	{
		string url = "opc.tcp://172.16.215.101:4842";
		IList<EquipmentInfo> list = new StationDao().GetDeMaGeEquipmentList();
		string PartSts = string.Empty;
		string MachineID = string.Empty;
		string ActCntPrt = string.Empty;
		string ActTimCyc = string.Empty;
		string ActFrcClp = string.Empty;
		string paramterStr = string.Empty;
		string paramterVal = string.Empty;
		Task.Run(async delegate
		{
			foreach (EquipmentInfo a in list)
			{
				try
				{
					if (!string.IsNullOrWhiteSpace(a.EquipmentIP) && !string.IsNullOrWhiteSpace(a.EquipmentPort))
					{
						Logger.Write("开始采集海天设备 :" + a.EquipmentCode);
						url = "opc.tcp://" + a.EquipmentIP + ":" + a.EquipmentPort;
						opcClient = new OPCUAHelper();
						opcClient.OpenConnectOfAnonymous(url);
						if (opcClient.ConnectStatus)
						{
							PartSts = opcClient.GetCurrentNodeValue("ns=2;s=PartSts").ToString();
							MachineID = opcClient.GetCurrentNodeValue("ns=2;s=MachineID").ToString();
							ActCntPrt = opcClient.GetCurrentNodeValue("ns=2;s=ActCntPrt").ToString();
							ActTimCyc = opcClient.GetCurrentNodeValue("ns=2;s=ActTimCyc").ToString();
							ActFrcClp = opcClient.GetCurrentNodeValue("ns=2;s=ActFrcClp").ToString();
							paramterStr = "@PartSts,@MachineID,@ActCntPrt,@ActTimCyc,@ActFrcClp";
							paramterVal = PartSts + "," + MachineID + "," + ActCntPrt + "," + ActTimCyc + "," + ActFrcClp;
							new StationDao().SaveEquipmentCollection(paramterStr, paramterVal, 2, out MachineID);
						}
						else
						{
							Logger.Write("采集海天注塑设备 :" + a.EquipmentCode + " 连接失败！");
						}
						Logger.Write("结束采集注塑设备 :" + a.EquipmentCode);
						continue;
					}
				}
				catch (Exception ex3)
				{
					Exception ex4 = ex3;
					Logger.Write("注塑设备【" + a.EquipmentCode + "】采集数据发生异常：" + ex4.Message, isOk: false);
					continue;
				}
				break;
			}
		}).Wait();
	}
	catch (Exception ex)
	{
		Exception ex2 = ex;
		Logger.Write("发生异常：" + ex2.Message, isOk: false);
	}
}
}
}
