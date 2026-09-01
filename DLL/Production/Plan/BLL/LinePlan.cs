using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Plan.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Plan.BLL
{
    public class LinePlan
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LinePlan 信息。
        /// </summary>
        /// <param name="entity">LinePlan 实体对象。</param>
        public Int32 Edit(LinePlanInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LinePlanId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@FInterID", SqlDbType.Int),
                new SqlParameter("@FBILLNO", SqlDbType.VarChar, 50),
                new SqlParameter("@FPlanCommitDate", SqlDbType.DateTime),
                new SqlParameter("@FPlanFinishDate", SqlDbType.DateTime),
                new SqlParameter("@FQty", SqlDbType.Decimal,8),
                new SqlParameter("@State", SqlDbType.VarChar, 5),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@TableName", SqlDbType.VarChar)
            };

            parms[0].Value = entity.LinePlanId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.LineId;
            parms[2].Value = entity.FInterID;
            parms[3].Value = entity.FBILLNO;
            parms[4].Value = entity.FPlanCommitDate;
            parms[5].Value = entity.FPlanFinishDate;
            parms[6].Value = entity.FQty;
            parms[7].Value = entity.State;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.ModifyBy;
            parms[10].Value = entity.Remark;
            parms[11].Value = entity.TableName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LinePlan_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 FInterID 字符串删除 LinePlan 信息。
        /// </summary>
        /// <param name="idString">FInterID 字符串。</param>
        /// <param name="userName">操作人姓名</param>
        /// <returns>日志内容。</returns>
        public void Delete(int FInterID, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FInterID", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar,20)
            };

            parms[0].Value = FInterID;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LinePlan_Delete", parms);
        }

        public void Delete(string FBILLNO)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FBILLNO", SqlDbType.VarChar,50)
            };

            parms[0].Value = FBILLNO;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LinePlan_DeleteByFBILLNO", parms);
        }

        /// <summary>
        /// 根据 LinePlanId 获取实体信息。
        /// </summary>
        /// <param name="linePlanId">LinePlanId。</param>
        /// <returns>LinePlan 实体对象。</returns>
        public LinePlanInfo GetInfo(Int32 linePlanId)
        {
            LinePlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LinePlanId", SqlDbType.Int)
            };

            parms[0].Value = linePlanId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LinePlan_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LinePlanInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetDateTime(5), rdr.GetDecimal(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LinePlan 实体对象。</returns>
        public LinePlanInfo GetInfo(String fieldValue)
        {
            LinePlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LinePlan_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LinePlanInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetDateTime(5), rdr.GetDecimal(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 LinePlan 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="linePlanCount">linePlan 总数。</param>
        /// <returns>LinePlan 列表。</returns>
        public List<LinePlanInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LinePlanInfo> list = new List<LinePlanInfo>();
            LinePlanInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_LinePlan", "LinePlanId",////Prod_LinePlan
                "[LinePlanId], [LineId], [FInterID], [FBILLNO], [FPlanCommitDate], [FPlanFinishDate], [FQty], [State], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[FStockQty],[TableName],[LinePlanType],ProductionLineSort,IsHand,OrderNO,ResourceId,ResName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LinePlanInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetDateTime(5), rdr.GetDecimal(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));

                    entity.FStockQty = rdr.GetDecimal(13);
                    entity.TableName = rdr.GetString(14);
                    entity.LinePlanType = rdr.GetInt32(15);
                    entity.ProductionLineSort = rdr.GetInt32(16);
                    entity.IsHand = Convert.ToInt32(rdr["IsHand"]);
                    entity.OrderNo = Convert.ToString(rdr["OrderNO"]);
                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    entity.ResName = Convert.ToString(rdr["ResName"]);
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

        public int GetProductedQuantityByOrderNo(string orderNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FBILLNO", SqlDbType.VarChar,50)
            };

            parms[0].Value = orderNo;
            object o = SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, "Prod_LinePlan_GetProductedQuantity", parms);
            if (Convert.IsDBNull(o))
            {
                return 0;
            }
            return Convert.ToInt32(o);
        }

        /// <summary>
        /// 创建生产排产信息
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="lineIdArr"></param>
        /// <param name="planQtyArr"></param>
        /// <param name="planStartTimeArr"></param>
        /// <param name="tableNameArr"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyBy"></param>
        /// <param name="prodLoadArr">线别负荷</param>
        public void CollectOrderPlanInfo(string linePlanId, int prodOrderId, string lineIdArr, string planQtyArr, string planStartTimeArr, string tableNameArr, string createBy, string modifyBy, int linePlanType,string prodLoadArr, string resourceIdArr)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LinePlanId", SqlDbType.VarChar),
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.VarChar),
                new SqlParameter("@PlanQty", SqlDbType.VarChar),
                new SqlParameter("@PlanStartTime", SqlDbType.VarChar),
                new SqlParameter("@TableName", SqlDbType.NVarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@LinePlanType", SqlDbType.Int),
                new SqlParameter("@ProductLoad", SqlDbType.NVarChar),
                new SqlParameter("@ResourceId", SqlDbType.VarChar),
            };
            parms[0].Value = linePlanId;
            parms[1].Value = prodOrderId;
            parms[2].Value = lineIdArr;
            parms[3].Value = planQtyArr;
            parms[4].Value = planStartTimeArr;
            parms[5].Value = tableNameArr;
            parms[6].Value = createBy;
            parms[7].Value = modifyBy;
            parms[8].Value = linePlanType;
            parms[9].Value = prodLoadArr;
            parms[10].Value = resourceIdArr;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectLinePlanInfo", parms);

        }


        /// <summary>
        /// 排产插单
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="lineIdArr"></param>
        /// <param name="planQtyArr"></param>
        /// <param name="planStartTimeArr"></param>
        /// <param name="tableNameArr"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyBy"></param>
        /// <param name="prodLoadArr">线别负荷</param>
        public void CollectOrderPlanInsert(string linePlanId, int prodOrderId, string lineIdArr, string planQtyArr, string planStartTimeArr, string tableNameArr, string createBy, string modifyBy, int linePlanType, string prodLoadArr)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LinePlanId", SqlDbType.VarChar),
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.VarChar),
                new SqlParameter("@PlanQty", SqlDbType.VarChar),
                new SqlParameter("@PlanStartTime", SqlDbType.VarChar),
                new SqlParameter("@TableName", SqlDbType.NVarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@LinePlanType", SqlDbType.Int),
                new SqlParameter("@ProductLoad", SqlDbType.NVarChar),
            };
            parms[0].Value = linePlanId;
            parms[1].Value = prodOrderId;
            parms[2].Value = lineIdArr;
            parms[3].Value = planQtyArr;
            parms[4].Value = planStartTimeArr;
            parms[5].Value = tableNameArr;
            parms[6].Value = createBy;
            parms[7].Value = modifyBy;
            parms[8].Value = linePlanType;
            parms[9].Value = prodLoadArr;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectLinePlanInsert", parms);

        }

        /// <summary>
        /// 确认工单排产信息
        /// </summary>
        /// <param name="linePlanOrder">排产工单号</param>
        /// <param name="userId">操作用户ID</param>
        /// <param name="isCheckMaterialApply">是否校验领料单（默认为true）</param>
        /// <returns></returns>
        public string ConfirmLinePlanInfo(string linePlanOrder, int userId)
        {
            string confirmMsg = "";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LinePlanNo", SqlDbType.VarChar),
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@ResultMsg", SqlDbType.VarChar,200),

            };

            parms[0].Value = linePlanOrder;
            parms[1].Value = userId;
            parms[2].Value = "";
            parms[2].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspComirmStockList", parms);

            confirmMsg = Convert.ToString(parms[2].Value);

            return confirmMsg;
        }

        /// <summary>
        /// 分页获取 StandardLaborTime 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="standardLaborTimeCount">standardLaborTime 总数。</param>
        /// <returns>StandardLaborTime 列表。</returns>
        public List<LinePlanOrderInfo> GetPlanOrderAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LinePlanOrderInfo> list = new List<LinePlanOrderInfo>();
            //表名或者视图
            string strTb = "vwGetPlanOrderList";
            //主键
            string strKey = "FInterID";
            //查询栏位字串
            string strColumns = @"[FInterID], [FBILLNO], [ItemCode],[ItemName],[LineName], [LineMachineRelation],[StandardCapacity],[Qty_to_Build],[FQty], [ChildrenNumber],[TableName], [Status], [Planned_Start_Time], [Planned_Completed_Date], [Actual_Start_Date],[Actual_Completed_Date],[RouterName], [ModifyBy], [ModifyTime],[LinePlanType],MaterialHomogeneityFlag,MaterialHomogeneity,MaterialLockFlag,MaterialLock,ProductionLineSort,ResourceId,ResName,WorkShopName,FactoryName";

            return ComMethod.GetComList<LinePlanOrderInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

        }

        /// <summary>
        /// 分页获取 BatchSNNcDataInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="standardLaborTimeCount">standardLaborTime 总数。</param>
        /// <returns>StandardLaborTime 列表。</returns>
        public List<ProdBatchSNNcDataInfo> GetBatchSNNcDataInfoAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ProdBatchSNNcDataInfo> list = new List<ProdBatchSNNcDataInfo>();
            //表名或者视图
            string strTb = "vw_BatchSNNcDataInfo";
            //主键
            string strKey = "ID";
            //查询栏位字串
            string strColumns = @"[ID],OrderNo ,ItemCode , ItemName , SN , LineID , StationID , isnull(ResourceID,-1)ResourceID ,NCGroupID ,NCCode ,NGQty ,isnull(Remark,'')Remark  ,CreateBy , CreateDateTime , isnull(SendRepairSN,'')SendRepairSN,LineName, StationName ";

            return ComMethod.GetComList<ProdBatchSNNcDataInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

        }

        /// <summary>
        /// 获取排产信息
        /// </summary>
        /// <param name="linePlanNo"></param>
        /// <returns></returns>
        public LinePlanInfo GetLinePlanInfo(string linePlanNo)
        {
            List<LinePlanInfo> list = new List<LinePlanInfo>();

            list = ComMethod.GetListBySql<LinePlanInfo>(@"select LinePlanId ,FBILLNO,
              OrderNO,
              ItemID,
              ItemName,
              ItemCode,
              ItemModel,FQty from vwGetLinePlanInfo where FBILLNO = '" + linePlanNo + "'", null, SQLHelper.MESConnString);

            return (list == null || list.Count == 0) ? new LinePlanInfo() : list[0];
        }


        /// <summary>
        /// 物料齐套检查
        /// </summary>
        /// <param name="entity"></param>
        public void CheckMaterialHomogeneity(LinePlanInfo entity, out int materialHomogeneityFlag, out string msg)
        {
            materialHomogeneityFlag = -1;
            msg = string.Empty;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PlanNo", SqlDbType.VarChar,50),
                new SqlParameter("@UserName", SqlDbType.VarChar,20),
                new SqlParameter("@MaterialHomogeneityFlag", SqlDbType.Int),
                new SqlParameter("@Msg", SqlDbType.NVarChar,200),
            };
            parms[0].Value = entity.FBILLNO;
            parms[1].Value = entity.ModifyBy;

            parms[2].Direction = ParameterDirection.Output;
            parms[3].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaterialHomogeneityCheck", parms);

            materialHomogeneityFlag = parms[2].Value == null ? -1 : Convert.ToInt32(parms[2].Value);
            msg = parms[3].Value == null ? string.Empty : parms[3].Value.ToString();

        }

        /// <summary>
        /// 物料齐套明细信息
        /// </summary>
        /// <param name="entity"></param>
        public IList<LinePlanInfo> GetMaterialHomogeneity(LinePlanInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PlanNo", SqlDbType.VarChar,50),
                new SqlParameter("@BomItemCode", SqlDbType.VarChar,50),
                new SqlParameter("@UserName", SqlDbType.VarChar,20)
            };
            parms[0].Value = entity.FBILLNO;
            parms[1].Value = entity.BomItemCode;
            parms[2].Value = entity.ModifyBy;
            return ComMethod.GetList<LinePlanInfo>("uspGetMaterialHomogeneity", parms);
        }

        /// <summary>
        /// 物料锁定
        /// </summary>
        /// <param name="entity"></param>
        public void MaterialLock(LinePlanInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PlanNo", SqlDbType.VarChar,50),
                new SqlParameter("@LockFlag", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar,20)
            };
            parms[0].Value = entity.FBILLNO;
            parms[1].Value = entity.MaterialLockFlag;
            parms[2].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaterialLock", parms);
        }

        /// <summary>
        /// 根据工单号返回工艺流程数据
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        public byte[] GetProcessPdfPrint(string OrderNo, string strXmlFilePath, string strImgPath)
        {
            //string DeliverNo = "";
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@OrderNo",SqlDbType.VarChar,100)
            };
            parms[0].Value = OrderNo;
            DataSet ds = ComMethod.GetListDataSet("uspGetprocess", parms, "dtProcessflowcard");
            //if (ds.Tables.Count > 0)
            //{
            //    DeliverNo = parms[1].Value.ToString();
            //    foreach (DataRow row in ds.Tables[1].Rows)
            //    {
            //        row["SentQty"] = Convert.ToDecimal(row["SentQty"]);
            //    }
            //}
            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        public void GetProcessEdit(string OrderNo)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@OrderNo",SqlDbType.VarChar,100)
            };
            parms[0].Value = OrderNo;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetPlanOrderEdit", parms);
        }
    }
}