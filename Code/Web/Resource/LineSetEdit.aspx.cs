using SKT.LeanMES.Resource.BLL;
using SKT.LeanMES.Resource.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Resource
{
    public partial class LineSetEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceResource));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new LineSet()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private LineSetInfo PageData
        {
            set
            {
                this.txtLineSetDate.Text = value.LineSetDate.ToShortDateString();
                this.hdnLineId.Value = Convert.ToString(value.LineId);
                this.txtLineName.Text = Convert.ToString(value.LineName);
                this.hdfShiftList.Value = Convert.ToString(value.ShiftId);
                this.txtShiftList.Text = Convert.ToString(value.ShiftName);
                this.txtPrincipal.Text = Convert.ToString(value.CName);
                this.hidPrincipal.Value = Convert.ToString(value.Principal);
                this.txtStandardHuman.Text = Convert.ToString(value.StandardHuman);
                this.txtActualHuman.Text = Convert.ToString(value.ActualHuman);
                this.txtSecond.Text = Convert.ToString(value.CSecName);
                this.hidSecond.Value = Convert.ToString(value.Seccipal);
            }
        }
    }
}