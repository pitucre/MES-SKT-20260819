using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ClientConfig.BLL;
using SKT.LeanMES.ClientConfig.Model;

namespace SKT.LeanMES.Web.ClientConfig
{
    public partial class PopedomInStationView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClientConfig));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new PopedomInStation()).GetInfo(Convert.ToInt32(idString));                    
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PopedomInStationInfo PageData
        {
            set
            {
                this.lblStation.InnerText = Convert.ToString(value.StationName);
                this.lblStationType.InnerText = Convert.ToString(value.StationTypeName);
                this.lblNewTemp.InnerText = GetResourceString("Popedom", value.PopedomName);
            }
        }

        private String GetResourceString(string resClass, string resKey)
        {
            string str = "";

            HttpCookie cookie = HttpContext.Current.Request.Cookies["lang"];
            string lang = cookie == null ? "zh-cn" : cookie.Value;
            Object resource = HttpContext.GetGlobalResourceObject(resClass, resKey, new System.Globalization.CultureInfo(lang));
            if (resource != null)
            {
                str = resource.ToString();
            }
            else
            {
                str = resKey;
            }
            return str;
        }
    }
}