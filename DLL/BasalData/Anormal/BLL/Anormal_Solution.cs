using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Anormal.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Anormal.BLL
{
    public class Anormal_Solution
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Anormal_Solution 信息。
        /// </summary>
        /// <param name="entity">Anormal_Solution 实体对象。</param>
        public Int32 Edit(Anormal_SolutionInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RecordId", SqlDbType.Int),
                new SqlParameter("@AnormalId", SqlDbType.Int),
                new SqlParameter("@ActionTime", SqlDbType.DateTime),
                new SqlParameter("@Solution", SqlDbType.NVarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@ActionPerson", SqlDbType.NVarChar, 30)
            };

            parms[0].Value = entity.RecordId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.AnormalId;
            parms[2].Value = entity.ActionTime;
            parms[3].Value = entity.Solution;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;
            parms[7].Value = entity.ActionPerson;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Solution_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 Anormal_SolutionId 字符串删除 Anormal_Solution 信息。
        /// </summary>
        /// <param name="idString">Anormal_SolutionId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Solution_Delete", parms);
        }

        /// <summary>
        /// 根据 Anormal_SolutionId 获取实体信息。
        /// </summary>
        /// <param name="anormal_SolutionId">Anormal_SolutionId。</param>
        /// <returns>Anormal_Solution 实体对象。</returns>
        public Anormal_SolutionInfo GetInfo(Int32 anormal_SolutionId)
        {
            Anormal_SolutionInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = anormal_SolutionId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Solution_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new Anormal_SolutionInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDateTime(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Anormal_Solution 实体对象。</returns>
        public Anormal_SolutionInfo GetInfo(String fieldValue)
        {
            Anormal_SolutionInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Solution_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new Anormal_SolutionInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDateTime(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Anormal_Solution 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="anormal_SolutionCount">anormal_Solution 总数。</param>
        /// <returns>Anormal_Solution 列表。</returns>
        public List<Anormal_SolutionInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<Anormal_SolutionInfo> list = new List<Anormal_SolutionInfo>();
            Anormal_SolutionInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Anormal_Solution", "Anormal_SolutionId",
                "[RecordId], [AnormalId], [ActionTime], [Solution], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [ActionPerson]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new Anormal_SolutionInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDateTime(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9));

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