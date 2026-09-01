using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using System.Text;
using SKT.Common.Framework.Model;
using System.Threading;
using System.Globalization;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Configuration;

namespace SKT.LeanMES.Web.Masters
{
    public partial class ProductionCollection : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //验证Anti-Xsrf Token
            AntiXSRFHelper.VerifyToken(this.Page, hdnCsrfToken);

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientConfig));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAccount));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClient));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSupplier));
            hfMESLang.Value = Request.Cookies["lang"].Value;

            //RenderShortcut();
            /*
            //加载菜单
            String pageName = "Client/CommonProCollection.aspx";// Request.QueryString["name"];

            if (pageName == null)
            {
                String path = Request.Path;
                pageName = path.Substring(path.LastIndexOf('/') + 1).Replace(".aspx", "");
            }

            Boolean isWarrantted = this.CheckPagePopedom(pageName);
            if (!isWarrantted)
            {
                //throw new MESException(String.Empty, "NotWarranttedToPage", ExceptionLevel.Warning);
                Response.Write("没有适合您的菜单");
            }*/
            if (!IsPostBack)
            {
                this.lblVersion.InnerText = Resources.Common.ApplicationVersion + Resources.Common.Colon + AppCode.Utility.GetAssemblyInfo.GetApplicationVersion();

                this.hdnIsAjaxPull.Value = ConfigHelper.ReadConfigAppSettingNodeValue("IsAjaxPull");
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

        public string FilterRequestQueryString(string requestName, string defaultValue, int truncateLength)
        {
            string rqs = Request.QueryString[requestName];
            if (rqs == null) 
            {
                return defaultValue;
            }
            if (truncateLength > 0)
            {
                return truncateCharactor(rqs, truncateLength);
            }
            return HttpUtility.UrlDecode(rqs);
            //return rqs;
        }

        /// <summary>
        /// 截取字符串长度
        /// </summary>
        /// <param name="resource">被截取的字符串</param>
        /// <param name="maxLength">截取的字符串长度</param>
        /// <returns></returns>
        private string truncateCharactor(string resource,int maxLength) 
        {
            if (resource.Length > maxLength)
            {
                return resource.Substring(0, maxLength - 3) + "...";
            }
            return resource;
        }
    }
}