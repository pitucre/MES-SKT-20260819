using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class SetOfBooksList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "ID DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if(txtDepartCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("DepartCode", this.txtDepartCode.Text.Trim().Replace("'", "''"));
            }

            if (txtDepartName.Text.Trim() != "")
            {
                searchSettings.AddCondition("DepartName", this.txtDepartName.Text.Trim().Replace("'", "''"));
            }


            this.Master.SearchSettings = searchSettings;

            if (this.IsPostBack)
            {
                
            }
        }
    }
}