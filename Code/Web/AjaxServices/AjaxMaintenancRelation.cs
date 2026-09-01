using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Maintenance.BLL;
using SKT.LeanMES.Maintenance.Model;
using System.Data;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaintenancRelation
    {
        [AjaxMethod]
        public DataTable GetRelationList(Int32 PlanId)
        {
            try
            {
                MaintenanceRelation bll = new MaintenanceRelation();
                DataTable list = new DataTable();
                list = bll.GetDemoList(PlanId);
                if (list != null)
                {
                    return list;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        [AjaxMethod]
        public DataTable GetMyRelationList(Int32 Id,int type)
        {
            try
            {
                MaintenanceRelation bll = new MaintenanceRelation();
                DataTable list = new DataTable();
                list = bll.GetMyDemoList(Id, type);
                if (list != null)
                {
                    return list;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 勾选保养项
        /// </summary>
        /// <param name="planId"></param>
        /// <param name="demoId"></param>
        /// <param name="temp"></param>
        [AjaxMethod]
        public void UpdateDemoList(Int32 planId, Int32 demoId, Int32 demoSubId, Int32 temp,string fileSaveName="")
        {
            try
            {
                MaintenanceRelation bll = new MaintenanceRelation();
                Int32 operatorId = AccountController.GetCurrentUser().UserId;
                String createBy = AccountController.GetCurrentUser().UserName;
                bll.UpdateDemo(planId, demoId, demoSubId, temp, operatorId, createBy, fileSaveName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 确认保养项
        /// </summary>
        /// <param name="planId"></param>
 
        [AjaxMethod]
        public void CheckDemo(Int32 planId)
        {
            try
            {
                MaintenanceRelation bll = new MaintenanceRelation();
                Int32 operatorId = AccountController.GetCurrentUser().UserId;
                String createBy = AccountController.GetCurrentUser().UserName;
                bll.CheckDemo(planId, operatorId, createBy);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 删除保养项
        /// </summary>
        /// <param name="planId"></param>

        [AjaxMethod]
        public void DeleteRelation(Int32 planId,int demoId)
        {
            try
            {
                MaintenanceRelation bll = new MaintenanceRelation();
 
                bll.DeleteRelation(planId, demoId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public DataTable PDA_GetMyRelationList(String Value, int Type)
        {
            try
            {
                MaintenanceRelation bll = new MaintenanceRelation();
                DataTable list = new DataTable();
                list = bll.PDA_GetDemoList(Value, Type);
                if (list != null)
                {
                    return list;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// PDA点检-确认
        /// </summary>
        [AjaxMethod]
        public void MaintainDemoBatch(string equimentCode, List<MaintainDemoInfo> maintains, string serverImageNames)
        {
            string createBy = AccountController.GetCurrentUser().UserName;
            int operatorID = AccountController.GetCurrentUser().UserId;
            try
            {
                MaintenanceRelation bll = new MaintenanceRelation();

                bll.MaintainDemoBatch(equimentCode, maintains, createBy, operatorID, serverImageNames);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}