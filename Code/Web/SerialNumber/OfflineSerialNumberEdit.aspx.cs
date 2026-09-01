using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.SerialNumber.BLL;

namespace SKT.LeanMES.Web.SerialNumber
{
    public partial class OfflineSerialNumberEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxOfflineSNConfig));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new OfflineSNConfig()).GetInfo(Convert.ToInt32(idString));
                    if (entity != null && entity.OfflineSNConfigId > 0)
                    {
                        this.PageData = entity;
                    }
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private OfflineSNConfigInfo PageData
        {
            set
            {
                this.hdnMainItemId.Value = Convert.ToString(value.MainItemId);
                this.txtMainItemCode.Text = value.MainItemCode;
                this.hdnPartItemId.Value = Convert.ToString(value.PartItemId);
                this.txtPartItemCode.Text = value.PartItemCode;
                this.hdnStationId.Value = Convert.ToString(value.StationId);
                this.txtStation.Text = value.Station;
                this.txtAssemblyQty.Text = Convert.ToString(value.AssemblyQty);
                this.hdnMaskId.Value = Convert.ToString(value.MaskId);
                this.txtMask.Text = value.MaskGroup;
                this.txtRemark.Text = value.Remark;
                this.ddlPartType.SelectedValue = value.PartType;
            }
        }
    }
}