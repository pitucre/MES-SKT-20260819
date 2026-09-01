using SKT.LeanMES.Warning.BLL;
using SKT.LeanMES.Warning.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warning
{
    public partial class WarningTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarning));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new WarningType()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WarningTypeInfo PageData
        {
            set
            {
                this.txtWarningTypeName.Text = value.WarningTypeName;
                this.txtWarningTypeValue.Text = Convert.ToString(value.WarningTypeValue);
                this.ddlWarningGroup.SelectedValue = Convert.ToString(value.WarningGroup);
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}