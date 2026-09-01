using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class GRNPackList : BasePage
    {
        public int index = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            index = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "PkdLoc")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxErrorLog));
          
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PIDID";
            this.Master.DefaultSortExpression = "lastupdate desc";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string sn = this.txtSN.Value.Trim().Replace("'", "''");
            string txtGRNSN = this.txtGRNSN.Value.Trim().Replace("'", "''");
            string txtVendorCode = this.txtVendorCode.Text.Trim().Replace("'", "''");
            int cartonstatus = Convert.ToInt32(this.selCartonStatus.SelectedValue);
            string txtPOCode = this.txtPOCode.Value.Trim().Replace("'", "''");
            if (!IsPostBack)
            {
                searchSettings.ExtensionCondition = " and carton.MaterialUnitId = -1 ";
            }
            else
            {
                string strWhere = "";

                if (sn != "")
                {
                    searchSettings.ExtensionCondition = " and carton.SerialNumber = '" + sn + "' ";
                }

                if (txtGRNSN != "")
                {
                    searchSettings.ExtensionCondition = " and grn.SerialNumber = '" + txtGRNSN + "' ";
                }
                if (txtVendorCode != "")
                {
                    searchSettings.ExtensionCondition = " and grn.VendorCode = '" + txtVendorCode + "' ";
                }
                if (txtPOCode != "")
                {
                    searchSettings.ExtensionCondition = " and POrder = '" + txtPOCode + "' ";
                }
                if (Convert.ToInt32(cartonstatus) != -1)
                {
                    if (Convert.ToInt32(cartonstatus) == 2)
                    {
                        strWhere += " and  grn.MaterialUnitId = -1";
                    }
                    else
                    {
                        strWhere += " and carton.Flag = " + Convert.ToInt32(cartonstatus);
                    }
                }

                searchSettings.ExtensionCondition += strWhere;

                int userType = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType;
                string userId = "";
                if (userType != -1)
                {
                    //新增供应商过滤
                    userId = " and  c.SupplierId = " + userType;
                    searchSettings.ExtensionCondition += userId;
                }
            }
            this.Master.SearchSettings = searchSettings;

            this.GridView1.PageIndex = 0;
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string flag = e.Row.Cells[index].Text;
                if (flag == "1")
                {
                    e.Row.Cells[index].Text = Resources.Common.Open;
                    e.Row.Cells[index].ForeColor = System.Drawing.Color.Green;
                    e.Row.Cells[index].Font.Bold = true;
                }
                else
                {
                    e.Row.Cells[index].Text = Resources.Common.Close;
                    e.Row.Cells[index].ForeColor = System.Drawing.Color.Gray;
                    e.Row.Cells[index].Font.Bold = true;
                }
                // e.Row.Cells[9].Text = e.Row.Cells[9].Text.ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
            }
        }

        // 合并相同的单元格
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
                    for (int i = 0; i <= 3; i++)
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
    }
}