using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxHolidayMaintenance
    {
        /// <summary>
        /// 编辑设备类型
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void Edit(int HolidayMaintenanceId, string txtDate, int ddlMultiple, int Holiday, string txtRemark)
        {
            try
            {
                SKT.LeanMES.HolidayMaintenance.BLL.HolidayMaintenance bll = new SKT.LeanMES.HolidayMaintenance.BLL.HolidayMaintenance();

                string CreateBy = null;
                string ModifyBy = null;
                if (HolidayMaintenanceId == -1)
                {
                    CreateBy = AccountController.GetCurrentUser().UserName;
                    ModifyBy = "";
                }
                else
                {
                    ModifyBy = AccountController.GetCurrentUser().UserName;
                    CreateBy = "";
                }

                var num = bll.Edit(HolidayMaintenanceId, txtDate, ddlMultiple, Holiday, CreateBy, ModifyBy, txtRemark);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

    }
}