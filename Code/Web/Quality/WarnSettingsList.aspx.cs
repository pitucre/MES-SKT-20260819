using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.Quality.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class WarnSettingsList : BasePage
    {
        private int columnIndex_WarnType = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_WarnType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "WarnType")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxQuality));

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WarnSettingsId";
            this.Master.DefaultSortExpression = "WarnSettingsId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ItemName", this.txtProduct.Text);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if(IsPostBack) {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Quality.BLL.WarnSettings bll = new SKT.LeanMES.Quality.BLL.WarnSettings();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //4改为columnIndex_WarnType
                e.Row.Cells[columnIndex_WarnType].Text = (Convert.ToString(e.Row.Cells[columnIndex_WarnType].Text.Trim()) == "1") ? "班次" : "天"; 
            }
        }
    }
}