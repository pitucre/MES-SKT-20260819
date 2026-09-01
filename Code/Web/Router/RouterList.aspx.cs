using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Router.Model;
using SKT.LeanMES.Router.BLL;
using SKT.LeanMES.Web.AjaxServices;
using System.IO;

namespace SKT.LeanMES.Web.Router
{
    public partial class RouterList : BasePage
    {
        private int columnIndex_R_Status = -1;
        private int columnIndex_ItemName = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_R_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "R_Status")) + 1;
            columnIndex_ItemName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ItemName")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxRouter));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "R_ID";
            this.Master.DefaultSortExpression = "R_ID DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("R_Name", this.txtRouter.Text.Trim());
            string itemname = this.txtItemName.Text.Trim();
            string strWhere = "";
            string ItemCode = this.txtItemCode.Text.Trim();
            if (itemname != "")
            {
                searchSettings.AddCondition("itemname", itemname);
            }
            if (ItemCode != "")
            {
                searchSettings.AddCondition("ItemCode", ItemCode);
            }
            searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and " + strWhere;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string username = AccountController.GetCurrentUser().UserName;
                    SKT.LeanMES.Router.BLL.Router bll = new LeanMES.Router.BLL.Router();
                    try
                    {
                        bll.Delete(Request.Form["hdnIdString"], username);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(username, ex, true);
                    }
                }
            }
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //2改为columnIndex_R_Status
                //4改为columnIndex_ItemName
                e.Row.Cells[columnIndex_R_Status].Text = ((SKT.LeanMES.Router.Model.EnumRouterStatus)Enum.Parse(typeof(SKT.LeanMES.Router.Model.EnumRouterStatus), e.Row.Cells[columnIndex_R_Status].Text)).ToString();
                string itemName = e.Row.Cells[columnIndex_ItemName].Text;
                e.Row.Cells[columnIndex_ItemName].Text = (itemName.Length > 20) ? (itemName.Substring(0, 20) + "...") : itemName;
                e.Row.Cells[columnIndex_ItemName].ToolTip = e.Row.Cells[columnIndex_ItemName].Text;
            }
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count < 2)
            {
                return;
            }

            int iMatch = 1;
            int mRow = 0;
            string sMark = GridView1.Rows[mRow].Cells[iMatch].Text;

            for (int iRow = 1; iRow < GridView1.Rows.Count; iRow++)
            {
                if (GridView1.Rows[iRow].Cells[iMatch].Text == sMark)
                {
                    for (int i = 1; i <= 3; i++)
                    {
                        GridView1.Rows[iRow].Cells[i].Visible = false;
                        GridView1.Rows[mRow].Cells[i].RowSpan = iRow - mRow + 1;
                    }
                }
                else
                {
                    mRow = iRow;
                    sMark = GridView1.Rows[mRow].Cells[iMatch].Text;
                }
            }
        }

        protected void Download_Click(object sender, EventArgs e)
        {
            string fileName = "";
            try
            {
                SKT.LeanMES.Router.BLL.Router bll2 = new LeanMES.Router.BLL.Router();
                string url = bll2.GetInfo(Convert.ToInt32(Request.Form["hdnIdString"])).Url;
                if (url == "")
                {
                    this.Response.Write("<script>alert('没有上传文件')</script>");
                    return;
                }
                if (url.IndexOf("\\") > -1)
                {
                    fileName = url.Substring(url.LastIndexOf("\\") + 1);
                }
                else
                {
                    fileName = url;
                }
                FileStream fileStream = new FileStream(@url, FileMode.Open);
                byte[] bytes = new byte[(int)fileStream.Length];
                fileStream.Read(bytes, 0, bytes.Length);
                fileStream.Close();
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition", "attachment;filename=" + fileName);
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.End();

            }
            catch (Exception ex)
            {

                this.Response.Write("<script>alert('" + ex + "')</script>");
                return;
            }

        }

    }
}