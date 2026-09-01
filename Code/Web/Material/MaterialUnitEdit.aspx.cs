using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialUnitEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));
            if (!this.IsPostBack)
            {
                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;



                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    MaterialUnit bllUnit = new MaterialUnit();
                    MaterialUnitInfo model = null;
                    model = bllUnit.GetMateialUnitById(Id);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                    SKT.LeanMES.Material.BLL.Material bll = new SKT.LeanMES.Material.BLL.Material();
                    hfDataJson.Value = bll.GetMaterialHistory(Id);

                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MaterialUnitInfo PageData
        {
            set
            {
                this.txtSerialNumber.Text = value.SerialNumber;
                this.txtLotCode.Text = value.LotCode;
                this.txtDateCode.Text = value.DateCode.ToString();
                this.txtItemName.Text = value.ItemName.ToString();
                this.txtItemDesc.Text = value.ItemDesc.ToString();
                this.txtMPN.Text = value.MPN.ToString();
                this.txtStatus.Text = value.WOStatus.ToString();
                this.txtSupplier.Text = value.VendorCode.ToString();
                this.txtCreateTime.Text = value.CreateDateTime.ToString();
                this.txtCreate.Text = value.CreateBy.ToString();
                this.txtBarCode.Text = value.CBarCode.ToString();
                this.txtBalanceQty.Text = value.BalanceQty.ToString("0.######");
                this.txtStorageTime.Text = value.PackTime.Contains("9999-12-31") ? "" : value.PackTime;
                this.txtCurrentQty.Text = value.Quantity.ToString("0.######");

            }
        }

    }
}