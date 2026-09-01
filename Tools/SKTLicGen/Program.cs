using System;
using System.IO;
using System.Reflection;
using System.Runtime.Serialization.Formatters.Binary;

namespace SKTLicGen
{
    /// <summary>
    /// 基于本机硬件信息生成合法的 SKTLicense.cer 认证文件。
    /// 依赖 System.Web.Engine.dll（LeanMES Web 根目录 bin 下），调用其公开方法完成
    /// License 对象创建、硬件锁定、Rijndael 加密（LicenseFormat.FormatLicense）。
    /// </summary>
    class Program
    {
        static Assembly _engine;
        static Type _licenseType;
        static Type _securityType;
        static Type _formatType;
        static Type _lockKeyType;
        static Type _hardwareType;

        static void Main(string[] args)
        {
            Console.WriteLine("=== LeanMES SKTLicense.cer 生成器 ===\n");

            string engineDll = FindEngineDll(args);
            string outPath = GetArg(args, "--out", "SKTLicense.cer");
            string customer = GetArg(args, "--customer", "LeanMES Dev");
            string system = GetArg(args, "--system", "LeanMES");
            string version = GetArg(args, "--version", "8.5");
            string line = GetArg(args, "--line", "200");
            string user = GetArg(args, "--user", "2000");
            string expire = GetArg(args, "--expire", "2099-12-31");
            string service = GetArg(args, "--service", DateTime.Now.ToString("yyyy-MM-dd"));
            string argCpu = GetArg(args, "--cpu", null);
            string argMac = GetArg(args, "--mac", null);
            string argDisk = GetArg(args, "--disk", null);

            if (engineDll == null)
            {
                Console.WriteLine("[错误] 未找到 System.Web.Engine.dll，程序无法运行！");
                Console.WriteLine();
                Console.WriteLine("原因：本工具依赖 LeanMES 引擎 DLL 才能完成 License 加密与硬件读取，");
                Console.WriteLine("      它不是独立可执行程序，必须带引擎一起拷走。");
                Console.WriteLine();
                Console.WriteLine("解决办法（任选其一）：");
                Console.WriteLine("  1) 把下面的文件拷到目标电脑，放同一目录后运行：");
                Console.WriteLine("       SKTLicGen.exe");
                Console.WriteLine("       System.Web.Engine.dll  （来自 Code\\Web\\bin\\ 或 Code\\Lib\\）");
                Console.WriteLine("  2) 或用 --dll 直接指定引擎 DLL 路径：");
                Console.WriteLine("       SKTLicGen.exe --dll \"D:\\xxx\\System.Web.Engine.dll\"");
                return;
            }

            try
            {
                _engine = Assembly.LoadFrom(engineDll);
                // 让 BinaryFormatter 反序列化能解析 System.Web.Engine 程序集
                AppDomain.CurrentDomain.AssemblyResolve += ResolveEngine;

                _licenseType = _engine.GetType("Systems.Web.License");
                _securityType = _engine.GetType("Systems.Web.Security");
                _formatType = _engine.GetType("Systems.Web.LicenseFormat");
                _lockKeyType = _engine.GetType("Systems.Web.LockKey");
                _hardwareType = _engine.GetType("Systems.Web.Hardware");

                Console.WriteLine("引擎: " + _engine.FullName);
                Console.WriteLine();

                // 1. 硬件信息：默认读取本机；若指定 --cpu/--mac/--disk 则用指定值（给其他机器远程发授权）
                string cpu, mac, disk;
                bool remote = argCpu != null || argMac != null || argDisk != null;
                if (remote)
                {
                    cpu = argCpu ?? "";
                    mac = argMac ?? "";
                    disk = argDisk ?? "";
                    Console.WriteLine("远程授权模式：使用指定的硬件指纹（未指定项留空）。");
                    Console.WriteLine("  CPU  : " + cpu);
                    Console.WriteLine("  MAC  : " + mac);
                    Console.WriteLine("  DISK : " + disk);
                    Console.WriteLine();
                    if (string.IsNullOrEmpty(cpu) || string.IsNullOrEmpty(mac) || string.IsNullOrEmpty(disk))
                    {
                        Console.WriteLine("[提示] 校验要求 Machine 包含目标机的 CPU+MAC+磁盘，缺项可能导致目标机校验失败。");
                        Console.WriteLine();
                    }
                }
                else
                {
                    GetHardwareString(out cpu, out mac, out disk);
                    Console.WriteLine("本机模式：");
                    Console.WriteLine("  CPU  : " + cpu);
                    Console.WriteLine("  MAC  : " + mac);
                    Console.WriteLine("  DISK : " + disk);
                    Console.WriteLine();
                }

                // 2. 构造 License 对象
                object lic = BuildLicense(customer, system, version, line, user, expire, service, cpu + mac + disk);

                // 3. 序列化为二进制流
                string tmp = Path.Combine(Path.GetTempPath(), "license_" + Guid.NewGuid().ToString("N") + ".bin");
                using (FileStream fs = new FileStream(tmp, FileMode.Create))
                {
                    new BinaryFormatter().Serialize(fs, lic);
                }
                Console.WriteLine("序列化临时文件: " + tmp + " (" + new FileInfo(tmp).Length + " B)");

                // 4. 使用 LicenseFormat.FormatLicense 加密生成 .cer
                string password = (string)_lockKeyType.GetMethod("GetLicLockKey").Invoke(null, null);
                _formatType.GetMethod("FormatLicense").Invoke(null, new object[] { tmp, outPath, password });
                File.Delete(tmp);

                Console.WriteLine();
                Console.WriteLine("已生成: " + Path.GetFullPath(outPath) + " (" + new FileInfo(outPath).Length + " B)");

                // 5. 自校验：用引擎的 GetLicense 读回，验证有效
                bool ok = VerifyLicense(Path.GetFullPath(outPath));
                Console.WriteLine();
                Console.WriteLine(ok ? "[成功] License 校验通过！" : "[失败] License 校验未通过！");
                Console.WriteLine("将生成的 SKTLicense.cer 放到 Web 站点根目录即可（如 E:\\source\\MES\\SKT\\20260819\\Code\\Web\\）。");
            }
            catch (Exception ex)
            {
                Console.WriteLine("[错误] " + ex.ToString());
            }
        }

