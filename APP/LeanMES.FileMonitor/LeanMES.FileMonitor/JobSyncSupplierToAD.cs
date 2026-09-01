
using LeanMES.FileMonitor.Dao;
using LeanMES.FileMonitor.Model;
using LeanMES.FileMonitor.Utility;
using Newtonsoft.Json;
using NPOI.SS.Formula.Functions;
using Opc.Ua;
using Quartz;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LeanMES.FileMonitor
{
    [DisallowConcurrentExecution]
    /// <summary>
    /// OPC方式采集海天设备信息
    /// </summary>
    public class JobSyncSupplierToAD : IJob
    {
        
        private OPCUAHelper opcClient;
        private List<OPCUAHelper> oPCUAHelpers;

        public void JobSyncSupplierToADA(List<OPCUAHelper > list)
        {
            oPCUAHelpers = list;
        }


        public async void Execute(IJobExecutionContext context)
        {

            try
            {


                string url = "opc.tcp://172.16.215.101:4842";
                //opcClient = new OPCUAHelper();
                //opcClient.OpenConnectOfAnonymous(url);
                //if(opcClient.ConnectStatus)
                //{
                //    List<NodeId> nodeIds = new List<NodeId>();
                //    nodeIds.Add("ns=2;s=PartSts");
                //    nodeIds.Add("ns=2;s=MachineID");
                //    nodeIds.Add("ns=2;s=ActCntPrt");
                //    Dictionary<string, DataValue> myValue2 = opcClient.GetBatchNodeDatasOfSync(nodeIds);
                //}
                IList<EquipmentInfo> list = new StationDao().GetDeMaGeEquipmentList();

                string PartSts = string.Empty;
                string MachineID = string.Empty;
                string ActCntPrt = string.Empty;
                string ActTimCyc = string.Empty;
                string ActFrcClp = string.Empty;
                string paramterStr = string.Empty;
                string paramterVal = string.Empty;
                Task.Run(async () =>
                {
                    foreach (EquipmentInfo a in list)
                    {
                        try
                        {
                            if (string.IsNullOrWhiteSpace(a.EquipmentIP) || string.IsNullOrWhiteSpace(a.EquipmentPort))
                            {
                                break;
                            }
                            ////判断IP是否可Ping通
                            //if (!Tool.PingIp(a.EquipmentIP))
                            //{
                            //    break;
                            //}
                            Logger.Write("开始采集海天设备 :" + a.EquipmentCode);
                            url = "opc.tcp://" + a.EquipmentIP + ":" + a.EquipmentPort;

                            opcClient = new OPCUAHelper();
                            opcClient.OpenConnectOfAnonymous(url);
                            if (opcClient.ConnectStatus)
                            {
                                //List<NodeId> nodeIds = new List<NodeId>();
                                //nodeIds.Add("ns=2;s=PartSts");
                                //nodeIds.Add("ns=2;s=MachineID");
                                //nodeIds.Add("ns=2;s=ActCntPrt");

                                PartSts = opcClient.GetCurrentNodeValue("ns=2;s=PartSts").ToString();  //生产状态 0=不生产 1=生产
                                MachineID = opcClient.GetCurrentNodeValue("ns=2;s=MachineID").ToString();   //机器号
                                ActCntPrt = opcClient.GetCurrentNodeValue("ns=2;s=ActCntPrt").ToString();  //生产数量计数器
                                ActTimCyc = opcClient.GetCurrentNodeValue("ns=2;s=ActTimCyc").ToString();  //周期（节拍）计数器
                                ActFrcClp = opcClient.GetCurrentNodeValue("ns=2;s=ActFrcClp").ToString();  //注塑力
                                paramterStr = "@PartSts,@MachineID,@ActCntPrt,@ActTimCyc,@ActFrcClp";
                                paramterVal = PartSts + "," + MachineID + "," + ActCntPrt + "," + ActTimCyc + "," + ActFrcClp;
                                new StationDao().SaveEquipmentCollection(paramterStr, paramterVal, 2, out MachineID);
                            }
                            else
                            {
                                Logger.Write("采集海天注塑设备 :" + a.EquipmentCode + " 连接失败！");
                            }

                            Logger.Write("结束采集注塑设备 :" + a.EquipmentCode);
                        }
                        catch (Exception ex)
                        {
                            Logger.Write("注塑设备【" + a.EquipmentCode + "】采集数据发生异常：" + ex.Message, false);
                        }
                    }
                }).Wait();
            }
            catch (Exception ex)
            {
                Logger.Write("发生异常：" + ex.Message, false);
            }





        }
    }

}
