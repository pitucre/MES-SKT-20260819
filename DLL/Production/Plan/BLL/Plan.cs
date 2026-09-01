using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Plan.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Plan.BLL
{
    public class Plan
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Plan 信息。
        /// </summary>
        /// <param name="entity">Plan 实体对象。</param>
        public Int32 Edit(PlanInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PlanId", SqlDbType.Int),
                new SqlParameter("@PlanTypeId", SqlDbType.Int),
                new SqlParameter("@OrderNumber", SqlDbType.VarChar, 20),
                new SqlParameter("@MaterialCode", SqlDbType.VarChar, 20),
                new SqlParameter("@MaterialDescription", SqlDbType.VarChar, 50),
                new SqlParameter("@Amount", SqlDbType.Int),
                new SqlParameter("@OrderStartTime", SqlDbType.DateTime),
                new SqlParameter("@OrderEndTime", SqlDbType.DateTime),
                new SqlParameter("@state", SqlDbType.VarChar, 5),
                new SqlParameter("@OrderCreateDateTime", SqlDbType.DateTime),
                new SqlParameter("@OrderType", SqlDbType.VarChar, 20),
                new SqlParameter("@SynthesisMachine", SqlDbType.VarChar, 20),
                new SqlParameter("@SynthesisDateTime", SqlDbType.DateTime),
                new SqlParameter("@SynthesisTeam", SqlDbType.VarChar, 20),
                new SqlParameter("@PressNumber", SqlDbType.VarChar, 20),
                new SqlParameter("@ScrappedQuantity", SqlDbType.Int),
                new SqlParameter("@Explain", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@PlanRemark", SqlDbType.VarChar, 100),
                new SqlParameter("@QICATSDT", SqlDbType.DateTime),
            };

            parms[0].Value = entity.PlanId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.PlanTypeId;
            parms[2].Value = entity.OrderNumber;
            parms[3].Value = entity.MaterialCode;
            parms[4].Value = entity.MaterialDescription;
            parms[5].Value = entity.Amount;
            parms[6].Value = entity.OrderStartTime;
            parms[7].Value = entity.OrderEndTime;
            parms[8].Value = entity.State;
            parms[9].Value = entity.OrderCreateDateTime;
            parms[10].Value = entity.OrderType;
            parms[11].Value = entity.SynthesisMachine;
            parms[12].Value = entity.SynthesisDateTime;
            parms[13].Value = entity.SynthesisTeam;
            parms[14].Value = entity.PressNumber;
            parms[15].Value = entity.ScrappedQuantity;
            parms[16].Value = entity.Explain;
            parms[17].Value = entity.CreateBy;
            parms[18].Value = entity.ModifyBy;
            parms[19].Value = entity.Remark;
            parms[20].Value = entity.PlanRemark;
            parms[21].Value = entity.QICATSDT;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Plan_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PlanId 字符串删除 Plan 信息。
        /// </summary>
        /// <param name="idString">PlanId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Plan_Delete", parms);
        }


        /// <summary>
        /// 根据 PlanId 获取实体信息。
        /// </summary>
        /// <param name="planId">PlanId。</param>
        /// <returns>Plan 实体对象。</returns>
        public PlanInfo GetInfo(Int32 planId)
        {
            PlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = planId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Plan_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PlanInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetString(14),
                        rdr.GetInt32(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetDateTime(19),
                        rdr.GetDateTime(20), rdr.GetString(21), rdr.GetDateTime(22), rdr.GetString(23));
                }
                rdr.Close();
            }

            return entity;
        }

     

        /// <summary>
        /// 分页获取 Plan 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="planCount">plan 总数。</param>
        /// <returns>Plan 列表。</returns>
        public List<PlanInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PlanInfo> list = new List<PlanInfo>();
            PlanInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_Plan", "PlanId",
                "[PlanId], [PlanTypeId], [OrderNumber], [MaterialCode], [MaterialDescription], [Amount], [OrderStartTime], [OrderEndTime], [State], [OrderCreateDateTime], [OrderType], [SynthesisMachine], [SynthesisDateTime], [SynthesisTeam], [PressNumber], [ScrappedQuantity], [Explain], [PlanRemark], [CreateBy], [CreateDateTime], [QICATSDT], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PlanInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                       rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                       rdr.GetString(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetString(14),
                       rdr.GetInt32(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetDateTime(19),
                       rdr.GetDateTime(20), rdr.GetString(21), rdr.GetDateTime(22), rdr.GetString(23));

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

        public Int32 EditFinished(DataTable table)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@table", SqlDbType.Structured)
            };
            parms[0].Value = table;
            
            int affect = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Plan_Edit_List", parms);

            return affect;
        }

        public Int32 EditSemi_Finished(DataTable table)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@table", SqlDbType.Structured)
            };
            parms[0].Value = table;
            int affect = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Plan_Edit_List_Semi_Finished", parms);

            return affect;
        }

        public void ToImportPreAssemblyDetail(DataTable table, String detailId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@table", SqlDbType.Structured),
                new SqlParameter("@ModelNo", SqlDbType.VarChar,100),
                new SqlParameter("@UserName", SqlDbType.VarChar,20)
            };
            parms[0].Value = table;
            parms[1].Value = detailId;
            parms[2].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspToImportPreAssemblyDetail", parms);
        }

    }
}