using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Client
{
    public partial class InspectionNCCollection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxNCCode));
            if (!IsPostBack)
            {
                var qs = Request.QueryString["stationId"];//获取站位ID
                var ncCode = Request.QueryString["ncCode"]; //传入的不良代码（将不良代码显示到界面中）
                if (qs != null)
                    this.hidNCStationId.Value = qs.ToString().Trim();
                if (ncCode != null)
                    this.hidNCCodes.Value = ncCode.ToString().Trim();
            }
        }
    }
}