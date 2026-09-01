using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.Jig.BLL;
using SKT.LeanMES.Jig.Model;

namespace SKT.LeanMES.Web.Jig
{
    public partial class JigHistoryList : BasePage
    {
        private bool scrap;
        private int columnIndex_OperateType = -1;
        private int columnIndex_JigType = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_OperateType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "OperateType")) + 1;
            columnIndex_JigType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "JigType")) + 1;

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "JigHistoryId";
            this.Master.DefaultSortExpression = " CreateDateTime Desc ";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();


            if (!String.IsNullOrEmpty(ddlOption.SelectedValue))
            {
                searchSettings.AddCondition("OperateType", ddlOption.SelectedValue);
            }

            if (!String.IsNullOrEmpty(tbBeginTime.Value) && !String.IsNullOrEmpty(tbEndTime.Value))
            {
                searchSettings.ExtensionCondition = " CreateDateTime between '" + tbBeginTime.Value + "' and '" + tbEndTime.Value + "'";
            }

            if (!String.IsNullOrEmpty(txtJigType.Text))
            {
                searchSettings.AddCondition("JigCategory", txtJigType.Text);
            }

            if (!String.IsNullOrEmpty(txtRequestor.Text))
            {
                searchSettings.AddCondition("CName", txtRequestor.Text);
            }
            if (!String.IsNullOrEmpty(txtJigCode.Text))
            {
                searchSettings.AddCondition("JigCode", txtJigCode.Text);
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
                    Int32 optionValue = 0;
                    txtBegin = tbBeginTime.Value == "" ? "1900-01-01" : tbBeginTime.Value;
                    txtEnd = tbEndTime.Value == "" ? "9999-12-31" : tbEndTime.Value;
                    optionValue = ddlOption.SelectedValue == "" ? 0 : Int32.Parse(ddlOption.SelectedValue);
                    tb = BindData(optionValue, txtBegin, txtEnd);
                    if (tb != null)
                    {
                        ExportToSpreadsheet(tb, DateTime.Now.ToShortDateString());
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

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //5改为columnIndex_OperateType，
                //6改为columnIndex_JigType
                TableCell tc = e.Row.Cells[columnIndex_OperateType];
                scrap = false;
                switch (tc.Text)
                {
                    case "1":
                        tc.Text = "归还";
                        break;
                    case "2":
                        tc.Text = "借用";
                        break;
                    case "3":
                        tc.Text = "报废";
                        scrap = true;
                        break;
                    default:
                        tc.Text = "";
                        break;
                }

                tc = e.Row.Cells[columnIndex_JigType];
                switch (tc.Text)
                {
                    case "1":
                        tc.Text = "包装归还";
                        break;
                    case "2":
                        tc.Text = "借用归还";
                        break;
                    case "3":
                        tc.Text = "闲置归还";
                        break;
                    case "4":
                        tc.Text = "不良归还";
                        break;
                    case "10":
                        tc.Text = "产线归还";
                        break;
                    case "5":
                        tc.Text = "维修借用";
                        break;
                    case "6":
                        tc.Text = "保养借用";
                        break;
                    case "7":
                        tc.Text = "借用出库";
                        break;
                    case "8":
                        tc.Text = "报废出库";
                        break;
                    case "9":
                        tc.Text = "退货出库";
                        break;
                    case "11":
                        tc.Text = "产线借用";
                        break;
                    default:
                        tc.Text = scrap ? "报废" : "";
                        break;
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



        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(Int32 outOrIn, String beginDateTime, String endDateTime)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            JigHistory bll = new JigHistory();
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