using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.Maintenance.BLL;
using SKT.LeanMES.Maintenance.Model;

using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaintenance
    {
        /// <summary>
        /// 计划保养确认
        /// </summary>
        /// <param name="maintainacePlanId">计划id</param>
        [AjaxMethod]
        public void MaintenanceConfirm(Int32 maintenancePlanId)
        {
            try
            {
                MaintenancePlan bll = new MaintenancePlan();

                bll.MaintenanceConfirm(maintenancePlanId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 编辑保养计划
        /// </summary>
        /// <param name="entity">保养计划实体</param>
        [AjaxMethod]
        public void EditMaintenancePlan(MaintenancePlanInfo entity, String demoIdStr)
        {
            try
            {
                MaintenancePlan bll = new MaintenancePlan();

                if (entity.MaintenancePlanId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                String creater = AccountController.GetCurrentUser().UserName;
                Int32 createrid = AccountController.GetCurrentUser().UserId;
                bll.Edit(entity, demoIdStr, createrid, creater);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 编辑设备与保养计划关联信息
        /// </summary>
        /// <param name="entity">保养计划实体</param>
        [AjaxMethod]
        public void EditMaintenanceEquiment(MaintenancePlanInfo entity)
        {
            try
            {
                MaintenancePlan bll = new MaintenancePlan();

                if (entity.Eid == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                }
                String creater = AccountController.GetCurrentUser().UserName;
                Int32 createrid = AccountController.GetCurrentUser().UserId;
                bll.EditMaintenanceEquiment(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}