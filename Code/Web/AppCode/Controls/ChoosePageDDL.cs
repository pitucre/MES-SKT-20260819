using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.ComponentModel;
using System.Web.Caching;
using System.Xml;

namespace SKT.LeanMES.Web.Controls
{
    /// <summary>
    /// ChoosePage下拉列表控件。
    /// </summary>
    [ToolboxData("<{0}:ChoosePage runat=\"server\"></{0}:ChoosePage>")]
    [Description("报表下拉列表。")]
    [Localizable(false)]
    public class ChoosePageDDL : DropDownListBase
    {
        private String dataValueField = "Field1";
        private String dataTextField = "Field2";

        /// <summary>
        /// 设置为列表项提供文本内容的数据源字段。
        /// </summary>
        [DefaultValue("-")]
        [Description("设置为列表项提供文本内容的数据源字段。")]
        public String BindTextField
        {
            get { return this.dataTextField; }
            set { this.dataTextField = value; }
        }

        /// <summary>
        /// 设置为列表项提供值的数据源字段。
        /// </summary>
        [DefaultValue("-1")]
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
            XmlDocument doc = new XmlDocument();
            doc.Load(HttpContext.Current.Server.MapPath(SKT.LeanMES.Web.WebHelper.WebRoot + "/App_Data/ChoosePage.xml"));
            XmlNodeList nodeList = doc.SelectNodes("//page[@id]");
            List<AJAXdataHelper.EntityInfo> list = new List<AJAXdataHelper.EntityInfo>();
            AJAXdataHelper.EntityInfo entity = null;
            string text = "";

            entity = new AJAXdataHelper.EntityInfo("-1", "", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
            list.Add(entity);

            foreach (XmlNode node in nodeList)
            {
                entity = new AJAXdataHelper.EntityInfo(null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
                entity.Field1 = node.Attributes["id"].Value;
                text = node.Attributes["title"].Value;
                entity.Field2 = GetResourceString(text, "Pages", text.Split(new char[1] { '.' })[1]);
                list.Add(entity);
            }

            this.DataSource = list;
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