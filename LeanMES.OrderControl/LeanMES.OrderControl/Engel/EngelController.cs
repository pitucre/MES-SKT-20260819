using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LeanMES.OrderControl.Utility;

namespace LeanMES.OrderControl.Engel
{
    /// <summary>
    /// 恩格尔注塑机控制器 (基于EUROMAP 63协议)
    /// </summary>
    public class EngelController
    {
        /// <summary>
        /// EUROMAP 63根目录
        /// </summary>
        private const string EUROMAP63_ROOT = @"C:\Engel\Euromap63\System\Access\MACHINES";

        /// <summary>
        /// 获取机台的EUROMAP 63路径
        /// </summary>
        private string GetMachinePath(string machineCode)
        {
            return Path.Combine(EUROMAP63_ROOT, machineCode);
        }

        /// <summary>
        /// 获取E63_JOBS路径
        /// </summary>
        private string GetJobsPath(string machineCode)
        {
            return Path.Combine(GetMachinePath(machineCode), "E63_JOBS");
        }

        /// <summary>
        /// 读取MESData.dat文件获取当前生产数据
        /// </summary>
        public EngelProductionData ReadProductionData(string machineCode)
        {
            EngelProductionData data = null;
            string datFile = Path.Combine(GetJobsPath(machineCode), "MESData.dat");

            try
            {
                if (File.Exists(datFile))
                {
                    string[] lines = File.ReadAllLines(datFile, Encoding.UTF8);
                    if (lines.Length >= 2)
                    {
                        // 第一行是表头，第二行是数据
                        string[] headers = lines[0].Split(',');
                        string[] values = lines[1].Split(',');

                        data = new EngelProductionData();
                        data.MachineCode = machineCode;
                        data.ReadTime = DateTime.Now;

                        // 解析各个字段
                        for (int i = 0; i < headers.Length && i < values.Length; i++)
                        {
                            string header = headers[i].Trim().ToUpper();
                            string value = values[i].Trim().Trim('"');

                            switch (header)
                            {
                                case "DATE":
                                    data.ProductionDate = value;
                                    break;
                                case "TIME":
                                    data.ProductionTime = value;
                                    break;
                                case "@32026":
                                case "@32000":
                                    data.MachineNumber = value;
                                    break;
                                case "@SHOTCOUNTER.SV_ISHOTSGOODPART":
                                    int.TryParse(value, out int goodParts);
                                    data.GoodPartsCount = goodParts;
                                    break;
                                case "@SHOTCOUNTER.SV_ISHOTCOUNTER":
                                    int.TryParse(value, out int totalShots);
                                    data.TotalShotsCount = totalShots;
                                    break;
                                case "@HOST.SV_SACTIVEPARTDATA":
                                    data.CurrentPartNumber = value;
                                    break;
                                case "@INJECTIONUNIT1.SV_RINTEGRALPHOST":
                                    double.TryParse(value, out double injectionPressure);
                                    data.InjectionPressure = injectionPressure;
                                    break;
                                case "@CYCLETIME.SV_DCYCLETIMEACTVALLASTHOST":
                                    double.TryParse(value, out double cycleTime);
                                    data.ActualCycleTime = cycleTime;
                                    break;
                                case "@PARTS.SV_SMOLDNUMBER":
                                    data.MoldNumber = value;
                                    break;
                                case "@PARTS.SV_SITEMNUMBER":
                                    data.ItemNumber = value;
                                    break;
                                case "@INJECTIONUNIT1.SV_SMATERIALNUMBER":
                                    data.MaterialNumber = value;
                                    break;
                                case "@PARTS.SV_SMACHINENUMBER":
                                    data.MachineNumberDetail = value;
                                    break;
                                case "@PARTS.SV_SORDERNUMBER":
                                    data.OrderNumber = value;
                                    break;
                                case "@SHOTCOUNTER.SV_IPARTCOUNTER":
                                    int.TryParse(value, out int partCounter);
                                    data.PartCounter = partCounter;
                                    break;
                                case "@SHOTCOUNTER.SV_ISHOTSREJECTPRODUCTION":
                                    int.TryParse(value, out int rejectCount);
                                    data.RejectCount = rejectCount;
                                    break;
                                case "@HOST.SV_ISTANDSTILLCODE":
                                    int.TryParse(value, out int standStillCode);
                                    data.StandStillCode = standStillCode;
                                    break;
                            }
                        }

                        Logger.Write($"成功读取恩格尔机台 {machineCode} 数据: 良品={data.GoodPartsCount}, 总射出={data.TotalShotsCount}");
                    }
                }
                else
                {
                    Logger.Write($"机台 {machineCode} 的MESData.dat文件不存在", false);
                }
            }
            catch (Exception ex)
            {
                Logger.Write($"读取恩格尔机台 {machineCode} 数据失败: {ex.Message}", false);
            }

            return data;
        }

