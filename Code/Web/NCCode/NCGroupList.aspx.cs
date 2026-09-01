using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.NCCode.BLL;

namespace SKT.LeanMES.Web.NCCode
{
    public partial class NCGroupList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
         {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxNCCode));

              this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
              this.Master.SetSearchSettings = true;
              this.Master.PageGridView = this.GridView1;
              this.Master.PageObjectDataSource = this.ObjectDataSource1;
              this.Master.RecordIDField = "NCGroupId";
              this.Master.DefaultSortExpression = "NCGroupId DESC"; //也可不赋值

              SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
              searchSettings.AddCondition("NCGroupName", Server.HtmlEncode(this.txtGroup.Text.Trim().Replace("'","''")));
              this.Master.SearchSettings = searchSettings;
              this.GridView1.PageIndex = 0;
          
              if (this.IsPostBack)
              {
                 if (Request.Form["hdnOperate"].ToLower() == "delete")
                 {
                    try
                    {
                        SKT.LeanMES.NCCode.BLL.NCGroup bll = new SKT.LeanMES.NCCode.BLL.NCGroup();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage("删除数据成功！");
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                 }
             }
         }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //4改为columnIndex_ModifyBy
                //5改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}