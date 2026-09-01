using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.EmailConfig.BLL;
using SKT.LeanMES.EmailConfig.Model;

namespace SKT.LeanMES.Web.EmailConfig
{
    public partial class RecPersonEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEmailConfig));

            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {

                EmailRecPersonInfo model = (new EmailRecPerson()).GetInfo(Id);

                if (model != null)
                {
                    PageData = model;
                }
            }
        }


        public EmailRecPersonInfo PageData
        {
            set
            {
                this.txtMailAddress.Text = value.MailAddress;
                this.txtUserName.Text = value.PersonName;
            }
        }
    }
}