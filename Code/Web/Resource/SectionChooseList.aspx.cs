using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Resource
{
    public partial class SectionChooseList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String flag = Request.QueryString["flag"];
            String workseq = Request.QueryString["workseq"];

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "LineId";
            this.Master.DefaultSortExpression = "LineId DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (flag == "1")
            {
                searchSettings.ExtensionCondition = " LineId not in(select LineId from Basal_LineSection where WorkSeq ='" + workseq + "')";
            }
            else if(flag=="2")
            {
                searchSettings.ExtensionCondition = " LineId in(select LineId from Basal_LineSection where WorkSeq ='" + workseq + "')";
            }
            if (IsPostBack)
            {
                searchSettings.AddCondition("LineName", this.txtLineName.Text.Trim());
            }

            if (string.IsNullOrEmpty(workseq))
            {
                searchSettings.AddCondition("2", "1");
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}