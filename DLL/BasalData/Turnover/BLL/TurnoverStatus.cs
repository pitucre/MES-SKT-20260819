using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Turnover.Model;

namespace SKT.LeanMES.Turnover.BLL
{
    /// <summary>
    /// 周转工具状态
    /// </summary>
    public class TurnoverStatus
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） TurnoverStatus 信息。
        /// </summary>
        /// <param name="entity">TurnoverStatus 实体对象。</param>
        public void Edit(TurnoverStatusInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TurnoverStatusId", SqlDbType.Int),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.TurnoverStatusId;
            parms[1].Value = entity.Description;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverStatus_Edit", parms);
        }

        /// <summary>
        /// 根据 TurnoverStatusId 字符串删除 TurnoverStatus 信息。
        /// </summary>
        /// <param name="idString">TurnoverStatusId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverStatus_Delete", parms);
        }

        /// <summary>
        /// 根据 TurnoverStatusId 获取实体信息。
        /// </summary>
        /// <param name="TurnoverStatusId">TurnoverStatusId。</param>
        /// <returns>TurnoverStatus 实体对象。</returns>
        public TurnoverStatusInfo GetInfo(Int32 turnoverStatusId)
        {
            TurnoverStatusInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = turnoverStatusId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverStatus_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new TurnoverStatusInfo(rdr.GetInt32(0), rdr.GetString(1));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体TurnoverStatus信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>TurnoverStatus 实体对象。</returns>
        public TurnoverStatusInfo GetInfo(String fieldValue)
        {
            TurnoverStatusInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverStatus_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 TurnoverStatus 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="TurnoverStatusCount">TurnoverStatus 总数。</param>
        /// <returns>TurnoverStatus 列表。</returns>
        public List<TurnoverStatusInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TurnoverStatusInfo> list = new List<TurnoverStatusInfo>();
            TurnoverStatusInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_TurnoverStatus", "TurnoverStatusId",
                "[TurnoverStatusId], [Description]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TurnoverStatusInfo(rdr.GetInt32(0), rdr.GetString(1));

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