using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SuplyMaterial
{
    public partial class PackGRNSuplyList : BasePage
    {
        private int columnIndex_PkdLoc = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_PkdLoc = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "PkdLoc")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxErrorLog));

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PIDID";
            this.Master.DefaultSortExpression = "cartoncreatetime desc";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string sn = this.txtSN.Value.Trim().Replace("'","''");
            string txtGRNSN = this.txtGRNSN.Value.Trim().Replace("'","''");
            int cartonstatus = Convert.ToInt32(selCartonStatus.SelectedValue);
            string txtPurOrderNo = this.txtPurOrderNo.Value.Trim().Replace("'", "''");
            string strWhere = "";
            //if (!IsPostBack)
            //{
            //    searchSettings.ExtensionCondition = " and carton.MaterialUnitId = -1 ";
            //}
            //else
            //{
             
            //}
            if (sn != "")
            {
                strWhere = " and carton.SerialNumber like  '%" + sn + "%' ";
            }

            if (txtGRNSN != "")
            {
                strWhere += " and grn.SerialNumber like  '%" + txtGRNSN + "%' ";
            }
            if (txtVendorCode.Text != "")
            {
                strWhere += " and grn.VendorCode like  '%" + txtVendorCode.Text + "%' ";
            }

            if (Convert.ToInt32(cartonstatus) != -1)
            {
                if (Convert.ToInt32(cartonstatus) == 2)
                {
                    strWhere += " and grn.MaterialUnitId = -1";
                }
                else
                {
                    strWhere += " and carton.Flag = " + Convert.ToInt32(cartonstatus);
                }
            }
            if (txtPurOrderNo != "")
            {
                strWhere += " and e.POrder like  '%" + txtPurOrderNo + "%' ";
            }

            searchSettings.ExtensionCondition += strWhere;
            string userType = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType.ToString();
            string strSql = "";
            if (userType != "-1")
            {
                int userId = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId;
                SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
                int supperId = user.GetInfo(userId).UserType;
                //新增供应商过滤
                strSql = " and  c.SupplierId = " + supperId;
                searchSettings.ExtensionCondition += strSql;
            }
            this.Master.SearchSettings = searchSettings;

            this.GridView1.PageIndex = 0;
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //5改为columnIndex_PkdLoc
                string flag = e.Row.Cells[columnIndex_PkdLoc].Text;
                if (flag == "1")
                {
                    e.Row.Cells[columnIndex_PkdLoc].Text = Resources.Common.Open;
                    e.Row.Cells[columnIndex_PkdLoc].ForeColor = System.Drawing.Color.Green;
                    e.Row.Cells[columnIndex_PkdLoc].Font.Bold = true;
                }
                else
                {
                    e.Row.Cells[columnIndex_PkdLoc].Text = Resources.Common.Close;
                    e.Row.Cells[columnIndex_PkdLoc].ForeColor = System.Drawing.Color.Gray;
                    e.Row.Cells[columnIndex_PkdLoc].Font.Bold = true;
                }
                // e.Row.Cells[9].Text = e.Row.Cells[9].Text.ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
            }
        }

        // 合并相同的单元格
        //protected void GridView1_PreRender(object sender, EventArgs e)
        //{
        //    if (GridView1.Rows.Count < 2)
        //    {
        //        return;
        //    }

        //    int iMatch = 1;
        //    int mRow = 0;
        //    string sMark = GridView1.Rows[mRow].Cells[iMatch].Text;

        //    for (int iRow = 1; iRow < GridView1.Rows.Count; iRow++)
        //    {
        //        if (GridView1.Rows[iRow].Cells[iMatch].Text == sMark)
        //        {
        //            for (int i = 0; i <= 6; i++)
        //            {
        //                GridView1.Rows[iRow].Cells[i].Visible = false;
        //                GridView1.Rows[mRow].Cells[i].RowSpan = iRow - mRow + 1;
        //            }
        //        }
        //        else
        //        {
        //            mRow = iRow;
        //            sMark = GridView1.Rows[mRow].Cells[iMatch].Text;
        //        }
        //    }
        //}
    }
}