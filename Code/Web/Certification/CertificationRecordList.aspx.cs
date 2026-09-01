using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Certification
{
    public partial class CertificationRecordList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "CertificationMemberId";
            this.Master.DefaultSortExpression = "Certification_Date";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("UserName", this.txtUserName.Text);
            searchSettings.AddCondition("Certification", this.txtCertName.Text);
            searchSettings.AddCondition("CertType", this.ddlCertType.SelectedItem.Text);
            this.Master.SearchSettings = searchSettings;

            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //判断当前行是不是数据绑定行
            if (e.Row.RowType == DataControlRowType.DataRow) { 
             
                //e.Row.Cells[6].Text = Convert.ToString(e.Row.Cells[6].Text) == "true" ? "是" : "否";
            }
        }
    }
}