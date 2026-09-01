using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.SuplyMaterial
{
    public partial class MaterialUnitEditSuply : BasePage
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
                this.txtCreateTime.Text = value.CreateDateTime.ToString();
                this.txtCreate.Text = value.CreateBy.ToString();
                this.txtBalanceQty.Text = value.BalanceQty.ToString("0.######");
                string txtStorageTime = value.PackTime;
                if (txtStorageTime.Contains("9999-12-31"))
                {
                    txtStorageTime = "";
                }
                this.txtStorageTime.Text = txtStorageTime;
                this.txtCurrentQty.Text = value.Quantity.ToString("0.######");

            }
        }

    }
}