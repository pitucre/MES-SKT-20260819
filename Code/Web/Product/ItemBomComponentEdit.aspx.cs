using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemBomComponentEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            int compId = Convert.ToInt32(Request.QueryString["ID"]);            
            if (compId > 0)
            { 
                var entity = (new SKT.LeanMES.Product.BLL.ItemBomChild()).GetInfo(compId);
                if (entity != null)
                {
                    this.PageData = entity;
                }
            }
        }

        private SKT.LeanMES.Product.Model.ItemBomChildInfo PageData
        {
            set
            {
                this.txtItemLevel.Text = value.ItemLevel;
                this.txtItemName.Text = value.ItemName;
                this.hdnItemId.Value = value.ItemId.ToString();
                this.hdnItemCode.Value = value.ItemCode;               
                this.txtQty.Text = value.Qty.ToString();
                this.txtUsePosition.Text = value.UsePosition;
                this.lblUnit.Text = value.Units;
                this.ddlIsFictitious.SelectedValue = (value.IsFictitious == true )?"1":"0";
            }
        }
    }
}