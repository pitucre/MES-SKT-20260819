using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Sparepart.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Sparepart.BLL
{
    public class PartsHistory
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） PartsHistory 信息。
        /// </summary>
        /// <param name="entity">PartsHistory 实体对象。</param>
        public Int32 Edit(PartsHistoryInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PartsHistoryId", SqlDbType.Int),
                new SqlParameter("@PartID", SqlDbType.Int),
                new SqlParameter("@OperateType", SqlDbType.Int),
                new SqlParameter("@Quantity", SqlDbType.Decimal),
                new SqlParameter("@OutOrIn", SqlDbType.Int),
                new SqlParameter("@Requestor", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@DeparmentId",SqlDbType.Int)
        };

            parms[0].Value = entity.PartsHistoryId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.PartID;
            parms[2].Value = entity.OperateType;
            parms[3].Value = entity.Quantity;
            parms[4].Value = entity.OutOrIn;
            parms[5].Value = entity.Requestor;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.Remark;
            parms[9].Value = entity.DeparmentId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PartsHistory_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PartsHistoryId 获取实体信息。
        /// </summary>
        /// <param name="partsHistoryId">PartsHistoryId。</param>
        /// <returns>PartsHistory 实体对象。</returns>
        public PartsHistoryInfo GetInfo(Int32 partsHistoryId)
        {
            PartsHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = partsHistoryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PartsHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PartsHistoryInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10));
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 分页获取 PartsHistory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partsCount">parts 总数。</param>
        /// <returns>Parts 列表。</returns>
        public List<SparepartInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SparepartInfo> list = new List<SparepartInfo>();
            SparepartInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetPartHistoryList", "PartsHistoryId",
                "[PartsHistoryId],[PartId], [PartName], [PartNickName], [PartNO], [PartCategory], [PartMachine], [PartLocation], [PartBrand], [PartStandard], [PartParam], [PartSafeQty], [PartQty], [PartUnit], [CreateBy], [Quantity], [OperateType], [Requestor],[OutOrIn],[CreateDateTime],Remark,DepartName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                
                while (rdr.Read())
                {
                    entity = new SparepartInfo();
                    entity.PartsHistoryId = Convert.ToInt32(rdr["PartsHistoryId"]);
                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.PartNickName = Convert.ToString(rdr["PartNickName"]);
                    entity.PartNO = Convert.ToString(rdr["PartNO"]);

                    entity.PartCategory = Convert.ToString(rdr["PartCategory"]);
                    entity.PartMachine = Convert.ToString(rdr["PartMachine"]);
                    entity.PartLocation = Convert.ToString(rdr["partLocation"]);
                    entity.PartBrand = Convert.ToString(rdr["partBrand"]);
                    entity.PartStandard = Convert.ToString(rdr["partStandard"]);
                    entity.PartParam = Convert.ToString(rdr["PartParam"]);

                    entity.PartSafeQty = Convert.ToInt32(rdr["partSafeQty"]);
                    entity.PartQty = Convert.ToInt32(rdr["partQty"]);
                    entity.PartUnit = Convert.ToString(rdr["partUnit"]);
                    entity.CreateBy = Convert.ToString(rdr["createBy"]);

                    //[Quantity], [OperateType], [Requestor],[OutOrIn],[CreateDateTime],Remark,DepartName
                    entity.Quantity = Convert.ToInt32(rdr["Quantity"]); ;
                    entity.OperateType = Convert.ToInt32(rdr["Quantity"]); ;
                    entity.Requestor = Convert.ToString(rdr["Requestor"]);
                    entity.OutOrIn = Convert.ToInt32(rdr["OutOrIn"]); ;
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.DepartName = Convert.ToString(rdr["DepartName"]);


                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 分页获取 PartsHistory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partsCount">parts 总数。</param>
        /// <returns>Parts 列表。</returns>
        public List<SparepartInfo> GetAllNew(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SparepartInfo> list = new List<SparepartInfo>();
            SparepartInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetPartOptionHistoryList", "PartsHistoryId",
                "[PartsHistoryId],[PartId], [PartName], [PartNickName], [PartNO],[PartQty], [CreateBy], [Requestor],[CreateDateTime],Remark", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {

                while (rdr.Read())
                {
                    entity = new SparepartInfo();
                    entity.PartsHistoryId = Convert.ToInt32(rdr["PartsHistoryId"]);
                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.PartNickName = Convert.ToString(rdr["PartNickName"]);
                    entity.PartNO = Convert.ToString(rdr["PartNO"]);
                    if (!rdr.IsDBNull(rdr.GetOrdinal("partQty"))) {
                        entity.PartQty = Convert.ToInt32(rdr["partQty"]);
                    }                    
                    entity.CreateBy = Convert.ToString(rdr["createBy"]);
                    entity.Requestor = Convert.ToString(rdr["Requestor"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);


                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="strWhere">查询条件</param>
        /// <returns></returns>
        public DataTable ImportToExcel(Int32 outOrIn, String beginDateTime, String endDateTime)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OutOrIn", SqlDbType.Int),
                new SqlParameter("@BeginCreateTime", SqlDbType.NVarChar),
                new SqlParameter("@EndCreateTime", SqlDbType.NVarChar)
            };
            parms[0].Value = outOrIn;
            parms[1].Value = beginDateTime;
            parms[2].Value = endDateTime;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Prod_PartsHistoryImportToExcel", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}