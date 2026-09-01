using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseTypeView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            WarehouseTypeInfo warehouseTypeInfo = (new WarehouseType()).GetInfo(Convert.ToInt32(idString));

            if (warehouseTypeInfo != null)
            {
                this.lblWarehouseType.Text = warehouseTypeInfo.WarehouseType;
                this.lblRemark.Text = warehouseTypeInfo.Remark;
            }
        }
    }
}