        // ---------- 硬件信息 ----------
        static void GetHardwareString(out string cpu, out string mac, out string disk)
        {
            object hw = _hardwareType.GetMethod("Instance").Invoke(null, null);
            cpu = (string)_hardwareType.GetMethod("GetCpuID").Invoke(hw, null);
            mac = (string)_hardwareType.GetMethod("GetMacAddress").Invoke(hw, null);
            disk = (string)_hardwareType.GetMethod("GetDiskID").Invoke(hw, null);
        }

        // ---------- License 构造 ----------
        static object BuildLicense(string customer, string system, string version, string line, string user, string expire, string service, string machinePlain)
        {
            object lic = Activator.CreateInstance(_licenseType);
            _licenseType.GetField("Customer").SetValue(lic, customer);
            _licenseType.GetField("System").SetValue(lic, system);
            _licenseType.GetField("Version").SetValue(lic, version);
            _licenseType.GetField("Line").SetValue(lic, Lock(line));
            _licenseType.GetField("User").SetValue(lic, Lock(user));
            _licenseType.GetField("Machine").SetValue(lic, Lock(machinePlain));
            _licenseType.GetField("ExpiredTime").SetValue(lic, Lock(expire));
            _licenseType.GetField("ServiceTime").SetValue(lic, Lock(service));
            _licenseType.GetField("CreateTime").SetValue(lic, Lock(service));
            _licenseType.GetField("ExtendAttr").SetValue(lic, "");
            return lic;
        }

        static string Lock(string s)
        {
            return (string)_securityType.GetMethod("Lock", new Type[] { typeof(string) }).Invoke(null, new object[] { s });
        }

        // ---------- 校验 ----------
        static bool VerifyLicense(string path)
        {
            // 说明：Security.GetLicense 内部会把路径中的 "License" 替换为 "Cer" 作为解密目标临时文件名，
            // 与站点运行逻辑耦合，不易独立验证。这里直接复用引擎的 DeFormatLicense + 反序列化进行验证，
            // 与 GetLicense 的实际解密路径完全一致。
            try
            {
                string password = (string)_lockKeyType.GetMethod("GetLicLockKey").Invoke(null, null);
                string tmp = Path.Combine(Path.GetTempPath(), "license_verify_" + Guid.NewGuid().ToString("N") + ".bin");
                _formatType.GetMethod("DeFormatLicense").Invoke(null, new object[] { path, tmp, password });
                object lic;
                using (FileStream fs = File.OpenRead(tmp))
                {
                    lic = new BinaryFormatter().Deserialize(fs);
                }
                File.Delete(tmp);
                foreach (var f in _licenseType.GetFields())
                    Console.WriteLine("  " + f.Name + " = [" + f.GetValue(lic) + "]");
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("  校验异常: " + ex);
                return false;
            }
        }

        // ---------- 工具 ----------
        static Assembly ResolveEngine(object sender, ResolveEventArgs e)
        {
            if (e.Name.StartsWith("System.Web.Engine"))
                return _engine;
            return null;
        }

        static string FindEngineDll(string[] args)
        {
            string dll = GetArg(args, "--dll", null);
            if (dll != null && File.Exists(dll)) return Path.GetFullPath(dll);

            // 从当前目录向上/向下多级搜索，覆盖常见部署位置
            string cur = Environment.CurrentDirectory;
            string[] candidates = {
                Path.Combine(cur, "System.Web.Engine.dll"),
                Path.Combine(cur, "bin", "System.Web.Engine.dll"),
                Path.Combine(cur, "..", "bin", "System.Web.Engine.dll"),
                Path.Combine(cur, "..", "..", "bin", "System.Web.Engine.dll"),
                Path.Combine(cur, "..", "..", "..", "bin", "System.Web.Engine.dll"),
                @"E:\source\MES\SKT\20260819\Code\Web\bin\System.Web.Engine.dll",
                @"E:\source\MES\SKT\20260819\Code\Lib\System.Web.Engine.dll"
            };
            foreach (var c in candidates)
                if (File.Exists(c)) return c;
            return null;
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
