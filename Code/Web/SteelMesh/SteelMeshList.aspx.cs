using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.SteelMesh.BLL;
using SKT.LeanMES.Web.AjaxServices;
using System.Data;
using System.Web;
using SKT.LeanMES.Equipment.Model;
using System.Collections.Generic;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Linq;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelMeshList : BasePage
    {
        private int columnIndex_StartInspectionDateTime = -1;
        private int columnIndex_InspectionDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_StartInspectionDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "StartInspectionDateTime")) + 1;
            columnIndex_InspectionDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "InspectionDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentId";
            this.Master.DefaultSortExpression = "EquipmentId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("EquipmentName", Server.HtmlEncode(this.txtSteelMeshName.Text));
            searchSettings.AddCondition("EquipmentCode", Server.HtmlEncode(this.txtSteelMeshCode.Text));
            searchSettings.AddCondition("PCBModel", Server.HtmlEncode(this.txtPCBModel.Text));
            if (ddlSteelStatus.SelectedValue != "-1")
            {
                searchSettings.AddCondition("EquipmentStatus", ddlSteelStatus.SelectedValue);
            }
            searchSettings.ExtensionCondition = " ParentTypeId in (-2,-3)";
            if (txtMainItemCode.Text.Trim() != "" && ddlLayout.SelectedValue != "-1")
            {
                searchSettings.ExtensionCondition += " AND EquipmentId IN (SELECT EquipmentId FROM Basal_SteelItem WHERE  Layout IN ('" + ddlLayout.SelectedValue + "') AND ItemId IN (SELECT ItemId FROM Basal_Item WHERE ItemCode='" + txtMainItemCode.Text.Trim().Replace("'", "''") + "' ))";

            }
            else
            {
                if (txtMainItemCode.Text.Trim() != "")
                {
                    searchSettings.ExtensionCondition += " AND EquipmentId IN (SELECT EquipmentId FROM Basal_SteelItem WHERE ItemId IN (SELECT ItemId FROM Basal_Item WHERE ItemCode='" + txtMainItemCode.Text.Trim().Replace("'", "''") + "' ))";
                }

                if (ddlLayout.SelectedValue != "-1")
                {
                    searchSettings.ExtensionCondition += " AND EquipmentId IN (SELECT EquipmentId FROM Basal_SteelItem WHERE Layout IN ('" + ddlLayout.SelectedValue + "'))";
                }
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.SteelMesh.BLL.SteelMesh bll = new SKT.LeanMES.SteelMesh.BLL.SteelMesh();
                        bll.DeleteNew(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message);
                    }
                }
                else if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    try
                    {
                        string sort = string.IsNullOrWhiteSpace(this.GridView1.SortExpression) ? " EquipmentId DESC " : this.GridView1.SortExpression;
                        if (!string.IsNullOrWhiteSpace(sort) && this.GridView1.SortDirection == SortDirection.Descending && !sort.EndsWith(" DESC"))
                        {
                            sort += " DESC";
                        }
                      var list =new SKT.LeanMES.Equipment.BLL.Equipments().GetAllNew(0, int.MaxValue, sort, searchSettings);
                        /*    DataTable tb = new DataTable();
                            String steelName = txtSteelMeshName.Text;
                            String steelCode = txtSteelMeshCode.Text;
                            tb = BindData(steelName, steelCode);
                            if (tb != null)
                            {
                                ExportToSpreadsheet(tb, DateTime.Now.ToShortDateString());
                            }*/
                        NPOIHelper.Export(list, this.GridView1, "钢网刮刀列表-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx");
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (Request.Form["hdnOperate"].ToLower() == "scrap")
                {
                    try
                    {
                        SKT.LeanMES.SteelMesh.BLL.SteelMesh bll = new SKT.LeanMES.SteelMesh.BLL.SteelMesh();
                        bll.ScrapNew(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.ScrapSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }

        }

        #region GridView行绑定
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                //if (e.Row.Cells[24].Text == "9999/12/31 0:00:00")
                //{
                //    e.Row.Cells[24].Text = "";
                //}
                //if (e.Row.Cells[25].Text == "9999/12/31 0:00:00")
                //{
                //    e.Row.Cells[25].Text = "";
                //}
                //by liwen 20210202 处理时间问题
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //14改为columnIndex_StartInspectionDateTime
                //15改为columnIndex_InspectionDateTime
                if (Convert.ToDateTime(e.Row.Cells[columnIndex_StartInspectionDateTime].Text).ToString("yyyy-MM-dd") == "9999-12-31")
                {
                    e.Row.Cells[columnIndex_StartInspectionDateTime].Text = "";
                }
                if (Convert.ToDateTime(e.Row.Cells[columnIndex_InspectionDateTime].Text).ToString("yyyy-MM-dd") == "9999-12-31")
                {
                    e.Row.Cells[columnIndex_InspectionDateTime].Text = "";
                }
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                EquipmentsInfo info = e.Row.DataItem as EquipmentsInfo;
                //if (info.InOrOut == 1)
                //{
                //    e.Row.Cells[15].Text = "已入库";
                //}
                //else
                //{
                //    e.Row.Cells[15].Text = "在产线";
                //}

                //if (info.IsClear == 1)
                //{
                //    e.Row.Cells[16].Text = "已清洗";
                //}
                //else
                //{
                //    e.Row.Cells[16].Text = "未清洗";
                //}
            }
        }
        #endregion

        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(String steelName, String steelCode)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            SKT.LeanMES.SteelMesh.BLL.SteelMesh bll = new SKT.LeanMES.SteelMesh.BLL.SteelMesh();
            tb = bll.ImportToExcel(steelName, steelCode);
            if (tb != null)
            {
                return tb;
            }
            else
            {
                return null;
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
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode("钢网-" + name, System.Text.Encoding.UTF8) + ".xls");
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
    }
}