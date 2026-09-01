using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Schedule.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Schedule.BLL
{
    public class ScheduleUpdate
    {
        private Int32 recordCount = 0;


        /// <summary>
        /// 根据 ScheduleUpdateId 获取实体信息。
        /// </summary>
        /// <param name="scheduleUpdateId">ScheduleUpdateId。</param>
        /// <returns>ScheduleUpdate 实体对象。</returns>
        public ScheduleUpdateInfo GetInfo(Int32 scheduleUpdateId)
        {
            ScheduleUpdateInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = scheduleUpdateId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ScheduleUpdate_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ScheduleUpdateInfo(rdr.GetDecimal(0), rdr.GetDateTime(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetDateTime(14), 
                        rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetInt32(24),
                        rdr.GetInt32(25), rdr.GetDateTime(26), rdr.GetDateTime(27), rdr.GetString(28), rdr.GetInt32(29), rdr.GetDecimal(30));
                    
                    entity.WorkSEQ = rdr.GetString(31);
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 根据 ScheduleUpdateId 获取实体信息。
        /// </summary>
        /// <param name="scheduleUpdateId">ScheduleUpdateId。</param>
        /// <returns>ScheduleUpdate 实体对象。</returns>
        public ScheduleUpdateInfo GetInfo(String moCode, String workSEQ, String pubufts)
        {
            ScheduleUpdateInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MoCode", SqlDbType.NVarChar, 60), 
                new SqlParameter("@WorkSEQ", SqlDbType.NVarChar, 60),
                new SqlParameter("@pubufts", SqlDbType.NVarChar, 60)
            };

            parms[0].Value = moCode;
            parms[1].Value = workSEQ;
            parms[2].Value = pubufts;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ScheduleUpdate_GetInfoByMR", parms))
            {
                if (rdr.Read())
                {
                    entity = new ScheduleUpdateInfo(rdr.GetDecimal(0), rdr.GetDateTime(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetDateTime(14),
                        rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19),
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetInt32(24),
                        rdr.GetInt32(25), rdr.GetDateTime(26), rdr.GetDateTime(27), rdr.GetString(28), rdr.GetInt32(29), rdr.GetDecimal(30));

                    entity.WorkSEQ = rdr.GetString(31);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ScheduleUpdate 实体对象。</returns>
        public ScheduleUpdateInfo GetInfo(String fieldValue)
        {
            ScheduleUpdateInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ScheduleUpdate_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ScheduleUpdateInfo(rdr.GetDecimal(0), rdr.GetDateTime(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetDateTime(14), 
                        rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetInt32(24),
                        rdr.GetInt32(25), rdr.GetDateTime(26), rdr.GetDateTime(27), rdr.GetString(28), rdr.GetInt32(29), rdr.GetDecimal(30));
                    
                    entity.WorkSEQ = rdr.GetString(31);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ScheduleUpdate 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="scheduleUpdateCount">scheduleUpdate 总数。</param>
        /// <returns>ScheduleUpdate 列表。</returns>
        public List<ScheduleUpdateInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ScheduleUpdateInfo> list = new List<ScheduleUpdateInfo>();
            ScheduleUpdateInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_ScheduleUpdate", "ScheduleId",
                "[MPID], [CreatDate], [MoCode], [BusType], [BusTypeName], [InvCode], [InvName], [ComUnitCode], [MDeptCode], [MDeptName], [RSortSeq], [SortSeqName], [Qty], [PlanQty], [PlanBeginDate], [PlanEndTime], [ModifyDate], [Memo], [Define1], [Define2], [Define3], [Define4], [Define5], [Define6], [Define7], [Define8], [Define9], [Define10], [pubufts], [STATE], ScheduleId, [SortSeq], WorkSEQ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ScheduleUpdateInfo(rdr.GetDecimal(0), rdr.GetDateTime(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetDateTime(14), 
                        rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetInt32(24),
                        rdr.GetInt32(25), rdr.GetDateTime(26), rdr.GetDateTime(27), rdr.GetString(28), rdr.GetInt32(29), rdr.GetDecimal(31));

                    entity.ScheduleId = rdr.GetInt32(30);
                    entity.WorkSEQ = rdr.GetString(31);

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


        /// <summary>
        /// 排程确认更新
        /// </summary>
        /// <param name="scheduleId"></param>
        /// <param name="user">操作员</param>
        /// <param name="update">1 忽略此更新 2  更新</param>
        public void ConfirmUpdate(string moCode, string workSEQ, string pubufts, string user, int update)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@OrderNO", SqlDbType.NVarChar,60) 
                , new SqlParameter("@WorkSEQ", SqlDbType.NVarChar,60) 
                , new SqlParameter("@pubufts", SqlDbType.NVarChar,60) 
                , new SqlParameter("@User",SqlDbType.VarChar, 20)
                , new SqlParameter("@Update",SqlDbType.TinyInt)
            };

            parms[0].Value = moCode;
            parms[1].Value = workSEQ;
            parms[2].Value = pubufts;
            parms[3].Value = user;
            parms[4].Value = update;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspScheduleConfirmUpdate", parms);
        }

    }
}