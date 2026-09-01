using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;
using System.Security.Cryptography;
using System.Configuration;

namespace SKT.LeanMES.Web.User
{
    public partial class CurrentUserChangePwd : BasePage
    {
        public string MandatoryPassword;
        public string WindowsPWDStrength;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            //配置password控件安全性
            this.txtOldPwd.Attributes.Add("autocomplete", "off");
            this.txtNewPwd.Attributes.Add("autocomplete", "off");
            this.txtCfmNewPwd.Attributes.Add("autocomplete", "off");


            GlobarParameter.Model.GlobarParameterInfo entity = new GlobarParameter.BLL.GlobarParameter().GetInfo("MandatoryPassword");
            if (entity != null && entity.ParaValue == "是")
                MandatoryPassword = "1";
            entity = new GlobarParameter.BLL.GlobarParameter().GetInfo("Windows密码强度");
            WindowsPWDStrength = entity.ParaValue;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));
           
        }
    }
}