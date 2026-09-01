using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class PartInOutStockRecordList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Rid";
            this.Master.DefaultSortExpression = "Rid";
            this.Master.DefaultSortDirection = SortDirection.Descending;



            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string whereStr = " PartCode like '%" + txtPartCode.Text.Trim() + "%' ";
          
            if (txtStartTime.Text != "")
            {
                whereStr += " and CreateTime >= '" + txtStartTime.Text + " 00:00:00'";
            }
            if (txtEndTime.Text != "")
            {
                whereStr += " and CreateTime <= '" + txtEndTime.Text + " 23:59:59'";
            }

            if (ddOutType.SelectedValue != "")
            {
                whereStr += " and OperationType= '" + ddOutType.SelectedValue + "'";
            }
            searchSettings.ExtensionCondition = whereStr;
            searchSettings.AddCondition("PartName", Server.HtmlEncode(this.txtPartName.Text));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            
        }
    }
}