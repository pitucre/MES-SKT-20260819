using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Sparepart.BLL;
using System.Data;
using System.Web;
using System.Linq;

namespace SKT.LeanMES.Web.Sparepart
{
    public partial class PartsList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PartId";
            this.Master.DefaultSortExpression = " PartId Desc ";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            var toolName = this.txtToolName.Text.ToString();
            //var toolCode = this.txtToolCode.Text.ToString();
            var category = this.txtPartCategory.Text.ToString();
            var supplier = this.txtSupplier.Text.ToString();
            var location = this.txtPartLocation.Text.ToString();
            var PartStandard = this.txtPartStandard.Text.ToString();
            string ddlStates = this.ddlStates.SelectedValue;          //状态
            var itemcode = this.txtItemCode.Text.ToString().Trim();
            //searchSettings.AddCondition(" PartName ",toolName );
            //searchSettings.AddCondition(" PartNickName ", toolCode);
           
            searchSettings.AddCondition(" PartCategory ", category);
            //searchSettings.AddCondition(" SupplierName ", supplier);
            //searchSettings.AddCondition(" partLocation ", location);

            searchSettings.ExtensionCondition = " 1=1 ";
            if (ddlStates != "-1")
            {
                if (ddlStates == "1")
                {
                    searchSettings.ExtensionCondition += " and PartQty>ScrapQty";
                }
                if (ddlStates == "2")
                {
                    searchSettings.ExtensionCondition += " and PartQty=ScrapQty";
                }
            }
            searchSettings.ExtensionCondition += " and (PartName like '%" + toolName + "%' or PartNickName like '%" + toolName + "%' )";
            searchSettings.ExtensionCondition += " and partLocation like '%" + location + "%' ";
            searchSettings.ExtensionCondition += " and VenName like '%" + supplier + "%' ";
            searchSettings.ExtensionCondition += " and PartStandard like '%" + PartStandard + "%' ";
            if (!string.IsNullOrEmpty(itemcode))
            {
           
                searchSettings.ExtensionCondition += "and ItemCode='"+ itemcode + "'";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Sparepart.BLL.Sparepart bll = new SKT.LeanMES.Sparepart.BLL.Sparepart();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    DataTable tb = new DataTable();

                    tb = BindData(toolName, toolName, category, supplier, location);
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
        public System.Data.DataTable BindData(String toolName, String toolCode, string category, string suppllier, string location)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            SKT.LeanMES.Sparepart.BLL.Sparepart bll = new SKT.LeanMES.Sparepart.BLL.Sparepart();
            tb = bll.ImportToExcel(toolName, toolCode, category, suppllier, location);
            if (tb != null)
            {
                return tb;
            }
            else
            {
                return null;
            }
        }
        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //TableCell tcSafeQty = e.Row.Cells[7];
                //TableCell tcQty  = e.Row.Cells[8];
                //if (Convert.ToDecimal(tcSafeQty.Text) > Convert.ToDecimal(tcQty.Text))
                //{
                //    tcQty.BackColor = System.Drawing.Color.Red;
                //}
                //if (e.Row.Cells[9].Text == "-1")
                //{
                //    e.Row.Cells[9].Text = "";
                //}

                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //14改为columnIndex_ModifyBy
                //15改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
        //#region  DataTable导出到Excel
        //public static void ExportToSpreadsheet(DataTable table, string name)
        //{
        //    Random r = new Random();
        //    string rf = "";
        //    for (int j = 0; j < 10; j++)
        //    {
        //        rf = r.Next(int.MaxValue).ToString();
        //    }

        //    HttpContext context = HttpContext.Current;
        //    context.Response.Clear();

        //    context.Response.ContentType = "text/csv";
        //    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
        //    context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + name + ".xls");
        //    context.Response.BinaryWrite(System.Text.Encoding.UTF8.GetPreamble());

        //    foreach (DataColumn column in table.Columns)
        //    {
        //        context.Response.Write(column.ColumnName + ",");
        //        //context.Response.Write(column.ColumnName + "(" + column.DataType + "),");   
        //    }

        //    context.Response.Write(Environment.NewLine);
        //    double test;

        //    foreach (DataRow row in table.Rows)
        //    {
        //        for (int i = 0; i < table.Columns.Count; i++)
        //        {
        //            switch (table.Columns[i].DataType.ToString())
        //            {
        //                case "System.String":
        //                    if (double.TryParse(row[i].ToString(), out test)) context.Response.Write("=");
        //                    context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
        //                    break;
        //                case "System.DateTime":
        //                    if (row[i].ToString() != "")
        //                        context.Response.Write("\"" + ((DateTime)row[i]).ToString("yyyy-MM-dd hh:mm:ss") + "\",");
        //                    else
        //                        context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
        //                    break;
        //                default:
        //                    context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
        //                    break;
        //            }
        //        }
        //        context.Response.Write(Environment.NewLine);
        //    }

        //    context.Response.End();

        //}



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
            var sheet1 = book.CreateSheet("工具列表");
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
                    var item = column.ColumnName;
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