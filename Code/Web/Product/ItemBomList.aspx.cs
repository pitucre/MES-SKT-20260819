using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemBomList : BasePage
    {
        private int columnIndex = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Source")) + 1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemBomId";
            this.Master.DefaultSortExpression = "ItemBomId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition(" BomName ", this.txtItemBomName.Text.Trim().Replace("'","''"));
            searchSettings.AddCondition("ItemCode", this.txtItemCode.Text.Trim().Replace("'", "''"));
            searchSettings.AddCondition("Version", this.txtVersion.Text.Trim().Replace("'", "''"));
          
            if (ddlIsCurrentVer.SelectedValue != "-1")
            {
                searchSettings.AddCondition("IsCurrentVer", ddlIsCurrentVer.SelectedValue);
            }
            if (ddlStatus.SelectedValue != "-1")
            {
                searchSettings.AddCondition("state", ddlStatus.SelectedValue);
            }
            if (ddlIsMESadd.SelectedValue != "-1")
            {
                //  searchSettings.AddCondition("Source", ddlIsMESadd.SelectedValue);
                searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? "Source=" + ddlIsMESadd.SelectedValue : " and " + "Source=" + ddlIsMESadd.SelectedValue;
              
            }
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
                        SKT.LeanMES.Product.BLL.ItemBom bll = new SKT.LeanMES.Product.BLL.ItemBom();
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
                string source = "";
                switch (e.Row.Cells[columnIndex].Text)
                {
                    case "1":
                        source = "ERP下载";
                        break;
                    case "2":
                        source = "MES导入";
                        break;
                    case "3":
                        source = "MES创建";
                        break;
                    default:
                        source = "";
                        break;
                

                }
                e.Row.Cells[columnIndex].Text = source; 
            }
        }

    }
}