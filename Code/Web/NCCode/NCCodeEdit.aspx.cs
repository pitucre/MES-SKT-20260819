using System;
using SKT.LeanMES.NCCode.BLL;
using SKT.LeanMES.NCCode.Model;

namespace SKT.LeanMES.Web.NCCode
{
    public partial class NCCodeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxNCCode));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SKT.LeanMES.NCCode.BLL.NCCode code = new LeanMES.NCCode.BLL.NCCode();
                    NCCodeInfo model = code.GetInfo(Convert.ToInt32(idString));
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
        private NCCodeInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtNCCode.Text = Resources.Buttons.COM_Copy + " - " + value.NCCode;
                }
                else
                {
                    this.txtNCCode.Text = value.NCCode;
                }
                this.txtNCCodeType.Text = value.NCCodeTypeName;
                this.hdnNCCodeTypeId.Value = value.NCCodeTypeId.ToString();
                this.txtDescription.Text = value.Description;
                if (value.Category == "失败品")
                {
                    value.Category = "Failure";
                }
                else if (value.Category == "缺陷品")
                {
                    value.Category = "Defect";
                }
                else if (value.Category == "返修品")
                {
                    value.Category = "Repair";
                }
                this.ddlStatus.SelectedValue = value.Status;
                this.ddlCategory.SelectedValue = value.Category;
                this.txtDataType.Text = value.DataType;
                this.txtDataTypeID.Value = value.DataTypeID.ToString();
            }
        }
    }
}