using SKT.Common.Account.BLL;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Framework
{
    public partial class Console1 : Systems.Web.AccessPage
    {

        public string checkPasswordMessage;
        protected void Page_Load(object sender, EventArgs e)
        {
            //验证Anti-Xsrf Token
            AntiXSRFHelper.VerifyToken(this.Page, hdnCsrfToken);

            if (Request.Cookies["lang"] != null)
            {
                hfMESLang.Value = Request.Cookies["lang"].Value;
            }

            //强制策略下初始化用户登录提示修改密码
            var isLogin = Request.QueryString["isLogin"];
            if (isLogin == "1")
            {
                GlobarParameter.Model.GlobarParameterInfo entity = new GlobarParameter.BLL.GlobarParameter().GetInfo("MandatoryPassword");
                if (entity != null && entity.ParaValue == "是" && AccountController.GetCurrentUser().UserId != -1)
                {
                    var user = (new Users()).GetInfo(Convert.ToInt32(AccountController.GetCurrentUser().UserId), "");
                    if (user != null && user.Password != null)
                    {
                        if (!Regex.IsMatch(SKT.Common.Utility.EncryptHelper.Decrypt(user.Password), @"^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"))
                        {
                            checkPasswordMessage = "您的密码过于简单,请修改密码！";
                        }
                    }
                }
            }

            //= Request.Cookies["lang"].Value;
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
               // this.lblVersion.InnerText = Resources.Common.ApplicationVersion + Resources.Common.Colon + AppCode.Utility.GetAssemblyInfo.GetApplicationVersion();

                //用户信息
                Common.Account.Model.MembershipInfo userInfo = AccountController.GetCurrentUserInfo();
                this.hdnUserId.Value = userInfo.UserId.ToString();
                string male = "../Content/console/img/maleNew.png";
                string female = "../Content/console/img/maleNew.png";
                string setUp = "../Content/console/img/setUp.png";
                if (userInfo.Sex == 0)
                {
                    this.userInfo.Text = "<img src='" + female + "' style='vertical-align:middle'/>&nbsp;<span style='vertical-align:middle'>Hi " + userInfo.UserName + "</span>";
                }
                else
                {
                    this.userInfo.Text = "<img src='" + male + "' style='vertical-align:middle'/>&nbsp;<span style='vertical-align:middle'>Hi " + userInfo.UserName + "</span>";
                }
                this.setupLine.Text = "<img src='" + setUp + "' style='vertical-align:middle'/>";
            }

            //设置客户logo
            try
            {
                Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
                AppSettingsSection appseting = (AppSettingsSection)config.GetSection("appSettings");
                var logoPath = (appseting.Settings["CustomerLogo"] != null) ? appseting.Settings["CustomerLogo"].Value : "";
                this.hdnCustomerLogoPath.Value = logoPath;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        /// <summary>
        /// 压缩页面空格和回车
        /// </summary>
        /// <param name="writer"></param>
        protected override void Render(HtmlTextWriter writer)
        {
            StringWriter sw = new StringWriter();
            HtmlTextWriter htmlWriter = new HtmlTextWriter(sw);
            base.Render(htmlWriter);
            string html = sw.ToString();
            /*
            html = html.Replace("//<![CDATA[", "");
            html = html.Replace("//]]>", "");
            html = Regex.Replace(html, "[\f\n\r\t\v]", "");
            html = Regex.Replace(html, " {2,}", " ");
            html = Regex.Replace(html, ">[ ]{1}", ">");
            */
            html = SKT.LeanMES.Web.Utility.PageFilter.NamingContainerFilter(html);
            html = SKT.LeanMES.Web.Utility.PageFilter.ViewStateFilter(html);
            html = SKT.LeanMES.Web.Utility.PageFilter.WhitespaceFilter(html);

            writer.Write(html);
        }
    }
}