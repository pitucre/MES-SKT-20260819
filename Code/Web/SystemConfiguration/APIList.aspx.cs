using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class APIList : BasePage
	{
        private int columnIndex_SapParam = -1;
        private int columnIndex_SapParamDesc = -1;
        private int columnIndex_SapFields = -1;
        private int columnIndex_TargetTabFields = -1;
        protected void Page_Load(object sender, EventArgs e)
		{
            columnIndex_SapParam = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "SapParam")) + 1;
            columnIndex_SapParamDesc = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "SapParamDesc")) + 1;
            columnIndex_SapFields = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "SapFields")) + 1;
            columnIndex_TargetTabFields = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "TargetTabFields")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSysConfiguration));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "ID DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("BusinessName", this.txtBusinessName.Text.Trim().Replace("'", "''"));

            this.Master.SearchSettings = searchSettings;

            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        string idStr = Request.Form["hdnIdString"].ToString();
                        SKT.LeanMES.CommonDataSource.BLL.SAPAPI bll = new SKT.LeanMES.CommonDataSource.BLL.SAPAPI();
                        bll.Delete(idStr, SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
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
                //3,4,5,7
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //3改为columnIndex_SapParam
                //4改为columnIndex_SapParamDesc
                //6改为columnIndex_ModifyBy
                //8改为columnIndex_ModifyDateTime
                e.Row.Cells[columnIndex_SapParam].Text = e.Row.Cells[columnIndex_SapParam].Text.Replace(",", ",</br>").Replace("，", ",</br>");
                e.Row.Cells[columnIndex_SapParamDesc].Text = e.Row.Cells[columnIndex_SapParamDesc].Text.Replace(",", ",</br>").Replace("，", ",</br>"); ;
                e.Row.Cells[columnIndex_SapFields].Text = e.Row.Cells[columnIndex_SapFields].Text.Replace(",", ",</br>").Replace("，", ",</br>"); ;
                e.Row.Cells[columnIndex_TargetTabFields].Text = e.Row.Cells[columnIndex_TargetTabFields].Text.Replace(",", ",</br>").Replace("，", ",</br>"); ;
            }
        }
	}
}