using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class InspectionRule
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionRule 信息。
        /// </summary>
        /// <param name="entity">InspectionRule 实体对象。</param>
        public Int32 Edit(InspectionRuleInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionRuleId", SqlDbType.Int),
                new SqlParameter("@InspectionRuleName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Creater", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreateTime", SqlDbType.DateTime),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionTemplateIdList", SqlDbType.NVarChar, 50),
                new SqlParameter("@Status", SqlDbType.Bit)
            };

            parms[0].Value = entity.InspectionRuleId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.InspectionRuleName;
            parms[2].Value = entity.Creater;
            parms[3].Value = entity.CreateTime;
            parms[4].Value = entity.Description;
            parms[5].Value = entity.InspectionTemplateIdList;
            parms[6].Value = entity.Status;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionRule_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 InspectionRuleId 字符串删除 InspectionRule 信息。
        /// </summary>
        /// <param name="idString">InspectionRuleId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionRule_Delete", parms);
        }

        /// <summary>
        /// 根据 InspectionRuleId 获取实体信息。
        /// </summary>
        /// <param name="inspectionRuleId">InspectionRuleId。</param>
        /// <returns>InspectionRule 实体对象。</returns>
        public InspectionRuleInfo GetInfo(Int32 inspectionRuleId)
        {
            InspectionRuleInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = inspectionRuleId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionRule_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new InspectionRuleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetBoolean(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionRule 实体对象。</returns>
        public InspectionRuleInfo GetInfo(String fieldValue)
        {
            InspectionRuleInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionRule_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new InspectionRuleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetBoolean(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 InspectionRule 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionRuleCount">inspectionRule 总数。</param>
        /// <returns>InspectionRule 列表。</returns>
        public List<InspectionRuleInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionRuleInfo> list = new List<InspectionRuleInfo>();
            InspectionRuleInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Quality_InspectionRule", "InspectionRuleId",
                "[InspectionRuleId] ,[InspectionRuleName], [Creater], [CreateTime], [Description], [InspectionTemplateIdList], [Status]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new InspectionRuleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetBoolean(6));

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