using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.ComponentModel;
using System.Web.Caching;
 

namespace SKT.LeanMES.Web.Controls
{
    /// <summary>
    /// 工厂下拉列表控件。
    /// </summary>
    [ToolboxData("<{0}:Report runat=\"server\"></{0}:Report>")]
    [Description("报表下拉列表。")]
    [Localizable(false)]
    public class ReportDDL : DropDownListBase
    {
        private static readonly String cacheKey = "Report";
        private String dataTextField = "TemplateDesc";
        private String dataValueField = "Report";

        /// <summary>
        /// 设置为列表项提供文本内容的数据源字段。
        /// </summary>
        [DefaultValue("RTDescription")]
        [Description("设置为列表项提供文本内容的数据源字段。")]
        public String BindTextField
        {
            get { return this.dataTextField; }
            set { this.dataTextField = value; }
        }

        /// <summary>
        /// 设置为列表项提供值的数据源字段。
        /// </summary>
        [DefaultValue("Report")]
        [Description("设置为列表项提供值的数据源字段。")]
        public String BindValueField
        {
            get { return this.dataValueField; }
            set { this.dataValueField = value; }
        }

        /// <summary>
        /// 绑定列表。
        /// </summary>
        protected override void BindControl()
        {
            #region 注释 Starry 2014-06-14 测试时注释，正式时开起
            //Cache cache = HttpContext.Current.Cache;
            //List<ReportInfo> reportList = cache.Get(cacheKey) as List<ReportInfo>;

            //if (reportList == null)
            //{
            //    reportList = (new SKT.MES.Report.BLL.Report()).GetAvailableBindReportName();

            //    cache.Insert(cacheKey, reportList, null, Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(20));
            //}
            #endregion
            List<SKT.LeanMES.Report.Model.TemplateInfo> reportList = (new SKT.LeanMES.Report.BLL.Template()).GetReportName();
            /*  foreach (SKT.LeanMES.Report.Model.TemplateInfo rpt in reportList)
              {
                  rpt.TemplateDesc = rpt.TemplateDesc + " (" + GetResourceString(rpt.TemplateDesc, "Pages", rpt.TemplateDesc) + ")";
              }*/
            this.DataSource = reportList;
            this.DataTextField = dataTextField;
            this.DataValueField = dataValueField;
            this.DataBind();
        }

        protected String GetResourceString(string strs, string resClass, string resKey)
        {
            string str = strs;
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["lang"];
                string lang = cookie == null ? "zh-cn" : cookie.Value;
                Object resource = HttpContext.GetGlobalResourceObject(resClass, resKey, new System.Globalization.CultureInfo(lang));
                if (resource != null)
                {
                    str = resource.ToString();
                }
            }
            catch { }
            return str;
        }
    }
}