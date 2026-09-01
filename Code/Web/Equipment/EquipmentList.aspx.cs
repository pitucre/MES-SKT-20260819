using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;
using System.Data;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentId";
            this.Master.DefaultSortExpression = "CreateDateTime DESC";
            this.Master.DefaultSortDirection = SortDirection.Ascending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("EquipmentCode", Server.HtmlEncode(this.txtEquipmentCode.Text));
            searchSettings.AddCondition("EquipmentName", Server.HtmlEncode(this.txtEquipmentName.Text));
            searchSettings.AddCondition("EquipmentTypeName", Server.HtmlEncode(this.txtEquimentType.Text));
            searchSettings.AddCondition("LineName", Server.HtmlEncode(this.txtlineName.Text));
            if (ddlEquipmentStatus.SelectedValue != "-1")
            {
                searchSettings.AddCondition("EquipmentStatus", Server.HtmlEncode(this.ddlEquipmentStatus.Text));
            }
            searchSettings.ExtensionCondition = " EquipmentTypeId NOT IN (-2,-3,-4)";
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        Equipments bll = new Equipments();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    DataTable tb = new DataTable();
                    String equipmentCode = txtEquipmentCode.Text;
                    String equipmentName = txtEquipmentName.Text;
                    int equipStatus = -1;
                    if (ddlEquipmentStatus.SelectedValue != "-1")
                    {
                        equipStatus = Convert.ToInt32(ddlEquipmentStatus.SelectedValue);
                    }
                    tb = BindData(equipmentCode, equipmentName, equipStatus);
                    if (tb != null)
                    {
                        ExportExcel(tb, DateTime.Now.ToString("yyyyMMddHHmmss"));
                        // ExportToSpreadsheet(tb, DateTime.Now.ToShortDateString());
                    }
                }
                if (Request.Form["hdnOperate"].ToLower() == "scrap")
                {
                    try
                    {
                        SKT.LeanMES.SteelMesh.BLL.SteelMesh bll = new SKT.LeanMES.SteelMesh.BLL.SteelMesh();
                        bll.Scrap(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.ScrapSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message);
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

            context.Response.ContentType = "application/vnd.ms-excel";
            context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");
            context.Response.HeaderEncoding = System.Text.Encoding.GetEncoding("gb2312");

            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + name + ".xls");
            context.Response.BinaryWrite(System.Text.Encoding.GetEncoding("gb2312").GetPreamble());

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
            var sheet1 = book.CreateSheet("设备列表");
            //给sheet1添加第一行的头部标题
            var row1 = sheet1.CreateRow(0);
            int rowId = 0;
            foreach (DataColumn column in table.Columns)
            {
                if (column.ColumnName != "pid" && column.ColumnName != "生产日期")
                {
                    row1.CreateCell(rowId).SetCellValue(column.ColumnName);
                    
                }
                rowId++;

            }

            //创建值
            for (var i = 0; i < table.Rows.Count; i++)
            {
                var rowId2 = 0;
                NPOI.SS.UserModel.IRow rowtemp = sheet1.CreateRow(i + 1);
                foreach (DataColumn column in table.Columns)
                {
                    if (column.ColumnName != "pid" && column.ColumnName != "生产日期")
                    {
                        if (column.ColumnName == "入厂日期" || column.ColumnName == "创建时间" || column.ColumnName == "过保日期")
                        {
                            rowtemp.CreateCell(rowId2).SetCellValue(Convert.ToDateTime(table.Rows[i][rowId2]).ToString("yyyy-MM-dd"));
                        }
                        else
                        {
                            rowtemp.CreateCell(rowId2).SetCellValue(table.Rows[i][rowId2].ToString());
                        }                        
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

        #endregion

        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(String code, String name, int status)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            SKT.LeanMES.Equipment.BLL.Equipments bll = new SKT.LeanMES.Equipment.BLL.Equipments();
            tb = bll.ImportToExcel(code, name, status);

            if (tb != null)
            {
                return tb;
            }
            else
            {
                return null;
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //12改为columnIndex_ModifyBy
                //13改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}