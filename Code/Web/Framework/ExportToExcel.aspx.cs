using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Framework
{
    /// <summary>
    /// 导出。Add by Hanson.Lei on 2016.12.13
    /// </summary>
    public partial class ExportToExcel : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Form["ExpToExcelContext"] != null)
            {
                ExpToExcel("Noname.xls", Microsoft.JScript.GlobalObject.unescape(Request.Form["ExpToExcelContext"].ToString()));
            }
        }
    }
}