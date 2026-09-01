using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web
{
    public partial class ReturnToSupplierDtl : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            string itemCode = Request.QueryString["ItemCode"] == null ? "-1" : Request.QueryString["ItemCode"].ToString();

            SKT.LeanMES.Material.BLL.Material bll = new SKT.LeanMES.Material.BLL.Material();
            hfDataJson.Value = bll.GetReturnToVendorGrn(IdStr, itemCode);
        }
    }
}