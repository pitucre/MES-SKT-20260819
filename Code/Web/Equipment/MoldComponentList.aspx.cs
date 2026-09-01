using SKT.Common.Account.Model;
using SKT.LeanMES.Equipment.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MoldComponentList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            //后台赋值只读，避免postback时控件值丢失的问题
            txtCreateBy.Attributes.Add("Readonly", "True");

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MoldComponentId";
            this.Master.DefaultSortExpression = "MoldComponentId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (this.txtComponentName.Text.Trim() != "")
            {
                searchSettings.AddCondition("ComponentName", Server.HtmlEncode(this.txtComponentName.Text.Trim()));
            }

   

            string sqlWhere = "";

            if (hdCreateBy.Value.Trim() != "")
            {
                sqlWhere = " CreateBy = '"+ hdCreateBy.Value.Trim() + "'";
            }
            if (txtCreateTimeStart.Text.Length > 0 || txtCreateTimeEnd.Text.Length > 0)
            {
                var startTime = txtCreateTimeStart.Text == "" ? "2000-01-01" : txtCreateTimeStart.Text;
                var endTime = txtCreateTimeEnd.Text == "" ? "9999-12-31" : txtCreateTimeEnd.Text;
                var filterTime = " CreateDateTime between '" + startTime + "' and '" + endTime + "'";
                sqlWhere = (sqlWhere == "") ? filterTime : sqlWhere + " and " + filterTime;
            }
          
            searchSettings.ExtensionCondition = sqlWhere;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        MoldComponent bll = new MoldComponent();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
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
            SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ////获取创建人
                //string userName = e.Row.Cells[4].Text;
                //if (!string.IsNullOrEmpty(userName))
                //{
                //    MembershipInfo userInfo = user.GetInfo(userName);
                //    e.Row.Cells[4].Text = (userInfo == null) ? "" : userInfo.EmployeeCName;
                //}

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_ModifyBy
                //7改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}