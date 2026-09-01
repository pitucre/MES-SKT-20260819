/*-------------------------------------------------
// Copyright(C)2016 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:Helper.cs
// 文件功能描述：用于实现一些通用的方法，比如：SqlDataReader转换List等
// 
// 创建标识：Larry.Lin 2016/07/27
// 
// 
//--------------------------------------------------*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Reflection;

namespace SKT.LeanMES.ProductionCollection.Utility
{
    class Helper
    {
        /// <summary>
        /// SqlDataReader转换List方法
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sdr">SqlDataReader</param>
        /// <returns></returns>
        public static List<T> SqlDataReaderConverToList<T>(SqlDataReader sdr) where T : new()
        {
            List<T> list;
            Type type = typeof(T);
            string tempName = string.Empty;
            if (sdr.HasRows)
            {
                list = new List<T>();
                while (sdr.Read())
                {
                    T t = new T();
                    PropertyInfo[] propertys = t.GetType().GetProperties();
                    foreach (PropertyInfo pi in propertys)
                    {
                        tempName = pi.Name;
                        if (readerExists(sdr, tempName))
                        {
                            if (!pi.CanWrite)
                            {
                                continue;
                            }
                            var value = sdr[tempName];

                            if (value != DBNull.Value)
                            {
                                pi.SetValue(t, value, null);
                            }

                        }

                    }

                    list.Add(t);
                }
                return list;
            }
            return null;

        }

        /// <summary>  
        /// 判断SqlDataReader是否存在某列  
        /// </summary>  
        /// <param name="dr">SqlDataReader</param>  
        /// <param name="columnName">列名</param>  
        /// <returns></returns>  
        private static bool readerExists(SqlDataReader dr, string columnName)
        {

            dr.GetSchemaTable().DefaultView.RowFilter = "ColumnName= '" + columnName + "'";

            return (dr.GetSchemaTable().DefaultView.Count > 0);

        }
    }
}
