using AjaxPro;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using SKT.LeanMES.TestManagement.Model;
using SKT.LeanMES.TestManagement.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxStaffAssess
    {
        /// <summary>
        /// 绩效考核的新增和编辑
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]      
        public void EditStaffAssess(StaffAssessInfo entity)
        {
            try
            {
                StaffAssess sta = new StaffAssess();
                if (entity.UserId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                sta.Edit(entity);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        
    }
}