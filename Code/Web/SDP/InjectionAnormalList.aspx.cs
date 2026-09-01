using System;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data;
using System.Reflection;
using SKT.Common.Model;
using System.Web.UI;
using System.Linq;

namespace SKT.LeanMES.Web.SDP
{
    public partial class InjectionAnormalList : BasePage
    {
        private int columnIndex_Status = -1;
        private int columnIndex_IsLineStop = -1;

        SKT.Common.Model.SearchSettings searchSettings;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Status")) + 1;
            columnIndex_IsLineStop = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IsLineStop")) + 1;

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AnormalId";
            this.Master.DefaultSortExpression = "AnormalId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            searchSettings = new SKT.Common.Model.SearchSettings();


            var strWhere = " 1=1 ";
            var LineName = Request.QueryString["LineName"];
            if (!string.IsNullOrEmpty(LineName))
            {
                strWhere += " and [LineName] like '" + LineName + "%'";
            }


            if (!string.IsNullOrEmpty(strWhere))
                searchSettings.ExtensionCondition = strWhere;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;


        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //是否停线
                e.Row.Cells[columnIndex_IsLineStop].Text = Convert.ToBoolean(e.Row.Cells[columnIndex_IsLineStop].Text) ? "已停线" : "未停线";
                //状态
                var status = e.Row.Cells[columnIndex_Status].Text;
                switch (status)
                {
                    case "1":
                        e.Row.Cells[columnIndex_Status].Text = "已建立";
                        break;
                    case "2":
                        e.Row.Cells[columnIndex_Status].Text = "已关闭";
                        break;
                    default:
                        e.Row.Cells[columnIndex_Status].Text = "";
                        break;
                }
            }
        }


        protected void btnExport_Click(object sender, EventArgs e)
        {

        }
    }

    [Serializable]
    public class AnormalObject
    {
        //{"order":"SR16080598","orderid":210,"itemcode":"61.02.415000-001","itemid":-1,"anormalid":-1}
        public string order { get; set; }
        public string orderid { get; set; }
        public string itemcode { get; set; }
        public string itemid { get; set; }
        public string anormalid { get; set; }
        public string anormalname { get; set; }
    }
}