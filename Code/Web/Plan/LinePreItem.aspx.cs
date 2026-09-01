using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Plan
{
    public partial class LinePreItem : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "LineId";
            this.Master.DefaultSortExpression = "LineId";
            this.Master.DefaultSortDirection = SortDirection.Descending;
         
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("LineName", this.txtLineName.Text.Trim());
          // searchSettings.ExtensionCondition = " LineId in(select LineId from Basal_Resource where IsScheduling=1)"; //获取排产资源
            this.Master.SearchSettings = searchSettings;

            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}