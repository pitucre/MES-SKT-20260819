using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ClientConfig.BLL;
using SKT.LeanMES.ClientConfig.Model;

namespace SKT.LeanMES.Web.ClientConfig
{
    public partial class UsersInStationView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClientConfig));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new UsersInStation()).GetInfo(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private UsersInStationInfo PageData
        {
            set
            {
                this.lblUserName.InnerText = value.UserName;
                this.lblStation.InnerText = value.Station;
                this.lblLineName.InnerText = value.LineName;
                this.lblResource.InnerText = value.ResName;
                this.lblIsDefault.InnerText = Convert.ToString(value.IsDefault) == "1" ? "是" : "否";
            }
        }
    }
}