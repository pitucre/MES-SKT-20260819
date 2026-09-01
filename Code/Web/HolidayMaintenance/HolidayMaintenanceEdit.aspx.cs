using System;
using SKT.LeanMES.HolidayMaintenance.BLL;
using SKT.LeanMES.HolidayMaintenance.Model;

namespace SKT.LeanMES.Web.HolidayMaintenance
{
    public partial class HolidayMaintenanceEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxHolidayMaintenance));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.HolidayMaintenance.BLL.HolidayMaintenance()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private HolidayMaintenanceInfo PageData
        {
            set
            {
                this.txtDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.Date);
                this.ddlMultiple.SelectedValue = Convert.ToString(value.Multiple);
                this.rblHoliday.SelectedValue = (value.IsHoliday == 0) ? "0" : "1";
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}