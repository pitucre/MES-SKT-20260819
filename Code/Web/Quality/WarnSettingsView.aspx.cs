using System;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Web.Quality
{
    public partial class WarnSettingsView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            WarnSettingsInfo warnSettingsInfo = (new WarnSettings()).GetInfo(Convert.ToInt32(idString));

            this.lblItemCode.Text = warnSettingsInfo.ItemName;
            this.lblLineName.Text = warnSettingsInfo.LineName;
            this.lblStationName.Text = warnSettingsInfo.StationName;
            this.lblWarnType.Text = warnSettingsInfo.WarnType == 1 ? "班次":"天";
            this.lblWarnLevel.Text = Convert.ToString(warnSettingsInfo.WarnLevel);
            this.lblYield.Text = Convert.ToString(warnSettingsInfo.Yield);
            this.lblReciveUsers.Text = warnSettingsInfo.ReciveUsers;
            this.lblContents.Text = warnSettingsInfo.Contents;
        }
    }
}