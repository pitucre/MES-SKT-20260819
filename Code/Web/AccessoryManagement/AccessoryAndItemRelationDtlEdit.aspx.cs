using SKT.LeanMES.AccessoryManagement.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.AccessoryManagement
{
    public partial class AccessoryAndItemRelationDtlEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessoryItemRelationDtl));
            int compId = Convert.ToInt32(Request.QueryString["ID"]);
            if (compId != -1)
            {
                var model= new AccessoryItemRelationDtl().GetInfo(compId);
                txtItemName.Text = model.AccessoryCode;
                txtQty.Text = model.Value.ToString();
                txtUnitname.Text = model.UnitName;
            }
        }
    }
}