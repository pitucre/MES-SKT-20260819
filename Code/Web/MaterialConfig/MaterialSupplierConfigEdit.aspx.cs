using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.MaterialConfig.Model;

namespace SKT.LeanMES.Web.MaterialConfig
{
    public partial class MaterialSupplierConfigEdit : BasePage
    {
        public Int32 configTypeId = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SKT.LeanMES.MaterialConfig.BLL.MaterialSupplierConfig supplierConfig = new LeanMES.MaterialConfig.BLL.MaterialSupplierConfig();
                    MaterialSupplierConfigInfo model = supplierConfig.GetInfo(Convert.ToInt32(idString));                   
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }


        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MaterialSupplierConfigInfo PageData
        {
            set
            {
                this.txtSupplier.Text = value.VendorName;
                this.hdnSupplierCode.Value = value.VendorCode;
                this.hdnSupplierId.Value = value.SupplierId.ToString();
                this.hdnItemId.Value = value.ItemId.ToString();
                this.txtItemName.Text = value.ItemName;
                this.hdnItemCode.Value = value.ItemCode;
                this.ddlPrintType.SelectedValue = value.PrintTypeId.ToString();
                this.txtRemark.Text = value.Remark.ToString();
            }
        }
    }
}