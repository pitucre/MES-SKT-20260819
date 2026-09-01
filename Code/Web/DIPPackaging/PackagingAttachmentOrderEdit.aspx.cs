using SKT.LeanMES.Container.BLL;
using SKT.LeanMES.Container.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.DIPPackaging
{
    public partial class PackagingAttachmentOrderEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxDIPPackaging));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new PackagingAttachmentOrder()).GetInfo(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }
                    else
                    {
                        this.txtPAOId.Value = "-1";
                    }
                }
                else
                {
                    this.txtPAOId.Value = "-1";
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PackagingAttachmentOrderInfo PageData
        {
            set
            {
                this.txtPAOId.Value = value.PAOId.ToString();
                this.txtOrderNO.Text = value.OrderNO;
                this.txtOrderId.Value = value.ProdOrderID.ToString();
                this.lblItemCode.Text = value.ItemCode;
                this.lblItemName.Text = value.ItemName;
                this.txtItemId.Value = value.ItemId.ToString();
                this.txtQuantity.Text = value.Quantity.ToString();
                this.txtDescription.Text = value.Description;
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}