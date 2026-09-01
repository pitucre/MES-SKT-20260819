using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Utility;


namespace SKT.LeanMES.Material.BLL
{
    /// <summary>
    /// add by peter.wang 2016-1-20
    /// 临时类 为显示DEMO 用后可删除 完工申报单
    /// </summary>
    public class CompleteOrder
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 通过派工单找到对应的数据
        ///  add by peter.wang 2016-1-20
        /// </summary>
        /// <param name="TransId"></param>
        /// <returns></returns>
        public List<CompleteOrderInfo> ShowCompleteOrderInfo(String DispatchNo)
        {
            List<CompleteOrderInfo> list = new List<CompleteOrderInfo>();
            CompleteOrderInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@DispatchNo",SqlDbType.NVarChar,50)
            };
            parms[0].Value = DispatchNo;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspShowCompleteOrderInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new CompleteOrderInfo();
                    entity.Operation = rdr.GetString(0);
                    entity.GoalOperation = rdr.GetString(1);
                    entity.OperatinDesc = rdr.GetString(2);
                    entity.DispatchQty = rdr.GetDecimal(3);
                    entity.PlanStartDate = rdr.GetDateTime(4);
                    entity.PlanEndDate = rdr.GetDateTime(5);
                    entity.CompleteQty = 0;
                    entity.WorkHouse = 0;
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 通过完工单ID找到对应的数据
        ///  add by peter.wang 2016-1-20
        /// </summary>
        /// <param name="TransId"></param>
        /// <returns></returns>
        public List<CompleteOrderInfo> ShowCompleteOrderByIdInfo(Int32 comPleteId)
        {
            List<CompleteOrderInfo> list = new List<CompleteOrderInfo>();
            CompleteOrderInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@ComPleteId",SqlDbType.Int)
            };
            parms[0].Value = comPleteId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspShowCompleteByIdInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new CompleteOrderInfo();
                    entity.CompleteOrder = rdr.GetString(0);
                    entity.DispatchNo = rdr.GetString(1);
                    entity.ActualStartDate = rdr.GetDateTime(2);
                    entity.ActualEndDate = rdr.GetDateTime(3);
                    entity.PlanStartDate = rdr.GetDateTime(4);
                    entity.PlanEndDate = rdr.GetDateTime(5);
                    entity.CreateDateTime = rdr.GetDateTime(6);
                    //子表信息
                    entity.Operation = rdr.GetString(7);
                    entity.GoalOperation = rdr.GetString(8);
                    entity.OperatinDesc = rdr.GetString(9);
                    entity.DispatchQty = rdr.GetDecimal(10);
                    entity.CompleteQty = rdr.GetDecimal(11);
                    entity.WorkHouse = rdr.GetInt32(12);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 保存完工申报单
        /// </summary>
        /// <param name="completeNo"></param>
        /// <param name="dispatch"></param>
        /// <param name="factStartDates"></param>
        /// <param name="factEndDates"></param>
        /// <param name="planStartDates"></param>
        /// <param name="planEndDates"></param>
        /// <param name="dispatchDates"></param>
        /// <param name="lineStr"></param>
        /// <param name="operationStr"></param>
        /// <param name="goalOperationStr"></param>
        /// <param name="operatinDescStr"></param>
        /// <param name="dispatchQtyStr"></param>
        /// <param name="completeQty"></param>
        /// <param name="workHouseStr"></param>
        /// <param name="userName"></param>
        public void SaveCompleteOrder(Int32 CompleteId,String completeNo, String dispatch, DateTime factStartDate, DateTime factEndDate, DateTime planStartDate,
                 DateTime planEndDate, DateTime dispatchDate, String lineStr, String operationStr, String goalOperationStr, String operatinDescStr,
          String dispatchQtyStr, String completeQtyStr, String workHouseStr, String userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                 
                   new SqlParameter("@CompleteId",SqlDbType.Int),
                   new SqlParameter("@CompleteNo",SqlDbType.NVarChar,50),
                   new SqlParameter("@Dispatch",SqlDbType.NVarChar,50),
                   new SqlParameter("@FactStartDate",SqlDbType.DateTime),
                   new SqlParameter("@FactEndDate",SqlDbType.DateTime),
                   new SqlParameter("@PlanStartDate",SqlDbType.DateTime),
                   new SqlParameter("@PlanEndDate",SqlDbType.DateTime),
                   new SqlParameter("@DispatchDate",SqlDbType.DateTime),

                   new SqlParameter("@LineStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@OperationStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@GoalOperationStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@OperatinDescStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@DispatchQtyStr",SqlDbType.NVarChar,8000),    
                   new SqlParameter("@CompleteQtyStr",SqlDbType.NVarChar,8000),  
                   new SqlParameter("@WorkHouseStr",SqlDbType.NVarChar,8000), 
                   new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };
            parms[0].Value = CompleteId;
            parms[1].Value = completeNo;
            parms[2].Value = dispatch;
            parms[3].Value = factStartDate;
            parms[4].Value = factEndDate;
            parms[5].Value = planStartDate;
            parms[6].Value = planEndDate;
            parms[7].Value = dispatchDate;

