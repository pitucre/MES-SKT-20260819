using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Net.Sockets;
using System.Threading.Tasks;

namespace LeanMES.OrderControl
{
    /// <summary>
    /// 注塑机连接测试工具 - 测试所有32台注塑机
    /// </summary>
    public class MachineTester
    {
        private string connString;
        private string logFile;

        public MachineTester()
        {
            connString = ConfigurationManager.ConnectionStrings["MESConnString"]?.ConnectionString
                ?? ConfigurationManager.AppSettings["MESConnString"];
            logFile = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "test_result.txt");
        }

        /// <summary>
        /// 测试所有注塑机
        /// </summary>
        public async Task TestAll()
        {
            Console.WriteLine("===========================================");
            Console.WriteLine("  Injection Machine Connection Tester");
            Console.WriteLine("===========================================");
            Console.WriteLine();

            var machines = await GetMachinesFromDB();
            Console.WriteLine($"Found {machines.Count} injection machines from database");
            Console.WriteLine();

            var results = new List<TestResult>();

            // 逐个测试
            foreach (var m in machines)
            {
                var result = await TestMachine(m);
                results.Add(result);

                // 显示结果
                ConsoleColor color = result.IsOnline ? ConsoleColor.Green : 
                                     result.IsEngel ? ConsoleColor.Cyan : ConsoleColor.Red;
                Console.ForegroundColor = color;
                Console.Write($"  [{m.EquipmentCode}] {m.EquipmentName,-12}");
                Console.ResetColor();
                Console.Write($" -> {result.StatusText,-10}");

                if (!string.IsNullOrEmpty(result.Message))
                    Console.Write($" ({result.Message})");

                Console.WriteLine();
            }

            // 检查恩格尔机器
            Console.WriteLine();
            Console.WriteLine("--- Checking Engel EUROMAP 63 Machines ---");
            var engelMachines = GetEngelMachines();
            foreach (var eng in engelMachines)
            {
                string path = $@"C:\Engel\Euromap63\System\Access\MACHINES\{eng}";
                bool exists = Directory.Exists(path);
                Console.WriteLine($"  [{eng}] {(exists ? "FOUND" : "NOT FOUND")}");
            }

            // 显示汇总
            Console.WriteLine();
            Console.WriteLine("===========================================");
            Console.WriteLine("Summary:");
            Console.WriteLine($"  Total:            {results.Count}");
            Console.WriteLine($"  Online (TCP):     {results.FindAll(r => r.IsOnline).Count}");
            Console.WriteLine($"  Engel (EUROMAP):  {engelMachines.Count}");
            Console.WriteLine($"  Offline:          {results.FindAll(r => !r.IsOnline && !r.IsEngel).Count}");
            Console.WriteLine("===========================================");

            // 保存报告
            SaveReport(results);
        }

        /// <summary>
        /// 测试单台注塑机
        /// </summary>
        private async Task<TestResult> TestMachine(MachineInfo machine)
        {
            var result = new TestResult
            {
                MachineCode = machine.EquipmentCode,
                MachineName = machine.EquipmentName
            };

            // 1. 检查是否是恩格尔机器 (EUROMAP 63)
            if (IsEngelMachine(machine.EquipmentCode))
            {
                result.IsEngel = true;
                result.Protocol = "EUROMAP 63";
                result.IsOnline = true;
                result.StatusText = "ENGEL_OK";
                result.Message = "EUROMAP 63 folder exists";
                return result;
            }

            // 2. 检查是否有IP配置
            if (string.IsNullOrEmpty(machine.EquipmentIP))
            {
                result.StatusText = "NO_IP";
                result.Message = "No IP configured";
                return result;
            }

            if (string.IsNullOrEmpty(machine.EquipmentPort))
            {
                result.StatusText = "NO_PORT";
                result.Message = "No port configured";
                return result;
            }

            // 3. Ping测试
            bool pingOk = await PingHost(machine.EquipmentIP);
            if (!pingOk)
            {
                result.StatusText = "PING_FAIL";
                result.Message = "Host unreachable";
                return result;
            }

            // 4. 端口连接测试
            bool portOk = await TestPort(machine.EquipmentIP, machine.EquipmentPort);
            if (!portOk)
            {
                result.StatusText = "PORT_CLOSED";
                result.Message = $"Port {machine.EquipmentPort} closed";
                return result;
            }

            // 5. 根据端口判断协议并测试
            string protocol = DetectProtocol(machine.EquipmentPort);
            result.Protocol = protocol;
            result.IsOnline = true;
            result.StatusText = "ONLINE";
            result.Message = $"{protocol} connection OK";

            return result;
        }

