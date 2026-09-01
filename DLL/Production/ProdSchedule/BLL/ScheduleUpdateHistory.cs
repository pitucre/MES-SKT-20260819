using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Schedule.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Schedule.BLL
{
    public class ScheduleUpdateHistory
    {
        private Int32 recordCount = 0;


        /// <summary>
        /// 根据 ScheduleUpdateHistoryId 获取实体信息。
        /// </summary>
        /// <param name="scheduleUpdateHistoryId">ScheduleUpdateHistoryId。</param>
        /// <returns>ScheduleUpdateHistory 实体对象。</returns>
        public ScheduleUpdateHistoryInfo GetInfo(Int32 scheduleUpdateHistoryId)
        {
            ScheduleUpdateHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = scheduleUpdateHistoryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ScheduleUpdateHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ScheduleUpdateHistoryInfo(rdr.GetInt32(0), rdr.GetDecimal(1), rdr.GetDateTime(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDecimal(13), rdr.GetDecimal(14), 
                        rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetDateTime(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetString(24),
                        rdr.GetInt32(25), rdr.GetInt32(26), rdr.GetDateTime(27), rdr.GetDateTime(28), rdr.GetString(29),
                        rdr.GetByte(30), rdr.GetDateTime(31), rdr.GetString(32), rdr.GetString(33), rdr.GetDecimal(34));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ScheduleUpdateHistory 实体对象。</returns>
        public ScheduleUpdateHistoryInfo GetInfo(String fieldValue)
        {
            ScheduleUpdateHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ScheduleUpdateHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ScheduleUpdateHistoryInfo(rdr.GetInt32(0), rdr.GetDecimal(1), rdr.GetDateTime(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDecimal(13), rdr.GetDecimal(14), 
                        rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetDateTime(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetString(24),
                        rdr.GetInt32(25), rdr.GetInt32(26), rdr.GetDateTime(27), rdr.GetDateTime(28), rdr.GetString(29),
                        rdr.GetByte(30), rdr.GetDateTime(31), rdr.GetString(32), rdr.GetString(33), rdr.GetDecimal(34));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ScheduleUpdateHistory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="scheduleUpdateHistoryCount">scheduleUpdateHistory 总数。</param>
        /// <returns>ScheduleUpdateHistory 列表。</returns>
        public List<ScheduleUpdateHistoryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ScheduleUpdateHistoryInfo> list = new List<ScheduleUpdateHistoryInfo>();
            ScheduleUpdateHistoryInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_ScheduleUpdateHistory", "ScheduleUpdateHistoryId",
                "[HistoryId], [MPID], [CreatDate], [MoCode], [BusType], [BusTypeName], [InvCode], [InvName], [ComUnitCode], [MDeptCode], [MDeptName], [SortSeq], [SortSeqName], [Qty], [PlanQty], [PlanBeginDate], [PlanEndTime], [ModifyDate], [Memo], [Define1], [Define2], [Define3], [Define4], [Define5], [Define6], [Define7], [Define8], [Define9], [Define10], [pubufts], [STATE], [UpdateDateTime], [UpdatePerson], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ScheduleUpdateHistoryInfo(rdr.GetInt32(0), rdr.GetDecimal(1), rdr.GetDateTime(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDecimal(13), rdr.GetDecimal(14), 
                        rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetDateTime(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetString(24),
                        rdr.GetInt32(25), rdr.GetInt32(26), rdr.GetDateTime(27), rdr.GetDateTime(28), rdr.GetString(29),
                        rdr.GetByte(30), rdr.GetDateTime(31), rdr.GetString(32), rdr.GetString(33), rdr.GetDecimal(34));

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