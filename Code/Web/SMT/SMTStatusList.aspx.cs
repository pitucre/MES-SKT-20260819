using SKT.Common.DAL.Marshal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SMT
{
    public partial class SMTStatusList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strSqlWhere = "";
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MaterialHistoryId";//工单ID
            this.Master.DefaultSortExpression = "MaterialHistoryId desc";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (txtOrderNo.Text.Trim() != "")
            {
                searchSettings.AddCondition("OrderNo", txtOrderNo.Text.Trim());
                strSqlWhere += " AND OrderNo = '" + txtOrderNo.Text.Trim() + "'";
            }
            if (txtItemCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());
                strSqlWhere += " AND ItemCode = '" + txtItemCode.Text.Trim() + "'";
            }
            if (txtFBILLNO.Text.Trim() != "")
            {
                searchSettings.AddCondition("FBILLNO", txtFBILLNO.Text.Trim());
                strSqlWhere += " AND FBILLNO = '" + txtFBILLNO.Text.Trim() + "'";
            }
            if (txtSerialNumber.Text.Trim() != "")
            {
                searchSettings.AddCondition("SerialNumber", txtSerialNumber.Text.Trim());
                strSqlWhere += " AND SerialNumber = '" + txtSerialNumber.Text.Trim() + "'";
            }
            if (txtMatItemCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("MatItemCode", txtMatItemCode.Text.Trim());
                strSqlWhere += " AND MatItemCode = '" + txtMatItemCode.Text.Trim() + "'";
            }
            if (txtVendorCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("VendorCode", txtVendorCode.Text.Trim());
                strSqlWhere += " AND VendorCode = '" + txtVendorCode.Text.Trim() + "'";
            }
            if (txtLineName.Text.Trim() != "")
            {
                searchSettings.AddCondition("LineName", txtLineName.Text.Trim());
                strSqlWhere += " AND LineName = '" + txtLineName.Text.Trim() + "'";
            }
            if (txtEquipmentName.Text.Trim() != "")
            {
                searchSettings.AddCondition("EquipmentName", txtEquipmentName.Text.Trim());
                strSqlWhere += " AND EquipmentName = '" + txtEquipmentName.Text.Trim() + "'";
            }
            //if (txtCreateTimeStart.Text.Length > 0 || txtCreateTimeEnd.Text.Length > 0)
            //{
            //    var startTime = txtCreateTimeStart.Text == "" ? "2000-01-01" : txtCreateTimeStart.Text;
            //    var endTime = txtCreateTimeEnd.Text == "" ? "9999-12-31" : txtCreateTimeEnd.Text;
            //    var filterTime = " LoadingTime between '" + startTime + "' and '" + endTime + "'";
            //    searchSettings.ExtensionCondition = (searchSettings.ExtensionCondition == "") ? filterTime : searchSettings.ExtensionCondition + " and " + filterTime;

            //    strSqlWhere += " AND " + ((searchSettings.ExtensionCondition == "") ? filterTime : searchSettings.ExtensionCondition + " and " + filterTime);
            //}
            searchSettings.ExtensionCondition = " 1=1";
            if (!string.IsNullOrEmpty(this.txtCreateTimeStart.Text))
            {
                searchSettings.ExtensionCondition += " and LoadingTime >= '" + txtCreateTimeStart.Text + " 00:00:00' ";
            }
            if (!string.IsNullOrEmpty(this.txtCreateTimeEnd.Text))
            {
                searchSettings.ExtensionCondition += " and LoadingTime <= '" + txtCreateTimeEnd.Text + " 23:59:59' ";
            }


            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    string strSql = @"	SELECT OrderNO as '工单号码' ,ItemCode  as '产品编码'  ,ItemName as '产品名称' ,ItemSpec as '产品规格',
            Actual_Start_Date as '工单开始时间' ,Actual_Completed_Date as '工单完成时间' ,FBILLNO as '排程工单号码' ,FQty as '排程工单数量', 
            FPlanCommitDate as '排程工单计划开工时间' ,FPlanFinishDate as '排程工单计划完工时间' ,SerialNumber as 'GRN号码' ,MatItemCode as '物料编码' ,
            MatItemName as '物料名称' ,MatItemSpec  as '物料规格', VendorCode as '制造商编码' ,VendorName as '制造商名称' ,DateCode as '制造生产日期' ,
            Batch as '制造生产批次',MPN ,LineName as '生产线' ,EquipmentCode as '机台编码',EquipmentName as '机台名称' ,SequenceNo as '机台顺序' ,
            LoadingListName as '上料清单名称' , TableName as '面',Area as '区',Position as '站位' , Point as '位置',case IsMain when 1 then '是' else '否' end as '是否主料' ,MainItemCode as '主料物料编码' ,
            MainItemName as '主料物料名称',SmtNum as '用量' ,case IsBindFeeder when 1 then '是' else '否' end  as '是否离线备料' ,FeederSN as 'feeder号码',FeederType as 'feeder类型' ,
            BindPerson as '最近绑定人' ,BindTime as '最新绑定时间' ,UnBindPerson as '最近解绑人',UnBindTime as '最近解绑时间' ,LoadingPerson as '上料人',
            LoadingTime as '上料时间' , LoadingQty as '上料时的数量	' ,UnLoadingPerson as '下料人' ,UnLoadingTime as '下料时间',UnLoadingQty as '下料时的数量' ,
            UseQty as '使用数量' , LastOperate  as '当前操作'   FROM [vwGetMaterialHistory] WHERE 1=1 ";
                    strSql = strSql + strSqlWhere + "order by OrderNO,FBILLNO,EquipmentCode,Position ";
                    DataTable tb = new DataTable();
                    tb = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, strSql, null);

                    if (tb != null)
                    {
                        ExportToSpreadsheet(tb, DateTime.Now.ToShortDateString());
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //if (Convert.ToDouble(e.Row.Cells[6].Text)< Convert.ToDouble(e.Row.Cells[7].Text))
                //{
                //    e.Row.BackColor = Color.FromName("red"); ;
                //}   

            }
        }

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
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode("SMT上料状态查询" + name, System.Text.Encoding.UTF8) + ".xls");
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

    }
}