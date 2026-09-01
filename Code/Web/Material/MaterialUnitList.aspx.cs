using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialUnitList : BasePage
    {
        private int columnIndex_MPN = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_MPN = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "MPN")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MaterialUnit));


            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MaterialUnitId";
            this.Master.DefaultSortExpression = "MaterialUnitId DESC";
            txtSerialNumber.Focus();
            string staus = this.ddlMaterialStatus.SelectedValue;
            string search = this.ddlSearch.SelectedValue;
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (!IsPostBack)
            {
                this.txtDateFrom.Value = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
                this.txtDateTo.Value = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd hh:mm:ss");
                searchSettings.ExtensionCondition = " A.MaterialUnitId = -1 ";
            }
            else
            {
                searchSettings.ExtensionCondition = " A.Flag = -1 ";
            }
            if (this.txtSerialNumber.Value.Trim() != "")
            {
                //searchSettings.AddCondition("A.SerialNumber", this.txtSerialNumber.Value.Trim());
                searchSettings.ExtensionCondition += " and a.SerialNumber like '%" + this.txtSerialNumber.Value.Trim() + "%'";
            }
            if (this.txtBoxGRN.Value.Trim() != "")
            {
                //searchSettings.AddCondition("A.SerialNumber", this.txtSerialNumber.Value.Trim());
                searchSettings.ExtensionCondition += " and PMP.SerialNumber like '%" + this.txtBoxGRN.Value.Trim() + "%'";
            }


            
            //if (this.txtItemCode.Value.Trim() != "")
            //{
            //    searchSettings.AddCondition("B.ItemCode", this.txtItemCode.Value.Trim());
            //}               
            if (this.txtVendor.Value.Trim() != "")
            {
                //searchSettings.AddCondition("A.VendorCode", this.txtVendor.Value.Trim());
                searchSettings.ExtensionCondition += " and A.VendorCode like '%" + this.txtVendor.Value.Trim() + "%'";
            }
            if (this.txtItemName.Value.Trim() != "")
            {
                //searchSettings.AddCondition("B.ItemName", this.txtItemName.Value.Trim());
                searchSettings.ExtensionCondition += " and B.ItemName like '%" + this.txtItemName.Value.Trim() + "%'";
            }

            if (this.txtItemCode.Value.Trim() != "")
            {
                //searchSettings.AddCondition("B.ItemName", this.txtItemName.Value.Trim());
                searchSettings.ExtensionCondition += " and B.ItemCode like '%" + this.txtItemCode.Value.Trim() + "%'";
            }

            if (this.txtItemSpec.Value.Trim() != "")
            {
                //searchSettings.AddCondition("B.ItemName", this.txtItemName.Value.Trim());
                searchSettings.ExtensionCondition += " and B.ItemModel like '%" + this.txtItemSpec.Value.Trim() + "%'";
            }
           

            if (this.txtLotCode.Value.Trim() != "")
            {
                //searchSettings.AddCondition("A.LotCode", this.txtLotCode.Value.Trim());
                searchSettings.ExtensionCondition += " and A.LotCode like '%" + this.txtLotCode.Value.Trim() + "%'";
            }
            //if (this.txtBarCode.Value.Trim() != "")
            //{
            //    searchSettings.AddCondition("A.cBarCode", this.txtBarCode.Value.Trim());
            //}

            if (search != "-1")
            {
                searchSettings.ExtensionCondition += "and " + search + " like '%" + this.txtSearch.Value.Trim() + "%'";
                //searchSettings.AddCondition(search, this.txtSearch.Value.Trim());
            }
            int warehouseId = -1;
            if (hdnWhID.Value == "")
            {
                warehouseId = -1;
            }
            else
            {
                warehouseId = Convert.ToInt32(hdnWhID.Value);
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
            if (staus != "-2" && !string.IsNullOrEmpty(staus))
            {
                searchSettings.ExtensionCondition += " and A.[Status] =" + Convert.ToInt32(staus) + "";
            }
            if (warehouseId != -1)
            {
                searchSettings.ExtensionCondition += " and A.[WarehouseId] =" + Convert.ToInt32(warehouseId) + "";
            }
            if (txtDateFrom != "" && txtDateTo == "")
            {
                if (!DateTime.TryParse(txtDateFrom, out tmFrom))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " and ( A.CreateDateTime > '" + Convert.ToDateTime(dateFrom).ToString("yyyy-MM-dd") + "')";//开始时间不需要加1
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
                    searchSettings.ExtensionCondition += " and (A.CreateDateTime <= '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd") + "')";
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
                    searchSettings.ExtensionCondition += " and ( a.CreateDateTime >= '" + Convert.ToDateTime(dateFrom).ToString("yyyy-MM-dd") + "'  and  a.CreateDateTime < '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd") + "') ";
                }
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (!IsPostBack)
            {
                bindDropMaterialStatus();
            }
            else
            {
                //导出
                if (Request["hdnOperate"].ToLower() == "exportexcel")
                {
                    SKT.LeanMES.Material.BLL.MaterialUnit bll = new LeanMES.Material.BLL.MaterialUnit();
                    if (txtDateTo == "" && txtDateFrom == "" && searchSettings.Conditions.Count == 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请选择对应的日期导出！')</script>");
                        return;
                    }
                    var lists = bll.GetMaterialInfoAll(0, -1, "MaterialUnitId DESC", searchSettings);

                    var list2 = lists.Select(k => new
                    {
                        k.SerialNumber,
                        k.POorder,
                        k.SOCode,
                        k.ApplyNo,
                        k.IqcBatchNo,
                        k.ItemCode,
                        k.ItemName,
                        k.ItemModel,
                        k.ShelfLife,
                        k.VendorCode,
                        k.LotCode,
                        k.CBarCode,
                        k.CWhName,
                        k.Quantity,
                        k.BalanceQty,
                        k.WOStatus,
                        k.CreateBy,
                        CreateDateTime = String.Format("{0:yyyy-MM-dd HH:mm:ss}", k.CreateDateTime),
                        k.PackTime,
                        DateCode = String.Format("{0:yyyy-MM-dd}", k.DateCode),
                        k.MPN,
                        k.WeekCode,
                        ExpiredDate = k.ExpiredDate.ToString().IndexOf("9999") > -1 ? "" : String.Format("{0:yyyy-MM-dd HH:mm:ss}", k.ExpiredDate),
                        k.SupplierOrderNumber
                    }).OrderByDescending(q => q.CreateDateTime).ThenByDescending(q => q.SerialNumber);

                    DataTable tb = CommonHelper.BLL.ComMethod.ConvertToDataTable(list2.ToList());
                    tb.Columns[0].ColumnName = "物料条码";
                    tb.Columns[1].ColumnName = "采购单号";
                    tb.Columns[2].ColumnName = "订单号";
                    tb.Columns[3].ColumnName = "领料单号";
                    tb.Columns[4].ColumnName = "IQC单号";
                    tb.Columns[5].ColumnName = "产品编码";
                    tb.Columns[6].ColumnName = "产品名称";
                    tb.Columns[7].ColumnName = "产品规格";
                    tb.Columns[8].ColumnName = "质保期(天)";
                    tb.Columns[9].ColumnName = "供应商";
                    tb.Columns[10].ColumnName = "批次号";
                    tb.Columns[11].ColumnName = "库位条码";
                    tb.Columns[12].ColumnName = "仓库";
                    tb.Columns[13].ColumnName = "最初数量";
                    tb.Columns[14].ColumnName = "可用数量";
                    tb.Columns[15].ColumnName = "状态";
                    tb.Columns[16].ColumnName = "创建人";
                    tb.Columns[17].ColumnName = "生成物料条码时间";
                    tb.Columns[18].ColumnName = "入库时间";
                    tb.Columns[19].ColumnName = "生产日期";
                    tb.Columns[20].ColumnName = "MPN";
                    tb.Columns[21].ColumnName = "生产日期(周)";
                    tb.Columns[22].ColumnName = "过期日期";
                    tb.Columns[23].ColumnName = "工单号";
                    if (tb != null)
                    {
                        ExportToSpreadsheet(tb, "物料信息" + DateTime.Now.ToShortDateString());
                    }
                }
            }
        }

        public void bindDropMaterialStatus()
        {

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            List<SKT.LeanMES.Material.Model.MaterialUnitInfo> materialUnit = new SKT.LeanMES.Material.BLL.MaterialUnit().GetMaterialAllStatus(0, -1, "", searchSettings);
            ddlMaterialStatus.DataSource = materialUnit;
            ddlMaterialStatus.DataTextField = "MaterialStatus";
            ddlMaterialStatus.DataValueField = "StatusId";
            ddlMaterialStatus.DataBind();
            this.ddlMaterialStatus.Items.Insert(0, new ListItem(Resources.lang.Choose, "-2"));
        }

        #region  DataTable导出到Excel

        public static void ExportToSpreadsheet(DataTable table, string name)
        {
            var r = new Random();
            var rf = "";
            for (var j = 0; j < 10; j++)
            {
                rf = r.Next(int.MaxValue).ToString();
            }

            var context = HttpContext.Current;
            context.Response.Clear();
            context.Response.ContentType = "text/csv";
            context.Response.ContentEncoding = Encoding.UTF8;
            context.Response.AppendHeader("Content-Disposition",
                "attachment; filename=" + HttpUtility.UrlEncode(name) + ".xls");
            context.Response.HeaderEncoding = Encoding.UTF8;
            context.Response.BinaryWrite(Encoding.UTF8.GetPreamble());

            foreach (DataColumn column in table.Columns)
            {
                context.Response.Write(column.ColumnName + ",");
                //context.Response.Write(column.ColumnName + "(" + column.DataType + "),");   
            }

            context.Response.Write(Environment.NewLine);
            double test; DateTime dtTest;

            foreach (DataRow row in table.Rows)
            {
                for (var i = 0; i < table.Columns.Count; i++)
                {

                    if (double.TryParse(row[i].ToString(), out test))
                    {
                        context.Response.Write("=");
                        context.Response.Write("\"" + row[i].ToString() + "\",");
                    }
                    else if (DateTime.TryParse(row[i].ToString(), out dtTest))
                    {
                        //context.Response.Write("\"" + Convert.ToDateTime(row[i]).ToString("yyyy-MM-dd") + "\",");
                        context.Response.Write("=\"" + row[i].ToString() + "\",");
                    }
                    else
                    {
                        context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                    }
                }
                context.Response.Write(Environment.NewLine);
            }

            context.Response.End();
        }

        #endregion

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //22改为columnIndex_MPN

                if (e.Row.Cells[columnIndex_MPN].Text == "9999/12/31 0:00:00" || e.Row.Cells[columnIndex_MPN].Text == "0001/1/1 0:00:00")
                {
                    e.Row.Cells[columnIndex_MPN].Text = "";
                }
            }
        }
    }
}