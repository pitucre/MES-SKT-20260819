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
    /// 注塑机真实状态检测工具类
    /// </summary>
    public class StatusChecker
    {
        private string connString;

        public StatusChecker()
        {
            connString = ConfigurationManager.ConnectionStrings["MESConnString"]?.ConnectionString
                ?? ConfigurationManager.AppSettings["MESConnString"];
        }

        /// <summary>
        /// 执行检测并生成JSON文件
        /// </summary>
        public async Task<string> CheckAndSave()
        {
            Console.WriteLine("Starting machine status check...");

            var machines = await GetMachinesFromDB();
            Console.WriteLine($"Found {machines.Count} injection machines");

            // 并行检测所有设备
            var tasks = new List<Task>();
            foreach (var machine in machines)
            {
                tasks.Add(Task.Run(async () =>
                {
                    machine.IsOnline = await CheckTcpConnection(machine.EquipmentIP, machine.EquipmentPort);
                    Console.WriteLine($"  [{machine.EquipmentCode}] {machine.EquipmentName}: {(machine.IsOnline ? "ONLINE" : "OFFLINE")}");
                }));
            }
            await Task.WhenAll(tasks);

            // 生成JSON
            int online = machines.FindAll(m => m.IsOnline).Count;
            var json = new System.Text.StringBuilder();
            json.AppendLine("{");
            json.AppendLine($"  \"timestamp\": \"{DateTime.Now:yyyy-MM-dd HH:mm:ss}\",");
            json.AppendLine($"  \"total\": {machines.Count},");
            json.AppendLine($"  \"online\": {online},");
            json.AppendLine($"  \"offline\": {machines.Count - online},");
            json.AppendLine("  \"data\": [");

            for (int i = 0; i < machines.Count; i++)
            {
                var m = machines[i];
                string status = "no_config";
                if (!string.IsNullOrEmpty(m.EquipmentIP) && !string.IsNullOrEmpty(m.EquipmentPort))
                    status = m.IsOnline ? "online" : "offline";

                json.AppendLine("    {");
                json.AppendLine($"      \"code\": \"{m.EquipmentCode}\",");
                json.AppendLine($"      \"name\": \"{m.EquipmentName}\",");
                json.AppendLine($"      \"ip\": \"{m.EquipmentIP}\",");
                json.AppendLine($"      \"port\": \"{m.EquipmentPort}\",");
                json.AppendLine($"      \"status\": \"{status}\",");
                json.AppendLine($"      \"mesStatus\": {m.Status},");
                json.AppendLine($"      \"runStatus\": {m.InjectionStatus}");
                json.AppendLine($"    }}{(i < machines.Count - 1 ? "," : "")}");
            }

            json.AppendLine("  ]");
            json.AppendLine("}");

            string path = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "status.json");
            File.WriteAllText(path, json.ToString());
            Console.WriteLine($"JSON saved to: {path}");

            return path;
        }

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

        private async Task<bool> CheckTcpConnection(string ip, string port)
        {
            if (string.IsNullOrEmpty(ip) || string.IsNullOrEmpty(port))
                return false;

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
    }

    public class MachineInfo
    {
        public string EquipmentCode { get; set; }
        public string EquipmentName { get; set; }
        public string EquipmentIP { get; set; }
        public string EquipmentPort { get; set; }
        public int Status { get; set; }
        public int InjectionStatus { get; set; }
        public string Brand { get; set; }
        public bool IsOnline { get; set; }
    }
}
