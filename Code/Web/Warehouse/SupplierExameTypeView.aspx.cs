using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class SupplierExameTypeView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            SupplierExameTypeInfo supplierExameTypeInfo = (new SupplierExameType()).GetInfo(Convert.ToInt32(idString));

            if (supplierExameTypeInfo != null)
            {
                this.lblExameType.Text = supplierExameTypeInfo.ExameType;
                this.lblRemark.Text = supplierExameTypeInfo.Remark;
            }
        }
    }
}