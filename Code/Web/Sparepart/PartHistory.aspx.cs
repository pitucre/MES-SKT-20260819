using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Sparepart.Model;
using SKT.LeanMES.Web.AjaxServices;
using AjaxPro;
using System.Text;
using System.IO;
using SKT.LeanMES.Sparepart.BLL;
using System.Data;

namespace SKT.LeanMES.Web.Sparepart
{
    public partial class PartHistory : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(PartHistory));
            tbBeginTime.ReadOnly = true;
            tbEndTime.ReadOnly = true;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PartsHistoryId";
            this.Master.DefaultSortExpression = " PartsHistoryId Desc ";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string beginValue = "";
            string endValue = "";
            searchSettings.ExtensionCondition = " 1=1 ";
            beginValue = tbBeginTime.Text == "" ? " AND CreateDateTime>='1900-01-01'" : " AND CreateDateTime>='" + Convert.ToDateTime(tbBeginTime.Text).ToString("yyyy-MM-dd") + "'";
            endValue = tbEndTime.Text == "" ? " AND CreateDateTime<='9999-12-31'" : " AND CreateDateTime<='" + Convert.ToDateTime(tbEndTime.Text).AddDays(1).ToString("yyyy-MM-dd") + "'";
            searchSettings.ExtensionCondition += beginValue + endValue;
            if (ddlOption.SelectedValue != "-1")
            {
                searchSettings.AddCondition("Requestor", ddlOption.SelectedValue);
            }
            if (txtPartCategory.Text != "")
            {
                searchSettings.ExtensionCondition += " and PartName like '%" + txtPartCategory.Text + "%'";
            }
            if (txtPartMachine.Text != "")
            {
                searchSettings.ExtensionCondition += " and PartNickName like '%" + txtPartMachine.Text + "%'";
            }
            if (txtRequestor.Text != "")
            {
                searchSettings.ExtensionCondition += " and CreateBy like '%" + txtRequestor.Text + "%'";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (IsPostBack)
            {

                if (Request["hdnOperate"].ToLower() == "exportexcel")
                {
                    DataTable tb = new DataTable();
                    string txtBegin = "";
                    string txtEnd = "";
                    //Int32 optionValue = 0;
                    txtBegin = tbBeginTime.Text == "" ? "1900-01-01" : tbBeginTime.Text;
                    txtEnd = tbEndTime.Text == "" ? "9999-12-31" : tbEndTime.Text;
                    //optionValue = ddlOption.SelectedValue == "" ? 0 : Int32.Parse(ddlOption.SelectedValue);
                    tb = BindData(1, txtBegin, txtEnd);
                    if (tb != null)
                    {
                        ExportExcel(tb, DateTime.Now.ToString("yyyyMMddHHmmss"));
                        //ExportToSpreadsheet(tb,DateTime.Now.ToShortDateString());
                    }
                }
            }

        }


        #region  DataTable导出到Excel 停用 update 2017-08-30
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
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + name + ".xls");
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

        #endregion


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
            var sheet1 = book.CreateSheet("出入库历史");
            //给sheet1添加第一行的头部标题
            var row1 = sheet1.CreateRow(0);
            int rowId = 0;
            foreach (DataColumn column in table.Columns)
            {
                if (column.ColumnName != "pid")
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
                    if (column.ColumnName != "pid")
                    {
                        if (column.ColumnName == "创建日期")
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
        public System.Data.DataTable BindData(Int32 outOrIn, String beginDateTime, String endDateTime)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            PartsHistory bll = new PartsHistory();
            tb = bll.ImportToExcel(outOrIn, beginDateTime, endDateTime);
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