using System;
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace SKT.LeanMES.Web.Labels
{
    public partial class PrinterEdit : BasePage
    {
        private string numbertype = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxLabels));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["Id"];
                //绑定下拉框
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = new Printer().GetEnity(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PrinterInfo PageData
        {
            set
            {
                this.txtName.Text = value.Name;
                this.txtGroupName.Text = value.GroupName;
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}