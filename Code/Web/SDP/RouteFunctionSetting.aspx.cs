using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SDP.Model;
using Resources;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SDP
{
    public partial class RouteFunctionSetting : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
            if (!IsPostBack)
            {   
                Common.Model.SearchSettings search = new Common.Model.SearchSettings();
                if (Request.QueryString["ID"] != null)
                {
                    search.AddCondition("RD_ID", Request.QueryString["ID"]);
                }
                else
                {
                    search.AddCondition("R_ID", Request.QueryString["RouterID"]);
                    search.AddCondition("Incoming_OpeID", Request.QueryString["OperationID"]);
                }
                List<RouteDetail> routeDetail = new SKT.LeanMES.SDP.BLL.Activity().GetRouteDetail(0, 10, "RD_ID Desc", search);

                if (routeDetail.Count > 0)
                {
                    lblRoute.Text = routeDetail[0].R_Name;
                    lblStation.Text = routeDetail[0].Station;
                    hdnStationId.Value = routeDetail[0].StationId.ToString();
                    lblStationDesc.Text = routeDetail[0].StationDesc;
                    hdnReouteDetailId.Value = routeDetail[0].RD_Id.ToString();

                    int modelId = routeDetail[0].ModelId.Value;
                    hdnModelId.Value = modelId.ToString();
                    UIModelDetailInfo modelinfo = new SKT.LeanMES.SDP.BLL.UIModelDetail().GetInfo(modelId);
                    if (modelinfo != null)
                    {
                        ContenHtml.Value = modelinfo.TemplateData;
                    }
                }
            }
        }
    }
}