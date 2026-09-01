using System;
using System.Web.UI.WebControls;
using Resources;
using SKT.Common.Model;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Configuration;
using System.Linq;

namespace SKT.LeanMES.Web.Quality
{
    public partial class RmaList : BasePage
    {
        private int columnIndex_RTypeId = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_RTypeId = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "RTypeId")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxQualityInspection));
            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "RmaId";
            Master.DefaultSortExpression = "RmaId";
            Master.DefaultSortDirection = SortDirection.Descending;
            if (IsPostBack)
            {

                var searchSettings = new SearchSettings();
                searchSettings.AddCondition("RmaNo", txtRmaNo.Text.Trim());
                if (ddlRmaType.SelectedValue != "-1")
                {
                    searchSettings.ExtensionCondition = " RTypeId = " + ddlRmaType.SelectedValue;
                }
                searchSettings.AddCondition("CustomerName", txtCustomerName.Text.Trim());

                searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());
                if (txtCancelTime.Text != "")
                {
                    searchSettings.ExtensionCondition = " CONVERT(varchar(10),CancelTime,120)=CONVERT(varchar(10),'" + txtCancelTime.Text + "',120)";
                }

                Master.SearchSettings = searchSettings;
                GridView1.PageIndex = 0;


                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        var bll = new InspectionTemplate();
                        bll.Delete(Request.Form["hdnIdString"], AccountController.GetCurrentUser().UserId.ToString());
                        WebHelper.ShowMessage(Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }

                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    DataTable tb = new DataTable();
                    //tb = (new SKT.LeanMES.Quality.BLL.Rma()).DtGetAll(0, -1, "", searchSettings);
                    //tb = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, "SELECT * FROM vwApplyDetailView", null);


                    String rmaNo = txtRmaNo.Text.Trim(); 
                    String cancelTime = txtCancelTime.Text.Trim();
                    String customerName = txtCustomerName.Text.Trim();
                    String itemCode = txtItemCode.Text.Trim();
                    int rmaType = -1;
                    if (ddlRmaType.SelectedValue != "-1")
                    {
                        rmaType = Convert.ToInt32(ddlRmaType.SelectedValue);
                    }
                    tb = BindData(rmaNo, cancelTime, customerName, itemCode, rmaType);

                    if (tb != null)
                    {
                        // ExportToSpreadsheet(tb, DateTime.Now.ToShortDateString());
                        ExportExcel(tb, DateTime.Now.ToString("yyyyMMddHHmmss"));
                    }
                }

                if (Request.Form["hdnOperate"].ToLower() == "rmareportpdfprint")
                {
                    var bll = new Rma();
                    string strXmlPath = "";
                    string strTargePath = "";
                    string strFileName = "";
                    strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "RMAReportFile.xml";
                    if (ConfigurationManager.AppSettings["FilePath"] != null)
                    {
                        strTargePath = CommonMethod.WebRoot + ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                        var rmaNo = Request.Form["hdnRamNo"];
                        strFileName = bll.GetRMAReportPdf(Convert.ToInt32(Request.Form["hdnIdString"]),rmaNo, strTargePath, strXmlPath, CommonMethod.WebRoot);
                        //导出文件
                        CommonMethod.exportFile(strFileName, strTargePath);
                    }
                    else
                    {
                        WebHelper.ShowMessage("在系统配置文件中未找到文件上传路径节点 [FilePath]！");
                    }
                }
            }
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //2改为columnIndex_RTypeId
                string type = e.Row.Cells[columnIndex_RTypeId].Text;
                if (type == "1")
                {
                    e.Row.Cells[columnIndex_RTypeId].Text = "RMA";
                }
                else
                {
                    e.Row.Cells[columnIndex_RTypeId].Text = "DOA";
                }

            }
        }

        #region  DataTable导出到Excel  停用 update 2017-08-30
        public static void ExportToSpreadsheet(DataTable table, string name)
        {
            Random r = new Random();
            string rf = "";
            for (int j = 0; j < 10; j++)
            {
                rf = r.Next(int.MaxValue).ToString();
            }

            HttpContext context = HttpContext.Current;
            context.Response.Clear();

            context.Response.ContentType = "text/csv";
            context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode("RMA单列表_" + name, System.Text.Encoding.UTF8) + ".xls");
            context.Response.BinaryWrite(System.Text.Encoding.UTF8.GetPreamble());

            foreach (DataColumn column in table.Columns)
            {
                context.Response.Write(column.ColumnName + ",");
                //context.Response.Write(column.ColumnName + "(" + column.DataType + "),");   
            }

            context.Response.Write(Environment.NewLine);
            double test;

            foreach (DataRow row in table.Rows)
            {
                for (int i = 0; i < table.Columns.Count; i++)
                {
                    switch (table.Columns[i].DataType.ToString())
                    {
                        case "System.String":
                            if (double.TryParse(row[i].ToString(), out test)) context.Response.Write("=");
                            context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                            break;
                        case "System.DateTime":
                            if (row[i].ToString() != "")
                                context.Response.Write("\"" + ((DateTime)row[i]).ToString("yyyy-MM-dd hh:mm:ss") + "\",");
                            else
                                context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                            break;
                        default:
                            context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                            break;
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
            var sheet1 = book.CreateSheet("RMA单列表");
            //给sheet1添加第一行的头部标题
            var row1 = sheet1.CreateRow(0);
            int rowId = 0;
            foreach (DataColumn column in table.Columns)
            {
                if (column.ColumnName != "pid" && column.ColumnName != "生产日期")
                {
                    row1.CreateCell(rowId).SetCellValue(column.ColumnName);
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
                
                    if (column.ColumnName == "退货时间" || column.ColumnName == "创建时间")
                    {
                        rowtemp.CreateCell(rowId2).SetCellValue(Convert.ToDateTime(table.Rows[i][rowId2]).ToString("yyyy-MM-dd HH:mm:ss"));
                    }
                    else
                    {
                        rowtemp.CreateCell(rowId2).SetCellValue(table.Rows[i][rowId2].ToString());
                    }

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

        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(string rmaNo,string cancelTime, string customerName, string itemCode,int rmaType)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            Rma bll = new Rma();
            tb = bll.DtGetAll(rmaNo, cancelTime, customerName, itemCode, rmaType);

            if (tb != null)
            {
                return tb;
            }
            else
            {
                return null;
            }
        }
        #endregion
    }
}