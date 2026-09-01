using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquimentPartList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PartId";
            this.Master.DefaultSortExpression = "CreateTime";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition(" PartCode", Server.HtmlEncode(this.txtPartCode.Text));
            searchSettings.AddCondition(" PartName", Server.HtmlEncode(this.txtPartName.Text));
            searchSettings.AddCondition(" EquipmentCode", Server.HtmlEncode(this.txtEquimentCode.Text));
            searchSettings.AddCondition(" EquipmentName", Server.HtmlEncode(this.txtEquimentName.Text));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            
        }
    }
}