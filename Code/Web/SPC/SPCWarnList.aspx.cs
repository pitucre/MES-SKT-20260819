using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SPC
{
    public partial class SPCWarnList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSPC));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SPCWarnId";
            this.Master.DefaultSortExpression = "SPCWarnId DESC"; //也可不赋值             
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("TaskName", txtTaskName.Text.Trim().Replace("'", "''"));

            string extensionCondition = string.Empty;

            if (txtWarnBegin.Text.Length > 0)
            {
                extensionCondition = "CONVERT(varchar(10),WarnTime,120) >= '" + txtWarnBegin.Text + "'";
            }
            if (txtWarnEnd.Text.Length > 0)
            {
                extensionCondition += " and CONVERT(varchar(10),WarnTime,120) <= '" + txtWarnEnd.Text + "'";
            }
            searchSettings.ExtensionCondition = extensionCondition;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}