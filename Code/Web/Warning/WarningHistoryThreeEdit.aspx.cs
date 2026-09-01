using SKT.LeanMES.Warning.Model;
using System;

namespace SKT.LeanMES.Web.Warning
{
    public partial class WarningHistoryThreeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarning));
            String idString = Request.QueryString["ID"];
            WarningHistoryInfo warningInfo = (new SKT.LeanMES.Warning.BLL.WarningHistory()).GetInfo(Convert.ToInt32(idString));
            this.lblWarningName.Text = warningInfo.WarningName;
            this.lblWarningType.Text = warningInfo.WarningType;
            this.lblOrder.Text = warningInfo.OrderNo;
            this.lblLineName.Text = warningInfo.LineName;
            this.lblRatio.Text = warningInfo.Ratio.ToString();
            this.lblNcNum.Text = warningInfo.NcNum.ToString();
            this.txtSolution.Text = warningInfo.ThreeSolve;
        }
    }
}