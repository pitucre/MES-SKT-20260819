using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class SystemParameterConfigEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSystemParameterConfig));

            if (!IsPostBack)
            {
                var tableName = Request.QueryString["TableName"];
                if (tableName != null)
                {
                    this.hidTableName.Value = tableName.Trim();
                }
            }
        }
    }
}