using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.Factory.BLL;


namespace SKT.LeanMES.Web.Factory
{
    public partial class CompanyList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxFactory));

            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "FactoryId";
            this.Master.DefaultSortExpression = "FactoryId DESC"; //也可不赋值txtFactoryCode

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("FactoryName", Server.HtmlEncode(this.txtFactoryName.Text));
            searchSettings.AddCondition("FactoryCode", Server.HtmlEncode(this.txtFactoryCode.Text));

            searchSettings.ExtensionCondition = "TypeId = 2";
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                try
                {
                    if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        SKT.LeanMES.Factory.BLL.Factory bll = new SKT.LeanMES.Factory.BLL.Factory();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                }
                catch (Exception ex)
                {
                    //2016-02-27弹出提示信息
                    WebHelper.HandleException(String.Empty, ex, true);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //5改为columnIndex_ModifyBy
                //6改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}