using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Plan.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Plan.BLL
{
    public class SchedulOrderDal
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 确认排产工单
        /// </summary>
        /// <param name="idString">ProdOrderId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void ConfirmOrderSchedul(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Confirm_OrderSchedul", parms);
        }

        /// <summary>
        /// 取消工单排产
        /// </summary>
        /// <param name="idString">PlanId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void CancelOrderSchedul(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Cancel_OrderSchedul", parms);
        }
        
        /// <summary>
        /// 分页获取 排产工单列表 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>Plan 列表。</returns>
        public List<SchedulOrderInfo> GetAllList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SchedulOrderInfo> list = new List<SchedulOrderInfo>();
            SchedulOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetOrderSchedulList", "ProdOrderID",
                  @"ProdOrderID,OrderNo,SchedulNum,Status,ItemCode,ItemName,ProductionFace,Priority,Planned_Start_Time,IsSmt", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SchedulOrderInfo();
                    entity.ProdOrderId = Convert.ToInt32(rdr["ProdOrderID"]);
                    entity.SchedulNum = Convert.ToInt32(rdr["SchedulNum"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.OrderNo = Convert.ToString(rdr["OrderNo"]);
                    entity.Status = Convert.ToString(rdr["Status"]);
                    entity.ProductionFace = Convert.ToString(rdr["ProductionFace"]);
                    entity.Priority = Convert.ToInt32(rdr["Priority"]);
                    entity.PlannedStartTime = Convert.ToDateTime(rdr["Planned_Start_Time"]);
                    entity.IsSmt = Convert.ToBoolean(rdr["IsSmt"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取线别生产负荷信息
        /// </summary>
        /// <param name="lineName">线别名称</param>
        /// <param name="dayTime">时间</param>
        /// <returns></returns>
        public DataSet GetLineProductLoad(string lineName,string dayTime)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@LineName",SqlDbType.VarChar),
                  new SqlParameter("@DayTime",SqlDbType.VarChar)
            };
            parms[0].Value = lineName;
            parms[1].Value = dayTime;
            DataSet ds = ComMethod.GetListDataSet("uspGetLineSchedulLoadList", parms);

            return ds;
        }


        /// <summary>
        /// 获取线别ID与时间生产负荷信息
        /// </summary>
        /// <param name="lineId">线别ID</param>
        /// <param name="dayTime">时间</param>
        /// <returns></returns>
        public DataTable GetLineDayProductLoad(int lineId, string dayTime)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@LineId",SqlDbType.VarChar),
                  new SqlParameter("@DayTime",SqlDbType.DateTime)
            };
            parms[0].Value = lineId;
            parms[1].Value = dayTime;
            DataTable ds= ComMethod.GetListDataSet("GetLineDayProductLoad", parms).Tables[0];

            return ds;
        }


        /// <summary>
        /// 生成排产计划
        /// </summary>
        /// <param name="xmlString">xmlString 字符串。</param>
        /// <param name="userName">xmlString 字符串。</param>
        /// <returns>日志内容。</returns>
        public void CreateSchedulPlan(string  xmlString, string userName,int days)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@XmlString", SqlDbType.VarChar),
                new SqlParameter("@Day", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = xmlString;
            parms[1].Value = days;
            parms[2].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Create_SchedulPlan", parms);
        }


       /// <summary>
       /// 获取工单预排产列表信息
       /// </summary>
       /// <param name="orderId"></param>
       /// <param name="tableName"></param>
       /// <returns></returns>
        public List<PreviewSchedulRecordInfo> GetPreviewSchedulRecordByOrderId(int orderId,string tableName)
        {
            List<PreviewSchedulRecordInfo> list = new List<PreviewSchedulRecordInfo>();
            PreviewSchedulRecordInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
                new SqlParameter("@TableName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = orderId;
            parms[1].Value = tableName;
           


            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPreviewSchedulRecordByOrderId", parms))
            {
                while (rdr.Read())
                {
                    entity = new PreviewSchedulRecordInfo();
                    entity.ProdOrderId = Convert.ToInt32(rdr["ProdOrderId"]);
                    entity.TableName = Convert.ToString(rdr["TableName"]);
                    entity.LineName = Convert.ToString(rdr["LineName"]);
                    entity.PlanNumber = Convert.ToDecimal(rdr["PlanNumber"]);
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.DayTime = Convert.ToString(rdr["DayTime"]);
                    entity.IsHand = Convert.ToInt32(rdr["IsHand"]);
                    entity.ResName = Convert.ToString(rdr["ResName"]);
                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

       
    }
}