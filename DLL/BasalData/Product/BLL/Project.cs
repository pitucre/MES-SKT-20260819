using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Product.BLL
{
    public class Project
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Project 信息。
        /// </summary>
        /// <param name="entity">Project 实体对象。</param>
        public Int32 Edit(ProjectInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProjectId", SqlDbType.Int),
                new SqlParameter("@ProName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ProDesc", SqlDbType.NVarChar, 50),
                new SqlParameter("@CustomerID", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ProjectId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ProName;
            parms[2].Value = entity.ProDesc;
            parms[3].Value = entity.CustomerID;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Project_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ProjectId 字符串删除 Project 信息。
        /// </summary>
        /// <param name="idString">ProjectId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Project_Delete", parms);
        }

        /// <summary>
        /// 根据 ProjectId 获取实体信息。
        /// </summary>
        /// <param name="projectId">ProjectId。</param>
        /// <returns>Project 实体对象。</returns>
        public ProjectInfo GetInfo(Int32 projectId)
        {
            ProjectInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = projectId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Project_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProjectInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Project 实体对象。</returns>
        public ProjectInfo GetInfo(String fieldValue)
        {
            ProjectInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Project_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProjectInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Project 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="projectCount">project 总数。</param>
        /// <returns>Project 列表。</returns>
        public List<ProjectInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ProjectInfo> list = new List<ProjectInfo>();
            ProjectInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwCustomerPro", "ProjectId",
                "[ProjectId], [ProName], [ProDesc], [CustomerID], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [CustomerName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProjectInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.CustomerName = rdr.GetString(9);
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