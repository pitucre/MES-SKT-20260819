using System;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Station.Model;

namespace SKT.LeanMES.Web.Station
{
    public partial class PhaseView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                PhaseInfo phaseInfo = (new Phase()).GetInfo(Convert.ToInt32(idString));
                this.lblPhaseName.Text = phaseInfo.PhaseName;
                this.lblCreateBy.Text = phaseInfo.CreateBy;
                this.lblCreateDateTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(phaseInfo.CreateDateTime);
                this.lblModifyBy.Text = phaseInfo.ModifyBy;
                this.lblModifyDateTime.Text = SKT.Common.Utility.TypeHelper.ToLongDateString(phaseInfo.ModifyDateTime);
                this.lblRemark.Text = phaseInfo.Remark;
            }
        }
    }
}