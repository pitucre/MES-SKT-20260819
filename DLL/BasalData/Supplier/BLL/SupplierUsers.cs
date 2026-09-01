using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.Model;
using SKT.LeanMES.Supplier.Model;

namespace SKT.LeanMES.Supplier.BLL
{
    public class SupplierUsers
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 把用户添加到供应商中
        /// </summary>
        /// <param name="SupplierId"></param>
        /// <param name="UserIdString"></param>
        /// <param name="UserName"></param>
        public void AssignUsersToSuplier(int SupplierId, string UserIdString, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierId", SqlDbType.Int),
                new SqlParameter("@UserIdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };
            parms[0].Value = SupplierId;
            parms[1].Value = UserIdString;
            parms[2].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_AddUsersToSupplier", parms);
        }
        /// <summary>
        /// 从供应商中移除用户
        /// </summary>
        /// <param name="SupplierId"></param>
        /// <param name="UserIdString"></param>
        /// <param name="UserName"></param>
        public void RemoveUsersFromSuplierint(int SupplierId, string UserIdString, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierId", SqlDbType.Int),
                new SqlParameter("@UserIdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };
            parms[0].Value = SupplierId;
            parms[1].Value = UserIdString;
            parms[2].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_RemoveUserSFromSupplier", parms);
        }
        /// <summary>
        /// 分页获取 供应商和用户 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="Basal_SupplierCount">Basal_Supplier 总数。</param>
        /// <returns>Basal_Supplier 列表。</returns>
        public List<SupplierUsersInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierUsersInfo> list = new List<SupplierUsersInfo>();
            SupplierUsersInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vWSupplierUsers", "userid",
            "userid,username,cname,employeeno", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SupplierUsersInfo();
                    entity.UserId = rdr.GetInt32(0);
                    entity.UserName = rdr.GetString(1);
                    entity.EmployeeNo = rdr.GetString(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 分页获取 登录的用户拥有的供应商列表 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="Basal_SupplierCount">Basal_Supplier 总数。</param>
        /// <returns>Basal_Supplier 列表。</returns>
        public List<SuppliersInfo> GetAllSuppliersByUserId(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SuppliersInfo> list = new List<SuppliersInfo>();
            SuppliersInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwUserOfSupplier", "SupplierUserID",
            "vendorcode,vendorname,[Site],SupplierUserID", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SuppliersInfo();
                    entity.VendorCode = rdr.GetString(0);
                    entity.VendorName = rdr.GetString(1);
                    entity.Site = rdr.GetString(2);
                    entity.SupplierId = rdr.GetInt32(3);
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
