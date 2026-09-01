using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Station
{

    public partial class StationTypeList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStation));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "StationTypeId";
            this.Master.DefaultSortExpression = "StationTypeId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("StationType", this.txtStationType.Text);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Station.BLL.StationType bll = new SKT.LeanMES.Station.BLL.StationType();
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
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //if (string.IsNullOrWhiteSpace(e.Row.Cells[4].Text) || e.Row.Cells[4].Text == "&nbsp;")
                //    e.Row.Cells[5].Text = "";

                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //4改为columnIndex_ModifyBy
                //5改为columnIndex_ModifyDateTime
                if (e.Row.Cells[columnIndex_ModifyDateTime].Text == "1927-04-06 00:00:00") {
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
                    e.Row.Cells[columnIndex_ModifyBy].Text = "";
                }
                   
            }
        }
    }
}