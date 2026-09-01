using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Schedule.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Schedule.BLL
{
    public class SchedulePublishHistory
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 根据 SchedulePublishHistoryId 获取实体信息。
        /// </summary>
        /// <param name="schedulePublishHistoryId">SchedulePublishHistoryId。</param>
        /// <returns>SchedulePublishHistory 实体对象。</returns>
        public SchedulePublishHistoryInfo GetInfo(Int32 schedulePublishHistoryId)
        {
            SchedulePublishHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = schedulePublishHistoryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_SchedulePublishHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulePublishHistoryInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDateTime(3), rdr.GetString(4), 
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
        /// <returns>SchedulePublishHistory 实体对象。</returns>
        public SchedulePublishHistoryInfo GetInfo(String fieldValue)
        {
            SchedulePublishHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_SchedulePublishHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulePublishHistoryInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDateTime(3), rdr.GetString(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SchedulePublishHistory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="schedulePublishHistoryCount">schedulePublishHistory 总数。</param>
        /// <returns>SchedulePublishHistory 列表。</returns>
        public List<SchedulePublishHistoryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SchedulePublishHistoryInfo> list = new List<SchedulePublishHistoryInfo>();
            SchedulePublishHistoryInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_SchedulePublishHistory", "SchedulePublishHistoryId",
                "[HistoryId], [ScheduleId], [SchedulingId], [PublishDateTime], [PublishPerson], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SchedulePublishHistoryInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDateTime(3), rdr.GetString(4), 
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