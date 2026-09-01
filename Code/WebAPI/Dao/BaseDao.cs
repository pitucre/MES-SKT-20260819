using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using WebAPI.Models;
using WebAPI.Models.Enum;
using WebAPI.Models.MES;
using WebAPI.Utility;

namespace WebAPI.Dao
{
    public class BaseDao
    {
        protected readonly string MESConnString = ConfigurationManager.AppSettings["MESConnString"].ToString();

        /// <summary>
        /// 是否集团总部（1：总部 0：子工厂）
        /// </summary>
        protected readonly string GroupHeadquartersFlag = ConfigurationManager.AppSettings["GroupHeadquartersFlag"] ?? string.Empty;

        /// <summary>
        /// 子工厂工厂代码（如果GroupHeadquartersFlag配置为1，则此处可以为空，否则不能为空
        /// </summary>
        protected readonly string SubFactory = ConfigurationManager.AppSettings["SubFactory"] ?? string.Empty;

        /// <summary>
        /// 批量插入数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="list"></param>
        /// <param name="em"></param>
        /// <returns></returns>
        public BulkInsertInfo BulkInsert<T>(IEnumerable<T> list, ApiEnum em) where T : class
        {
            BulkInsertInfo bulkInsertInfo = new BulkInsertInfo() { AffectedCount = 0 };
            //int affectedCount = 0;
            var dt = new DataTable();
            var listBillNo = new List<string>();
            var tableName = string.Empty;
            //MOM表中工厂代码字段（一般为FactoryCode、Site）
            var factoryCodeFieldList = new List<string>() { "FactoryCode", "Site" };

            try
            {
                //获取中间表名
                var entity = new ERPSyncDao().GetERPSyncInfo(em);
                tableName = entity.MiddleTableName; //中间表名

                var newPropertys = new List<PropertyInfo>();

                #region 构造DataTable

                System.Reflection.PropertyInfo[] propertys = list.First().GetType().GetProperties(BindingFlags.Instance | BindingFlags.Public);
                foreach (System.Reflection.PropertyInfo pi in propertys)
                {
                    if (!pi.CanRead)
                    {
                        continue;
                    }
                    #region 根据自定义属性特性进行过滤

                    //根据自定义属性特性进行过滤
                    var ignore = false;
                    object[] objAttrs = pi.GetCustomAttributes(typeof(MappingPropertyAttribute), true);//获取自定义特性
                    if (objAttrs != null && objAttrs.Length > 0)
                    {
                        var attr = objAttrs[0] as MappingPropertyAttribute;
                        if (attr != null && attr.FieldIgnore)
                        {
                            //实体类映射到表时，是否对应忽略字段
                            ignore = true;
                        }
                    }

                    if (!ignore)
                    {
                        Type propType;
                        if (pi.PropertyType.FullName.Contains(typeof(Nullable).ToString()))
                        {
                            propType = Nullable.GetUnderlyingType(pi.PropertyType);
                        }
                        else
                        {
                            propType = pi.PropertyType;
                        }

                        //判断值是否为空
                        newPropertys.Add(pi);

                        dt.Columns.Add(pi.Name, propType);
                        //sqlbulkcopy.ColumnMappings.Add(pi.Name, pi.Name);
                    }

                    #endregion
                }

                #endregion

                #region 遍历集合，把值赋给DataTable

                var values = new object[newPropertys.Count];
                PropertyInfo propertyInfo;
                IEnumerable<MappingPropertyAttribute> attributesList;
                var syncCurrentFactroyCodeData = true;  //是否同步当前工厂数据
                foreach (var item in list)
                {
                    for (var i = 0; i < values.Length; i++)
                    {
                        //获取值
                        propertyInfo = newPropertys[i];
                        values[i] = propertyInfo.GetValue(item, null);

                        //获取自定义特性，判断属性是否允许为空
                        attributesList = propertyInfo.GetCustomAttributes<MappingPropertyAttribute>(false);
                        var allowEmpty = attributesList.FirstOrDefault(p => !p.AllowEmpty);//是否允许为空
                        var isBillNo = attributesList.Any(p => p.IsBillNo);//是否为单据号

                        if (allowEmpty != null && (values[i] == null || string.IsNullOrWhiteSpace(values[i].ToString())))
                        {
                            throw new Exception($"{propertyInfo.Name}不能为空");
                        }

                        var type = propertyInfo.PropertyType;
                        if (type == typeof(DateTime) && values[i] != null && Convert.ToDateTime(values[i]) == DateTime.MinValue)
                        {
                            //时间类型，如果为0001-01-01，则转成1900-01-01
                            values[i] = Convert.ToDateTime("1900-01-01");
                        }
                        else if (type.FullName.Contains(typeof(Nullable).ToString()) && values[i] == null)
                        {
                            //可空类型，获取可空类型默认值
                            values[i] = DefaultForType(Nullable.GetUnderlyingType(type));
                        }
                        else if (type == typeof(string) && values[i] == null)
                        {
                            //string类型，如果是NULL，转成空字符串
                            values[i] = string.Empty;
                        }

                        //单据类需要根据子工厂代码进行同步，总部同步所有数据
                        if (GroupHeadquartersFlag != "1"    //非集团总部
                            && entity.SyncByFactroyCodeFlag == 1    //需要根据工厂代码同步
                            && type == typeof(string) && !string.IsNullOrEmpty(values[i].ToString()) //工厂代码字段需要为string类型
                            && factoryCodeFieldList.Any(p => string.Equals(p, propertyInfo.Name, StringComparison.CurrentCultureIgnoreCase)))   //当前字段是工厂代码字段
                        {
                            if (string.IsNullOrWhiteSpace(SubFactory))
                            {
                                throw new Exception($"请检查是否配置SubFactory节点值");
                            }

                            //该字段为工厂代码字段，判断是否与Web.Config中配置的工厂代码一致，如果一致，才同步数据，否则不同步数据
                            if (!string.Equals(values[i].ToString(), SubFactory, StringComparison.CurrentCultureIgnoreCase))
                            {
                                syncCurrentFactroyCodeData = false;
                                break;
                            }
                        }

                        //返回单据号
                        if (isBillNo && type == typeof(string) && !listBillNo.Any(p => string.Equals(p, values[i].ToString(), StringComparison.CurrentCultureIgnoreCase)))
                        {
                            listBillNo.Add(values[i].ToString());
                        }
                    }

                    if (syncCurrentFactroyCodeData)
                    {
                        dt.Rows.Add(values);
                    }
                }

                #endregion

                //未获取到数据，可能不是当前工厂的JSON数据
                if (dt.Rows.Count <= 0)
                {
                    return bulkInsertInfo;
                }

            }
            catch (Exception ex)
            {
                Logger.Write.Error("构造中间库插入数据失败", ex);
                throw ex;
            }

            #region 将DataTable数据插入到中间表
            try
            {
                //构建Insert语句
                using (SqlConnection conn = new SqlConnection(MESConnString))
                {
                    conn.Open();
                    using (SqlBulkCopy sqlbulkcopy = new SqlBulkCopy(conn, SqlBulkCopyOptions.UseInternalTransaction, null))
                    {
                        sqlbulkcopy.DestinationTableName = tableName;// "ERP_Customer";//需要写入数据库的表名

                        //将List字段与MES字段进行映射
                        foreach (DataColumn dc in dt.Columns)
                        {
                            sqlbulkcopy.ColumnMappings.Add(dc.ColumnName, dc.ColumnName);
                        }

                        sqlbulkcopy.WriteToServer(dt);
                        bulkInsertInfo.AffectedCount = dt.Rows.Count;
                        bulkInsertInfo.ListBillNo = listBillNo;
                        dt.Dispose();
                        return bulkInsertInfo;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.Write.Error("插入数据到中间表失败", ex);
                throw ex;
            }
            #endregion
        }

        #region BulkInsert tableName
        ///// <summary>
        ///// 批量插入数据
        ///// </summary>
        ///// <typeparam name="T"></typeparam>
        ///// <param name="list"></param>
        ///// <param name="tableName"></param>
        ///// <returns></returns>
        //public BulkInsertInfo BulkInsert<T>(IEnumerable<T> list, string tableName) where T : class
        //{
        //    BulkInsertInfo bulkInsertInfo = new BulkInsertInfo();
        //    //int affectedCount = 0;
        //    var dt = new DataTable();
        //    var listBillNo = new List<string>();

        //    try
        //    {
        //        var newPropertys = new List<PropertyInfo>();

        //        #region 构造DataTable

        //        System.Reflection.PropertyInfo[] propertys = list.First().GetType().GetProperties(BindingFlags.Instance | BindingFlags.Public);
        //        foreach (System.Reflection.PropertyInfo pi in propertys)
        //        {
        //            if (!pi.CanRead)
        //            {
        //                continue;
        //            }
        //            #region 根据自定义属性特性进行过滤

        //            //根据自定义属性特性进行过滤
        //            var ignore = false;
        //            object[] objAttrs = pi.GetCustomAttributes(typeof(MappingPropertyAttribute), true);//获取自定义特性
        //            if (objAttrs != null && objAttrs.Length > 0)
        //            {
        //                var attr = objAttrs[0] as MappingPropertyAttribute;
        //                if (attr != null && attr.FieldIgnore)
        //                {
        //                    //实体类映射到表时，是否对应忽略字段
        //                    ignore = true;
        //                }
        //            }

        //            if (!ignore)
        //            {
        //                Type propType;
        //                if (pi.PropertyType.FullName.Contains(typeof(Nullable).ToString()))
        //                {
        //                    propType = Nullable.GetUnderlyingType(pi.PropertyType);
        //                }
        //                else
        //                {
        //                    propType = pi.PropertyType;
        //                }

        //                //判断值是否为空
        //                newPropertys.Add(pi);

        //                dt.Columns.Add(pi.Name, propType);
        //                //sqlbulkcopy.ColumnMappings.Add(pi.Name, pi.Name);
        //            }

        //            #endregion
        //        }

        //        #endregion

        //        #region 遍历集合，把值赋给DataTable

        //        var values = new object[newPropertys.Count];
        //        PropertyInfo propertyInfo;
        //        IEnumerable<MappingPropertyAttribute> attributesList;
        //        foreach (var item in list)
        //        {
        //            for (var i = 0; i < values.Length; i++)
        //            {
        //                //获取值
        //                propertyInfo = newPropertys[i];
        //                values[i] = propertyInfo.GetValue(item, null);

        //                //获取自定义特性，判断属性是否允许为空
        //                attributesList = propertyInfo.GetCustomAttributes<MappingPropertyAttribute>(false);
        //                var allowEmpty = attributesList.FirstOrDefault(p => !p.AllowEmpty);//是否允许为空
        //                var isBillNo = attributesList.Any(p => p.IsBillNo);//是否为单据号

        //                if (allowEmpty != null && (values[i] == null || string.IsNullOrWhiteSpace(values[i].ToString())))
        //                {
        //                    throw new Exception($"{propertyInfo.Name}不能为空");
        //                }

        //                var type = propertyInfo.PropertyType;
        //                if (type == typeof(DateTime) && values[i] != null && Convert.ToDateTime(values[i]) == DateTime.MinValue)
        //                {
        //                    //时间类型，如果为0001-01-01，则转成1900-01-01
        //                    values[i] = Convert.ToDateTime("1900-01-01");
        //                }
        //                else if (type.FullName.Contains(typeof(Nullable).ToString()) && values[i] == null)
        //                {
        //                    //可空类型，获取可空类型默认值
        //                    values[i] = DefaultForType(Nullable.GetUnderlyingType(type));
        //                }
        //                else if (type == typeof(string) && values[i] == null)
        //                {
        //                    //string类型，如果是NULL，转成空字符串
        //                    values[i] = string.Empty;
        //                }

        //                //单据类需要根据子工厂代码进行同步
        //                if (GroupHeadquartersFlag != "1")
        //                {
        //                    if (string.IsNullOrWhiteSpace(SubFactory))
        //                    {
        //                        throw new Exception($"请检查是否配置SubFactory节点值");
        //                    }

        //                    //MOM表中工厂代码字段（一般为FactoryCode、Site）
        //                    var factoryCodeFieldList = new List<string>() { "FactoryCode", "Site" };
        //                    if (factoryCodeFieldList.Any(p => string.Equals(p, propertyInfo.Name, StringComparison.CurrentCultureIgnoreCase)))
        //                    {

        //                    }
        //                }

        //                //返回单据号
        //                if (isBillNo && type == typeof(string) && !listBillNo.Any(p => string.Equals(p, values[i].ToString(), StringComparison.CurrentCultureIgnoreCase)))
        //                {
        //                    listBillNo.Add(values[i].ToString());
        //                }
        //            }
        //            dt.Rows.Add(values);
        //        }

        //        #endregion

        //    }
        //    catch (Exception ex)
        //    {
        //        Logger.Write.Error("构造中间库插入数据失败", ex);
        //        throw ex;
        //    }

        //    try
        //    {
        //        //构建Insert语句
        //        using (SqlConnection conn = new SqlConnection(MESConnString))
        //        {
        //            conn.Open();
        //            using (SqlBulkCopy sqlbulkcopy = new SqlBulkCopy(conn, SqlBulkCopyOptions.UseInternalTransaction, null))
        //            {
        //                sqlbulkcopy.DestinationTableName = tableName;// "ERP_Customer";//需要写入数据库的表名

        //                //将List字段与MES字段进行映射
        //                foreach (DataColumn dc in dt.Columns)
        //                {
        //                    sqlbulkcopy.ColumnMappings.Add(dc.ColumnName, dc.ColumnName);
        //                }

        //                sqlbulkcopy.WriteToServer(dt);
        //                bulkInsertInfo.AffectedCount = dt.Rows.Count;
        //                bulkInsertInfo.ListBillNo = listBillNo;
        //                dt.Dispose();
        //                return bulkInsertInfo;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Logger.Write.Error("插入数据到中间表失败", ex);
        //        throw ex;
        //    }
        //} 
        #endregion

        #region BulkInsert Old
        ///// <summary>
        ///// 批量插入数据
        ///// </summary>
        ///// <typeparam name="T"></typeparam>
        ///// <param name="list"></param>
        ///// <param name="tableName"></param>
        ///// <returns></returns>
        //public int BulkInsert<T>(IEnumerable<T> list, string tableName) where T : class
        //{
        //    try
        //    {
        //        int affectedCount = 0;
        //        //构建Insert语句
        //        using (SqlConnection conn = new SqlConnection(MESConnString))
        //        {
        //            conn.Open();
        //            using (SqlBulkCopy sqlbulkcopy = new SqlBulkCopy(conn, SqlBulkCopyOptions.UseInternalTransaction, null))
        //            {
        //                sqlbulkcopy.DestinationTableName = tableName;// "ERP_Customer";//需要写入数据库的表名

        //                var dt = new DataTable();
        //                var newPropertys = new List<PropertyInfo>();

        //                #region 构造DataTable

        //                System.Reflection.PropertyInfo[] propertys = list.First().GetType().GetProperties(BindingFlags.Instance | BindingFlags.Public);
        //                foreach (System.Reflection.PropertyInfo pi in propertys)
        //                {
        //                    if (!pi.CanRead)
        //                    {
        //                        continue;
        //                    }
        //                    #region 根据自定义属性特性进行过滤

        //                    //根据自定义属性特性进行过滤
        //                    var ignore = false;
        //                    object[] objAttrs = pi.GetCustomAttributes(typeof(MappingPropertyAttribute), true);//获取自定义特性
        //                    if (objAttrs != null && objAttrs.Length > 0)
        //                    {
        //                        var attr = objAttrs[0] as MappingPropertyAttribute;
        //                        if (attr != null && attr.FieldIgnore)
        //                        {
        //                            //查询时忽略查询字段，或者为空时，忽略查询字段
        //                            ignore = true;
        //                        }
        //                    }

        //                    if (!ignore)
        //                    {

        //                        Type propType;
        //                        if (pi.PropertyType.FullName.Contains(typeof(Nullable).ToString()))
        //                        {
        //                            propType = Nullable.GetUnderlyingType(pi.PropertyType);
        //                        }
        //                        else
        //                        {
        //                            propType = pi.PropertyType;
        //                        }

        //                        newPropertys.Add(pi);

        //                        dt.Columns.Add(pi.Name, propType);

        //                        //将List字段与MES字段进行映射
        //                        sqlbulkcopy.ColumnMappings.Add(pi.Name, pi.Name);
        //                    }

        //                    #endregion
        //                }

        //                #endregion

        //                #region 遍历集合，把值赋给DataTable

        //                var values = new object[newPropertys.Count];
        //                foreach (var item in list)
        //                {
        //                    for (var i = 0; i < values.Length; i++)
        //                    {
        //                        values[i] = newPropertys[i].GetValue(item, null);

        //                        //可空类型获取默认值
        //                        var type = newPropertys[i].PropertyType;
        //                        if (type == typeof(DateTime) && values[i] != null && Convert.ToDateTime(values[i]) == DateTime.MinValue)
        //                        {
        //                            values[i] = Convert.ToDateTime("1900-01-01");
        //                        }
        //                        else if (type.FullName.Contains(typeof(Nullable).ToString()) && values[i] == null)
        //                        {
        //                            values[i] = DefaultForType(Nullable.GetUnderlyingType(type));
        //                        }
        //                    }
        //                    dt.Rows.Add(values);
        //                }

        //                #endregion

        //                sqlbulkcopy.WriteToServer(dt);
        //                affectedCount = dt.Rows.Count;
        //                dt.Dispose();
        //                return affectedCount;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Logger.Write.Error("插入数据到中间库失败", ex);
        //        throw ex;
        //    }
        //} 
        #endregion

        /// <summary>
        /// 获取属性默认值
        /// </summary>
        /// <param name="targetType"></param>
        /// <returns></returns>
        public static object DefaultForType(Type targetType)
        {
            if (targetType.IsValueType)
            {
                if (targetType == typeof(DateTime))
                {
                    return Convert.ToDateTime("1900-01-01");
                }
                else
                {
                    return Activator.CreateInstance(targetType);
                }
            }
            else
            {
                return null;
            }
        }


    }
}