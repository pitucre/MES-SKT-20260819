using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    /// <summary>
    /// 日志操作类
    /// </summary>
    public class WriteLog
    {
        static string userid = "";
        static string TableName = "SDP_Log";
        public WriteLog()
        {

        }
        public static void ToTable(string msg, bool status, int type)
        {
            string sql = "INSERT INTO dbo.SDP_Log VALUES()";

        }
        public static void ToShow(string msg, bool status)
        {

        }
        public static void ToXml(string msg, bool status)
        {

        }
        public static void ToTxt(string msg, bool status)
        {

        }
    }
}
