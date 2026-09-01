using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.ComponentModel;
using System.Web.UI.WebControls;
using System.Data;
 

namespace SKT.LeanMES.Web.Controls
{
    /// <summary>
    /// 性别下拉列表控件。
    /// </summary>
    [ToolboxData("<{0}:SexDropDownList runat=\"server\"></{0}:SexDropDownList>")]
    [Description("性别下拉列表。")]
    [Localizable(false)]
    public class SexDropDownList : DropDownListBase
    {
        private String dataValueField = "Value";
        private String dataTextField = "Text";

        /// <summary>
        /// 设置为列表项提供文本内容的数据源字段。
        /// </summary>
        [DefaultValue("SexValue")]
        [Description("设置为列表项提供文本内容的数据源字段。")]
        public String BindTextField
        {
            get { return this.dataTextField; }
            set { this.dataTextField = value; }
        }

        /// <summary>
        /// 设置为列表项提供值的数据源字段。
        /// </summary>
        [DefaultValue("0")]
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
            DataTable dt = new DataTable();
            dt.Columns.Add("Value", System.Type.GetType("System.String"));
            dt.Columns.Add("Text", System.Type.GetType("System.String"));

            DataRow dr = dt.NewRow();
            dr["Value"] = "0";
            dr["Text"] = Resources.Common.Female;
            dt.Rows.Add(dr);

            dr = dt.NewRow();
            dr["Value"] = "1";
            dr["Text"] = Resources.Common.Male;
            dt.Rows.Add(dr);

            dr = dt.NewRow();
            dr["Value"] = "2";
            dr["Text"] = Resources.Common.Other ;
            dt.Rows.Add(dr);

            this.DataSource = dt;
            this.DataValueField = dataValueField;
            this.DataTextField = dataTextField;
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