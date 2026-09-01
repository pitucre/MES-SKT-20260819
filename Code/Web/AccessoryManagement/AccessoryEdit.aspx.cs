using System;
using SKT.LeanMES.AccessoryManagement.BLL;
using SKT.LeanMES.AccessoryManagement.Model;

namespace SKT.LeanMES.Web.AccessoryManagement
{
    public partial class AccessoryEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessory));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new Accessory()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private AccessoryInfo PageData
        {
            set
            {
                hAccessoryId.Value = value.AccessoryCodoe;
                //this.txtAccessoryCodoe.Text = value.AccessoryCodoe;
                this.txtAccessoryName.Text = value.AccessoryCodoe;
                this.txtLot.Text = value.Lot;
                this.txtSN.Text = value.SerialNumber;
                this.txtLoseTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.LoseTime);
                this.txtSupplierCode.Text = value.SupplierName;
                hSupplieCodeId.Value = value.SupplierCode;
                hAccessoryTypeId.Value = value.AccessoryType.ToString();
                this.textAccessoryType.Text = value.AccessoryTypeName;
                this.txtInStockQty.Text = Convert.ToString(value.InStockQty);
                this.txtProdDateTime.Text= SKT.Common.Utility.TypeHelper.ToShortDateString(value.ProdDateTime);
            }
        }
    }
}