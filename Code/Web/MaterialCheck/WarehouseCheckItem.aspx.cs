using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SKT.LeanMES.Web.MaterialCheck
{
    public partial class WarehouseCheckItem : BasePage
    {
        string checkOrder = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            checkOrder = Request.QueryString["OrderName"];
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCheck));
        }
        //导出Excel
        protected void btnImportExcel_Click(object sender, EventArgs e)
        {
            DataTable tb = new DataTable();
            tb = BindData(checkOrder);
            if (tb != null)
            {
                ExportExcel(tb, DateTime.Now.ToString("yyyyMMddHHmmss"));
            }
        }

        public static void ExportExcel(DataTable table, string name)
        {
            HttpContext context = HttpContext.Current;
            var book = new NPOI.HSSF.UserModel.HSSFWorkbook();

            //添加一个sheet
            var sheet1 = book.CreateSheet("盘点GRN明细");
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
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + name + ".xls");
            context.Response.BinaryWrite(ms.ToArray());

        }

        public System.Data.DataTable BindData(String checkOrder)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            SKT.LeanMES.Material.BLL.WarehouseCheck bll = new LeanMES.Material.BLL.WarehouseCheck();
            tb = bll.CheckOrderImportToExcel(checkOrder, 2);
            if (tb != null)
            {
                return tb;
            }
            else
            {
                return null;
            }
        }
    }
}