using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.PubItems.BLL;
using ExcelHelper = SKT.LeanMES.Web.AppCode.Utility.ExcelHelper;


namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialApplyDetailView : BasePage
    {
        private int columnIndex_UseDateTime = -1;
        private int columnIndex_StatueDesc = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime= -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_UseDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UseDateTime")) + 1;
            columnIndex_StatueDesc = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "StatueDesc")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ApplyId";
            this.Master.DefaultSortExpression = "UseDateTime";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ApplyNO", txtApplyNO.Text.Trim());
            searchSettings.AddCondition("DepName", txtDepName.Text.Trim());
            searchSettings.AddCondition("WhName", txtWhName.Text.Trim());
            searchSettings.AddCondition("SrcOrderType", ddlSrcType.SelectedValue);
            searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());
            searchSettings.ExtensionCondition = " 1=1 ";
            if (ddlType.SelectedValue != "")
            {
                searchSettings.ExtensionCondition += " AND ApplyType= " + ddlType.SelectedValue;
            }

            if (ddlState.SelectedValue != "")
            {
                searchSettings.ExtensionCondition += " AND Statue= " + ddlState.SelectedValue;
            }
            else
            {
                searchSettings.ExtensionCondition += " AND Statue!= -1";
            }
            if (txtMOCode.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += " AND MOCode like '%" + txtMOCode.Text.Trim() + "%' ";
            }
            string txtDateFrom = this.txtDateFrom.Value.Trim();
            string txtDateTo = this.txtDateTo.Value.Trim();
            string dateFrom = "";
            string dateTo = "";
            dateFrom = txtDateFrom;
            dateTo = txtDateTo;
            this.txtDateFrom.Value = dateFrom;
            this.txtDateTo.Value = dateTo;
            DateTime tmFrom;
            DateTime tmTo;
            if (txtDateFrom != "" && txtDateTo == "")
            {
                if (!DateTime.TryParse(txtDateFrom, out tmFrom))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " and ( UseDateTime > '" + Convert.ToDateTime(dateFrom).ToString("yyyy-MM-dd") + "')";//开始时间不需要加1
                }
            }
            if (txtDateTo != "" && txtDateFrom == "")
            {
                if (!DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " and (UseDateTime <= '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd") + "')";
                }
            }
            if (txtDateFrom != "" && txtDateTo != "")
            {
                //判断日期
                if (!DateTime.TryParse(txtDateFrom, out tmFrom) || !DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " and ( UseDateTime >= '" + Convert.ToDateTime(dateFrom).ToString("yyyy-MM-dd") + "'  and  UseDateTime < '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd") + "') ";
                }
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    try
                    {
                        SKT.LeanMES.Material.BLL.Apply bll = new LeanMES.Material.BLL.Apply() ;
                        DataTable dt = bll.GetApplyDetailExportView(1,int.MaxValue, " ModifyDateTime ", searchSettings);
                        string filename = "仓库备料出库列表";
                        ExcelHelper.ExportToExcel(dt, filename + DateTime.Now.ToString("yyyyMMdd") + ".xls", "UTF-8");
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
        }
        DateTime minDate = DateTime.MinValue.AddYears(1);
        DateTime maxDate = DateTime.MaxValue.AddYears(-1);
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                try
                {
                    //xiang.yan 2024-4-23 cells取值改为根据列名获取
                    //15改为columnIndex_UseDateTime
                    //16改为columnIndex_StatueDesc
                    //17改为columnIndex_ModifyBy
                    //18改为columnIndex_ModifyDateTime

                    DateTime dt = DateTime.Parse(e.Row.Cells[columnIndex_UseDateTime].Text.Trim());
                    if (dt > maxDate || dt < minDate)
                    {
                        e.Row.Cells[columnIndex_UseDateTime].Text = "";
                    }
                    else
                    {
                        e.Row.Cells[columnIndex_UseDateTime].Text = dt.ToString("yyyy-MM-dd");
                    }

                    if (e.Row.Cells[columnIndex_StatueDesc].Text != "已接收")
                    {
                        e.Row.Cells[columnIndex_ModifyBy].Text = "";
                        e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
                    }
                }
                catch { }
            }
        }
    }
}