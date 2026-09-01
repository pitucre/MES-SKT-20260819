using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Report.Model;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelZPLList : BasePage
    {
        private int columnIndex_ZplType = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ZplType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ZplType")) + 1;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "LabelZPLId";
            this.Master.DefaultSortExpression = "LabelZPLId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ZplName", Server.HtmlEncode(this.txtZPLName.Text));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Labels.BLL.LabelZPL bll = new SKT.LeanMES.Labels.BLL.LabelZPL();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }
        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            //xiang.yan 2024-4-23 cells取值改为根据列名获取
            //1改为columnIndex_ZplType
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[columnIndex_ZplType].Text == "0")
                    e.Row.Cells[columnIndex_ZplType].Text = "ZPL指令";
                else            
                    e.Row.Cells[columnIndex_ZplType].Text = "POSTEK指令";
            }
        }
    }
}