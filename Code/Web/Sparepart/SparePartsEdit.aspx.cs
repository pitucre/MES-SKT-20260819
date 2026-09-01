using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Sparepart.Model;

namespace SKT.LeanMES.Web.Sparepart
{
    public partial class SparePartsEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxSparepart));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxEquipment));
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SteelItemId";
            this.Master.DefaultSortExpression = "SteelItemId ";

            string EquipmentId = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
            searchSettings.ExtensionCondition += " EquipmentId = " + EquipmentId;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            DisplaySteelItem();
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new SKT.LeanMES.Sparepart.BLL.Sparepart()).GetInfo(Convert.ToInt32(idString));
            }
            if (!this.IsPostBack)
            {

            }
        }

        ///检查是否隐藏产品
        private void DisplaySteelItem()
        {
            bool isneedAdd = true;
            int idString = Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"]);
            if (idString == -1 && isneedAdd)
            {
                hdnIsNeedAdd.Value = "1";
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SparepartInfo PageData
        {
            set
            {
                this.txtToolName.Text = value.PartName;
                this.txtToolCode.Text = value.PartNickName;

                this.txtPartCategory.Text = value.PartCategory;
                //this.txtPartMachine.Text = value.PartMachine;
                this.txtPartLocation.Text = value.PartLocation;

                this.txtPartStandard.Text = value.PartStandard;
                //this.txtPartParam.Text = value.PartParam;

                this.txtFactoryDate.Text = value.FactoryDate.ToString("yyyy-MM-dd");
                this.txtProduceDate.Text = value.ProduceDate.ToString("yyyy-MM-dd");
                this.txtServiceLife.Text = value.ServiceLife.ToString("yyyy-MM-dd");
                this.txtPartQty.Text = Convert.ToString(value.PartQty);
                this.txtPartUnit.Text = (value.PartUnit == "-1" ? "" : value.PartUnit);
                this.txtRemark.Text = value.Remark;
                this.txtSupplier.Text = value.SupplierName;
                this.txtFactory.Text = value.VenName;
            }
        }
    }
}