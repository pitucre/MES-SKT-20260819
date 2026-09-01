using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Container.Model;

namespace SKT.LeanMES.Web.Container
{
    public partial class ContainerEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxContainer));
            if (!this.IsPostBack)
            {
                string ContainerId = Request.QueryString["ID"].ToString();
                //绑定下拉框
                Bind("Status", this.ddlStatus);

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
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtName.Text = Resources.Buttons.COM_Copy + " - " + value.Name;
                }
                else
                {
                    this.txtName.Text = value.Name;
                }
                this.txtDescription.Text = value.Description;
                this.txtDataTypeName.Text = value.DataTypeName;
                this.txtDataTypeID.Value = Convert.ToString(value.DataTypeId);
                this.ddlStatus.Text = value.Status;
                this.CbMixShopOrders.Checked = value.MixShopOrders;
                this.textHeight.Text = value.Height.ToString();
                this.textLength.Text = value.Depth.ToString();
                this.textMaxFillWeight.Text = value.MaxFillWeight.ToString();
                this.textWidth.Text = value.Width.ToString();
                this.textContainerWeight.Text = value.Weight.ToString();
                this.CbMixItems.Checked = value.MixItems;
                this.CbSequence.Checked = value.Sequence;
            }
        }

        /// <summary>
        /// 下拉框绑定
        /// </summary>
        /// <param name="Value">查询字段值</param>
        /// <param name="DDList">下拉框</param>
        private void Bind(string Value, DropDownList DDList)
        {

            SKT.LeanMES.SerialNumber.BLL.Dictionary dictionary = new LeanMES.SerialNumber.BLL.Dictionary();
            List<SKT.LeanMES.SerialNumber.Model.DictionaryInfo> dInfos = dictionary.GetListInfo(Value);
            DDList.DataSource = dInfos;
            DDList.DataTextField = "Value";
            DDList.DataValueField = "Value";
            DDList.DataBind();
        }
    }
}