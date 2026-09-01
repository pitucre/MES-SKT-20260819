using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

namespace SKT.LeanMES.Web.SuplyMaterial
{
    public partial class SupplierDeliveryList : BasePage
    {
        private int columnIndex_ItemQty = -1;
        private int columnIndex_FinishQty = -1;
        private int columnIndex_UnpaidQyt = -1;
        private int columnIndex_UnpaidStatus = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ItemQty = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ItemQty")) + 1;
            columnIndex_FinishQty = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "FinishQty")) + 1;
            columnIndex_UnpaidQyt = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UnpaidQyt")) + 1;
            columnIndex_UnpaidStatus = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UnpaidStatus")) + 1;


            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SupplierDeliveryId";
            this.Master.DefaultSortExpression = "SupplierDeliveryId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            searchSettings.ExtensionCondition += " 1=1  ";

            //采购单号
            searchSettings.AddCondition("POCode", this.txtpOCode.Text);

            //物料编码/名称/规格
            if (this.txtItem.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += string.Format(" and  (ItemCode like '%{0}%' or  ItemName  like '%{1}%'  or  ItemDescription   like '%{2}%' )  ", this.txtItem.Text.Trim(), this.txtItem.Text.Trim(), this.txtItem.Text.Trim());
            }
            //供应商编码/名称
            if (this.txtSuplier.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += string.Format(" and  (SuplierCode like '%{0}%' or  VendorName  like '%{1}%')  ", this.txtSuplier.Text.Trim(), this.txtSuplier.Text.Trim());
            }
            //交货状态
            if (this.ddlUnpaid.SelectedValue!= "")
            {
                if(this.ddlUnpaid.SelectedValue == "未完成")
                {
                    searchSettings.ExtensionCondition += "  and   UnpaidQyt>0  ";
                }
                else
                {
                    searchSettings.ExtensionCondition += "  and   UnpaidQyt<=0   ";
                }
            }



            if (AccountController.GetCurrentUser().UserType != -1)
            {
                //如果是供应商角色，只能查看自己的记录
                searchSettings.ExtensionCondition += " AND SupplierId  = "+ AccountController.GetCurrentUser().UserType.ToString() + " ";
            }
          

            //出货日期
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
          
            if (txtDateFrom != "" && txtDateTo != "")
            {
                //判断日期
                if (!DateTime.TryParse(txtDateFrom, out tmFrom) || !DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " AND PlanDateTime BETWEEN '" + dateFrom + "' AND '" + dateTo + "' ";
                    //searchSettings.ExtensionCondition += " AND PlanDateTime BETWEEN '" + dateFrom + "' AND '" + dateTo + "' ";
                }
            }
            else
            {
                if (txtDateFrom != "" && txtDateTo == "")
                {
                    if (!DateTime.TryParse(txtDateFrom, out tmFrom))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += " AND ( PlanDateTime >= '" + dateFrom + "')";
                        //searchSettings.ExtensionCondition += " AND ( PlanDateTime >= '" + dateFrom + "')";
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
                        searchSettings.ExtensionCondition += " AND (PlanDateTime <= '" + dateTo + "')";
                        //searchSettings.ExtensionCondition += "AND (PlanDateTime <= '" + dateTo + "')";
                    }
                }
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Supplier.BLL.SupplierDelivery bll = new SKT.LeanMES.Supplier.BLL.SupplierDelivery();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
                //导出
                if (Request["hdnOperate"].ToLower() == "exportexcel")
                {
                    string strWhere = " 1=1 ";
                    var tb = new DataTable();
                    strWhere += " AND POCode LIKE '%" + this.txtpOCode.Text + "%' ";
                    strWhere += string.Format(" and  (ItemCode like '%{0}%' or  ItemName  like '%{1}%'  or  ItemDescription   like '%{2}%' )  ", this.txtItem.Text.Trim(), this.txtItem.Text.Trim(), this.txtItem.Text.Trim());
                    strWhere += string.Format(" and  (SuplierCode like '%{0}%' or  VendorName  like '%{1}%')  ", this.txtSuplier.Text.Trim(), this.txtSuplier.Text.Trim());
                    if (this.ddlUnpaid.SelectedValue != "")
                    {
                        if (this.ddlUnpaid.SelectedValue == "未完成")
                        {
                            strWhere += "  and   UnpaidQyt>0  ";
                        }
                        else
                        {
                            strWhere += "  and   UnpaidQyt<=0   ";
                        }
                    }
                    if (AccountController.GetCurrentUser().UserType != -1)
                    {
                        //如果是供应商角色，只能查看自己的记录
                        strWhere += " AND SupplierId =" + AccountController.GetCurrentUser().UserType.ToString();
                    }
                    SKT.LeanMES.Supplier.BLL.SupplierDelivery bll = new SKT.LeanMES.Supplier.BLL.SupplierDelivery();
                    tb = bll.GetSupplierDeliveryDataTable(strWhere);
                    if (tb != null)
                    {
                        ExportToSpreadsheet(tb, "供应商交期维护" + DateTime.Now.ToShortDateString());
                    }
                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                try
                {
                    //xiang.yan 2024-4-24 cells取值改为根据列名获取
                    //8改为columnIndex_ItemQty
                    //9改为columnIndex_FinishQty
                    string finishQty = e.Row.Cells[columnIndex_FinishQty].Text;
                    string ItemQty = e.Row.Cells[columnIndex_ItemQty].Text;
                    decimal UnpaidQty = decimal.Parse(ItemQty) - decimal.Parse(finishQty);
                    string UnpaidQtyss = UnpaidQty.ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
                    //xiang.yan 2024-4-24 cells取值改为根据列名获取
                    //10改为columnIndex_UnpaidQyt
                    e.Row.Cells[columnIndex_UnpaidQyt].Text = UnpaidQty < 0 ? "0" : UnpaidQtyss;

                    //数量显示，去掉未位0
                    e.Row.Cells[columnIndex_FinishQty].Text = e.Row.Cells[columnIndex_FinishQty].Text.ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
                    e.Row.Cells[columnIndex_ItemQty].Text = e.Row.Cells[columnIndex_ItemQty].Text.ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });

                    //xiang.yan 2024-4-24 cells取值改为根据列名获取
                    //11改为columnIndex_UnpaidStatus
                    if (UnpaidQty <= 0)
                    {
                        e.Row.Cells[columnIndex_UnpaidStatus].Text = "已完成";
                    }
                    else
                    {
                        e.Row.Cells[columnIndex_UnpaidStatus].Text = "未完成";
                    }
                }
                catch { }
            }
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
            double test;

            foreach (DataRow row in table.Rows)
            {
                for (var i = 0; i < table.Columns.Count; i++)
                {
                    if (i != 11)
                    {
                        if (double.TryParse(row[i].ToString(), out test)) context.Response.Write("=");
                        //context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                        context.Response.Write("\"" + row[i].ToString() + "\",");
                    }
                    else
                    {
                        if (row[i].ToString() != "")
                            context.Response.Write("\"" + Convert.ToDateTime(row[i]).ToString("yyyy-MM-dd") +
                                                   "\",");
                        else
                            context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                    }
                }
                context.Response.Write(Environment.NewLine);
            }

            context.Response.End();
        }

        #endregion
    }
}