using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Supplier.Model;

namespace SKT.LeanMES.Web.SuplyMaterial
{
    public partial class SupplierDeliveryEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSupplier));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SupplierDeliveryInfo model = (new SKT.LeanMES.Supplier.BLL.SupplierDelivery()).GetVendorByPO(idString);
                    if (model != null)
                    {
                        //供应商名称
                        lblVendorName.Text = model.VendorName;
                        lblPO.Text = model.POCode;
                    }
                }
            }
        }
    }
}