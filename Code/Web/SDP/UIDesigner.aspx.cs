using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SDP.Model;
using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SDP
{
    public partial class UIDesigner : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
            string ID = Request.QueryString["ID"].ToString();
            UIModelInfo info = new UIModel().GetInfo(Convert.ToInt32(ID));
            if (info != null)
            {
                txtModelName.Text = info.ModelName;
                txtStation.Text = info.Station;
                hdnStationId.Value = info.StationId.ToString();

            }
        }
    }
}