using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ClientConfig.BLL;
using SKT.LeanMES.ClientConfig.Model;
using SKT.Common.Framework.Model;
using SKT.LeanMES.SDP.Model;
using SKT.LeanMES.SDP.BLL;

namespace SKT.LeanMES.Web.ClientConfig
{
    public partial class PopedomInStationEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClientConfig));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStation));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new PopedomInStation()).GetInfo(Convert.ToInt32(idString));
                    if (Request.QueryString["name"].Equals("Client_PopedomStationEdit"))
                    {
                        //复制，将id赋值为-1；
                        this.hdnPopedomInStationId.Value = Request.QueryString["ID"];
                    }
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
                this.txtStation.Text = Convert.ToString(value.StationName);
                this.hdnStationId.Value = Convert.ToString(value.StationId);
                this.txtStationType.Text = Convert.ToString(value.StationTypeName);
                this.hdnStationTypeId.Value = Convert.ToString(value.StationTypeId);
                this.hdnNewTemplate.Value = Convert.ToString(value.Popedom);
                this.txtNewTemp.Text = GetResourceString("Popedom", value.PopedomName);
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