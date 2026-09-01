using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Activities
{
    public partial class TemplatesEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxActivity));
            if (!IsPostBack)
            {
                int tmplId = Convert.ToInt32(Request.QueryString["ID"]);
                if (tmplId != -1)
                {
                    this.txtTmplName.Enabled = false;
                    this.txtTmplName.ReadOnly = true;
                    SKT.LeanMES.Station.Model.TemplateInfo model = (new SKT.LeanMES.Station.BLL.Template()).GetInfo(tmplId);
                    this.txtTmplName.Text = model.Tmpl_TemplateName;
                    this.hdnValue.Value = (String.IsNullOrEmpty(model.Tmpl_TemplateValue)) ? "" : SKT.Common.Utility.EncryptHelper.Decrypt(model.Tmpl_TemplateValue);  //解密       
                    this.txtTmplDesc.Text = model.Tmpl_TemplateDesc;
                }
            }
        }
    }
}