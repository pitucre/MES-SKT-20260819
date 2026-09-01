using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class SearchMolding : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RowIndex";
            this.Master.DefaultSortExpression = "RowIndex DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = SetSearchSetting();

            this.Master.SearchSettings = searchSettings;

            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    DataTable tb = new DataTable();
                    tb = BindData();
                    if (tb != null)
                    {
                        ExportToSpreadsheet(tb, DateTime.Now.ToShortDateString());
                    }
                }
            }
        }

        #region  DataTable导出到Excel
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

        private DataTable BindData()
        {
            SKT.Common.Model.SearchSettings searchSettings = SetSearchSetting();

            LeanMES.Molding.BLL.MaterialMolding bll = new LeanMES.Molding.BLL.MaterialMolding();
            return bll.GetWOMoldingExcle(); 
           
        }

        private SKT.Common.Model.SearchSettings SetSearchSetting()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (txtItem.Text.Trim() != "")
            {
                searchSettings.AddCondition("SourceItemCode", txtItem.Text.Trim());
            }

            if (txtItem2.Text.Trim() != "")
            {
                searchSettings.AddCondition("TargetItemCode", txtItem2.Text.Trim());
            }

            if (txtWorkOrder.Text.Trim() != "")
            {
                searchSettings.AddCondition("OrderNO", txtWorkOrder.Text.Trim());
            }

            if (txtStation.Text.Trim() != "")
            {
                searchSettings.AddCondition("Station", txtStation.Text.Trim());
            }

            if (txtBeginTime.Text != "")
            {
                searchSettings.ExtensionCondition = " CreateTime > '" + txtBeginTime.Text + "' ";
            }

            if (txtEndTime.Text != "")
            {
                string endTime = Convert.ToDateTime(txtEndTime.Text).AddDays(1).ToString("yyyy-MM-dd");
                searchSettings.ExtensionCondition = (searchSettings.ExtensionCondition == "" ? "" : searchSettings.ExtensionCondition + " And ") + " CreateTime < '" + endTime + "' ";
            }
            return searchSettings;
        }
    }
}