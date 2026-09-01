using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web
{
    public partial class GroupIndex : Systems.Web.AccessPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //验证Anti-Xsrf Token
            AntiXSRFHelper.VerifyToken(this.Page, hdnCsrfToken);

            if (Request.Cookies["lang"] != null)
            {
                this.hdnLang.Value = Request.Cookies["lang"].Value;
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
            html = Utility.PageFilter.NamingContainerFilter(html);
            html = Utility.PageFilter.ViewStateFilter(html);
            html = Utility.PageFilter.WhitespaceFilter(html);

            writer.Write(html);
        }

    }
}