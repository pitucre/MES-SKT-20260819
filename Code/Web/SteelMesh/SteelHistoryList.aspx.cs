using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.SteelMesh.BLL;
using SKT.LeanMES.SteelMesh.Model;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelHistoryList : BasePage
    {
        private bool scrap;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "HistoryID";
            this.Master.DefaultSortExpression = " HistoryID Desc ";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (!String.IsNullOrEmpty(ddlStatus.SelectedValue) && ddlStatus.SelectedValue != "-1")
            {
                searchSettings.AddCondition("EquipmentStatus", ddlStatus.SelectedValue);
            }

            if (!String.IsNullOrEmpty(tbBeginTime.Value.Trim()))
            {
                searchSettings.ExtensionCondition = " UPLineTime >= '" + Convert.ToDateTime(tbBeginTime.Value.Trim()).ToString("yyyy-MM-dd") + "'";
            }

            if (!String.IsNullOrEmpty(tbEndTime.Value.Trim()))
            {
                searchSettings.ExtensionCondition = " UPLineTime <= '" + Convert.ToDateTime(tbEndTime.Value.Trim()).AddDays(1).ToString("yyyy-MM-dd") + "'";
            }

            if (txtWorkOrder.Text.Trim() != "")
            {
                searchSettings.AddCondition("OrderNO", txtWorkOrder.Text.Trim());
            }

            if (txtEquipmentCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("EquipmentCode", txtEquipmentCode.Text.Trim());
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
                    txtBegin = tbBeginTime.Value == "" ? "1900-01-01" : tbBeginTime.Value;
                    txtEnd = tbEndTime.Value == "" ? "9999-12-31" : tbEndTime.Value;
                    int status = ddlStatus.SelectedValue == "" ? 0 : Int32.Parse(ddlStatus.SelectedValue);
                    tb = BindData(status, txtBegin, txtEnd);
                    if (tb != null)
                    {
                        SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.ExportToExcel(tb, DateTime.Now.ToString("yyyyMMddHHmmssffff")+".xls", "utf-8");
                        //ExportToSpreadsheet(tb, DateTime.Now.ToShortDateString());
                    }
                }
            }


            #region 控件禁用，又能直接取值。
            if (!IsPostBack)
            {
                this.tbBeginTime.Attributes.Add("readonly", "true");
                this.tbBeginTime.Attributes.Add("onfocus", "this.blur()");
                this.tbBeginTime.Attributes["style"] += "background-color:#F0F0F0";
                this.tbEndTime.Attributes.Add("readonly", "true");
                this.tbEndTime.Attributes.Add("onfocus", "this.blur()");
                this.tbEndTime.Attributes["style"] += "background-color:#F0F0F0";
            }
            #endregion

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



        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(Int32 status, String beginDateTime, String endDateTime)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            SteelHistory bll = new SteelHistory();
            tb = bll.ImportToExcel(status, beginDateTime, endDateTime);
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