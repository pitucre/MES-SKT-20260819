using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LeanMES.OrderControl.Utility
{
    /// <summary>
    /// 日志工具类
    /// </summary>
    public static class Logger
    {
        private static readonly object _lockObj = new object();
        private static string _logDirectory = string.Empty;

        /// <summary>
        /// 日志目录
        /// </summary>
        public static string LogDirectory
        {
            get
            {
                if (string.IsNullOrEmpty(_logDirectory))
                {
                    _logDirectory = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Logs");
                    if (!Directory.Exists(_logDirectory))
                    {
                        Directory.CreateDirectory(_logDirectory);
                    }
                }
                return _logDirectory;
            }
            set { _logDirectory = value; }
        }

        /// <summary>
        /// 写入信息日志
        /// </summary>
        public static void Write(string message)
        {
            Write(message, true);
        }

        /// <summary>
        /// 写入日志
        /// </summary>
        /// <param name="message">日志内容</param>
        /// <param name="isInfo">true=信息日志, false=错误日志</param>
        public static void Write(string message, bool isInfo)
        {
            try
            {
                string logType = isInfo ? "INFO" : "ERROR";
                string logFile = Path.Combine(LogDirectory, $"{DateTime.Now:yyyy-MM-dd}.log");
                string logMessage = $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss.fff}] [{logType}] {message}";

                lock (_lockObj)
                {
                    using (StreamWriter sw = new StreamWriter(logFile, true, Encoding.UTF8))
                    {
                        sw.WriteLine(logMessage);
                    }
                }

                // 同时输出到控制台
                if (isInfo)
                {
                    Console.ForegroundColor = ConsoleColor.White;
                }
                else
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                }
                Console.WriteLine(logMessage);
                Console.ResetColor();
            }
            catch (Exception ex)
            {
                // 日志写入失败时，避免影响主程序运行
                Console.WriteLine($"日志写入失败: {ex.Message}");
            }
        }

        /// <summary>
        /// 清理过期日志文件
        /// </summary>
        /// <param name="keepDays">保留天数</param>
        public static void CleanOldLogs(int keepDays = 30)
        {
            try
            {
                DirectoryInfo dirInfo = new DirectoryInfo(LogDirectory);
                FileInfo[] files = dirInfo.GetFiles("*.log");

                DateTime cutoffDate = DateTime.Now.AddDays(-keepDays);

                foreach (FileInfo file in files)
                {
                    if (file.LastWriteTime < cutoffDate)
                    {
                        file.Delete();
                    }
                }
            }
            catch (Exception ex)
            {
                Write($"清理过期日志失败: {ex.Message}", false);
            }
        }
    }
}
