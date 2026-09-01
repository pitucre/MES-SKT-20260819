using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.Warehouse
{
public partial class WarehouseLocationView : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String idString = Request.QueryString["ID"];
        WarehouseLocationInfo warehouseLocationInfo = (new WarehouseLocation()).GetInfo(Convert.ToInt32(idString));
        if (warehouseLocationInfo != null)
        {
            this.lblcStoreCode.Text = warehouseLocationInfo.CStoreCode;
            this.lblcStoreName.Text = warehouseLocationInfo.CStoreName;
            this.lblcPosCode.Text = warehouseLocationInfo.CPosCode;
            this.lblcPosName.Text = warehouseLocationInfo.CPosName;
            this.lblCProperty.Text = warehouseLocationInfo.CProperty;
            this.lblcWhCode.Text = warehouseLocationInfo.CWhCode;
            this.lblMOrder.Text = warehouseLocationInfo.MOrder;
            this.lblPOrder.Text = warehouseLocationInfo.POrder;
            this.lbliPosGrade.Text = Convert.ToString(warehouseLocationInfo.IPosGrade);
            this.lblbPosEnd.Text = Convert.ToString(warehouseLocationInfo.BPosEnd);
            this.lblcBarCode.Text = warehouseLocationInfo.CBarCode;
            this.lbliMaxCubage.Text = Convert.ToString(warehouseLocationInfo.IMaxCubage);
            this.lbliMaxWeight.Text = Convert.ToString(warehouseLocationInfo.IMaxWeight);
                this.lblLoctionType.Text = Convert.ToString(warehouseLocationInfo.LocationType);
            }
    }
  }
}