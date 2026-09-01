using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.DataDistribution.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.DataDistribution.BLL
{
    public class DataDistributionSYBConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 根据 WorkShopId 获取实体信息。
        /// </summary>
        /// <param name="workShopId">WorkShopId。</param>
        /// <returns>WorkShop 实体对象。</returns>
        public DataDistributionSYBConfigInfo GetInfo(Int32 ID)
        {
            DataDistributionSYBConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = ID;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "DataDistributionSYBConfigInfoList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DataDistributionSYBConfigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8),rdr.GetString(9), rdr.GetString(10));
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>WorkShop 实体对象。</returns>
        public DataDistributionSYBConfigInfo GetInfo(String fieldValue)
        {
            DataDistributionSYBConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "DataDistributionSYBConfigInfoList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DataDistributionSYBConfigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), rdr.GetString(10));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SYS_Organization 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="workShopCount">SYS_Organization 总数。</param>
        /// <returns>WorkShop 列表。</returns>
        public List<DataDistributionSYBConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DataDistributionSYBConfigInfo> list = new List<DataDistributionSYBConfigInfo>();
            DataDistributionSYBConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwDataDistributionSYBConfigInfoList", "ID",
                "[ID],[DepartCode], [DepartName],[CreateBy],[CreateDateTime],[ModifyBy],[ModifyTime],[Remark],[MesUrl],[DataBaseName],[DBLinkName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new DataDistributionSYBConfigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), rdr.GetString(10));
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
        /// <summary>
        /// 将产品数据下发到事业部
        /// </summary>
        /// <param name="IDS"></param>
        public void DataDistributionOp(string ItemCodeList,string DepartCodeList,string CreateBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemCodeList", SqlDbType.VarChar),
                new SqlParameter("@DepartCodeList", SqlDbType.VarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar)
            };

            parms[0].Value = ItemCodeList;
            parms[1].Value = DepartCodeList;
            parms[2].Value = CreateBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaterialDataDistribution", parms);
        }
        /// <summary>
        /// 将账套数据下发到事业部
        /// </summary>
        /// <param name="IDS"></param>
        public void DataDistributionOrgOp(string OrgCodeList, string DepartCodeList, string CreateBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrgCodeList", SqlDbType.VarChar),
                new SqlParameter("@DepartCodeList", SqlDbType.VarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar)
            };

            parms[0].Value = OrgCodeList;
            parms[1].Value = DepartCodeList;
            parms[2].Value = CreateBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOrgDataDistribution", parms);
        }
        /// <summary>
        /// 将供应商数据下发到事业部
        /// </summary>
        /// <param name="IDS"></param>
        public void DataDistributionSupplierOp(string SupplierCodeList, string DepartCodeList, string CreateBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierCodeList", SqlDbType.VarChar),
                new SqlParameter("@DepartCodeList", SqlDbType.VarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar)
            };

            parms[0].Value = SupplierCodeList;
            parms[1].Value = DepartCodeList;
            parms[2].Value = CreateBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSupplierDataDistribution", parms);
        }
        /// <summary>
        /// 将客户数据下发到事业部
        /// </summary>
        /// <param name="IDS"></param>
        public void DataDistributionCustomerOp(string CustomerCodeList, string DepartCodeList, string CreateBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CustomerCodeList", SqlDbType.VarChar),
                new SqlParameter("@DepartCodeList", SqlDbType.VarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar)
            };

            parms[0].Value = CustomerCodeList;
            parms[1].Value = DepartCodeList;
            parms[2].Value = CreateBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCustomerDataDistribution", parms);
        }
        /// <summary>
        /// 将工单数据下发到事业部
        /// </summary>
        /// <param name="IDS"></param>
        public void DataDistributionShopOrderOp(string ShopOrderCodeList, string DepartCodeList, string CreateBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ShopOrderCodeList", SqlDbType.VarChar),
                new SqlParameter("@DepartCodeList", SqlDbType.VarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar)
            };

            parms[0].Value = ShopOrderCodeList;
            parms[1].Value = DepartCodeList;
            parms[2].Value = CreateBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspShopOrderDataDistribution", parms);
        }
    }
}
