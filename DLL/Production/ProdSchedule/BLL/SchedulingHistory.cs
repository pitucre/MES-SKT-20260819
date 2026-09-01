using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Schedule.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Schedule.BLL
{
    public class SchedulingHistory
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 根据 SchedulingHistoryId 获取实体信息。
        /// </summary>
        /// <param name="schedulingHistoryId">SchedulingHistoryId。</param>
        /// <returns>SchedulingHistory 实体对象。</returns>
        public SchedulingHistoryInfo GetInfo(Int32 schedulingHistoryId)
        {
            SchedulingHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = schedulingHistoryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_SchedulingHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulingHistoryInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDateTime(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SchedulingHistory 实体对象。</returns>
        public SchedulingHistoryInfo GetInfo(String fieldValue)
        {
            SchedulingHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_SchedulingHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulingHistoryInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDateTime(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SchedulingHistory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="schedulingHistoryCount">schedulingHistory 总数。</param>
        /// <returns>SchedulingHistory 列表。</returns>
        public List<SchedulingHistoryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SchedulingHistoryInfo> list = new List<SchedulingHistoryInfo>();
            SchedulingHistoryInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_SchedulingHistory", "SchedulingHistoryId",
                "[HistoryId], [SchedulingId], [OperateDateTime], [OperatePerson], [OperateType], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SchedulingHistoryInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDateTime(2), rdr.GetString(3), rdr.GetInt32(4), 
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