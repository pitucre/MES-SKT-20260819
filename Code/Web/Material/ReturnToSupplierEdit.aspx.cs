using SKT.LeanMES.Material.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class ReturnToSupplierEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));

            if (!IsPostBack)
            {
                this.hidModifyBy.Value = AccountController.GetCurrentUser().UserName;

                var returnNo = Request.QueryString["Id"];
                if (!string.IsNullOrEmpty(returnNo))
                {
                    
                    SKT.LeanMES.Material.BLL.ReturnToVendor bll = new SKT.LeanMES.Material.BLL.ReturnToVendor();
                    var model = bll.GetReturnToVendorInfo(new ReturnToVendorInfo { ReturnOrder = returnNo,UpdateBy= AccountController.GetCurrentUser().UserName });
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }

        private ReturnToVendorInfo PageData
        {
            set
            {
                this.txtWarehouse.Value = value.CWhName;
                this.hidWarehouseId.Value = value.WarehouseId.ToString();
                this.hidWarehouseCode.Value = value.CWhCode;
            }
        }

    }
}