            parms[8].Value = lineStr;
            parms[9].Value = operationStr;
            parms[10].Value = goalOperationStr;
            parms[11].Value = operatinDescStr;
            parms[12].Value = dispatchQtyStr;
            parms[13].Value = completeQtyStr;
            parms[14].Value = workHouseStr;
            parms[15].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveCompleteOrder", parms);
        }

        /// <summary>
        ///   生成派工申报单
        /// </summary>
        /// <param name="flag"></param>
        /// <param name="dispatch"></param>
        /// <param name="completeQtyStr"></param>
        /// <param name="userName"></param>
        /// <param name="workHouseStr"></param>
        /// <param name="ComPleteId"></param>
        /// <returns></returns>
        public String GenerateDispatch(Int32 flag, String dispatch, String completeQtyStr, String userName, String workHouseStr, Int32 ComPleteId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                 
                   new SqlParameter("@Flag",SqlDbType.Int),
                   new SqlParameter("@Dispatch",SqlDbType.NVarChar,50),
                   new SqlParameter("@CompleteQtyStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@UserName",SqlDbType.VarChar,20),
                   new SqlParameter("@WorkHouseStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@ComPleteId",SqlDbType.Int),
                   new SqlParameter("@DispatchOrder",SqlDbType.NVarChar,50)
                   
            };
            parms[0].Value = flag;
            parms[1].Value = dispatch;
            parms[2].Value = completeQtyStr;
            parms[3].Value = userName;
            parms[4].Value = workHouseStr;
            parms[5].Value = ComPleteId;
            parms[6].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateDispatch", parms);
            return Convert.ToString(parms[6].Value);
        }


        /// <summary>
        /// 生成完工报告
        /// </summary>
        /// <param name="flag"></param>
        /// <param name="dispatch"></param>
        /// <param name="completeQtyStr"></param>
        /// <param name="userName"></param>
        public String GenerateCompleteReport(Int32 flag, String dispatch, String completeQtyStr, String userName, String workHouseStr, Int32 ComPleteId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                 
                   new SqlParameter("@Flag",SqlDbType.Int),
                   new SqlParameter("@Dispatch",SqlDbType.NVarChar,50),
                   new SqlParameter("@CompleteQtyStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@UserName",SqlDbType.VarChar,20),
                   new SqlParameter("@WorkHouseStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@ComPleteId",SqlDbType.Int),
                   new SqlParameter("@BackOrder",SqlDbType.NVarChar,50)
                   
            };
            parms[0].Value = flag;
            parms[1].Value = dispatch;
            parms[2].Value = completeQtyStr;
            parms[3].Value = userName;
            parms[4].Value = workHouseStr;
            parms[5].Value = ComPleteId;
            parms[6].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateCompleteReport", parms);
            return Convert.ToString(parms[6].Value);
        }

        /// <summary>
        /// 入库倒冲
        /// </summary>
        /// <param name="dispatch"></param>
        /// <param name="completeOrder"></param>
        public String BackStorage(String dispatch, String completeOrder, Int32 ComPleteId) 
        {
            SqlParameter[] parms = new SqlParameter[] { 
                 
                   new SqlParameter("@Dispatch",SqlDbType.NVarChar,50),
                   new SqlParameter("@CompleteOrder",SqlDbType.NVarChar,50),
                   new SqlParameter("@ComPleteId",SqlDbType.Int),
                   new SqlParameter("@IssueDocStr",SqlDbType.NVarChar,50)
            };
            parms[0].Value = dispatch;
            parms[1].Value = completeOrder;
            parms[2].Value = ComPleteId;
            parms[3].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspBackStorage", parms);
            return Convert.ToString(parms[3].Value);
        }

        /// <summary>
        /// 分页获取 TransferOut 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="transferOutCount">transferOut 总数。</param>
        /// <returns>TransferOut 列表。</returns>
        public List<CompleteOrderInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CompleteOrderInfo> list = new List<CompleteOrderInfo>();
            CompleteOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[dbo].[Prod_DispatchCompleteOrder]", "ID",
                "[ID], [CompleteNo], [DocNo], [ActualStartDate], [ActualEndDate], [CreateBy], [CreateDateTime],[PlanStartDate],[PlanEndDate]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CompleteOrderInfo();
                    entity.ID = rdr.GetInt32(0);
                    entity.CompleteOrder = rdr.GetString(1);
                    entity.DispatchNo = rdr.GetString(2);
                    entity.ActualStartDate = rdr.GetDateTime(3);
                    entity.ActualEndDate = rdr.GetDateTime(4);
                    entity.CreateBy = rdr.GetString(5);
                    entity.CreateDateTime = rdr.GetDateTime(6);
                    entity.PlanStartDate = rdr.GetDateTime(7);
                    entity.PlanEndDate = rdr.GetDateTime(8);
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
