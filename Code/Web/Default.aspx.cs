using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using System.IO;

namespace SKT.LeanMES.Web
{
    public partial class Default : Systems.Web.AccessPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string IsGroupEdition = string.IsNullOrEmpty(Request.QueryString["org"]) ? "" : Request.QueryString["org"].ToString();
            if (IsGroupEdition=="1")
            {
                Response.Redirect("GroupIndex.aspx");
            }
            else {
                Response.Redirect("Index.aspx");
            }
           
            Response.End();
            //当前版本
            this.hdnVersion.Value = Resources.Common.ApplicationVersion + Resources.Common.Colon + AppCode.Utility.GetAssemblyInfo.GetApplicationVersion();
            
            //设置当前选择的语言
            if (Request.Cookies["lang"] != null)
            {
                this.hdnLang.Value = Request.Cookies["lang"].Value;
            }

            //记住我
            if (Request.Cookies["UserInfo"] != null)
            {
                this.hdnUserName.Value = Request.Cookies["UserInfo"].Values["UserName"].ToString();
                this.hdnIsRmb.Value = "1";
            }

            if (Request.Cookies["DBLink"] != null)
            {
                this.hdnCurrentSite.Value = Request.Cookies["DBLink"]["id"];
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