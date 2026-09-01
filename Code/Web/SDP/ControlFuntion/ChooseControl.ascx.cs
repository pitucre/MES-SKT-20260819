using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace SKT.LeanMES.Web.SDP.ControlFuntion
{
    public partial class ChooseControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindPage(ddlPage);
        }

        private void BindPage(DropDownList ddlPage)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(this.MapPath(String.Format("{0}/App_Data/{1}", WebHelper.WebRoot, "ChoosePage.xml")));

            XmlNodeList nodes = doc.SelectNodes("/pages/page");
            foreach (XmlNode node in nodes)
            {
                string pages = node.Attributes["title"].InnerText;
                string title = pages;
                if (pages.IndexOf('.') > 1)
                {
                    title = GetResourceString(pages, pages.Split(new char[1] { '.' })[0], pages.Split(new char[1] { '.' })[1]);
                }
                ListItem li = new ListItem(title, node.Attributes["id"].InnerText);
                List<string> returnFields = node.Attributes["returnFields"].InnerText.Split(new char[] { ',' }).ToList();

                string returnFielesValue = string.Join(",", returnFields);
                string returnFielesName = "";

                XmlNodeList fieldNodes = node.SelectNodes("fields/field");
                for (int i = 0; i < returnFields.Count; i++)
                {
                    int index = Convert.ToInt32(returnFields[i]) - 1;
                    if (fieldNodes[index].InnerText.IndexOf('.') > 1)
                    {
                        returnFielesName += GetResourceString(fieldNodes[index].InnerText, "lang", fieldNodes[index].InnerText.Split(new char[1] { '.' })[1]) + ",";
                    }
                    else
                    {
                        returnFielesName += fieldNodes[index].InnerText.Replace("lang.", "") + ",";
                    }
                }
                li.Attributes["returnFielesValue"] = returnFielesValue.TrimEnd(new char[] { ',' });
                li.Attributes["returnFielesName"] = returnFielesName.TrimEnd(new char[] { ',' });
                ddlPage.Items.Add(li);
            }

            ddlPage.Items.Insert(0, new ListItem("请选择", ""));
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