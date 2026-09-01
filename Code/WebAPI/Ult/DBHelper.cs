using Dapper;
using SKT.Common.DAL.Marshal;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace WebAPI.Ult
{
    /// <summary>
    /// 
    /// </summary>
    public class DBHelper
    {
        #region Dapper

        /// <summary>
        /// MES库连接字符串
        /// </summary>
        public static readonly string MESConnString = SQLHelper.MESConnString;

        /// <summary>
        /// 打开链接
        /// </summary>
        /// <param name="ec"></param>
        /// <returns></returns>
        public static IDbConnection GetConnection()
        {
            IDbConnection connection = new SqlConnection(MESConnString);
            connection.Open();
            return connection;
        }

        /// <summary>
        /// 获取数据集合
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql"></param>
        /// <param name="param"></param>
        /// <param name="enumConn">链接的数据库</param>
        /// <returns></returns>
        public static IList<T> GetList<T>(string sql, object param = null, int? commandTimeout = default(int?), CommandType? commandType = null) where T : new()
        {
            using (var conn = GetConnection())
            {
                return conn.Query<T>(sql, param, null, true, commandTimeout, commandType).ToList();
            }
        }

        /// <summary>
        /// 获取数据集合
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql"></param>
        /// <param name="param"></param>
        /// <param name="enumConn">链接的数据库</param>
        /// <returns></returns>
        public static dynamic GetList(string sql, object param = null, int? commandTimeout = default(int?), CommandType? commandType = null)
        {
            using (var conn = GetConnection())
            {
                return conn.Query(sql, param, null, true, commandTimeout, commandType).ToList();
            }
        }

        /// <summary>
        /// 获取数据实体
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql"></param>
        /// <param name="param"></param>
        /// <param name="ec"></param>
        /// <returns></returns>
        public static T Get<T>(string sql, object param, int? commandTimeout = default(int?), CommandType? commandType = null) where T : new()
        {
            using (var conn = GetConnection())
            {
                return conn.QueryFirstOrDefault<T>(sql, param, null, commandTimeout, commandType);
            }
        }

        /// <summary>
        /// 插入或者更新数据（支持批量处理）（带事务执行）
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql">INSERT OR UPDATE 语句</param>
        /// <param name="param">要插入或者更新的数据集</param>
        /// <param name="ec"></param>
        /// <returns></returns>
        public static int ExecuteTran(string sql, object param = null)
        {
            var rows = -1;
            using (var conn = GetConnection())
            {
                var tran = conn.BeginTransaction();
                rows = conn.Execute(sql, param, transaction: tran);
                tran.Commit();
            }
            return rows;
        }

        /// <summary>
        /// 执行SQL语句或者存储过程
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql">CRUD 语句 或者 存储过程名</param>
        /// <param name="param">参数（如果是批量新增或者更新，可以传入List集合）</param>
        /// <param name="ec"></param>
        /// <returns></returns>
        public static int Execute(string sql, object param = null, int? commandTimeout = null, CommandType? commandType = null)
        {
            var rows = -1;
            using (var conn = GetConnection())
            {
                rows = conn.Execute(sql, param, null, commandTimeout, commandType);
            }
            return rows;
        }

        #endregion
    }
}
