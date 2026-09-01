using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.SDP.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SDP
{
    public partial class SDPUIDesigner : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
            if (!IsPostBack)
            {
                string ID = Request.QueryString["ID"].ToString();
                UIModelInfo info = new UIModel().GetInfo(Convert.ToInt32(ID));
                if (info != null)
                {
                    txtModelName.Text = info.ModelName;
                    hdnValue.Value = info.Content.Replace("''", "'");
                    hdnStationId.Value = info.StationId.ToString();
                    txtStation.Text = info.Station;
                    hdBuiltinPopedom.Value = info.PopedomId.ToString();
                }
            }
        }
    }
}