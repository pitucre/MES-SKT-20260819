using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Customer
{
    public partial class CustomerOrderList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {

            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            string custoemrId = this.hdnCustomerId.Value;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "CustomerOrderID";
            this.Master.DefaultSortExpression = "CreateDateTime DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition += " 1=1 ";

            searchSettings.AddCondition("CustomerOrder", this.txtCustomerOrder.Text.Trim());
            if (this.txtItemCode.Value.Trim() != "")
            {
                searchSettings.ExtensionCondition += string.Format(" and ItemCode  like '%{0}%' ", this.txtItemCode.Value.Trim());
            }
            //searchSettings.AddCondition("ItemCode", this.txtItemCode.Value.Trim());
            searchSettings.AddCondition("CustomerName", this.txtCustomer.Text.Trim());

            if (ddlOpenDataStatus.SelectedValue.Trim() != "")
            {
                searchSettings.ExtensionCondition += " and OpenDataStatus=" + ddlOpenDataStatus.SelectedValue.Trim();
            }
            if (ddlIsMesAdd.SelectedValue.Trim() != "")
            {
                if (ddlIsMesAdd.SelectedValue.Trim() == "0")
                {
                    searchSettings.ExtensionCondition += " and IsMesAdd=0 ";
                }
                else
                {
                    searchSettings.ExtensionCondition += " and IsMesAdd<>0 ";
                }
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string uesrName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Customer.BLL.Project bll = new LeanMES.Customer.BLL.Project();
                        bll.DeleteCustomerOrder(Request.Form["hdnIdString"].ToString(), uesrName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(uesrName, ex, true);
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //12改为columnIndex_ModifyBy
                //13改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}