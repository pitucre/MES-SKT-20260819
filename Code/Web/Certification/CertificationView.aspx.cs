using System;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Certification
{
    public partial class CertificationView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCertification));
            Int32 certID = Convert.ToInt32(Request.QueryString["ID"]);
            if (!this.IsPostBack)
            {
                if (certID != -1)
                {
                    SKT.LeanMES.Certification.BLL.Certification bllCert = new SKT.LeanMES.Certification.BLL.Certification();
                    SKT.LeanMES.Certification.Model.CertificationInfo model = null;
                    model = bllCert.GetInfo(certID);
                    if (model != null)
                    {
                        this.CertData = model;
                    }
                }
            }
        }
        /// <summary>
        /// 编辑状态下获得对应CertID的数据
        /// </summary>
        protected SKT.LeanMES.Certification.Model.CertificationInfo CertData
        {
            set
            {
                this.lblCert.Text = value.Certification;
                this.lblDesc.Text = value.Description;
                this.lblRenewal.Text = value.RenewalDays.ToString();
                this.lblEvent.Text = value.Expiration_Alarm_Event;
                this.lblWarning.Text = value.WarningDays.ToString();
                this.lblType.Text = value.Type;
            }
        }
    }
}