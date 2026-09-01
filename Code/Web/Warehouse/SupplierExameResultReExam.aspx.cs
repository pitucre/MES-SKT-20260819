using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class SupplierExameResultReExam : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSupplierExame));
            int Year = DateTime.Now.Year;
            for (int i = 0; i < 5; i++)
            {
                ddlYear.Items.Add(new ListItem((Year - i).ToString() + "年", (Year - i).ToString()));
            }
        }
    }
}