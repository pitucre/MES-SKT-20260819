using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using System.Text.RegularExpressions;
using SKT.Common.Account.BLL;

namespace SKT.LeanMES.Web.Framework
{
    public partial class Console : Systems.Web.AccessPage
    {
        public string checkPasswordMessage;
        protected void Page_Load(object sender, EventArgs e)
        {
            var isLogin = Request.QueryString["isLogin"];
            //if (isLogin == "1")
            //{
            //    GlobarParameter.Model.GlobarParameterInfo entity = new GlobarParameter.BLL.GlobarParameter().GetInfo("MandatoryPassword");
            //    if (entity != null && entity.ParaValue == "是" && AccountController.GetCurrentUser().UserId != -1)
            //    {
            //        var user = (new Users()).GetInfo(Convert.ToInt32(AccountController.GetCurrentUser().UserId), "");
            //        if (user != null && user.Password != null)
            //        {
            //            if (!Regex.IsMatch(SKT.Common.Utility.EncryptHelper.Decrypt(user.Password), @"^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"))
            //            {
            //                checkPasswordMessage = "密码必须由字母和数字组成,至少有一个大写,一个小写,长度最少是8位";
            //            }
            //        }
            //    }
            //}
            var url = "Console1.aspx" + (isLogin == "1" ? "?isLogin=" + isLogin : "");
            Response.Redirect(url);
            Response.End();
            //Modify By Alen 2017-02-13 当当前登录的用户是供应商时，直接进入仓库管理模块，不需要在控制面板停留
            if (AccountController.GetCurrentUser().UserType != -1)
            {
                Response.Redirect("home.aspx?module=LeanMES_Store&modulename=仓库管理");
                Response.End();
            }

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAccount));
            if (!IsPostBack)
            {
                this.lblVersion.InnerText = Resources.Common.ApplicationVersion + Resources.Common.Colon + AppCode.Utility.GetAssemblyInfo.GetApplicationVersion();

                //用户信息
                Common.Account.Model.MembershipInfo userInfo = AccountController.GetCurrentUserInfo();
                this.hdnUserId.Value = userInfo.UserId.ToString();
                string male = "../Content/console/img/male.png";
                string female = "../Content/console/img/female.png";
                if (userInfo.Sex == 0)
                {
                    this.userInfo.Text = "<img src='" + female + "' style='vertical-align:middle'/><span style='vertical-align:middle'>Hi " + userInfo.UserName + "</span>";
                }
                else
                {
                    this.userInfo.Text = "<img src='" + male + "' style='vertical-align:middle'/><span style='vertical-align:middle'>Hi " + userInfo.UserName + "</span>";
                }

            }
        }
    }
}