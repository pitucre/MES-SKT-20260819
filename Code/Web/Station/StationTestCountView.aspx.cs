using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Station.Model;
using SKT.LeanMES.Station.BLL;

namespace SKT.LeanMES.Web.Station
{
    public partial class StationTestCountView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                this.lblStation.Text = value.Station;
                this.lblItemCode.Text = value.ItemCode.ToString();
                this.lblPassTimes.Text = value.MaxPassTimes.ToString();
                this.lblFailTimes.Text = value.MaxFailTimes.ToString();
                this.lblDescription.Text = value.Description.ToString(); 
            }
        }
    }
}