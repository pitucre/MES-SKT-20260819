using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.Common.Utility;
using AjaxPro;
using SKT.Common.Organization.BLL;
using SKT.Common.Organization.Model;
using SKT.LeanMES.Plan.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.Plan.BLL;
using System.Collections;
using SKT.LeanMES.Resource.Model;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPlan
    {
        /// <summary>
        /// 编辑部门
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Int32 OrganizationEdit(OrganizationInfo entity)
        {
            int organizationId = -1;
            try
            {
                organizationId = (new Common.Organization.BLL.Organization()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return organizationId;
        }

        [AjaxMethod]
        public Int32 PlanEdit(PlanInfo entity)
        {
            int id = -1;

            entity.OrderStartTime = TypeHelper.ToDateTime(entity.OrderStartTimeStr);
            if (entity.QICATSDTStr == null) entity.QICATSDTStr = "";
            entity.QICATSDT = TypeHelper.ToDateTime(entity.QICATSDTStr);
            entity.OrderEndTime = TypeHelper.ToDateTime(entity.QICATSDTStr);
            entity.OrderCreateDateTime = TypeHelper.ToDateTime(entity.OrderCreateDateTimeStr);
            if (entity.SynthesisDateTimeStr == null)
            {
                entity.SynthesisDateTimeStr = "";
            }
            entity.SynthesisDateTime = TypeHelper.ToDateTime(entity.SynthesisDateTimeStr);

            entity.PressNumber = "";

            if (entity.Remark == null)
            {
                entity.Remark = "";
            }


            try
            {
                id = (new LeanMES.Plan.BLL.Plan()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return id;
        }

        [AjaxMethod]
        public void PlanDelete(String labelFieldId, String labelId)
        {
            try
            {
                (new SKT.LeanMES.Plan.BLL.Plan()).Delete(labelFieldId, labelId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void LinePlanEdit(LinePlanEntity entity)
        {
            try
            {

                SKT.LeanMES.Plan.BLL.LinePlan linePlanBll = new LeanMES.Plan.BLL.LinePlan();
                string[] LineId = entity.LineIdArr.Split(',');
                string[] StartDate = entity.StartDateArr.Split(',');
                //string[] EndDate = entity.EndDateArr.Split(',');
                string[] FQty = entity.FQtyArr.Split(',');
                string[] LinePlanIdArr = entity.LinePlanIdArr.Split(',');
                string[] TableNameArr = entity.TableNameArr.Split(',');
                int qty = 0; //已排期到线上的数量
                if (LineId != null && LineId.Length > 0)
                {
                    linePlanBll.Delete(entity.FBILLNO);
                }
                SKT.LeanMES.Plan.Model.LinePlanInfo info = new SKT.LeanMES.Plan.Model.LinePlanInfo();
                for (int i = 0; i < LineId.Length && entity.LineIdArr != ""; i++)
                {
                    if (qty == 0)
                    {
                        for (int q = 0; q < FQty.Length; q++)
                        {
                            qty += Convert.ToInt32(FQty[q]);
                        }
                    }


                    info.LinePlanId = Convert.ToInt32(LinePlanIdArr[i]);
                    info.FInterID = entity.FInterID;
                    info.FBILLNO = entity.FBILLNO;
                    info.LineId = Convert.ToInt32(LineId[i]);
                    info.FQty = Convert.ToDecimal(FQty[i]);
                    info.FPlanCommitDate = DateTime.Parse(StartDate[i]);
                    //info.FPlanFinishDate = DateTime.Parse(EndDate[i]);
                    info.FPlanFinishDate = DateTime.MaxValue;
                    info.CreateDateTime = DateTime.MaxValue;
                    info.ModifyDateTime = DateTime.MaxValue;
                    info.CreateBy = entity.CreateBy;
                    info.ModifyBy = entity.ModifyBy;
                    info.Remark = "";
                    info.State = 1;
                    info.TableName = TableNameArr[i];
                    linePlanBll.Edit(info);
                }

                ///更新ERP同步的到Prod_Order表里的工单
                SKT.LeanMES.Order.BLL.ShopOrder orderBll = new Order.BLL.ShopOrder();
                SKT.LeanMES.Order.Model.ShopOrderInfo orderInfo = orderBll.GetInfo(entity.FBILLNO);
                //有产线则更新工单的状为1
                if (entity.LineIdArr != "")
                {
                    orderInfo.Status = 1;
                }
                else
                {
                    orderInfo.Status = 0;
                }
                orderInfo.Qty_to_Line = qty;
                orderBll.Edit(orderInfo,
                    orderInfo.Planned_Start_Time.ToString(),
                    orderInfo.Planned_Completed_Date.ToString(),
                    orderInfo.Scheduled_Start_Date.ToString(),
                    orderInfo.Scheduled_Completed_Time.ToString());

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 创建生产排产信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void CollectOrderPlanInfo(LinePlanEntity entity)
        {
            SKT.LeanMES.Plan.BLL.LinePlan linePlanBll = new LeanMES.Plan.BLL.LinePlan();
            try
            {
                linePlanBll.CollectOrderPlanInfo(entity.LinePlanIdArr, entity.FInterID, entity.LineIdArr, entity.FQtyArr, entity.StartDateArr, entity.TableNameArr, entity.CreateBy, entity.ModifyBy, entity.LinePlanType, entity.ProductLoadArr, entity.ResourceIdArr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 插单操作
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void CollectOrderPlanInsert(LinePlanEntity entity)
        {
            SKT.LeanMES.Plan.BLL.LinePlan linePlanBll = new LeanMES.Plan.BLL.LinePlan();
            try
            {
                linePlanBll.CollectOrderPlanInsert(entity.LinePlanIdArr, entity.FInterID, entity.LineIdArr, entity.FQtyArr, entity.StartDateArr, entity.TableNameArr, entity.CreateBy, entity.ModifyBy, entity.LinePlanType, entity.ProductLoadArr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public DataTable GetLineDayProductLoad(int lineId, string dayTime)
        {
            SchedulOrderDal bll = new SchedulOrderDal();
            DataTable table = bll.GetLineDayProductLoad(lineId, dayTime);
            return table;
        }

        [AjaxMethod]
        public int GetLineIdByLinePlanId(int LinePlanId)
        {
            SKT.LeanMES.Plan.BLL.LinePlan linePlanBll = new LeanMES.Plan.BLL.LinePlan();
            SKT.LeanMES.Plan.Model.LinePlanInfo linePlanInfo = linePlanBll.GetInfo(LinePlanId);
            if (linePlanInfo != null)
            {
                return linePlanInfo.FInterID;
            }
            return 0;
        }

        [AjaxMethod]
        public List<SKT.LeanMES.Plan.Model.LinePlanInfo> GetLinePlanByFInterID(int orderID)
        {
            SKT.LeanMES.Plan.BLL.LinePlan linePlanBll = new LeanMES.Plan.BLL.LinePlan();
            Common.Model.SearchSettings searchSetting = new Common.Model.SearchSettings();
            searchSetting.ExtensionCondition = " FInterID = " + orderID + "  and FPlanCommitDate > DATEADD(DAY,-1,GETDATE()) ";

            List<SKT.LeanMES.Plan.Model.LinePlanInfo> list = linePlanBll.GetAll(0, Int32.MaxValue, "FPlanCommitDate", searchSetting);
            return list;
        }
        [AjaxMethod]
        public List<SKT.LeanMES.Plan.Model.LinePlanInfo> GetLinePlanByFInterIDS(int orderID)
        {
            SKT.LeanMES.Plan.BLL.LinePlan linePlanBll = new LeanMES.Plan.BLL.LinePlan();
            Common.Model.SearchSettings searchSetting = new Common.Model.SearchSettings();
            searchSetting.ExtensionCondition = " FInterID = " + orderID;

            List<SKT.LeanMES.Plan.Model.LinePlanInfo> list = linePlanBll.GetAll(0, Int32.MaxValue, "FPlanCommitDate", searchSetting);
            return list;
        }
        [AjaxMethod]
        public List<PreviewSchedulRecordInfo> GetLinePreviewSchedulByOrderId(int orderId, string tableName)
        {
            SchedulOrderDal schedulOrderDal = new SchedulOrderDal();
            List<PreviewSchedulRecordInfo> list = schedulOrderDal.GetPreviewSchedulRecordByOrderId(orderId, tableName);
            return list;
        }

        [AjaxMethod]
        public SKT.LeanMES.Resource.Model.LineInfo GetLineInfoLineID(int lineId)
        {
            SKT.LeanMES.Resource.BLL.Line lineBll = new LeanMES.Resource.BLL.Line();
            SKT.LeanMES.Resource.Model.LineInfo info = lineBll.GetInfo(lineId);
            return info;
        }

        /// <summary>
        /// 查询面别信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<LoadingListTableInfo> GetTableName()
        {
            List<LoadingListTableInfo> list = new List<LoadingListTableInfo>();
            try
            {
                list = new SKT.LeanMES.SMT.BLL.LoadingListTable().GetAll(0, -1, "", new Common.Model.SearchSettings());
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取标准产能信息
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="tableName"></param>
        /// <param name="equipmentLine"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int GetStandardCapacity(int itemId, string tableName, string equipmentLine)
        {
            int standardCapacity = 0;
            try
            {
                standardCapacity = new SKT.LeanMES.Plan.BLL.StandardLaborTime().GetStandardCapacity(itemId, tableName, equipmentLine);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return standardCapacity;
        }


        /// <summary>
        /// 获取标准产能信息
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="tableName"></param>
        /// <param name="lineId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int GetLineStandardCapacity(int itemId, string tableName, int lineId)
        {
            int standardCapacity = 0;
            try
            {
                standardCapacity = new SKT.LeanMES.Plan.BLL.StandardLaborTime().GetStandardCapacity(itemId, tableName, lineId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return standardCapacity;
        }

        /// <summary>
        /// 确认工单排产信息
        /// </summary>
        /// <param name="prodOrderId"></param>
        [AjaxMethod]
        public void ConfirmLinePlanInfo(string linePlanOrder)
        {
            SKT.LeanMES.Plan.BLL.LinePlan linePlanBll = new LeanMES.Plan.BLL.LinePlan();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                linePlanBll.ConfirmLinePlanInfo(linePlanOrder, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 物料齐套检查
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public ArrayList CheckMaterialHomogeneity(LinePlanInfo entity)
        {
            LinePlan linePlanBll = new LinePlan();
            try
            {
                int materialHomogeneityFlag;
                string msg;
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                linePlanBll.CheckMaterialHomogeneity(entity, out materialHomogeneityFlag, out msg);

                var list = new ArrayList();
                list.Add(materialHomogeneityFlag);
                list.Add(msg);
                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 物料齐套列表
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public IList<LinePlanInfo> GetMaterialHomogeneity(LinePlanInfo entity)
        {
            LinePlan linePlanBll = new LinePlan();
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                return linePlanBll.GetMaterialHomogeneity(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 物料锁定
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void MaterialLock(LinePlanInfo entity)
        {
            LinePlan linePlanBll = new LinePlan();
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                linePlanBll.MaterialLock(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public ResourceManageInfo GetResourceManageInfo(int itemId, int lineId, string tableName)
        {
            ResourceManageInfo model = new ResourceManageInfo();
            model = new LeanMES.Resource.BLL.ResourceManage().GetInfoByItemOrLineId(itemId, lineId, tableName);
            return model;
        }

        /// <summary>
        /// 编辑部门
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void ReplaceLoadList(string linePlanOrder)
        {
            try
            {
                int userId = AccountController.GetCurrentUser().UserId;
                string confirmMsg = "";
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@LinePlanNo", SqlDbType.VarChar),
                    new SqlParameter("@UserId", SqlDbType.Int),
                    new SqlParameter("@ResultMsg", SqlDbType.VarChar,2000),
                };

                parms[0].Value = linePlanOrder;
                parms[1].Value = userId;
                parms[2].Value = "";
                parms[2].Direction = ParameterDirection.Output;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReplaceLoadList", parms);

                confirmMsg = Convert.ToString(parms[2].Value);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public int IsExistStockList(string linePlanOrder)
        {
            try
            {
                int userId = AccountController.GetCurrentUser().UserId;
                string confirmMsg = "";
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@LinePlanNo", SqlDbType.VarChar),
                    new SqlParameter("@UserId", SqlDbType.Int),
                    new SqlParameter("@RecordQty", SqlDbType.Int),
                };

                parms[0].Value = linePlanOrder;
                parms[1].Value = userId;
                parms[2].Value = 0;
                parms[2].Direction = ParameterDirection.Output;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspIsExistStockList", parms);

                return Convert.ToInt32(parms[2].Value);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }

    }

    public class LinePlanEntity
    {
        public string LinePlanIdArr { get; set; }
        public int FInterID { get; set; }
        public string FBILLNO { get; set; }
        public string LineIdArr { get; set; }
        public string StartDateArr { get; set; }
        public string EndDateArr { get; set; }
        public string FQtyArr { get; set; }
        public string CreateBy { get; set; }
        public string ModifyBy { get; set; }
        public string TableNameArr { get; set; }
        public string ProductLoadArr { get; set; }
        public int LinePlanType { get; set; }
        public string ResourceIdArr { get; set; }

    }
}