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
    public partial class SendEmailConfig : BasePage
    {
        public int isCP = 0;
        public int id = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEmailConfig));

            EmailServerConfigInfo model = (new EmailServerConfig()).GetInfo(-1);

            if(model != null)
            {
                PageData = model;
                isCP = 1;
            }
        }

        public EmailServerConfigInfo PageData
        {
            set
            {
                this.id = value.Id;
                this.txtMailServerName.Text = value.MailServerName;
                this.txtMailServertype.Text = value.MailServertype;
                this.txtMailAddress.Text = value.MailAddress;
                this.txtPassWord.Attributes.Add("value", value.PWD);
                this.txtPort.Text = value.Port.ToString();
                this.txtUserName.Text = value.UserName;
            }
        }
    }
}