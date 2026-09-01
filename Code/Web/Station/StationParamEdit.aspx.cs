using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Station.Model;

namespace SKT.LeanMES.Web.Station
{
    public partial class StationParamEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));

            if (!this.IsPostBack)
            {
                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;

                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    this.PageData = (new SKT.LeanMES.Station.BLL.Station()).GetInfo(Id);
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private StationInfo PageData
        {
            set
            {
                this.lblStationName.Text = Convert.ToString(value.Station);
                this.lblStationType.Text = Convert.ToString(value.OpeType);
            }
        }
    }
}