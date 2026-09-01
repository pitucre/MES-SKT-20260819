using System;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Station.Model;

namespace SKT.LeanMES.Web.Station
{
    public partial class PhaseEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPhase));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new Phase()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PhaseInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtPhaseName.Text = Resources.Buttons.COM_Copy + " - " + value.PhaseName;
                }
                else
                {
                    this.txtPhaseName.Text = value.PhaseName;
                }
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}