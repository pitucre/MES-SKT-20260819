using SKT.LeanMES.Detection.BLL;
using SKT.LeanMES.Detection.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Detection
{
    public partial class DetectionItemEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxDetectionItem));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new DetectionItem()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private DetectionItemInfo PageData
        {
            set
            {
                this.txtDetectionCode.Text = value.DetectionCode;
                this.txtDetectionName.Text = value.DetectionName;
                this.txtDetectionDesc.Text = value.DetectionDesc;
                this.txtVersions.Text = value.Versions;
                this.hdnStationId.Value = Convert.ToString(value.StationId);
                this.txtStation.Text = value.Station.ToString();
                this.txtSL.Text = Convert.ToString(value.SL);
                this.txtUSL.Text = Convert.ToString(value.USL);
                this.txtLSL.Text = Convert.ToString(value.LSL);
                this.txtCL.Text = Convert.ToString(value.CL);
                this.txtUCL.Text = Convert.ToString(value.UCL);
                this.txtLCL.Text = Convert.ToString(value.LCL);                 
            }
        }
    }
}