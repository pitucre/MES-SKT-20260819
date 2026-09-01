using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxAllowance
    {
        /// <summary>
        /// 编辑设备类型
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void Edit(int AllowanceId, int txtUserID, string txtwages, string txtRemark, string txtUserName, string txtOutputAllowance)
        {
            try
            {
                SKT.LeanMES.Allowance.BLL.Allowance bll = new SKT.LeanMES.Allowance.BLL.Allowance();

                string CreateBy = null;
                string ModifyBy = null;
                if (AllowanceId == -1)
                {
                    CreateBy = AccountController.GetCurrentUser().UserName;
                    ModifyBy = "";
                }
                else
                {
                    ModifyBy = AccountController.GetCurrentUser().UserName;
                    CreateBy = "";
                }

                var num = bll.Edit(AllowanceId, txtUserID, txtwages, CreateBy, ModifyBy, txtRemark, txtUserName, txtOutputAllowance);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}