using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.IO;
using System.Threading;
using System.Globalization;

using SKT.Common.Account.Model;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.Web.Framework
{
    public partial class MsgCenter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPlugins));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxNavigation));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            #region 问候信息
            string hello = "";
            DateTime dt = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd HH:mm"));
            DateTime n = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd") + " 00:00");
            /*
             * 6:00 ~ 9:00 早上
             * 9:00 ~ 12:00 上午
             * 12:00 ~ 13:00 中午
             * 13:00 ~ 19:00 下午
             * 19:00 ~ 6:00 晚上
             */

            if (dt >= n.AddHours(6) && dt < n.AddHours(9))
            {
                hello = $"{Resources.lang.GoodMorning}，";
            }
            else if (dt >= n.AddHours(9) && dt < n.AddHours(12))
            {
                hello = $"{Resources.lang.GoodMornings}，";
            }
            else if (dt >= n.AddHours(12) && dt < n.AddHours(13))
            {
                hello = $"{Resources.lang.GoodAfternoon}，";
            }
            else if (dt >= n.AddHours(13) && dt < n.AddHours(19))
            {
                hello = $"{Resources.lang.GoodAfternoons}，";
            }
            else if (dt >= n.AddHours(19) && dt < n.AddHours(33))
            {
                hello = $"{Resources.lang.GoodEvening}，";
            }
            #endregion

            if (!IsPostBack)
            {
                MembershipInfo user = AccountController.GetCurrentUser();
                if (String.IsNullOrEmpty(user.EmployeeNo))
                {
                    this.lblUserName.Text = hello + " " + user.UserName;
                }
                else
                {
                    this.lblUserName.Text = hello + " " + user.UserName + " (" + Resources.lang.EmployeeNo + ":" + user.EmployeeNo + ")";
                }
                this.lblUserName.Text += $"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{Resources.lang.WelcomeToSKTLeanMESSystem}。";
                this.lblUserName.Style.Add("margin-left", "20px;");
                this.lblUserName.Style.Add("height", "25px;");
                this.lblUserName.Style.Add("color", "#000000");
                this.lblUserName.Style.Add("width","50%");
                this.lblUserName.Font.Bold = true;
                this.lblEmployeeNo.Text = user.EmployeeNo;
                this.lblName.Text = user.EmployeeCName;
                if (!String.IsNullOrEmpty(user.EmployeeEName))
                {
                    this.lblName.Text += "(" + user.EmployeeEName + ")";
                }
                //this.lblTel.Text = user.Phone.ToString();
                //this.lblEmail.Text = user.Email.ToString();
                //this.lblLastLoginTime.Text = Common.Utility.TypeHelper.ToLongDateString(user.LastLoginDate);

                this.lblAppVersion.Text = AppCode.Utility.GetAssemblyInfo.GetApplicationVersion();
            }
        }

        /// <summary>
        /// 设置页面语言
        /// </summary>
        protected override void InitializeCulture()
        {
            String strlang = "zh-cn";
            HttpCookie cookieLang = this.Request.Cookies["lang"];
            if (cookieLang != null)
            {
                cookieLang = Request.Cookies["lang"];
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(cookieLang.Value);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(cookieLang.Value);
            }
            else
            {
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(strlang);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(strlang);
            }
            base.InitializeCulture();
        }

        protected override void Render(HtmlTextWriter writer)
        {
            StringWriter sw = new StringWriter();
            HtmlTextWriter htmlWriter = new HtmlTextWriter(sw);
            base.Render(htmlWriter);
            string html = sw.ToString();
            html = html.Replace("//<![CDATA[", "");
            html = html.Replace("//]]>", "");
            html = Regex.Replace(html, "[\f\n\r\t\v]", "");
            html = Regex.Replace(html, " {2,}", " ");
            html = Regex.Replace(html, ">[ ]{1}", ">");
            writer.Write(html);
        }
    }
}