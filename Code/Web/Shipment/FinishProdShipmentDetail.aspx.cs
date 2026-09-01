using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Shipment.BLL;
using SKT.LeanMES.Shipment.Model;

namespace SKT.LeanMES.Web.Shipment
{
    public partial class FinishProdShipmentDetail : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMobileShipment));
            string ID = Request.QueryString["ID"] == null ? "" : Request.QueryString["ID"];
            if (!this.IsPostBack)
            {
                if (ID != null && ID != "")
                {
                    txtCode.Text = ID;
                    var entity = (new ShipmentRecord()).GetInfo(ID);
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }
                }
            }
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AutoID";
            this.Master.DefaultSortExpression = "AutoID DESC";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "Code='" + ID + "'";
            this.Master.SearchSettings = searchSettings;
        }
        /// <summary>
        /// 设置页面上的部件数据。
        /// </summary>
        private ShipmentRecordInfo PageData
        {
            set
            {
                this.txtSOCode.Text = value.SOCode;
                this.txtDate.Text = value.ShipDate;
                this.txtCusCode.Text = value.CusCode;
                this.txtPlanQty.Text = value.PlanQty.ToString();
                this.txtOutStorageQty.Text = value.OutStorageQty.ToString();
            }
        }
    }
}