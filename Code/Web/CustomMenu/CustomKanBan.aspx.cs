using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.CustomMenu
{
    public partial class CustomKanBan : BasePage
    {
        protected string pageContent = "";
        protected Boolean IsPreView = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
        }
        protected String InitPage()
        {
            if (Request.QueryString["PaName"] != null)
            {
                pageContent = new LeanMES.CustomMenu.BLL.CustomMenu().GetContentInfo(Request.QueryString["PaName"].ToString());
            }
            //新增时预览
            if (string.IsNullOrEmpty(pageContent))
            {
                IsPreView = true;
                return "";
            }
            string str = Microsoft.JScript.GlobalObject.decodeURI(pageContent);
            int index = str.IndexOf("@@@@@@@@@@;");
            IsPreView = false;
            return str.Substring(0, index);
        }
        protected String InitBodyPage()
        {
            if (string.IsNullOrEmpty(pageContent))
            {
                IsPreView = true;
                return "";
            }
            string str = Microsoft.JScript.GlobalObject.decodeURI(pageContent);
            int index = str.IndexOf("@@@@@@@@@@;");
            IsPreView = false;
            return str.Substring(index + 11);
        }
    }
}