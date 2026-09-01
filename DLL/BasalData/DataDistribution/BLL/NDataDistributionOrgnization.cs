using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.DataDistribution.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.DataDistribution.BLL
{
    public class NDataDistributionOrgnization
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 根据 WorkShopId 获取实体信息。
        /// </summary>
        /// <param name="workShopId">WorkShopId。</param>
        /// <returns>WorkShop 实体对象。</returns>
        public NDataDistributionOrgnizationInfo GetInfo(Int32 ID)
        {
            NDataDistributionOrgnizationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = ID;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "NDataDistributionOrgnizationInfoList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new NDataDistributionOrgnizationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2));
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
        public NDataDistributionOrgnizationInfo GetInfo(String fieldValue)
        {
            NDataDistributionOrgnizationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "NDataDistributionOrgnizationInfoList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new NDataDistributionOrgnizationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2));
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
        public List<NDataDistributionOrgnizationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<NDataDistributionOrgnizationInfo> list = new List<NDataDistributionOrgnizationInfo>();
            NDataDistributionOrgnizationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwNDataDistributionOrgnizationInfoList", "OrganizationId",
                "[OrganizationId],[DepartNo], [DepartName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new NDataDistributionOrgnizationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2));
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
