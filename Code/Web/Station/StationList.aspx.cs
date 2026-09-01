using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.Station.BLL;


namespace SKT.LeanMES.Web.Station
{
    public partial class StationList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
                this.Master.SetSearchSettings = true;
                this.Master.PageGridView = this.GridView1;
                this.Master.PageObjectDataSource = this.ObjectDataSource1;
                this.Master.RecordIDField = "StationId";
                this.Master.DefaultSortExpression = "StationId DESC"; //也可不赋值

                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                searchSettings.AddCondition("Station", this.txtStation.Text);
                searchSettings.AddCondition("certification", this.txtcertification.Text);
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
                        SKT.LeanMES.Station.BLL.Station bll = new SKT.LeanMES.Station.BLL.Station();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex,true);
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //9改为columnIndex_ModifyBy
                //10改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}