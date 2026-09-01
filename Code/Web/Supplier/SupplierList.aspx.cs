using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.Supplier.Model;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.Supplier
{
    public partial class SupplierList : BasePage
    {
        private int columnIndex_IsShipmentReport = -1;
        private int columnIndex_IsLaboratoryReport = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_IsShipmentReport = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IsShipmentReport")) + 1;
            columnIndex_IsLaboratoryReport = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IsLaboratoryReport")) + 1;

            string defaultSort = "VendorCode";
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SupplierId";
            this.Master.DefaultSortExpression = "VendorCode";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "(1=1) ";
            if (!string.IsNullOrEmpty(this.txtVendorCode.Text.Trim()))
            {
                searchSettings.ExtensionCondition += " AND VendorCode like '%" + this.txtVendorCode.Text.Trim() + "%' ";
            }
            if (!string.IsNullOrEmpty(this.txtVendorName.Text.Trim()))
            {
                searchSettings.ExtensionCondition += " AND VendorName like '%" + this.txtVendorName.Text.Trim() + "%' ";
            }
            if (!string.IsNullOrEmpty(this.txtVendorSort.Text.Trim()))
            {
                searchSettings.ExtensionCondition += " AND VendorSort like '%" + this.txtVendorSort.Text.Trim() + "%' ";
            }
            if (ddlIsMesAdd.SelectedValue != "-1")
            {
                searchSettings.ExtensionCondition += " AND IsMesAdd=" + ddlIsMesAdd.SelectedValue;
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                string userName = AccountController.GetCurrentUser().UserName;
                try
                {
                    if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        Suppliers bll = new Suppliers();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                    {
                        //Sperkey.Zhong 2018-07-20 修改导出方法，导出数据与列表查询结果及查询列一致
                        string sort = string.IsNullOrWhiteSpace(this.GridView1.SortExpression) ? defaultSort : this.GridView1.SortExpression;
                        if (!string.IsNullOrWhiteSpace(sort) && this.GridView1.SortDirection == SortDirection.Descending)
                        {
                            sort += " DESC";
                        }
                        bool isMatchAll = false;//全词匹配
                        var match = Request.Form["ctl00$ctl00$ContentPlaceHolder1$chkMatchWholeWord"];
                        if (match != null && string.Equals(match, "on", StringComparison.CurrentCultureIgnoreCase))
                        {
                            isMatchAll = true;
                        }
                        searchSettings.IsMatchWholeWord = isMatchAll;
                        SKT.LeanMES.Supplier.BLL.Suppliers bll = new SKT.LeanMES.Supplier.BLL.Suppliers();
                        DataTable dt = bll.ImportToExcel(sort, searchSettings);
                        SetExportColumn(dt);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(userName, ex, true);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                try
                {
                    //xiang.yan 2024-4-24 cells取值改为根据列名获取
                    //10改为columnIndex_IsShipmentReport
                    if (e.Row.Cells[columnIndex_IsShipmentReport].Text=="1")
                    {
                        e.Row.Cells[columnIndex_IsShipmentReport].Text = "是";
                    }
                    else
                    {
                        e.Row.Cells[columnIndex_IsShipmentReport].Text = "否";
                    }

                    //xiang.yan 2024-4-24 cells取值改为根据列名获取
                    //11改为columnIndex_IsLaboratoryReport
                    if (e.Row.Cells[columnIndex_IsLaboratoryReport].Text == "1")
                    {
                        e.Row.Cells[columnIndex_IsLaboratoryReport].Text = "是";
                    }
                    else
                    {
                        e.Row.Cells[columnIndex_IsLaboratoryReport].Text = "否";
                    }
                }
                catch { }
            }
        }

        /// <summary>
        /// 设置要导出的列
        /// </summary>
        /// <param name="dt"></param>
        public void SetExportColumn(DataTable dt)
        {
            var dic = new Dictionary<string, string>()
            {
                {"VendorCode",Resources.lang.VendorCode },
                {"VendorSort",Resources.lang.VendorSort },
                {"VendorName",Resources.lang.VendorName },
                {"VendorAddress",Resources.lang.VendorAddress },
                {"CreateBy",Resources.lang.CreateBy },
                {"CreateDateTime",Resources.lang.CreateDateTime },
                {"DataSource","来源" }
            };

            //更改列名，并设置导出列顺序
            int idx = 0;
            foreach (var item in dic)
            {
                if (dt.Columns.Contains(item.Key))
                {
                    dt.Columns[item.Key].SetOrdinal(idx);
                    dt.Columns[item.Key].ColumnName = item.Value;
                    idx++;
                }
            }

            //移除多余列
            int colCount = dt.Columns.Count;
            for (int i = colCount - 1; i >= idx; i--)
            {
                dt.Columns.RemoveAt(i);
            }

            //导出
            ExportExcel(dt, "供应商列表-" + DateTime.Now.ToString("yyyyMMddHHmmss"));
        }
     
        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(string sort, String code, String name, int isMesAdd)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            SKT.LeanMES.Supplier.BLL.Suppliers bll = new SKT.LeanMES.Supplier.BLL.Suppliers();
            tb = bll.ImportToExcel(sort, name, isMesAdd, code);

            if (tb != null)
            {
                return tb;
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 导出Excel add zx 2017-08-30
        /// </summary>
        /// <param name="table"></param>
        /// <param name="name"></param>
        public static void ExportExcel(DataTable table, string name)
        {
            HttpContext context = HttpContext.Current;
            var book = new NPOI.HSSF.UserModel.HSSFWorkbook();

            //添加一个sheet
            var sheet1 = book.CreateSheet("供应商列表");
            //给sheet1添加第一行的头部标题
            var row1 = sheet1.CreateRow(0);
            int rowId = 0;
            foreach (DataColumn column in table.Columns)
            {
                row1.CreateCell(rowId).SetCellValue(column.ColumnName);
                rowId++;
            }

            //创建值
            for (var i = 0; i < table.Rows.Count; i++)
            {
                var rowId2 = 0;
                NPOI.SS.UserModel.IRow rowtemp = sheet1.CreateRow(i + 1);
                foreach (DataColumn column in table.Columns)
                {
                    rowtemp.CreateCell(rowId2).SetCellValue(table.Rows[i][rowId2].ToString());
                    rowId2++;
                }

            }

            // 写入到客户端
            var ms = new System.IO.MemoryStream();
            book.Write(ms);
            context.Response.ContentType = "application/vnd.ms-excel";
            context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");
            context.Response.HeaderEncoding = System.Text.Encoding.GetEncoding("gb2312");
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + name + ".xls");
            context.Response.BinaryWrite(System.Text.Encoding.GetEncoding("gb2312").GetPreamble());
            context.Response.BinaryWrite(ms.ToArray());

        }
    }
}