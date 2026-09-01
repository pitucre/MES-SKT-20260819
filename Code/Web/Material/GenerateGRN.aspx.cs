using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class GenerateGRN : BasePage
    {
        public readonly int maxLabelCount = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["MaxLabelCount"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AccountController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSerialNumber));
            //if (!IsPostBack)
            //{
            //    txtProdDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            //}
        }
    }
}