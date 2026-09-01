using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialStorageGRNInput : BasePage
    {
        public string IQCBatchId = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouse));
        }
    }
}