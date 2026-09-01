using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemList : BasePage
    {
        private int columnIndex_ItemName = -1;
        private int columnIndex_ItemType = -1;
        private int columnIndex_Status = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ItemName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ItemName")) + 1;
            columnIndex_ItemType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ItemType")) + 1;
            columnIndex_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Status")) + 1;

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemId";
            this.Master.DefaultSortExpression = "ItemId DESC";  

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
             
            string itemname = this.txtItemName.Text.Trim();
            //
            if (itemname != "")
            {
                /*searchSettings.AddCondition("ItemCode", itemname);
                searchSettings.AddCondition("ItemName", itemname);
                 * */
                if (Request.Form["ctl00$ctl00$ContentPlaceHolder1$chkMatchWholeWord"] != null)
                {
                    searchSettings.ExtensionCondition += " (ItemCode = '" + itemname + "' or ItemName = '" + itemname + "') ";
                }
                else
                {
                    searchSettings.ExtensionCondition += " (ItemCode like '%" + itemname + "%' or ItemName like '%" + itemname + "%') ";
                }
            }
            if (ddlIsMESadd.SelectedValue != "-1")
            {
                searchSettings.AddCondition("IsMESadd", ddlIsMESadd.SelectedValue);
            }
            //2016-12-13
            if (ddlItemType.SelectedValue != "-1")
            {
                searchSettings.AddCondition("ItemType", ddlItemType.SelectedValue);
            }

            string txtCPN = this.txtCPN.Text.Trim();
            if (txtCPN != "")
            {
                searchSettings.AddCondition("CPN", txtCPN);
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Product.BLL.Item bll = new SKT.LeanMES.Product.BLL.Item();
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch( Exception ex)
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
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //2改为columnIndex_ItemName
                //5改为columnIndex_ItemType
                //9改为columnIndex_Status

                e.Row.Cells[columnIndex_ItemType].Text = (String)GetGlobalResourceObject("Enum", ((SKT.LeanMES.Product.Model.EnumItemType)Enum.Parse(typeof(SKT.LeanMES.Product.Model.EnumItemType), e.Row.Cells[columnIndex_ItemType].Text)).ToString());
                string itemName = e.Row.Cells[columnIndex_ItemName].Text;
                if (itemName.Length > 150)
                {
                    e.Row.Cells[columnIndex_ItemName].Text = itemName.Substring(0, 150) + "...";
                    e.Row.Cells[columnIndex_ItemName].ToolTip = itemName;
                }
                e.Row.Cells[columnIndex_Status].Text = (String)GetGlobalResourceObject("Enum", ((SKT.LeanMES.Product.Model.EnumItemStatus)Enum.Parse(typeof(SKT.LeanMES.Product.Model.EnumItemStatus),e.Row.Cells[columnIndex_Status].Text)).ToString());
            }
        }

    }
}