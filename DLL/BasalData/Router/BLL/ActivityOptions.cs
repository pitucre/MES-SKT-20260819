using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Router.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Router.BLL
{
    public class ActivityOptions
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ActivityOptions 信息。
        /// </summary>
        /// <param name="entity">ActivityOptions 实体对象。</param>
        public Int32 Edit(ActivityOptionsInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AOID", SqlDbType.Int),
                new SqlParameter("@AC_ID", SqlDbType.Int),
                new SqlParameter("@AC_Param_Sequence", SqlDbType.Int),
                new SqlParameter("@AC_Param_Name", SqlDbType.NVarChar, 100),
                new SqlParameter("@AC_Param_Value", SqlDbType.NVarChar, 100),
                new SqlParameter("@AC_Param_Remark", SqlDbType.NVarChar, 100)
            };

            parms[0].Value = entity.AOID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.AC_ID;
            parms[2].Value = entity.AC_Param_Sequence;
            parms[3].Value = entity.AC_Param_Name;
            parms[4].Value = entity.AC_Param_Value;
            parms[5].Value = entity.AC_Param_Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ActivityOptions_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ActivityOptionsId 字符串删除 ActivityOptions 信息。
        /// </summary>
        /// <param name="idString">ActivityOptionsId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ActivityOptions_Delete", parms);
        }

        /// <summary>
        /// 根据 ActivityOptionsId 获取实体信息。
        /// </summary>
        /// <param name="activityOptionsId">ActivityOptionsId。</param>
        /// <returns>ActivityOptions 实体对象。</returns>
        public List<ActivityOptionsInfo> GetActionByACID(Int32  AC_ID)
        {
            List<ActivityOptionsInfo> list = new List<ActivityOptionsInfo>();
            ActivityOptionsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AC_ID", SqlDbType.Int)
            };

            parms[0].Value = AC_ID;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspActivityByACID", parms))
            {
                while (rdr.Read())
                {
                    entity = new ActivityOptionsInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ActivityOptions 实体对象。</returns>
        public ActivityOptionsInfo GetInfo(String fieldValue)
        {
            ActivityOptionsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ActivityOptions_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ActivityOptionsInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ActivityOptions 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="activityOptionsCount">activityOptions 总数。</param>
        /// <returns>ActivityOptions 列表。</returns>
        public List<ActivityOptionsInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ActivityOptionsInfo> list = new List<ActivityOptionsInfo>();
            ActivityOptionsInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_ActivityOptions", "ActivityOptionsId",
                "[AOID], [AC_ID], [AC_Param_Sequence], [AC_Param_Name], [AC_Param_Value], [AC_Param_Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ActivityOptionsInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));

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