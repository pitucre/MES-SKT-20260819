using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Navigation.BLL;

namespace SKT.LeanMES.Web.Navigation
{
    public partial class NavigationItem : BasePage
    {
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxNavigation));

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "Sequence ASC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (!string.IsNullOrEmpty(this.txtNavigationName.Text))
            {
                searchSettings.AddCondition("NavigationName", this.txtNavigationName.Text);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Navigation.BLL.Navigationitem bll = new SKT.LeanMES.Navigation.BLL.Navigationitem();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {

                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //8改为columnIndex_ModifyDateTime
                if (e.Row.Cells[columnIndex_ModifyDateTime].Text== "9999-12-31 00:00:00")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";                
            }
        }
    }
}