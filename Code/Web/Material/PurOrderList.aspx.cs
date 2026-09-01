using SKT.Common.Account.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class PurOrderList :BasePage
    {
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PurOrderId";
            this.Master.DefaultSortExpression = "PurOrderId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (txtPOCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("POCode", txtPOCode.Text.Trim());
            }
            //if (txtProjectNo.Text.Trim() != "")
            //{
            //    searchSettings.AddCondition("ProjectNo", txtProjectNo.Text.Trim());
            //}
            if (txtVendorName.Value.Trim() != "")
            {
                searchSettings.AddCondition("VendorName", txtVendorName.Value.Trim());
            }
            searchSettings.AddCondition("POTypeName", selPoType.SelectedValue.Trim());
            searchSettings.AddCondition("ReceiveType", selReceiveType.SelectedValue.Trim());
            searchSettings.AddCondition("SupplierDelivery", ddlSupplierDelivery.SelectedValue.Trim());

            if(txtUserName.Text.Trim() != "")
            {
                searchSettings.AddCondition("CreateByCName", txtUserName.Text.Trim());
            }



                searchSettings.ExtensionCondition += " 1=1 ";
            if (ddlIsMesAdd.SelectedValue != "-1")
            {
                searchSettings.ExtensionCondition += " and IsMesAdd=" + ddlIsMesAdd.SelectedValue;
            }
            if (ddlOpenDataStatus.SelectedValue.Trim() != "")
            {
                searchSettings.ExtensionCondition += " and OpenDataStatus=" + ddlOpenDataStatus.SelectedValue.Trim();
            }
            if (AccountController.GetCurrentUser().UserType!=-1) {
                searchSettings.ExtensionCondition += " and VenID=" + AccountController.GetCurrentUser().UserType;
            }
            string txtDateFrom = this.txtDateFrom.Value.Trim();
            string txtDateTo = this.txtDateTo.Value.Trim();
            string dateFrom = "";
            string dateTo = "";
            dateFrom = txtDateFrom;
            dateTo = txtDateTo;
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
                    searchSettings.ExtensionCondition += " and ( OrderDate > '" + Convert.ToDateTime(dateFrom).AddDays(-1) + "')";
                }
            }
            else if (txtDateTo != "" && txtDateFrom == "")
            {
                if (!DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " and (OrderDate <= '" + Convert.ToDateTime(dateTo).AddDays(1) + "')";
                }
            }
            else if (txtDateFrom != "" && txtDateTo != "")
            {
                //判断日期
                if (!DateTime.TryParse(txtDateFrom, out tmFrom) || !DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " and ( OrderDate >= '" + Convert.ToDateTime(dateFrom) + "'  and  OrderDate < '" + Convert.ToDateTime(dateTo).AddDays(1) + "') ";
                }
            }
            
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Material.BLL.PurOrder bll = new SKT.LeanMES.Material.BLL.PurOrder();
                    try
                    {
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                    
                }
            }

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //12改为columnIndex_ModifyDateTime
                if (e.Row.Cells[columnIndex_ModifyDateTime].Text == "9999-12-31 00:00:00")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}