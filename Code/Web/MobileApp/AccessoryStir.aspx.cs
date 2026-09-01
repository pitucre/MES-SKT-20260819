using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class AccessoryStir : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessory));

            //2018-6-6设置先进先出权限
            int userId = AccountController.GetCurrentUser().UserId;
            this.hdFIFO.Value = Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 11470099) ? "1" : "-1"; //用户FIFO权限  1：有权限 -1：没有权限
        }
    }
}