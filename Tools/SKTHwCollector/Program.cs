using System;
using System.IO;
using System.Reflection;
using System.Text;

namespace SKTHwCollector
{
    /// <summary>
    /// LeanMES 硬件信息收集工具。
    /// 优先加载 System.Web.Engine.dll 读取硬件（与校验端格式完全一致），
    /// 未找到引擎时回退 WMI。输出 hwinfo.txt 供 SKTLicGen 生成授权证书。
    /// </summary>
    class Program
    {
        static Assembly _engine;
        static Type _hardwareType;

        static void Main(string[] args)
        {
            try { Console.OutputEncoding = Encoding.UTF8; } catch { }
            Console.WriteLine("========================================");
            Console.WriteLine("  LeanMES 硬件信息收集工具 v2.1");
            Console.WriteLine("========================================");
            Console.WriteLine();

            string cpu, mac, disk;
            string engineDll = FindEngineDll(args);
            bool useEngine = false;

            if (engineDll != null)
            {
                try
                {
                    _engine = Assembly.LoadFrom(engineDll);
                    _hardwareType = _engine.GetType("Systems.Web.Hardware");
                    object hw = _hardwareType.GetMethod("Instance").Invoke(null, null);
                    cpu = (string)_hardwareType.GetMethod("GetCpuID").Invoke(hw, null);
                    mac = (string)_hardwareType.GetMethod("GetMacAddress").Invoke(hw, null);
                    disk = (string)_hardwareType.GetMethod("GetDiskID").Invoke(hw, null);
                    useEngine = true;
                    Console.WriteLine("硬件读取: 引擎模式（格式与校验端一致）");
                    Console.WriteLine("引擎: " + Path.GetFileName(engineDll));
                }
                catch (Exception ex)
                {
                    Console.WriteLine("[警告] 引擎读取失败，改用 WMI: " + ex.Message);
                    cpu = mac = disk = "";
                }
            }
            else
            {
                Console.WriteLine("硬件读取: WMI 模式（未找到 System.Web.Engine.dll）");
                cpu = GetCpuID();
                mac = GetMacAddress();
                disk = GetDiskSerial();
            }

            string computerName = Environment.MachineName;
            string osVersion = Environment.OSVersion.ToString();

            Console.WriteLine("计算机名    : " + computerName);
            Console.WriteLine("操作系统    : " + osVersion);
            Console.WriteLine();
            Console.WriteLine("--- 硬件指纹 ---");
            Console.WriteLine("CPU ID      : " + cpu);
            Console.WriteLine("MAC 地址    : " + mac);
            Console.WriteLine("磁盘信息    : " + disk);
            Console.WriteLine();

            string machine = cpu + mac + disk;
            Console.WriteLine("--- Machine（拼接后）---");
            Console.WriteLine(machine);
            Console.WriteLine();

            string cmd = string.Format(
                "SKTLicGen.exe --out \"SKTLicense.cer\" --cpu \"{0}\" --mac \"{1}\" --disk \"{2}\"",
                cpu, mac, disk);
            Console.WriteLine("--- SKTLicGen 命令行 ---");
            Console.WriteLine(cmd);
            Console.WriteLine();

            if (string.IsNullOrEmpty(cpu) || string.IsNullOrEmpty(mac) || string.IsNullOrEmpty(disk))
            {
                Console.WriteLine("[警告] 硬件信息不完整，授权可能校验失败！");
                Console.WriteLine();
            }

            // 保存到文件
            string outPath = GetArg(args, "--out", "hwinfo.txt");
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("# LeanMES 硬件信息 - " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            sb.AppendLine("# 计算机名: " + computerName);
            sb.AppendLine("# 操作系统: " + osVersion);
            sb.AppendLine("# 读取方式: " + (useEngine ? "Engine" : "WMI"));
            sb.AppendLine();
            sb.AppendLine("CPU=" + cpu);
            sb.AppendLine("MAC=" + mac);
            sb.AppendLine("DISK=" + disk);
            sb.AppendLine("MACHINE=" + machine);
            sb.AppendLine();
            sb.AppendLine("# SKTLicGen 命令行:");
            sb.AppendLine("# " + cmd);

            File.WriteAllText(outPath, sb.ToString(), Encoding.UTF8);
            Console.WriteLine("已保存到: " + Path.GetFullPath(outPath));

            // 复制到剪贴板
            try
            {
                if (Array.Exists(args, a => a.Equals("--clip", StringComparison.OrdinalIgnoreCase)))
                {
                    if (Type.GetType("System.Windows.Forms.Clipboard") != null ||
                        File.Exists(Path.Combine(Path.GetDirectoryName(typeof(Program).Assembly.Location) ?? "", "System.Windows.Forms.dll")))
                    {
                        // 可选，不强依赖
                    }
                    Console.WriteLine("命令行: " + cmd);
                }
            }
            catch { }

            Console.WriteLine();
            Console.WriteLine("请将 hwinfo.txt 文件发送给系统管理员，用于生成授权证书。");
            SafeReadKey();
        }

        static void SafeReadKey()
        {
            try
            {
                if (!Console.IsInputRedirected && Environment.UserInteractive)
                {
                    Console.WriteLine("按任意键退出...");
                    Console.ReadKey(true);
                }
            }
            catch { }
        }

        // ---------- 引擎查找 ----------
        static string FindEngineDll(string[] args)
        {
            string dll = GetArg(args, "--dll", null);
            if (dll != null && File.Exists(dll)) return Path.GetFullPath(dll);

            string cur = Environment.CurrentDirectory;
            string exeDir = AppDomain.CurrentDomain.BaseDirectory;
            string[] candidates = {
                Path.Combine(exeDir, "System.Web.Engine.dll"),
                Path.Combine(cur, "System.Web.Engine.dll"),
                Path.Combine(exeDir, "bin", "System.Web.Engine.dll"),
                Path.Combine(cur, "bin", "System.Web.Engine.dll"),
                Path.Combine(exeDir, "..", "System.Web.Engine.dll"),
                Path.Combine(cur, "..", "System.Web.Engine.dll"),
                Path.Combine(exeDir, "..", "SKTLicGen", "System.Web.Engine.dll"),
                @"E:\source\MES\SKT\20260819\Code\Web\bin\System.Web.Engine.dll",
                @"E:\source\MES\SKT\20260819\Code\Lib\System.Web.Engine.dll"
            };
            foreach (var c in candidates)
                if (File.Exists(c)) return Path.GetFullPath(c);
            return null;
        }

        // ---------- WMI 回退 ----------
        static string GetCpuID()
        {
            try
            {
                using (var searcher = new System.Management.ManagementObjectSearcher("SELECT ProcessorId FROM Win32_Processor"))
                {
                    foreach (var obj in searcher.Get())
                    {
                        string id = obj["ProcessorId"]?.ToString()?.Trim();
                        if (!string.IsNullOrEmpty(id)) return id;
                    }
                }
            }
            catch { }
            return "";
        }

        static string GetMacAddress()
        {
            try
            {
                foreach (var nic in System.Net.NetworkInformation.NetworkInterface.GetAllNetworkInterfaces())
                {
                    if (nic.OperationalStatus == System.Net.NetworkInformation.OperationalStatus.Up &&
                        nic.NetworkInterfaceType != System.Net.NetworkInformation.NetworkInterfaceType.Loopback &&
                        nic.NetworkInterfaceType != System.Net.NetworkInformation.NetworkInterfaceType.Tunnel)
                    {
                        byte[] bytes = nic.GetPhysicalAddress().GetAddressBytes();
                        if (bytes.Length == 6 && !IsAllZero(bytes))
                            return string.Join(":", Array.ConvertAll(bytes, b => b.ToString("X2")));
                    }
                }
            }
            catch { }
            return "";
        }

        static string GetDiskSerial()
        {
            try
            {
                using (var searcher = new System.Management.ManagementObjectSearcher("SELECT Model, SerialNumber FROM Win32_DiskDrive"))
                {
                    foreach (var obj in searcher.Get())
                    {
                        // 优先 Model（与引擎格式接近），其次 SerialNumber
                        string model = obj["Model"]?.ToString()?.Trim();
                        if (!string.IsNullOrEmpty(model)) return model;
                        string serial = obj["SerialNumber"]?.ToString()?.Trim();
                        if (!string.IsNullOrEmpty(serial)) return serial;
                    }
                }
            }
            catch { }
            return "";
        }

        static bool IsAllZero(byte[] bytes)
        {
            foreach (var b in bytes)
                if (b != 0) return false;
            return true;
        }

        static string GetArg(string[] args, string key, string def)
        {
            for (int i = 0; i < args.Length - 1; i++)
                if (string.Equals(args[i], key, StringComparison.OrdinalIgnoreCase))
                    return args[i + 1];
            return def;
        }
    }
}
