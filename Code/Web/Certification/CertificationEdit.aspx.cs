using System;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Certification
{
    public partial class CertificationEdit : BasePage
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
                        this.txtCert.Enabled = false;
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
                this.txtCert.Text = value.Certification;
                this.txtDesc.Text = value.Description;
                this.txtRenewal.Text = value.RenewalDays.ToString();
                this.txtEvent.Text = value.Expiration_Alarm_Event;
                this.txtWarning.Text = value.WarningDays.ToString();
                for (int i = 0; i < ddlType.Items.Count; i++)
                {
                    if (ddlType.Items[i].Value == value.Type)
                    {
                        ddlType.SelectedIndex = i;
                        break;
                    }
                }
            }
        }
    }
}