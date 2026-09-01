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
    public class Scheduling
    {
        private Int32 recordCount = 0;


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
        public SchedulingInfo GetInfo(Int32 schedulingId)
        {
            SchedulingInfo entity = null;

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
                    entity = new SchedulingInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                   rdr.GetInt32(5), rdr.GetInt32(6), TypeHelper.ToString(rdr.GetDateTime(7)), TypeHelper.ToString(rdr.GetDateTime(8)), TypeHelper.ToString(rdr.GetDateTime(9)),
                   TypeHelper.ToString(rdr.GetDateTime(10)), rdr.GetInt32(11), rdr.GetInt32(12), rdr.GetInt32(13), rdr.GetString(14),
                   rdr.GetString(15), rdr.GetDecimal(16));
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
        public SchedulingInfo GetInfo(String fieldValue)
        {
            SchedulingInfo entity = null;

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
                    entity = new SchedulingInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                   rdr.GetInt32(5), rdr.GetInt32(6), TypeHelper.ToString(rdr.GetDateTime(7)), TypeHelper.ToString(rdr.GetDateTime(8)), TypeHelper.ToString(rdr.GetDateTime(9)),
                   TypeHelper.ToString(rdr.GetDateTime(10)), rdr.GetInt32(11), rdr.GetInt32(12), rdr.GetInt32(13), rdr.GetString(14),
                   rdr.GetString(15), rdr.GetDecimal(16));
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
        public List<SchedulingInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SchedulingInfo> list = new List<SchedulingInfo>();
            SchedulingInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProdScheduling", "SchedulingId",
                "[SchedulingId], ProdOrderNO, ProductName, FactoryCode, WorkSEQ, ProdOrderQty, FinishedQty, PlanBeginDate, PlanEndTime, ActualBeginDate, ActualEndTime, ScheduleId, SchedulingStatus, SchedulingSeq, Shift, Line, SchedulingQty", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SchedulingInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                   rdr.GetInt32(5), rdr.GetInt32(6), TypeHelper.ToString(rdr.GetDateTime(7)), TypeHelper.ToString(rdr.GetDateTime(8)), TypeHelper.ToString(rdr.GetDateTime(9)),
                   TypeHelper.ToString(rdr.GetDateTime(10)), rdr.GetInt32(11), rdr.GetInt32(12), rdr.GetInt32(13), rdr.GetString(14),
                   rdr.GetString(15), rdr.GetDecimal(16));

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
        /// <param name="stopOrCancell">1 暂停 2 取消</param>
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
        public void BomConfirmChange(string orderNO, string pubufts, string user)
        {
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@OrderNO", SqlDbType.NVarChar, 60)
                , new SqlParameter("@Pubufts", SqlDbType.NVarChar, 60)
                , new SqlParameter("@User", SqlDbType.VarChar, 20)
            };

            parms[0].Value = orderNO;
            parms[1].Value = pubufts;
            parms[2].Value = user;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMOBomConfirmUpdate", parms);

        }
    }
}