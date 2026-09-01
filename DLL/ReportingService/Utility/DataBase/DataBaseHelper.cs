using System;
using System.Configuration;
using System.Data;
using Microsoft.ApplicationBlocks.Data;
using SKT.Common.Utility;
using SKT.MES.ReportingService.Utility.Common.Helpers;

namespace SKT.MES.ReportingService.Utility.DataBase
{
    /// <summary>
    /// 数据库帮助程序
    /// </summary>
    public class DataBaseHelper
    {
        /// <summary>
        /// 数据库连接字符串
        /// </summary>
        public static readonly string connectionstring;

        /// <summary>
        /// 构造函数、初始化
        /// </summary>
        static DataBaseHelper()
        {
            //DataBaseHelper.connectionstring = "";
            var connStr = string.Empty;
            if (string.Equals(ConfigurationManager.AppSettings["ConnStringEncrypt"], "true", StringComparison.CurrentCultureIgnoreCase))
            {
                connStr = EncryptHelper.Decrypt(ConfigurationManager.AppSettings["ReportConnString"].ToString());
            }
            else
            {
                connStr = ConfigurationManager.AppSettings["ReportConnString"].ToString();
            }
            DataBaseHelper.connectionstring = connStr;
        }

        /// <summary>
        /// 执行指定sql,返回DataSet.
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        public static DataSet GetDataSet(string sql)
        {
            return SqlHelper.ExecuteDataset(DataBaseHelper.connectionstring, CommandType.Text, sql);
        }

        /// <summary>
        /// 执行指定sql,返回DataTable.
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        public static DataTable GetDataTable(string sql)
        {
            DataSet dataSet = DataBaseHelper.GetDataSet(sql);
            DataTable result;
            if (dataSet.Tables.Count == 0)
            {
                result = null;
            }
            else
            {
                result = dataSet.Tables[0];
            }
            return result;
        }

        /// <summary>
        /// 执行指定sql,返回受影响行数
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        public static int ExecuteNonQuery(string sql)
        {
            return SqlHelper.ExecuteNonQuery(DataBaseHelper.connectionstring, CommandType.Text, sql);
        }

        /// <summary>
        /// 执行指定sql,判断是否存在
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        public static bool Has(string sql)
        {
            object obj = SqlHelper.ExecuteScalar(DataBaseHelper.connectionstring, CommandType.Text, sql);
            return obj != null && !Convert.IsDBNull(obj) && CommonHelper.ObjToInt(obj) != 0;
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        public DataBaseHelper()
        {
        }
    }
}
