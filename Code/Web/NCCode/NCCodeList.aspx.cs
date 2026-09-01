using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.NCCode.BLL;

namespace SKT.LeanMES.Web.NCCode
{
    public partial class NCCodeList : BasePage
    {
        private int columnIndex_Category = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Category = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Category")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxNCCode));

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "NCCodeId";
            this.Master.DefaultSortExpression = "NCCodeId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "(1=1)";
            searchSettings.AddCondition("NCCode", Server.HtmlEncode(this.txtCode.Text.Trim()));
            searchSettings.AddCondition("NCGroupName", Server.HtmlEncode(this.txtNCCodeGroup.Text.Trim()));
            //类型
            if (!string.IsNullOrEmpty(selType.Value))
            {
                searchSettings.ExtensionCondition += "AND Category = '" + selType.Value + "'";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.NCCode.BLL.NCCode bll = new SKT.LeanMES.NCCode.BLL.NCCode();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage("删除数据成功");
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //3改为columnIndex_Category
                //8改为columnIndex_ModifyBy
                //9改为columnIndex_ModifyDateTime
                switch (e.Row.Cells[columnIndex_Category].Text) {
                    case "失败品":
                        e.Row.Cells[columnIndex_Category].Text = "不良现象";
                        break;
                    case "缺陷品":
                        e.Row.Cells[columnIndex_Category].Text = "不良原因";
                        break;
                    case "返修品":
                        e.Row.Cells[columnIndex_Category].Text = "维修方法";
                        break;
                }
                if (e.Row.Cells[columnIndex_ModifyDateTime].Text == "9999-12-31 00:00:00")
                {
                    e.Row.Cells[columnIndex_ModifyBy].Text = "";
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
                }

            }
        }
    }
}