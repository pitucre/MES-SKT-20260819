using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Product.BLL
{
    public class Customer
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Customer 信息。
        /// </summary>
        /// <param name="entity">Customer 实体对象。</param>
        public Int32 Edit(CustomerInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CustomerID", SqlDbType.Int),
                new SqlParameter("@CustomerName", SqlDbType.NVarChar, 20),
                new SqlParameter("@Address1", SqlDbType.NVarChar, 200),
                new SqlParameter("@Address2", SqlDbType.NVarChar, 200),
                new SqlParameter("@City", SqlDbType.NVarChar, 50),
                new SqlParameter("@StateProvince", SqlDbType.NVarChar, 50),
                new SqlParameter("@Country", SqlDbType.NVarChar, 50),
                new SqlParameter("@Postal", SqlDbType.NVarChar, 50),
                new SqlParameter("@EmailAddress", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.CustomerID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.CustomerName;
            parms[2].Value = entity.Address1;
            parms[3].Value = entity.Address2;
            parms[4].Value = entity.City;
            parms[5].Value = entity.StateProvince;
            parms[6].Value = entity.Country;
            parms[7].Value = entity.Postal;
            parms[8].Value = entity.EmailAddress;
            parms[9].Value = entity.Remark;
            parms[10].Value = entity.ModifyBy;
            parms[11].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Customer_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 CustomerId 字符串删除 Customer 信息。
        /// </summary>
        /// <param name="idString">CustomerId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Customer_Delete", parms);
        }

        /// <summary>
        /// 根据 CustomerId 获取实体信息。
        /// </summary>
        /// <param name="customerId">CustomerId。</param>
        /// <returns>Customer 实体对象。</returns>
        public CustomerInfo GetInfo(Int32 customerId)
        {
            CustomerInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = customerId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Customer_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CustomerInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Customer 实体对象。</returns>
        public CustomerInfo GetInfo(String fieldValue)
        {
            CustomerInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Customer_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CustomerInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Customer 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="customerCount">customer 总数。</param>
        /// <returns>Customer 列表。</returns>
        public List<CustomerInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CustomerInfo> list = new List<CustomerInfo>();
            CustomerInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Customer", "CustomerId",
                "[CustomerID], [CustomerName], [Address1], [Address2], [City], [StateProvince], [Country], [Postal], [EmailAddress], [Remark], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CustomerInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}