using AjaxPro;
using SKT.LeanMES.ProdUnit.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// 辅料管理
    /// </summary>
    public class AjaxSNScrap
    {
        [AjaxMethod]
        public void SaveSNScrap(int ID)
        {
            try
            {
                int userId = AccountController.GetCurrentUser().UserId;
                SKT.LeanMES.ProdUnit.BLL.SNScrap bll = new ProdUnit.BLL.SNScrap();
                bll.RegainSNScrapt(ID, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}