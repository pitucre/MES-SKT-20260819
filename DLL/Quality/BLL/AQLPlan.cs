using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
//using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class AQLPlan
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AQLPlan 信息。
        /// </summary>
        /// <param name="entity">AQLPlan 实体对象。</param>
        public Int32 Edit(AQLPlanInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PlanId", SqlDbType.Int),
                new SqlParameter("@AqlName", SqlDbType.NVarChar, 50),
                new SqlParameter("@AqlRuleTypeId", SqlDbType.Int),
                new SqlParameter("@AqlPlanType", SqlDbType.Int),
                new SqlParameter("@ApplyTo", SqlDbType.Int),
                new SqlParameter("@AqlPlanStatus", SqlDbType.Int),
                new SqlParameter("@AqlDescription", SqlDbType.NVarChar, 50),
                new SqlParameter("@Reject", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreaterBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreateDate", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@ModifyDate", SqlDbType.DateTime)
            };

            parms[0].Value = entity.PlanId;
            parms[1].Value = entity.AqlName;
            parms[2].Value = entity.AqlRuleTypeId;
            parms[3].Value = entity.AqlPlanType;
            parms[4].Value = entity.ApplyTo;
            parms[5].Value = entity.AqlPlanStatus;
            parms[6].Value = entity.AqlDescription;
            parms[7].Value = entity.Reject;
            parms[8].Value = entity.Remark;
            parms[9].Value = entity.CreaterBy;
            parms[10].Value = entity.CreateDate;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = entity.ModifyDate;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_AQLPlanEdit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AQLPlanId 字符串删除 AQLPlan 信息。
        /// </summary>
        /// <param name="idString">AQLPlanId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_AQLPlanDelete", parms);
        }

        /// <summary>
        /// 根据 AQLPlanId 获取实体信息。
        /// </summary>
        /// <param name="aQLPlanId">AQLPlanId。</param>
        /// <returns>AQLPlan 实体对象。</returns>
        public AQLPlanInfo GetInfo(Int32 aQLPlanId)
        {
            AQLPlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = aQLPlanId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_AQLPlanGetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AQLPlanInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AQLPlan 实体对象。</returns>
        public AQLPlanInfo GetInfo(String fieldValue)
        {
            AQLPlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_AQLPlanGetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AQLPlan 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="aQLPlanCount">aQLPlan 总数。</param>
        /// <returns>AQLPlan 列表。</returns>
        public List<AQLPlanInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AQLPlanInfo> list = new List<AQLPlanInfo>();
            AQLPlanInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Quality_AQLPlan", "PlanID",
                "[PlanId], [AqlName], [AqlRuleTypeId], [AqlPlanType], [ApplyTo], [AqlPlanStatus], [AqlDescription], [Reject], [Remark], [CreaterBy], [CreateDate], [ModifyBy], [ModifyDate]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AQLPlanInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12));

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