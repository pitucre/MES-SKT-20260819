using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Framework
{
    public partial class VersionUpGrade : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "VersionID";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (txtVersion.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += (String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? "" : " and ") + string.Format(" Version like '%{0}%'", txtVersion.Text.Trim());
            }
            string createDateTimeStart = this.txtDateTimeStart.Text.Trim();
            string createDateTimeEnd = this.txtDateTimeEnd.Text.Trim();
            if (createDateTimeStart != "")
            {
                searchSettings.ExtensionCondition  += (String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? "" : " and ") + " CreateDateTime >= '" + createDateTimeStart + "'" ;
            }
            if (createDateTimeEnd != "")
            {
                searchSettings.ExtensionCondition += (String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? "" : " and ") + " CreateDateTime <= '" + createDateTimeEnd + "'";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

        }
    }
}