using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Plan.Model;
using AjaxPro;
using SKT.LeanMES.Order.Model;
using SKT.LeanMES.Plan.BLL;
using SKT.LeanMES.Resource.Model;

namespace SKT.LeanMES.Web.Plan
{
    public partial class PlanInsertOrder : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxShopOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxPlan));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(PlanInsertOrder));
            if (!this.IsPostBack)
            {

            }
        }
        

       


    }
}