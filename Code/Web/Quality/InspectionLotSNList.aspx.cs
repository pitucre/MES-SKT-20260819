using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SKT.LeanMES.Quality.BLL;
using System;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionLotSNList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string QcLotNo = Request.QueryString["QcLotNo"] == null ? "" : Request.QueryString["QcLotNo"].ToString();

            if (QcLotNo != "")
            {
                this.Master.PageGridView = this.GridView1;
                this.Master.PageObjectDataSource = this.ObjectDataSource1;
                this.Master.RecordIDField = "UID";
                //this.Master.DefaultSortExpression = "ItemLevel";

                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                searchSettings.ExtensionCondition = " AND A.QcLotNo = '" + QcLotNo + "'";
                this.Master.SearchSettings = searchSettings;
            }

            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    DataTable tb = new DataTable();

                    tb = BindData(QcLotNo);
                    if (tb != null)
                    {
                        ExportExcel(tb, DateTime.Now.ToString("yyyyMMddHHmmss"));
                    }
                }
            }
        }
        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(string QcLotNo)
        {
            System.Data.DataTable tb = new System.Data.DataTable();

            InspectionLot bll = new InspectionLot();
            tb = bll.GetQcLotSNImportToExcel(QcLotNo);
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
        /// 导出Excel 
        /// </summary>
        /// <param name="table"></param>
        /// <param name="name"></param>
        public static void ExportExcel(DataTable table, string name)
        {
            HttpContext context = HttpContext.Current;
            var book = new NPOI.HSSF.UserModel.HSSFWorkbook();

            //添加一个sheet
            var sheet1 = book.CreateSheet("批次明细列表");
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
    }
}