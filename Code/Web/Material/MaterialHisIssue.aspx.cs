using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialHisIssue : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClient));
            if (!IsPostBack)
            {
                this.hdnLabelContent.Value = SKT.LeanMES.Web.AppCode.Utility.FilesHelper.GetLabelContent("grn");
            }
        }
    }
}