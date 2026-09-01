using SKT.Common.DAL.Marshal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using Dapper;

namespace SKT.LeanMES.ERP
{
    public class DBHelper
    {
        /// <summary>
        /// 打开链接
        /// </summary>
        /// <param name="ec"></param>
        /// <returns></returns>
        public static IDbConnection GetConnection()
        {
            IDbConnection connection = new SqlConnection() { ConnectionString = SQLHelper.MESConnString };
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
        public static IList<T> GetList<T>(string sql, object param = null) where T : new()
        {
            using (var conn = GetConnection())
            {
                return conn.Query<T>(sql, param).ToList();
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
        public static T Get<T>(string sql, object param) where T : new()
        {
            using (var conn = GetConnection())
            {
                return conn.QueryFirstOrDefault<T>(sql, param);
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
        /// 插入或者更新数据（支持批量处理）
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql">INSERT OR UPDATE 语句</param>
        /// <param name="param">要插入或者更新的数据集</param>
        /// <param name="ec"></param>
        /// <returns></returns>
        public static int Execute(string sql, object param = null)
        {
            var rows = -1;
            using (var conn = GetConnection())
            {
                rows = conn.Execute(sql, param);
            }
            return rows;
        }


        /// <summary>
        /// 获取首行首列数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql">INSERT OR UPDATE 语句</param>
        /// <param name="param">要插入或者更新的数据集</param>
        /// <param name="ec"></param>
        /// <returns></returns>
        public static object ExecuteScalar(string sql, object param = null)
        {
            dynamic obj = null;
            using (var conn = GetConnection())
            {
                obj = conn.ExecuteScalar(sql, param);
            }
            return obj;
        }


    }
}
