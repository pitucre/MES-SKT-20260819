using System;
using SKT.LeanMES.Sparepart.BLL;
using SKT.LeanMES.Sparepart.Model;

namespace SKT.LeanMES.Web.Sparepart
{
    public partial class PartsView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            String idString = Request.QueryString["ID"];


            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SteelItemId";
            this.Master.DefaultSortExpression = "SteelItemId ";


            searchSettings.ExtensionCondition += " EquipmentId = " + idString;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            SparepartInfo partsInfo = (new SKT.LeanMES.Sparepart.BLL.Sparepart()).GetInfo(Convert.ToInt32(idString));

            this.lblPartName.Text = partsInfo.PartName;
            this.lblPartNickName.Text = partsInfo.PartNickName;

            this.lblPartStandard.Text = partsInfo.PartStandard;
            this.lblPartCategory.Text = partsInfo.PartCategory;

            this.lblPartUnit.Text = partsInfo.PartUnit;
            this.lblPartLocation.Text = partsInfo.PartLocation;

            this.lblSupplier.Text = partsInfo.SupplierName;
            this.lblVencode.Text = partsInfo.VenName;

            this.lblPartQty.Text = Convert.ToString(partsInfo.PartQty);
            this.lblRemark.Text = partsInfo.Remark;
            this.lblFactoryDate.Text = partsInfo.FactoryDate.ToString("yyyy-MM-dd");
            this.lblProduceDate.Text = partsInfo.ProduceDate.ToString("yyyy-MM-dd");
            this.Label1.Text = partsInfo.ServiceLife.ToString("yyyy-MM-dd");

        }
    }
}