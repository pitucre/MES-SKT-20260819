using System;
using SKT.LeanMES.Detection.BLL;
using System.Web.UI.WebControls;
using System.Linq;

namespace SKT.LeanMES.Web.Detection
{
    public partial class DetectionItemList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyTime = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyTime")) + 1;

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "DetectionItemId";
            this.Master.DefaultSortExpression = "DetectionItemId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (this.txtDetectionCode.Text != "")
            {
                searchSettings.AddCondition("DetectionCode", this.txtDetectionCode.Text.Trim());
            }
            if (this.txtDetectionName.Text != "")
            {
                searchSettings.AddCondition("DetectionName", this.txtDetectionName.Text.Trim());
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;


            //删除
            if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
            {
                try
                {
                    DetectionItem bll = new DetectionItem();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //14改为columnIndex_ModifyBy
                //15改为columnIndex_ModifyTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyTime].Text = "";
            }
        }
    }
}