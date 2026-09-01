using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Schedule.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.Common.Utility;

namespace SKT.LeanMES.Schedule.BLL
{
    public class Schedules
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Schedule 信息。
        /// </summary>
        /// <param name="entity">Schedule 实体对象。</param>
        public void Edit(SchedulesInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MPID", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreatDate", SqlDbType.DateTime),
                new SqlParameter("@MoCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@BusType", SqlDbType.NVarChar, 10),
                new SqlParameter("@BusTypeName", SqlDbType.NVarChar, 255),
                new SqlParameter("@InvCode", SqlDbType.NVarChar, 30),
                new SqlParameter("@InvName", SqlDbType.NVarChar, 255),
                new SqlParameter("@ComUnitCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@MDeptCode", SqlDbType.NVarChar, 20),
                new SqlParameter("@MDeptName", SqlDbType.NVarChar, 20),
                new SqlParameter("@SortSeq", SqlDbType.NVarChar, 50),
                new SqlParameter("@SortSeqName", SqlDbType.NVarChar, 255),
                new SqlParameter("@Qty", SqlDbType.Decimal),
                new SqlParameter("@PlanQty", SqlDbType.Decimal),
                new SqlParameter("@PlanBeginDate", SqlDbType.DateTime),
                new SqlParameter("@PlanEndTime", SqlDbType.DateTime),
                new SqlParameter("@ModifyDate", SqlDbType.DateTime),
                new SqlParameter("@Memo", SqlDbType.NVarChar, 60),
                new SqlParameter("@Define1", SqlDbType.VarChar, 60),
                new SqlParameter("@Define2", SqlDbType.VarChar, 60),
                new SqlParameter("@Define3", SqlDbType.VarChar, 60),
                new SqlParameter("@Define4", SqlDbType.VarChar, 120),
                new SqlParameter("@Define5", SqlDbType.VarChar, 120),
                new SqlParameter("@Define6", SqlDbType.VarChar, 120),
                new SqlParameter("@Define7", SqlDbType.Int),
                new SqlParameter("@Define8", SqlDbType.Int),
                new SqlParameter("@Define9", SqlDbType.DateTime),
                new SqlParameter("@Define10", SqlDbType.DateTime),
                new SqlParameter("@pubufts", SqlDbType.NVarChar),
                new SqlParameter("@STATE", SqlDbType.TinyInt),
                new SqlParameter("@PublishStatus", SqlDbType.Int),
                new SqlParameter("@ScheduleId", SqlDbType.Int)
            };

            parms[0].Value = entity.MPID;
            parms[1].Value = entity.CreatDate;
            parms[2].Value = entity.MoCode;
            parms[3].Value = entity.BusType;
            parms[4].Value = entity.BusTypeName;
            parms[5].Value = entity.InvCode;
            parms[6].Value = entity.InvName;
            parms[7].Value = entity.ComUnitCode;
            parms[8].Value = entity.MDeptCode;
            parms[9].Value = entity.MDeptName;
            parms[10].Value = entity.SortSeq;
            parms[11].Value = entity.SortSeqName;
            parms[12].Value = entity.Qty;
            parms[13].Value = entity.PlanQty;
            parms[14].Value = entity.PlanBeginDate;
            parms[15].Value = entity.PlanEndTime;
            parms[16].Value = entity.ModifyDate;
            parms[17].Value = entity.Memo;
            parms[18].Value = entity.Define1;
            parms[19].Value = entity.Define2;
            parms[20].Value = entity.Define3;
            parms[21].Value = entity.Define4;
            parms[22].Value = entity.Define5;
            parms[23].Value = entity.Define6;
            parms[24].Value = entity.Define7;
            parms[25].Value = entity.Define8;
            parms[26].Value = entity.Define9;
            parms[27].Value = entity.Define10;
            parms[28].Value = entity.Pubufts;
            parms[29].Value = entity.State;
            parms[30].Value = entity.PublishStatus;
            parms[31].Value = entity.ScheduleId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Schedule_Edit", parms);

        }

        /// <summary>
        /// 根据 ScheduleId 字符串删除 Schedule 信息。
        /// </summary>
        /// <param name="idString">ScheduleId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Schedule_Delete", parms);
        }

        /// <summary>
        /// 根据 ScheduleId 获取实体信息。
        /// </summary>
        /// <param name="scheduleId">ScheduleId。</param>
        /// <returns>Schedule 实体对象。</returns>
        public SchedulesInfo GetInfo(Int32 scheduleId)
        {
            SchedulesInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = scheduleId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Schedule_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulesInfo(rdr.GetDecimal(0), TypeHelper.ToString(rdr.GetDateTime(1)), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), TypeHelper.ToString(rdr.GetDateTime(14)),
                        TypeHelper.ToString(rdr.GetDateTime(15)), TypeHelper.ToString(rdr.GetDateTime(16)), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19),
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetInt32(24),
                        rdr.GetInt32(25), TypeHelper.ToString(rdr.GetDateTime(26)), TypeHelper.ToString(rdr.GetDateTime(27)), rdr.GetString(28), rdr.GetByte(29),
                        rdr.GetInt32(30), rdr.GetInt32(31), rdr.GetInt32(32), rdr.GetBoolean(33), rdr.GetDecimal(34), rdr.GetDecimal(35));

                    entity.WorkSEQ = rdr.GetString(36);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Schedule 实体对象。</returns>
        public SchedulesInfo GetInfo(String fieldValue)
        {
            SchedulesInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Schedule_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulesInfo(rdr.GetDecimal(0), TypeHelper.ToString(rdr.GetDateTime(1)), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), TypeHelper.ToString(rdr.GetDateTime(14)), 
                        TypeHelper.ToString(rdr.GetDateTime(15)), TypeHelper.ToString(rdr.GetDateTime(16)), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetInt32(24), 
                        rdr.GetInt32(25), TypeHelper.ToString(rdr.GetDateTime(26)), TypeHelper.ToString(rdr.GetDateTime(27)), rdr.GetString(28), rdr.GetByte(29),
                        rdr.GetInt32(30), rdr.GetInt32(31), rdr.GetInt32(32), rdr.GetBoolean(33), rdr.GetDecimal(34), rdr.GetDecimal(35));

                    entity.WorkSEQ = rdr.GetString(36);
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Schedule 实体对象。</returns>
        public SchedulesInfo GetInfo(String moCode, String workSEQ)
        {
            SchedulesInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MoCode", SqlDbType.NVarChar, 60), 
                new SqlParameter("@WorkSEQ", SqlDbType.NVarChar, 60)
            };

            parms[0].Value = moCode;
            parms[1].Value = workSEQ;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Schedule_GetInfoByMR", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulesInfo(rdr.GetDecimal(0), TypeHelper.ToString(rdr.GetDateTime(1)), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), TypeHelper.ToString(rdr.GetDateTime(14)),
                        TypeHelper.ToString(rdr.GetDateTime(15)), TypeHelper.ToString(rdr.GetDateTime(16)), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19),
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetInt32(24),
                        rdr.GetInt32(25), TypeHelper.ToString(rdr.GetDateTime(26)), TypeHelper.ToString(rdr.GetDateTime(27)), rdr.GetString(28), rdr.GetByte(29),
                        rdr.GetInt32(30), rdr.GetInt32(31), rdr.GetInt32(32), rdr.GetBoolean(33), rdr.GetDecimal(34), rdr.GetDecimal(35));

                    entity.WorkSEQ = rdr.GetString(36);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Schedule 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="scheduleCount">schedule 总数。</param>
        /// <returns>Schedule 列表。</returns>
        public List<SchedulesInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SchedulesInfo> list = new List<SchedulesInfo>();
            SchedulesInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProdSchedule", "ScheduleId",
                "[MPID], [CreatDate], [MoCode], [BusType], [BusTypeName], [InvCode], [InvName], [ComUnitCode], [MDeptCode], [MDeptName], [RSortSeq], [SortSeqName], [Qty], [PlanQty], [PlanBeginDate], [PlanEndTime], [ModifyDate], [Memo], [Define1], [Define2], [Define3], [Define4], [Define5], [Define6], [Define7], [Define8], [Define9], [Define10], [pubufts], [STATE], [PublishStatus], [ScheduleId], [KittingStatus], [HaveUpdate], [SortSeq], WorkSEQ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SchedulesInfo(rdr.GetDecimal(0), TypeHelper.ToString(rdr.GetDateTime(1)), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), TypeHelper.ToString(rdr.GetDateTime(14)),
                        TypeHelper.ToString(rdr.GetDateTime(15)), TypeHelper.ToString(rdr.GetDateTime(16)), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetInt32(24), 
                        rdr.GetInt32(25), TypeHelper.ToString(rdr.GetDateTime(26)), TypeHelper.ToString(rdr.GetDateTime(27)), rdr.GetString(28), rdr.GetByte(29), 
                        rdr.GetInt32(30), rdr.GetInt32(31), rdr.GetInt32(32), rdr.GetBoolean(33), -1 , rdr.GetDecimal(34));

                    entity.WorkSEQ = rdr.GetString(35);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 分页获取 未发布的“排程分配信息” 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="scheduleCount">schedule 总数。</param>
        /// <returns>Schedule 列表。</returns>
        public List<SchedulesInfo> GetAllottedScheduleAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SchedulesInfo> list = new List<SchedulesInfo>();
            SchedulesInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwScheduleAllttedList", "Id",
                "[MPID], [MoCode], [RSortSeq], [InvCode], [InvName], [AllotQty], [PlanBeginDate], [PlanEndTime], [LineName], [ShiftName], [Id], [WorkSEQ]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SchedulesInfo();
                    entity.MPID = rdr.GetDecimal(0);
                    entity.MoCode = rdr.GetValue(1).ToString();
                    entity.RSortSeq = rdr.GetValue(2).ToString();
                    entity.InvCode = rdr.GetValue(3).ToString();
                    entity.InvName = rdr.GetValue(4).ToString();
                    entity.AllotQty = rdr.GetDecimal(5);
                    entity.PlanBeginDate = rdr.GetValue(6).ToString();
                    entity.PlanEndTime = rdr.GetValue(7).ToString();
                    entity.LineName = rdr.GetValue(8).ToString();
                    entity.ShiftName = rdr.GetValue(9).ToString();
                    entity.AllotId = rdr.GetInt32(10);
                    entity.WorkSEQ = rdr.GetString(11);

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
        /// 立即触发排程导入
        /// </summary>
        public void AtOnceImportSchedule()
        {
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspScheduleImport", null);
        }

        /// <summary>
        /// 排程齐套验证
        /// </summary>
        /// <param name="scheduleId"></param>
        public void Kitting(int scheduleId)
        {
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@UnKitting", SqlDbType.Bit)
                ,new SqlParameter("@ScheduleId", SqlDbType.Int)
            };

            parms[0].Value = 0;
            parms[1].Value = scheduleId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspScheduleKittingCheck", parms);
        }

        /// <summary>
        /// 排程取消齐套锁定
        /// </summary>
        /// <param name="scheduleId"></param>
        public void UnKitting(int scheduleId)
        {
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@UnKitting", SqlDbType.Bit)
                ,new SqlParameter("@ScheduleId", SqlDbType.Int)
            };

            parms[0].Value = 1;
            parms[1].Value = scheduleId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspScheduleKittingCheck", parms);
        }

        /// <summary>
        /// 排程发布
        /// </summary>
        /// <param name="scheduleId"></param>
        public void SchedulePublish(int scheduleId, string user)
        {
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@ScheduleId", SqlDbType.Int)
                , new SqlParameter("@User",SqlDbType.VarChar, 20)
            };

            parms[0].Value = scheduleId;
            parms[1].Value = user;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSchedulePublish", parms);
        }

        /// <summary>
        /// 排程发布
        /// </summary>
        /// <param name="scheduleId"></param>
        public void ScheduleAllottedPublish(string user)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@User",SqlDbType.VarChar, 20)
            };

            parms[0].Value = user;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspScheduleAllottedPublish", parms);
        }

        /// <summary>
        /// 排程分配
        /// </summary>
        /// <param name="scheduleId"></param>
        /// <param name="shift">班次Id字符串</param>
        /// <param name="qty">数量字符串</param>
        /// <param name="line">线体Id字符串</param>
        public void ScheduleAllot(int scheduleId, string shift, string qty, string line, string user)
        {
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@ScheduleId", SqlDbType.Int)
                , new SqlParameter("@ShiftStr",SqlDbType.NVarChar, 500)
                , new SqlParameter("@QtyStr",SqlDbType.VarChar, 1000)
                , new SqlParameter("@LineStr",SqlDbType.NVarChar, 500)
                , new SqlParameter("@User",SqlDbType.VarChar, 20)
            };

            parms[0].Value = scheduleId;
            parms[1].Value = shift;
            parms[2].Value = qty;
            parms[3].Value = line;
            parms[4].Value = user;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspScheduleAllot", parms);
        }
        
        /// <summary>
        /// 获取该排程的分配数据
        /// </summary>
        /// <param name="scheduleId"></param>
        public List<SchedulePublishToLineInfo> GetScheduleAllotList(int scheduleId)
        {
            SchedulePublishToLineInfo entity = null;
            List<SchedulePublishToLineInfo> list = new List<SchedulePublishToLineInfo>();

            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@ScheduleId", SqlDbType.Int)
            };

            parms[0].Value = scheduleId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspScheduleAllotList", parms))
            {
                while(rdr.Read())
                {
                    entity = new SchedulePublishToLineInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), rdr.GetString(5), rdr.GetDecimal(6));
                    entity.IsPublish = rdr.GetBoolean(7);

                    list.Add(entity);
                }

                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 排程分配后的记录发布
        /// </summary>
        /// <param name="scheduleAllotId">分配记录Id</param>
        /// <param name="user"></param>
        public void ScheduleAllotPublish(int scheduleAllotId, string user)
        {
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@ScheduleAllotId", SqlDbType.Int)
                , new SqlParameter("@User",SqlDbType.VarChar, 20)
            };

            parms[0].Value = scheduleAllotId;
            parms[1].Value = user;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspScheduleAllotPublish", parms);
        }



    }
}