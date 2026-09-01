using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseLocationMaterialEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseLocationMaterial));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var bll = new WarehouseLocationMaterial();
                    this.PageData = bll.GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WarehouseLocationMaterialInfo PageData
        {
            set
            {
                this.hdnItemId.Value = value.ItemId.ToString();
                this.txtItemCode.Text = value.ItemCode;
                this.hdnCWhID.Value = value.CWhId.ToString();
                this.txtCWhCode.Text = value.CWhCode;
                this.hdnCWlId.Value = value.CWlId.ToString();
                this.txtCBarCode.Text = value.CBarCode;
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}