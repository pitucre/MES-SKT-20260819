using System;
using SKT.LeanMES.Allowance.BLL;
using SKT.LeanMES.Allowance.Model;

namespace SKT.LeanMES.Web.Allowance
{
    public partial class AllowanceEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAllowance));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.Allowance.BLL.Allowance()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private AllowanceInfo PageData
        {
            set
            {
                this.hdnUserId.Value = Convert.ToString(value.UserID);
                this.txtUserName.Text = value.UserName;
                this.txtwages.Text = Convert.ToString(value.Wages);
                this.txtRemark.Text = value.Remark;
                this.txtOutputAllowance.Text = Convert.ToString(value.OutputAllowance);
            }
        }
    }
}