using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ClientConfig.Model;
using SKT.LeanMES.ClientConfig.BLL;

namespace SKT.LeanMES.Web.ClientConfig
{
    public partial class UsersInStationEdit : BasePage
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
                else
                {
                    this.chkIsDefault.Checked = true;
                    this.chkIsDefault.Disabled = true;
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
                this.txtUserName.Text = value.UserName;
                this.txtStation.Text = value.Station;
                this.txtLineName.Text = value.LineName;
                this.txtResource.Text = value.ResName;

                this.hdnUserId.Value = Convert.ToString(value.UserId);
                this.hdnStationId.Value = Convert.ToString(value.StationId);
                this.hdnLineId.Value = Convert.ToString(value.LineId);
                this.hdnResId.Value = Convert.ToString(value.ResId);
                this.chkIsDefault.Checked = Convert.ToString(value.IsDefault) == "1" ? true : false;
                if (Convert.ToString(value.IsDefault) == "1")
                {
                    this.chkIsDefault.Disabled = true;
                }                
            }
        }
    }
}