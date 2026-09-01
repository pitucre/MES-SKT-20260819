using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{

    public partial class InspectionOrderConfirmation : BasePage
    {
        public bool Ischecked = true;
        public int Id = -1;
        public int InspectionTypeId = 0;
        public string AuditStatus = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
            if (Request["Id"] != null)
            {
                Id = Convert.ToInt32(Request["Id"]);

                InspectionOrder bll = new InspectionOrder();
                InspectionOrderInfo info = bll.GetInfo(Id);
                if(info!=null)
                {
                    this.lbInspectionOrderNo.Text = info.InspectionOrderNo;
                    this.DealResultRemark.Text = info.DealResultRemark;
                    this.txtRem.Text = info.AuditRemark;
                    this.lblSamplePicture.Text = info.UploadFile;
                    this.hdFileName.Value = info.FileName;
                    InspectionTypeId = info.InspectionTypeId;
                    AuditStatus = info.AuditResult.ToString();
                    if (info.AuditResult == "3")
                    {
                        Ischecked = false;
                    }
                }
                
            }
        }
    }
}