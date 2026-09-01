using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 日志
    /// </summary>
    public class NLogLogInfo
    {
        /// <summary>
        /// LogId
        /// </summary>
        public int LogId { get; set; }

        /// <summary>
        /// CreateDate
        /// </summary>
        public string CreateDate { get; set; }

        /// <summary>
        /// Origin
        /// </summary>
        public string Origin { get; set; }

        /// <summary>
        /// LogLevel
        /// </summary>
        public string LogLevel { get; set; }

        /// <summary>
        /// Message
        /// </summary>
        public string Message { get; set; }

        /// <summary>
        /// Exception
        /// </summary>
        public string Exception { get; set; }

        /// <summary>
        /// StackTrace
        /// </summary>
        public string StackTrace { get; set; }
    }
}