using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Schedule.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Schedule.BLL
{
    public class SchedulePublishToLine
    {
        private Int32 recordCount = 0;


        /// <summary>
        /// 根据 SchedulePublishToLineId 获取实体信息。
        /// </summary>
        /// <param name="schedulePublishToLineId">SchedulePublishToLineId。</param>
        /// <returns>SchedulePublishToLine 实体对象。</returns>
        public SchedulePublishToLineInfo GetInfo(Int32 schedulePublishToLineId)
        {
            SchedulePublishToLineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = schedulePublishToLineId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_SchedulePublishToLine_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulePublishToLineInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SchedulePublishToLine 实体对象。</returns>
        public SchedulePublishToLineInfo GetInfo(String fieldValue)
        {
            SchedulePublishToLineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_SchedulePublishToLine_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulePublishToLineInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SchedulePublishToLine 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="schedulePublishToLineCount">schedulePublishToLine 总数。</param>
        /// <returns>SchedulePublishToLine 列表。</returns>
        public List<SchedulePublishToLineInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SchedulePublishToLineInfo> list = new List<SchedulePublishToLineInfo>();
            SchedulePublishToLineInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_SchedulePublishToLine", "SchedulePublishToLineId",
                "[Id], [LineId], [ScheduleId], [SchedulingId]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SchedulePublishToLineInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3));

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