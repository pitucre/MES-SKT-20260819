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
    public class bScheduling
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Scheduling 信息。
        /// </summary>
        /// <param name="entity">Scheduling 实体对象。</param>
        public void Edit(bSchedulingInfo entity)
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
                new SqlParameter("@ScheduleId", SqlDbType.Int),
                new SqlParameter("@SchedulingId", SqlDbType.Int),
                new SqlParameter("@SchedulingStatus", SqlDbType.Int)
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
            parms[30].Value = entity.ScheduleId;
            parms[31].Value = entity.SchedulingId;
            parms[32].Value = entity.SchedulingStatus;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Scheduling_Edit", parms);

        }

        /// <summary>
        /// 根据 SchedulingId 字符串删除 Scheduling 信息。
        /// </summary>
        /// <param name="idString">SchedulingId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Scheduling_Delete", parms);
        }

        /// <summary>
        /// 根据 SchedulingId 获取实体信息。
        /// </summary>
        /// <param name="schedulingId">SchedulingId。</param>
        /// <returns>Scheduling 实体对象。</returns>
        public bSchedulingInfo GetInfo(Int32 schedulingId)
        {
            bSchedulingInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = schedulingId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Scheduling_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new bSchedulingInfo(rdr.GetDecimal(0), TypeHelper.ToString(rdr.GetDateTime(1)), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), TypeHelper.ToString(rdr.GetDateTime(14)), 
                        TypeHelper.ToString(rdr.GetDateTime(15)), TypeHelper.ToString(rdr.GetDateTime(16)), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetInt32(24),
                        rdr.GetInt32(25), TypeHelper.ToString(rdr.GetDateTime(26)), TypeHelper.ToString(rdr.GetDateTime(27)), rdr.GetString(28), rdr.GetByte(29), 
                        rdr.GetInt32(30), rdr.GetInt32(31), rdr.GetInt32(32));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Scheduling 实体对象。</returns>
        public bSchedulingInfo GetInfo(String fieldValue)
        {
            bSchedulingInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Scheduling_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new bSchedulingInfo(rdr.GetDecimal(0), TypeHelper.ToString(rdr.GetDateTime(1)), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), TypeHelper.ToString(rdr.GetDateTime(14)),
                        TypeHelper.ToString(rdr.GetDateTime(15)), TypeHelper.ToString(rdr.GetDateTime(16)), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19),
                        rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetInt32(24),
                        rdr.GetInt32(25), TypeHelper.ToString(rdr.GetDateTime(26)), TypeHelper.ToString(rdr.GetDateTime(27)), rdr.GetString(28), rdr.GetByte(29),
                        rdr.GetInt32(30), rdr.GetInt32(31), rdr.GetInt32(32));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Scheduling 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="schedulingCount">scheduling 总数。</param>
        /// <returns>Scheduling 列表。</returns>
        public List<bSchedulingInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<bSchedulingInfo> list = new List<bSchedulingInfo>();
            bSchedulingInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProdScheduling", "SchedulingId",
                "[MPID], [CreatDate], [MoCode], [BusType], [BusTypeName], [InvCode], [InvName], [ComUnitCode], [MDeptCode], [MDeptName], [SortSeq], [SortSeqName], [Qty], [PlanQty], [PlanBeginDate], [PlanEndTime], [ModifyDate], [Memo], [Define1], [Define2], [Define3], [Define4], [Define5], [Define6], [Define7], [Define8], [Define9], [Define10], [pubufts], [STATE], [ScheduleId], [SchedulingId], [SchedulingStatus]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new bSchedulingInfo(rdr.GetDecimal(0), TypeHelper.ToString(rdr.GetDateTime(1)), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                   rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                   rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), TypeHelper.ToString(rdr.GetDateTime(14)),
                   TypeHelper.ToString(rdr.GetDateTime(15)), TypeHelper.ToString(rdr.GetDateTime(16)), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19),
                   rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetInt32(24),
                   rdr.GetInt32(25), TypeHelper.ToString(rdr.GetDateTime(26)), TypeHelper.ToString(rdr.GetDateTime(27)), rdr.GetString(28), rdr.GetByte(29),
                   rdr.GetInt32(30), rdr.GetInt32(31), rdr.GetInt32(32));

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
        /// 排产数量变更
        /// </summary>
        /// <param name="schedulingId">排产Id</param>
        /// <param name="isGet">1 获取数量 2 确认变更</param>
        /// <returns>返回原数量和新数量</returns>
        public string[] SchedulingQtyChange(int schedulingId, decimal changeQty, string user, int isGet)
        {
            string[] arr = { "-1", "-1" };

            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@SchedulingId", SqlDbType.Int)
                , new SqlParameter("@User", SqlDbType.VarChar, 20)
                , new SqlParameter("@IsGet", SqlDbType.Int)
                , new SqlParameter("@OldQty", SqlDbType.Decimal)
                , new SqlParameter("@NewQty", SqlDbType.Decimal)
            };

            parms[0].Value = schedulingId;
            parms[1].Value = user;
            parms[2].Value = isGet;
            parms[3].Direction = ParameterDirection.Output;
            parms[4].Value = changeQty;
            parms[4].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSchedulingQtyChange", parms);

            arr[0] = parms[3].Value.ToString();
            arr[1] = parms[4].Value.ToString();

            return arr;
        }

        /// <summary>
        /// 排产顺序变更
        /// </summary>
        /// <param name="schedulingId">排产Id</param>
        /// <param name="upOrDownOrSwop">1 上移 2 下移 3 调换</param>
        /// <param name="swopSchedulingId">参与交换的排产Id</param>
        public void SchedulingSeqChange(int schedulingId, string user, int upOrDownOrSwop, int swopSchedulingId)
        {

            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@SchedulingId", SqlDbType.Int)
                , new SqlParameter("@User", SqlDbType.VarChar, 20)
                , new SqlParameter("@UpOrDownOrSwop", SqlDbType.Int)
                , new SqlParameter("@SwopSchedulingId", SqlDbType.Int)
            };

            parms[0].Value = schedulingId;
            parms[1].Value = user;
            parms[2].Value = upOrDownOrSwop;
            parms[3].Value = swopSchedulingId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSchedulingSeqChange", parms);

        }


        /// <summary>
        /// 排产暂停或取消
        /// </summary>
        /// <param name="schedulingId">排产Id</param>
        /// <param name="stopOrCancel">1 暂停 2 取消</param>
        public void SchedulingStopOrCancel(int schedulingId, string user, int stopOrCancel)
        {

            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@SchedulingId", SqlDbType.Int)
                , new SqlParameter("@User", SqlDbType.VarChar, 20)
                , new SqlParameter("@StopOrCancel", SqlDbType.Int)
            };

            parms[0].Value = schedulingId;
            parms[1].Value = user;
            parms[2].Value = stopOrCancel;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSchedulingStopOrCancel", parms);

        }

        /// <summary>
        /// 取消停止排产
        /// </summary>
        /// <param name="schedulingId">排产Id</param>
        public void CancelStopScheduling(int schedulingId, string user)
        {

            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@SchedulingId", SqlDbType.Int)
                , new SqlParameter("@User", SqlDbType.VarChar, 20)
            };

            parms[0].Value = schedulingId;
            parms[1].Value = user;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSchedulingCancelStop", parms);

        }


        /// <summary>
        /// 工单BOM变更
        /// </summary>
        /// <param name="id">ERP_MOBOM_ChangeId</param>
        public void BomConfirmChange(int id, string user)
        {
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@Id", SqlDbType.Int)
                , new SqlParameter("@User", SqlDbType.VarChar, 20)
            };

            parms[0].Value = id;
            parms[1].Value = user;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMOBomConfirmUpdate", parms);

        }
    }
}