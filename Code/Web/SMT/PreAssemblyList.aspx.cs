using System;

namespace SKT.LeanMES.Web.SMT
{
    public partial class PreAssemblyList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("OrderNO", this.schOrderNO.Text.Trim());
            searchSettings.AddCondition("ModelNO", this.schModelNO.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            
        }
    }
}