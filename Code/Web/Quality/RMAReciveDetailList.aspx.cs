using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{
    public partial class RMAReciveDetailList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.Quality.RMAReciveDetailList));            

            string RMAID = Request.QueryString["ID"];
            if (!string.IsNullOrEmpty(RMAID))
            {
                //PageData = (new Rma()).GetInfo(Convert.ToInt32(RMAID));
            }

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RMAUnitID";
            this.Master.DefaultSortExpression = "RmaNo Desc"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (!string.IsNullOrWhiteSpace(txtRMANO.Text.Trim()))
            {
                searchSettings.AddCondition("RmaNo", txtRMANO.Text.Trim());
            }
            if (!string.IsNullOrWhiteSpace(txtSN.Text.Trim()))
            {
                searchSettings.AddCondition("SN", txtSN.Text.Trim());
            }
            if (!string.IsNullOrWhiteSpace(txtItemCode.Text.Trim()))
            {
                searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if(IsPostBack)
            {
                if (Request["hdnOperate"].ToLower() == "exportexcel")
                {
                    SKT.LeanMES.Quality.BLL.RMAUnit bll = new LeanMES.Quality.BLL.RMAUnit();
                    var lists = bll.GetAll(0, -1, "RmaNo DESC", searchSettings);

                    var list2 = lists.Select(k => new
                    {
                        k.RmaNo,
                        k.SN,
                        k.StatusName,
                        k.ItemCode,
                        k.ItemName,
                        k.ItemSpec,
                        k.CWhName,
                        k.cBarCode
                    });

                    DataTable tb = CommonHelper.BLL.ComMethod.ConvertToDataTable(list2.ToList());
                    if (tb != null)
                    {
                       // ExportToSpreadsheet(tb, "供应商交期维护" + DateTime.Now.ToShortDateString());
                        ExportExcel(tb, DateTime.Now.ToString("yyyyMMddHHmmss"));
                    }
                }
            }
        }

        [AjaxPro.AjaxMethod]
        public string CheckRePrintData(string idStr)
        {
            SKT.LeanMES.Quality.BLL.RMAUnit bll = new LeanMES.Quality.BLL.RMAUnit();
            return bll.CheckRePrintData(idStr);
        }

        #region  DataTable导出到Excel 停用 update 2017-08-30

        public static void ExportToSpreadsheet(DataTable table, string name)
        {
            var r = new Random();
            var rf = "";
            for (var j = 0; j < 10; j++)
            {
                rf = r.Next(int.MaxValue).ToString();
            }

            var context = HttpContext.Current;
            context.Response.Clear();
            context.Response.ContentType = "text/csv";
            context.Response.ContentEncoding = Encoding.UTF8;
            context.Response.AppendHeader("Content-Disposition",
                "attachment; filename=" + HttpUtility.UrlEncode(name) + ".xls");
            context.Response.HeaderEncoding = Encoding.UTF8;
            context.Response.BinaryWrite(Encoding.UTF8.GetPreamble());

            foreach (DataColumn column in table.Columns)
            {
                context.Response.Write(column.ColumnName + ",");
                //context.Response.Write(column.ColumnName + "(" + column.DataType + "),");   
            }

            context.Response.Write(Environment.NewLine);
            double test; DateTime dtTest;

            foreach (DataRow row in table.Rows)
            {
                for (var i = 0; i < table.Columns.Count; i++)
                {

                    if (double.TryParse(row[i].ToString(), out test))
                    {
                        context.Response.Write("=");
                        context.Response.Write("\"" + row[i].ToString() + "\",");
                    }
                    else if (DateTime.TryParse(row[i].ToString(), out dtTest))
                    {
                        context.Response.Write("\"" + Convert.ToDateTime(row[i]).ToString("yyyy-MM-dd") + "\",");
                    }
                    else
                    {
                        context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                    }
                }
                context.Response.Write(Environment.NewLine);
            }

            context.Response.End();
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
            var sheet1 = book.CreateSheet("RMA产品重打印");
            //给sheet1添加第一行的头部标题
            var row1 = sheet1.CreateRow(0);
            int rowId = 0;
            foreach (DataColumn column in table.Columns)
            {
                if (column.ColumnName == "RmaNo" || column.ColumnName == "SN" || column.ColumnName == "StatusName" || column.ColumnName == "ItemCode"
                     || column.ColumnName == "ItemName" || column.ColumnName == "ItemSpec" || column.ColumnName == "CWhName" || column.ColumnName == "cBarCode")
                {
                    var columnName = "";
                    switch (column.ColumnName)
                    {
                        case "RmaNo":
                            columnName = "RMA编号";
                            break;
                        case "SN":
                            columnName = "产品条码";
                            break;
                        case "StatusName":
                            columnName = "产品状态";
                            break;
                        case "ItemCode":
                            columnName = "产品编码";
                            break;
                        case "ItemName":
                            columnName = "产品名称";
                            break;
                        case "ItemSpec":
                            columnName = "产品规格";
                            break;
                        case "CWhName":
                            columnName = "仓库名称";
                            break;
                        case "cBarCode":
                            columnName = "库位";
                            break;
                    }
                    row1.CreateCell(rowId).SetCellValue(columnName);
                    rowId++;
                }

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

        #endregion
    }
}