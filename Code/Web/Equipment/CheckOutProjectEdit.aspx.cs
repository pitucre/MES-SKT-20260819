using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class CheckOutProjectEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxCheckOutProject));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new CheckOutProject()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private CheckOutProjectInfo PageData
        {
            set
            {
                this.txtCheckOutProjectName.Text = value.CheckOutProjectName;
                this.txtIsEnable.Text = value.IsEnable ? "1" : "0";
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}