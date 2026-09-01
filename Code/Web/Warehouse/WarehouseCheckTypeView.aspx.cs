using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.Warehouse
{
public partial class WarehouseCheckTypeView : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String idString = Request.QueryString["ID"];
        WarehouseCheckTypeInfo warehouseCheckTypeInfo = (new WarehouseCheckType()).GetInfo(Convert.ToInt32(idString));

        this.lblErpCode.Text = Convert.ToString(warehouseCheckTypeInfo.ErpCode);
        this.lblWarehouseCheckTypeName.Text = warehouseCheckTypeInfo.WarehouseCheckTypeName;
        this.lblDescribe.Text = warehouseCheckTypeInfo.Describe;
        this.lblCreateBy.Text = warehouseCheckTypeInfo.CreateBy;
        this.lblCreateDateTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(warehouseCheckTypeInfo.CreateDateTime);
        this.lblModifyBy.Text = warehouseCheckTypeInfo.ModifyBy;
        this.lblModifyDateTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(warehouseCheckTypeInfo.ModifyDateTime);
    }
  }
}