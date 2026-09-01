using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseCpOutStockView : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCpOutStock));
            Master.PageGridView = GridView1;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "SalOrderID";
            Master.DefaultSortExpression = "SalOrderID DESC,SalOrderDtlID"; //也可不赋值
            string str = "";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("DNCode", this.DNCode.Text.Trim());
            if (!string.IsNullOrEmpty(txtCustomerOrder.Text))
            {
                searchSettings.AddCondition("CustomerOrder", txtCustomerOrder.Text);
            }
            if (!string.IsNullOrEmpty(txtSalOrderNo.Text))
            {
                searchSettings.AddCondition("SalOrderNo", txtSalOrderNo.Text);
            }
            if (!string.IsNullOrEmpty(txtsup.Text))
            {
                searchSettings.AddCondition("CusCode", txtsup.Text);
            }
            if (!string.IsNullOrEmpty(txtmat.Text))
            {
                searchSettings.AddCondition("ItemCode", txtmat.Text);
            }
            if (ddlStatus.SelectedValue != "-1")
            {
                searchSettings.AddCondition("Status", ddlStatus.SelectedValue);
            }
            if (!string.IsNullOrEmpty(txtStrDate.Value.Trim()) && string.IsNullOrEmpty(txtEndDate.Value.Trim()))
            {
                searchSettings.ExtensionCondition = " CreateDateTime >" + txtStrDate.Value.Trim();
            }
            if (string.IsNullOrEmpty(txtStrDate.Value.Trim()) && !string.IsNullOrEmpty(txtEndDate.Value.Trim()))
            {
                searchSettings.ExtensionCondition = " CreateDateTime <" + txtStrDate.Value.Trim();
            }
            if (!string.IsNullOrEmpty(txtStrDate.Value.Trim()) && !string.IsNullOrEmpty(txtEndDate.Value.Trim()))
            {
                string sd = txtStrDate.Value.Trim();
                string ed = txtEndDate.Value.Trim() + " 23:59:59";
                if (Convert.ToDateTime(ed).CompareTo(Convert.ToDateTime(sd)) < 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('结束时间不能小于开始时间')</script>");
                    return;
                }
                searchSettings.ExtensionCondition = " CreateDateTime  between '" + sd + "'  and  '" + ed + "'";
            }
            Master.SearchSettings = searchSettings;
            GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                try
                {
                    SKT.LeanMES.Warehouse.BLL.WarehouseCpOutStock bll = new SKT.LeanMES.Warehouse.BLL.WarehouseCpOutStock();
                    if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {

                      
                        bll.DeleteStockOrder(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);

                    }//导出出货明细excle
                    else if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                    {
                        var id = Request.Form["hdnIdString"].ToString();

                        DataTable dt = bll.GetSalOrderDtlMemberListExcle(int.Parse(id));
                       
                        CommonMethod.ExportToSpreadsheet(dt, "出货明细列表" + DateTime.Now.ToString("yyyyMMddhhmmss"));
                    }
                    else if(Request.Form["hdnOperate"].ToLower() == "syncshipdata")
                    {
                        SKT.LeanMES.Material.BLL.ERPShipData eRPShipData = new LeanMES.Material.BLL.ERPShipData();
                        string res=eRPShipData.GetU9CShipData();
                        if(res=="OK")
                        {
                            WebHelper.ShowMessage("同步成功！");
                        }
                        else
                        {
                            WebHelper.ShowMessage(res);
                        }
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.ShowMessage(ex.Message);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //16改为columnIndex_ModifyBy
                //17改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) )
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}