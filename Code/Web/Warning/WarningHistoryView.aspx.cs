using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warning
{
    public partial class WarningHistoryView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            LeanMES.Warning.Model.WarningHistoryInfo warningInfo = (new SKT.LeanMES.Warning.BLL.WarningHistory()).GetInfo(Convert.ToInt32(idString));
            this.lblWarningName.Text = warningInfo.WarningName;
            this.lblWarningType.Text = warningInfo.WarningType;
            this.lblOrder.Text = warningInfo.OrderNo;
            this.lblLineName.Text = warningInfo.LineName;
            this.lblRatio.Text = warningInfo.Ratio.ToString();
            this.lblNcNum.Text = warningInfo.NcNum.ToString();
            this.lblSolution1.Text = warningInfo.OneSolve;
            this.lblSolution2.Text = warningInfo.TowSolve;
            this.lblSolution3.Text = warningInfo.ThreeSolve;
            this.lblCloseBy.Text = warningInfo.CloseBy;
            if (warningInfo.CloseDateTime.ToString("yyyy-MM-dd") == "9999-12-30")
            {
                this.lblCloseDateTime.Text = "";
            }
            else
            {
                this.lblCloseDateTime.Text = warningInfo.CloseDateTime.ToString("yyyy-MM-dd");
            }
            int Status = warningInfo.Status;
            string StatusName = "";
            if (Status == 1)
            {
                StatusName = "一级预警中";
            }
            else if (Status == 2)
            {
                StatusName = "二级预警中";
            }
            else if (Status == 3)
            {
                StatusName = "三级预警中";
            }
            else if (Status == 4)
            {
                StatusName = "已关闭";
            }
            else
            {
                StatusName = "";
            }
            this.lblStatusName.Text = StatusName;
        }
    }
}