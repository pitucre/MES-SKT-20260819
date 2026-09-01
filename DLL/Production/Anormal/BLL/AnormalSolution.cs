using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.ProdAnormal.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.ProdAnormal.BLL
{
    public class AnormalSolution
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AnormalSolution 信息。
        /// </summary>
        /// <param name="entity">AnormalSolution 实体对象。</param>
        public Int32 Edit(AnormalSolutionInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SolutionId", SqlDbType.Int),
                new SqlParameter("@AnormalId", SqlDbType.Int),
                new SqlParameter("@ActionPerson", SqlDbType.NVarChar, 30),
                new SqlParameter("@Solution", SqlDbType.NVarChar, 500),
                new SqlParameter("@ActionTime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@AbnormalTimeLength", SqlDbType.Float),
                new SqlParameter("@AbnormalUnit", SqlDbType.NVarChar, 20),
                new SqlParameter("@EffectPerson", SqlDbType.Decimal)
            };

            parms[0].Value = entity.SolutionId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.AnormalId;
            parms[2].Value = entity.ActionPerson;
            parms[3].Value = entity.Solution;
            parms[4].Value = entity.ActionTime;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = entity.Remark;
            parms[8].Value = entity.AbnormalTimeLength;
            parms[9].Value = entity.AbnormalUnit;
            parms[10].Value = entity.EffectPerson;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalSolution_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AnormalSolutionId 字符串删除 AnormalSolution 信息。
        /// </summary>
        /// <param name="idString">AnormalSolutionId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalSolution_Delete", parms);
        }

        /// <summary>
        /// 根据 AnormalSolutionId 获取实体信息。
        /// </summary>
        /// <param name="anormalSolutionId">AnormalSolutionId。</param>
        /// <returns>AnormalSolution 实体对象。</returns>
        public AnormalSolutionInfo GetInfo(Int32 anormalSolutionId)
        {
            AnormalSolutionInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = anormalSolutionId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalSolution_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalSolutionInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDouble(10), rdr.GetString(11), rdr.GetDecimal(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AnormalSolution 实体对象。</returns>
        public AnormalSolutionInfo GetInfo(String fieldValue)
        {
            AnormalSolutionInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalSolution_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalSolutionInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDouble(10), rdr.GetString(11), rdr.GetDecimal(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AnormalSolution 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="anormalSolutionCount">anormalSolution 总数。</param>
        /// <returns>AnormalSolution 列表。</returns>
        public List<AnormalSolutionInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AnormalSolutionInfo> list = new List<AnormalSolutionInfo>();
            AnormalSolutionInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_AnormalSolution", "AnormalSolutionId",
                "[SolutionId], [AnormalId], [ActionPerson], [Solution], [ActionTime], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [AbnormalTimeLength], [AbnormalUnit], [EffectPerson]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AnormalSolutionInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDouble(10), rdr.GetString(11), rdr.GetDecimal(12));

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