using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Plan
{
    public partial class StockListAddPositionStandard : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStockList));
            string idStr = Request.QueryString["PlanOrderNo"] == null ? "" : Request.QueryString["PlanOrderNo"].ToString();
            BindEquipment(idStr);
            var id = Convert.ToInt32(Request.QueryString["standardID"]);

            if (!this.IsPostBack)
            {
                SKT.LeanMES.Plan.BLL.StockList bll = new SKT.LeanMES.Plan.BLL.StockList();
                if (id >0)
                {
                    PageData = bll.GetProdStockByID(Convert.ToInt32(id));
                    hidPid.Value = id.ToString();
                    Button1.Disabled = true;
                }

            }
        }

        private SKT.LeanMES.Plan.Model.StockListInfo PageData
        {
            set
            {
                this.txtMainItemCode.Text = value.ItemCode;
                this.hdnItemId.Value = value.ItemId.ToString();
                this.ddlEquipment.SelectedValue = value.EquipmentId.ToString();
                this.txtArea.Text = value.Area;
                this.txtPosition.Text = value.Positon;
                this.txtNum.Text = value.Num.ToString("0.00");
                this.txtFeederType.Text = value.FeederType;
                this.txtFeederTypeID.Value = value.FeederTypeID.ToString();
            }
        }

        protected void BindEquipment(string linePlanNo)
        {
            var dataTable = new SKT.LeanMES.Plan.BLL.StockList().GetEquipmentList(linePlanNo);
            ddlEquipment.DataTextField = "EquipmentCode";
            ddlEquipment.DataValueField = "EquipmentId";
            ddlEquipment.DataSource = dataTable;
            ddlEquipment.DataBind();
            ddlEquipment.Items.Insert(0, new ListItem("--请选择--", ""));
        }
    }
}