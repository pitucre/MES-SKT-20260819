using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.Utility;

namespace SKT.MES.Web.BasalData
{
    public partial class ShiftMemberEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShiftMember));
            Int32 MPID = Convert.ToInt32(Request.QueryString["ID"]);
            if (!this.IsPostBack)
            {
                if (MPID != -1)
                {
                    SKT.LeanMES.ProductionShift.BLL.Shift_Member bllDict = new SKT.LeanMES.ProductionShift.BLL.Shift_Member();
                    SKT.LeanMES.ProductionShift.Model.Shift_MemberInfo model = null;
                    model = bllDict.GetInfo(MPID);
                    if (model != null)
                    {
                        this.ShiftMember = model;
                        this.txtProductionShift.Enabled = false;
                    }
                }
            }
        }

        /// <summary>
        /// 编辑状态下获得对应CertID的数据
        /// </summary>
        protected SKT.LeanMES.ProductionShift.Model.Shift_MemberInfo ShiftMember
        {
            set
            {
                this.txtProductionShift.Text = value.ProductionShift.ToString();
                this.txtDescription.Text = value.Description;
                this.txtStartTime.Text = value.StartTime;
                this.txtEndTime.Text = value.EndTime;
                this.txtSequence.Text = value.Sequence.ToString();
                this.chkIsInterDay.Checked = value.IsInterday;
            }
        }
    }
}