using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Plan
{
    public partial class StockListEditStandard : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStockList));
            string idStr = Request.QueryString["PlanOrderNo"] == null ? "" : Request.QueryString["PlanOrderNo"].ToString();

            var entity = new SKT.LeanMES.Plan.BLL.LinePlan().GetLinePlanInfo(idStr);

            if (entity != null && entity.LinePlanId > 0)
            {
                 
                this.LinePlanData = entity;
            }

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "StockListId";
            //this.Master.DefaultSortExpression = "EquipmentCode";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("EquipmentCode", txtEquipmentCode.Text.Trim().Replace("'", "''"));
            searchSettings.AddCondition("Area", txtArea.Text.Trim().Replace("'", "''"));
            searchSettings.AddCondition("Positon", txtPositon.Text.Trim().Replace("'", "''"));
            searchSettings.ExtensionCondition = " FBILLNO = '"+idStr+"'"; 
            
            this.Master.SearchSettings = searchSettings;

        }

        private SKT.LeanMES.Plan.Model.LinePlanInfo LinePlanData
        {
            set
            {
                this.lblItemCode.Text = value.ItemCode.ToString();
                this.lblItemName.Text = value.ItemName.ToString();
                this.lblOrderNo.Text = value.OrderNo.ToString();
                this.lblPlanOrderNo.Text = value.FBILLNO.ToString();
                this.lblPlanQty.Text = value.FQty.ToString();
                //this.lblCLNumber.Text = value.CLNumber;
            }
        }
    }
}