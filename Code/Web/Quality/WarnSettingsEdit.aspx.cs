using System;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Web.Quality
{
    public partial class WarnSettingsEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxQuality));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new WarnSettings()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WarnSettingsInfo PageData
        {
            set
            {
                this.hdnItemId.Value = Convert.ToString(value.ItemId);
                this.txtItem.Text = value.ItemName;

                this.hdnLineId.Value = Convert.ToString(value.LineId);
                this.txtLineName.Text = value.LineName;

                this.hdnStationId.Value = Convert.ToString(value.StationId);
                this.txtStation.Text = value.StationName;

                this.ddlWarnType.Text = Convert.ToString(value.WarnType);
                this.ddlWarnLevel.Text = Convert.ToString(value.WarnLevel);
                this.txtYield.Text = Convert.ToString(value.Yield);
                this.hdnReciyeId.Value = value.ReciveUsersId;
                this.txtReciveUsers.Text = value.ReciveUsers;
                this.txtContents.Text = value.Contents;
            }
        }

        protected string GetConditions()
        {
            return Server.UrlEncode("LineId IN(SELECT TOP " + Application["LineQty"].ToString() + " LineId FROM Basal_Line WHERE LineId<>-1 ORDER BY LineId)");
        }
    }
}