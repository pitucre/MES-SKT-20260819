using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ESOP.BLL;
using SKT.LeanMES.ESOP.Model;

namespace SKT.LeanMES.Web.ESOP
{
    public partial class ESOPStroeConfig : BasePage
    {
        public int isCP = 0;
        public int id = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            //配置password控件安全性
            this.txtPassWord.Attributes.Add("autocomplete", "off");

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxFtpConfig));

            FtpServerConfigInfo model = (new FtpServerConfig()).GetInfo();

            if (model != null)
            {
                PageData = model;
                isCP = 1;
            }
        }

        public FtpServerConfigInfo PageData
        {
            set
            {
                this.txtFtpServerName.Text = value.FtpServerName;
                this.txtPassWord.Attributes["value"] = value.PWD;
                this.txtUserName.Text = value.UserName;
                this.txtStoreLocation.Text=value.FtpStoreLocation;
            }
        }
    }
}