using System;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Web.MaterialCheck
{
public partial class WarehouseCheckOrderView : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String idString = Request.QueryString["ID"];
        WarehouseCheckOrderInfo warehouseCheckOrderInfo = (new WarehouseCheckOrder()).GetInfo(Convert.ToInt32(idString));

        //this.lblCheckOrder.Text = warehouseCheckOrderInfo.CheckOrder;
        //this.lblCheckTypeId.Text = Convert.ToString(warehouseCheckOrderInfo.CheckTypeId);
        //this.lblWarehouseId.Text = Convert.ToString(warehouseCheckOrderInfo.WarehouseId);
        //this.lblBeginDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(warehouseCheckOrderInfo.BeginDate);
        //this.lblCheckOrderStatus.Text = Convert.ToString(warehouseCheckOrderInfo.CheckOrderStatus);
        //this.lblRemark.Text = warehouseCheckOrderInfo.Remark;
        //this.lblCreateBy.Text = warehouseCheckOrderInfo.CreateBy;
        //this.lblCreateTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(warehouseCheckOrderInfo.CreateTime);
        //this.lblUpdateBy.Text = warehouseCheckOrderInfo.UpdateBy;
        //this.lblUpdateTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(warehouseCheckOrderInfo.UpdateTime);
        //this.lblErpCode.Text = warehouseCheckOrderInfo.ErpCode;
        //this.lblDefault1.Text = warehouseCheckOrderInfo.Default1;
        //this.lblDefault2.Text = warehouseCheckOrderInfo.Default2;
        //this.lblDefault3.Text = warehouseCheckOrderInfo.Default3;
    }
  }
}