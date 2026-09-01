using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Container.BLL;
using SKT.LeanMES.Container.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Container
{
    public partial class PackingAccessoriesEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPackingAccessories));
            BindMaskId();
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new PackingAccessories()).GetInfo(Convert.ToInt32(idString));
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
        private PackingAccessoriesConfigInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtAccessoriesName.Text = Resources.Buttons.COM_Copy + " - " + value.AccessoriesName;
                }
                else
                {
                    this.txtAccessoriesName.Text = value.AccessoriesName;
                }
                this.txtMainItemCode.Text = value.ItemCode;
                this.hdnMainItemId.Value = Convert.ToString(value.ItemId);                
                this.txtStation.Text = Convert.ToString(value.Station);
                this.hdnStationId.Value = value.StationId.ToString();
                this.txtAccessoriesQty.Text = Convert.ToString(value.AccessoriesQty);
                this.txtMaskId.SelectedValue = Convert.ToString(value.MaskId);
                this.txtMaskId.Text = value.MaskGroup;
                this.txtRemark.Text = value.Remark;
                this.txtSequence.Text = value.Sequence.ToString();
                this.ddlCheckType.SelectedValue = value.CheckType.ToString();
                this.ddlSnType.SelectedValue = value.MaskId.ToString();
                this.ddlPart.SelectedValue = value.MaskId.ToString();
            }
        }
        protected void BindMaskId()
        {
            AjaxPackingAccessories bll = new AjaxServices.AjaxPackingAccessories();
            this.txtMaskId.DataSource = bll.GetMaskIdALL();
            this.txtMaskId.DataTextField = "MaskGroup";
            this.txtMaskId.DataValueField = "MaskId";
            this.txtMaskId.DataBind();
        }
    }
}