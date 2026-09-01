using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Station.Model;

namespace SKT.LeanMES.Web.Station
{
    public partial class StationTestCountEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStation));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new StationTestCount()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private StationTestCountInfo PageData
        {
            set
            {
                this.txtStation.Text = value.Station;
                this.hdnStationId.Value = Convert.ToString(value.StationId);
                this.hdnItemId.Value = Convert.ToString(value.ItemId);
                this.txtItemCode.Text = Convert.ToString(value.ItemCode);
                this.txtPassTimes.Text = Convert.ToString(value.MaxPassTimes);
                this.txtFailTimes.Text = Convert.ToString(value.MaxFailTimes);
                this.txtDescription.Text = value.Description;
            }
        }
    }
}