        /// <summary>
        /// Ping测试
        /// </summary>
        private async Task<bool> PingHost(string ip)
        {
            try
            {
                var ping = new System.Net.NetworkInformation.Ping();
                var reply = await ping.SendPingAsync(ip, 2000);
                return reply.Status == System.Net.NetworkInformation.IPStatus.Success;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 端口连接测试
        /// </summary>
        private async Task<bool> TestPort(string ip, string port)
        {
            int portNum;
            if (!int.TryParse(port, out portNum))
                return false;

            try
            {
                using (var client = new TcpClient())
                {
                    var task = client.ConnectAsync(ip, portNum);
                    var timeout = Task.Delay(3000);

                    if (await Task.WhenAny(task, timeout) == timeout)
                        return false;

                    await task;
                    return client.Connected;
                }
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 根据端口检测协议类型
        /// </summary>
        private string DetectProtocol(string port)
        {
            switch (port)
            {
                case "4840": return "OPC UA (Euromap 77)";
                case "4842": return "OPC UA";
                case "1883": return "MQTT";
                case "502": return "Modbus TCP";
                default: return $"TCP:{port}";
            }
        }

        /// <summary>
        /// 从数据库获取注塑机列表
        /// </summary>
        private async Task<List<MachineInfo>> GetMachinesFromDB()
        {
            var machines = new List<MachineInfo>();

            using (var conn = new SqlConnection(connString))
            {
                await conn.OpenAsync();
                var sql = @"
                    SELECT EquipmentCode, EquipmentName, EquipmentIP, EquipmentPort, 
                           Status, InjectionStatus, Brand
                    FROM Basal_Equipment 
                    WHERE EquipmentName LIKE '%注塑%' 
                    ORDER BY EquipmentCode";

                using (var cmd = new SqlCommand(sql, conn))
                using (var reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        machines.Add(new MachineInfo
                        {
                            EquipmentCode = reader["EquipmentCode"].ToString(),
                            EquipmentName = reader["EquipmentName"].ToString(),
                            EquipmentIP = reader["EquipmentIP"]?.ToString() ?? "",
                            EquipmentPort = reader["EquipmentPort"]?.ToString() ?? "",
                            Status = Convert.ToInt32(reader["Status"]),
                            InjectionStatus = Convert.ToInt32(reader["InjectionStatus"]),
                            Brand = reader["Brand"]?.ToString() ?? ""
                        });
                    }
                }
            }

            return machines;
        }

        /// <summary>
        /// 获取恩格尔机器列表
        /// </summary>
        private List<string> GetEngelMachines()
        {
            var machines = new List<string>();
            string basePath = @"C:\Engel\Euromap63\System\Access\MACHINES";

            if (Directory.Exists(basePath))
            {
                foreach (var dir in Directory.GetDirectories(basePath))
                {
                    string machineCode = Path.GetFileName(dir);
                    if (machineCode != "machine.sta")
                        machines.Add(machineCode);
                }
            }

            return machines;
        }

        /// <summary>
        /// 检查是否是恩格尔机器
        /// </summary>
        private bool IsEngelMachine(string equipmentCode)
        {
            string path = $@"C:\Engel\Euromap63\System\Access\MACHINES\{equipmentCode}";
            return Directory.Exists(path);
        }

        /// <summary>
        /// 保存测试报告
        /// </summary>
        private void SaveReport(List<TestResult> results)
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("Injection Machine Test Report");
            sb.AppendLine($"Time: {DateTime.Now:yyyy-MM-dd HH:mm:ss}");
            sb.AppendLine($"Database: {connString.Split(';')[0]}");
            sb.AppendLine();
            sb.AppendLine("=".PadRight(60));
            sb.AppendLine($"{"Code",-6} {"Name",-15} {"Status",-12} {"Protocol",-20} {"Message"}");
            sb.AppendLine("=".PadRight(60));

            foreach (var r in results)
            {
                sb.AppendLine($"{r.MachineCode,-6} {r.MachineName,-15} {r.StatusText,-12} {r.Protocol,-20} {r.Message}");
            }

            sb.AppendLine("=".PadRight(60));
            sb.AppendLine($"Total: {results.Count}");
            sb.AppendLine($"Online: {results.FindAll(r => r.IsOnline).Count}");
            sb.AppendLine($"Offline: {results.FindAll(r => !r.IsOnline).Count}");

            File.WriteAllText(logFile, sb.ToString());
            Console.WriteLine();
            Console.WriteLine($"Report saved to: {logFile}");
        }
    }

    public class TestResult
    {
        public string MachineCode { get; set; }
        public string MachineName { get; set; }
        public bool IsOnline { get; set; }
        public bool IsEngel { get; set; }
        public string StatusText { get; set; }
        public string Protocol { get; set; }
        public string Message { get; set; }
    }
}
