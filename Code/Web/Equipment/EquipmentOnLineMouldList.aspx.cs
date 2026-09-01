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
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentOnLineMouldList : BasePage
    {
        private int columnIndex_CreateBy = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_CreateBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "CreateBy")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MoldFixtureUpLineId";
            this.Master.DefaultSortExpression = "MoldFixtureUpLineId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition(" EquipmentCode", Server.HtmlEncode(this.txtEquipmentCode.Text));
            searchSettings.AddCondition(" EquipmentName", Server.HtmlEncode(this.txtEquipmentName.Text));
            searchSettings.AddCondition(" MoudleCode", Server.HtmlEncode(this.txtMouldCode.Text));
            searchSettings.AddCondition(" MoudleName", Server.HtmlEncode(this.txtMouldName.Text));
            //searchSettings.AddCondition(" EquipmentTypeName", Server.HtmlEncode(this.txtEquipmentTypeName.Text));

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        MoludBom bll = new MoludBom();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
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

        #endregion

        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(String code, String name,int status)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            SKT.LeanMES.Equipment.BLL.Equipments bll = new SKT.LeanMES.Equipment.BLL.Equipments();
            tb = bll.ImportToExcel(code, name,status);

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
            SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //获取处理人
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_CreateBy
                string userName = e.Row.Cells[columnIndex_CreateBy].Text;
                if (!string.IsNullOrEmpty(userName))
                {
                    MembershipInfo userInfo = user.GetInfo(userName);
                    e.Row.Cells[columnIndex_CreateBy].Text = (userInfo == null) ? "" : userInfo.EmployeeCName;
                }
            }
        }
    }
}