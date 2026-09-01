using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warning
{
    public partial class WarningHistoryEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarning));
            String idString = Request.QueryString["ID"];
            LeanMES.Warning.Model.WarningHistoryInfo warningInfo = (new SKT.LeanMES.Warning.BLL.WarningHistory()).GetInfo(Convert.ToInt32(idString));
            this.lblWarningName.Text = warningInfo.WarningName;
            this.lblWarningType.Text = warningInfo.WarningType;
            this.lblOrder.Text = warningInfo.OrderNo;
            this.lblLineName.Text = warningInfo.LineName;
            this.lblRatio.Text = warningInfo.Ratio.ToString();
            this.lblNcNum.Text = warningInfo.NcNum.ToString();
            this.txtSolution.Text = warningInfo.OneSolve;
        }
    }
}