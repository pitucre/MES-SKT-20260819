using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Accessories
{
    public partial class AccessoryPartList : BasePage
    {
        private int columnIndex_LeedFree=-1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_LeedFree = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "LeedFree")) + 1;
            
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "ItemName";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ItemName", Server.HtmlEncode(txtItemName.Value.Trim()));

            this.Master.SearchSettings = searchSettings;

            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Accessories.BLL.AccessoryPart bll = new SKT.LeanMES.Accessories.BLL.AccessoryPart();
                    
                    try
                    {
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //e.Row.Cells[10].Text = "aa";
                //e.Row.Cells[4].Text = (e.Row.Cells[4].Text.ToLower() == "true") ? (String)this.GetGlobalResourceObject("Common", "Yes") : (String)this.GetGlobalResourceObject("Common", "No");              

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //2改为columnIndex_LeedFree
                e.Row.Cells[columnIndex_LeedFree].Text = (Convert.ToInt32(e.Row.Cells[columnIndex_LeedFree].Text.Trim()) == 1) ? (String)this.GetGlobalResourceObject("Pages", "PartType1") : (String)this.GetGlobalResourceObject("Pages", "PartType0");

            }
        }

    }
}