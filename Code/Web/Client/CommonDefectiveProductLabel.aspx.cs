using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Client
{
    public partial class CommonDefectiveProductLabel : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxContainerWeight));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxWarehouseCpInList));
            
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSerialNumber));
            var Id = Convert.ToInt32(Request.QueryString["ID"]);
            var LineName = Request.QueryString["LineId"];
            var OrderNo = Request.QueryString["#OrderNo"];
            var OrderId = Request.QueryString["#OrderId"];
            var StationId = Request.QueryString["#StationId"];
            var productName = Request.QueryString["#ProductName"];
            if (!IsPostBack)
            {
                //LoadinglistInfo(OrderNo, OrderId,StationId,LineName);
            }
        }

        public void LoadinglistInfo(string OrderNo,string OrderId,string stationId,string lineName)
        {



            //this.txtOrderNo.Text = OrderNo;
            //this.hdnOrderId.Value= OrderId;
            //this.txtLineName.Text = lineName;
            //this.hdnLineId.Value = "";
            //this.txtStationName.Text = "";
            //this.hdnStationId.Value = stationId;
        }
    }
}