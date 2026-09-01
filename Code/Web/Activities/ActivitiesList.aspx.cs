using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Activities
{
    public partial class ActivitiesList :BasePage
    {
        private int columnIndex_AC_Name = -1;
        protected void Page_Load(object sender, EventArgs e)
        {

            columnIndex_AC_Name = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "AC_Name")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxActivity));

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AC_ID";
            this.Master.DefaultSortExpression = "AC_ID DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("AC_Name", this.txtAC_Name.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Router.BLL.Activity bll = new LeanMES.Router.BLL.Activity();
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        bll.Delete(Convert.ToInt32(Request.Form["hdnIdString"].ToString()), userName);
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
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string s = this.GridView1.DataKeys[e.Row.RowIndex].Values["AC_Attributes"].ToString();
                if (s.ToUpper() == "Y")
                {
                    //xiang.yan 2024-4-23 cells取值改为根据列名获取
                    //1改为columnIndex_AC_Name
                    e.Row.Cells[columnIndex_AC_Name].Text = "<img src='../Content/images/lock.png' alt='' title='" + Resources.lang.SysBuiltActivity + "'/>" + e.Row.Cells[columnIndex_AC_Name].Text;
                    e.Row.ForeColor = System.Drawing.Color.LightGray;
                }
            }
        }
    }
}