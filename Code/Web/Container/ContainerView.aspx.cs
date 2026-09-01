using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Container.Model;
namespace SKT.LeanMES.Web.Container
{
    public partial class ContainerView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxContainer));
            if (!this.IsPostBack)
            {
                string ContainerId = Request.QueryString["ID"].ToString();
                if (ContainerId != null)
                {
                    SKT.LeanMES.Container.BLL.Container bllContainer = new SKT.LeanMES.Container.BLL.Container();
                    SKT.LeanMES.Container.Model.ContainerInfo model = null;
                    model = bllContainer.GetInfo(Convert.ToInt32(ContainerId));
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
        private ContainerInfo PageData
        {
            set
            {
                this.labName.Text = value.Name;
                this.lblDescription.Text = value.Description;
                this.lblDataTypeName.Text = value.DataTypeName;
                this.lblStatus.Text = value.Status;
                this.lblMixShopOrders.Text = (value.MixShopOrders) ? (String)GetGlobalResourceObject("Common", "Yes") : (String)GetGlobalResourceObject("Common", "No");
                this.lblMixItems.Text = (value.MixItems) ? (String)GetGlobalResourceObject("Common", "Yes") : (String)GetGlobalResourceObject("Common", "No");
                this.lblSequence.Text = (value.Sequence) ? (String)GetGlobalResourceObject("Common", "Yes") : (String)GetGlobalResourceObject("Common", "No");
                this.lblHeight.Text = value.Height.ToString();
                this.lblLength.Text = value.Depth.ToString();
                this.lblMaxFillWeight.Text = value.MaxFillWeight.ToString();
                this.lblWidth.Text = value.Width.ToString();
                this.lblContainerWeight.Text = value.Weight.ToString();
            }
        }
    }
}