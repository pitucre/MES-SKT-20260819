using log4net;
using log4net.Appender;
using log4net.Config;
using System;
using System.IO;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    /// <summary>
    /// Log4Net日志记录辅助类
    /// </summary>
    public class Log4Helper
    {
        private static readonly ILog Log;

        static Log4Helper()
        {
            XmlConfigurator.ConfigureAndWatch(new FileInfo(AppDomain.CurrentDomain.BaseDirectory + "Log4net.config"));
            Log = LogManager.GetLogger(typeof(Log4Helper));
        }
        /// <summary>
        /// 记录调试信息
        /// </summary>
        /// <param name="message">信息</param>
        public static void Debug(object message)
        {
            Log.Debug(message);
        }

        /// <summary>
        /// 记录警告信息
        /// </summary>
        /// <param name="message">信息</param>
        public static void Warn(object message)
        {
            Log.Warn(message);
        }

        /// <summary>
        /// 记录错误信息
        /// </summary>
        /// <param name="message">信息</param>
        public static void Error(object message)
        {
            Log.Error(message);
        }

        /// <summary>
        /// 记录重要提示信息
        /// </summary>
        /// <param name="message">信息</param>
        public static void Info(object message)
        {
            Log.Info(message);
        }

        /// <summary>
        /// 记录信息和异常信息
        /// </summary>
        /// <param name="message">错误信息</param>
        /// <param name="ex">异常对象</param>
        public static void Debug(object message, Exception ex)
        {
            Log.Debug(message, ex);
        }

        /// <summary>
        /// 记录信息和异常信息
        /// </summary>
        /// <param name="message">错误信息</param>
        /// <param name="ex">异常对象</param>
        public static void Warn(object message, Exception ex)
        {
            Log.Warn(message, ex);
        }

        /// <summary>
        /// 记录信息和异常信息
        /// </summary>
        /// <param name="message">错误信息</param>
        /// <param name="ex">异常对象</param>
        public static void Error(object message, Exception ex)
        {
            Log.Error(message, ex);
        }

        /// <summary>
        /// 记录信息和异常信息
        /// </summary>
        /// <param name="message">错误信息</param>
        /// <param name="ex">异常对象</param>
        public static void Info(object message, Exception ex)
        {
            Log.Info(message, ex);
        }
    }

    public class MinimalLockDeleteEmpty : FileAppender.MinimalLock
    {
        public override void ReleaseLock()
        {
            base.ReleaseLock();

            var logFile = new FileInfo(CurrentAppender.File);
            if (logFile.Exists && logFile.Length <= 0)
            {
                logFile.Delete();
            }
        }
    }
}