        /// <summary>
        /// 发送停止作业命令
        /// </summary>
        public bool SendStopCommand(string machineCode)
        {
            bool success = false;
            string reqFile = Path.Combine(GetJobsPath(machineCode), "SESS0001.REQ");

            try
            {
                // 生成停止命令内容
                // 格式: 序号 EXECUTE "Job文件名";
                string command = "00000001 EXECUTE \"AbortReportProcessData.job\";\r\n";

                // 写入REQ文件
                File.WriteAllText(reqFile, command, Encoding.ASCII);

                Logger.Write($"已向恩格尔机台 {machineCode} 发送停止命令");
                success = true;
            }
            catch (Exception ex)
            {
                Logger.Write($"向恩格尔机台 {machineCode} 发送停止命令失败: {ex.Message}", false);
            }

            return success;
        }

        /// <summary>
        /// 发送自定义作业命令
        /// </summary>
        public bool SendJobCommand(string machineCode, string jobFileName)
        {
            bool success = false;
            string reqFile = Path.Combine(GetJobsPath(machineCode), "SESS0001.REQ");

            try
            {
                string command = $"00000001 EXECUTE \"{jobFileName}\";\r\n";
                File.WriteAllText(reqFile, command, Encoding.ASCII);

                Logger.Write($"已向恩格尔机台 {machineCode} 发送作业命令: {jobFileName}");
                success = true;
            }
            catch (Exception ex)
            {
                Logger.Write($"向恩格尔机台 {machineCode} 发送作业命令失败: {ex.Message}", false);
            }

            return success;
        }

        /// <summary>
        /// 读取命令执行响应
        /// </summary>
        public string ReadResponse(string machineCode)
        {
            string response = string.Empty;
            string rspFile = Path.Combine(GetJobsPath(machineCode), "SESS0001.Rsp");

            try
            {
                if (File.Exists(rspFile))
                {
                    response = File.ReadAllText(rspFile, Encoding.UTF8);
                    Logger.Write($"恩格尔机台 {machineCode} 响应: {response}");
                }
            }
            catch (Exception ex)
            {
                Logger.Write($"读取恩格尔机台 {machineCode} 响应失败: {ex.Message}", false);
            }

            return response;
        }

        /// <summary>
        /// 检查机台是否在线
        /// </summary>
        public bool IsMachineOnline(string machineCode)
        {
            string logFile = Path.Combine(GetJobsPath(machineCode), "MESData.log");

            try
            {
                if (File.Exists(logFile))
                {
                    string[] lines = File.ReadAllLines(logFile, Encoding.UTF8);
                    // 查找最新的日志行
                    for (int i = lines.Length - 1; i >= 0; i--)
                    {
                        if (lines[i].Contains("Machine is online"))
                        {
                            return true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.Write($"检查恩格尔机台 {machineCode} 在线状态失败: {ex.Message}", false);
            }

            return false;
        }
    }

    /// <summary>
    /// 恩格尔生产数据类
    /// </summary>
    public class EngelProductionData
    {
        public string MachineCode { get; set; }
        public string ProductionDate { get; set; }
        public string ProductionTime { get; set; }
        public string MachineNumber { get; set; }
        public int GoodPartsCount { get; set; }
        public int TotalShotsCount { get; set; }
        public string CurrentPartNumber { get; set; }
        public double InjectionPressure { get; set; }
        public double ActualCycleTime { get; set; }
        public string MoldNumber { get; set; }
        public string ItemNumber { get; set; }
        public string MaterialNumber { get; set; }
        public string MachineNumberDetail { get; set; }
        public string OrderNumber { get; set; }
        public int PartCounter { get; set; }
        public int RejectCount { get; set; }
        public int StandStillCode { get; set; }
        public DateTime ReadTime { get; set; }
    }
}
