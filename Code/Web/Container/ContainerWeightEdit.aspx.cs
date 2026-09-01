using SKT.LeanMES.Container.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Container
{
    public partial class ContainerWeightEdit : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxContainerWeight));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new AjaxContainerWeight()).GetContainerWeightById(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }

                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ContainerWeightInfo PageData
        {
            set
            {
                this.txtMainItemCode.Text = value.ItemCode;
                this.hdnMainItemId.Value = value.ItemId.ToString();
                this.txtMinQty.Text = value.MinWeight.ToString();
                this.txtMaxQty.Text = value.MaxWeight.ToString();
                this.ddlType.Text = value.PackingType;
                this.sltUnits.Value = value.UnitId;
                this.txtProdOrder.Text = value.OrderNO;
                hdnProdOrderId.Value = value.ProdOrderId.ToString();
                if (value.TypeId == 2)
                {
                    radioProdOrder.Checked = true;
                    //trItem.Visible = false;
                    //trProdOrder.Visible = true;
                }

            }
        }
    }
}