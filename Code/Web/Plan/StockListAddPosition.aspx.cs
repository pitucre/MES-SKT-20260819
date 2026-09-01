using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Plan
{
    public partial class StockListAddPosition : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStockList));
            string idStr = Request.QueryString["PlanOrderNo"] == null ? "" : Request.QueryString["PlanOrderNo"].ToString();
            BindEquipment(idStr);
        }


        protected void BindEquipment(string linePlanNo)
        {
            var dataTable = new SKT.LeanMES.Plan.BLL.StockList().GetEquipmentList(linePlanNo);
            ddlEquipment.DataTextField = "EquipmentCode";
            ddlEquipment.DataValueField = "EquipmentId";
            ddlEquipment.DataSource = dataTable;            
            ddlEquipment.DataBind();
            ddlEquipment.Items.Insert(0,new ListItem("--请选择--", ""));
        }
    }
}