using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ESOP.Model;
using SKT.LeanMES.ESOP.BLL;

namespace SKT.LeanMES.Web.ESOP
{
    public partial class ESOPMacEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEsop));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new ESOPMac()).GetInfo(Convert.ToInt32(idString));
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
        private ESOPMacInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] != null && Request.QueryString["Action"].ToLower() == "copy")
                {
                    this.txtMAC.Text = value.MAC;
                    this.txtStation.Text = value.Station;
                    this.hdnStationId.Value = Convert.ToString(value.StationId);
                    this.txtResource.Text = value.ResName;
                    this.hdnResourceId.Value = Convert.ToString(value.ResourceId);
                    this.chkIsSwitch.Checked = value.IsSwitch;
                    this.txtMacName.Text = value.MacName;
                    this.chkIsDefault.Checked = value.IsDefault;
                     
                }
                else
                {
                    this.txtMAC.Text = value.MAC;
                    this.txtStation.Text = value.Station;
                    this.hdnStationId.Value = Convert.ToString(value.StationId);
                    this.txtResource.Text = value.ResName;
                    this.hdnResourceId.Value = Convert.ToString(value.ResourceId);
                    this.chkIsSwitch.Checked = value.IsSwitch;
                    this.txtMacName.Text = value.MacName;
                    this.txtRemark.Text = value.Remark;
                    this.chkIsDefault.Checked = value.IsDefault;
                    if (value.IsDefault == true)
                    {
                        this.chkIsDefault.Enabled = false;
                    }   
                }
            }
        }
    }
}