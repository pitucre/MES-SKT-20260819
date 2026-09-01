using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Order.BLL;
using SKT.LeanMES.Order.Model;
using SKT.LeanMES.PubItems.BLL;
using SKT.LeanMES.PubItems.Model;

namespace SKT.LeanMES.Web.Production
{
    public partial class ShopOrderEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxBaseExt));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxProduct));
            int soId = Convert.ToInt32(Request.QueryString["ID"]);
            int BomId = Convert.ToInt32(hdnBomId.Value);
            int ChoosingFlag = Convert.ToInt32(ddlPrivacyBOM.SelectedValue);
            if (!IsPostBack)
            {
                BindShopOrderStatus();
                //int soId = Convert.ToInt32(Request.QueryString["ID"]);
                if (soId < -1 || soId > 0)
                {
                    ShopOrderInfo model = new ShopOrder().GetInfo(soId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
            else
            {
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    DataTable tb = new DataTable();
                    //initOrderBOM(soId.toString(), $("#hdnBomId").val(), $("#ddlPrivacyBOM").val());
                  
                    tb = BindData(soId, BomId, ChoosingFlag);
                    if (tb != null)
                    {
                        ExportExcel(tb, DateTime.Now.ToString("yyyyMMddHHmmss"));
                    }
                }
            }
            //生成可选工序
            SKT.Common.Model.SearchSettings searchSettingsB = new SKT.Common.Model.SearchSettings();
            //searchSettingsB.ExtensionCondition = "StationStatus >= 0 ";
            hfJSONStation.Value = (new SKT.LeanMES.PubItems.BLL.PubItems()).GetStationList("OrderID", soId.ToString());

        }

        private void BindShopOrderStatus()
        {

     
            SKT.Common.Model.SearchSettings searchSettingsB = new SKT.Common.Model.SearchSettings();
            searchSettingsB.AddCondition(" StatusFlag","1");
            searchSettingsB.ExtensionCondition=" statusid != -1";
            hfJSONOrderStatus.Value = (new SKT.LeanMES.PubItems.BLL.PubItems()).GetOrderStatus("", searchSettingsB);


            //this.ddlShopOrderStatus.DataSource = SKT.LeanMES.Web.Utility.EnumHelper.ParseEnumToList(typeof(EnumShopOrderStatus));
         
            //this.ddlShopOrderStatus.DataTextField = "text";
            //this.ddlShopOrderStatus.DataValueField = "value";
            //this.ddlShopOrderStatus.DataBind();
        }

        private ShopOrderInfo PageData
        {
            set
            {
                this.txtOrderNO.Text = value.OrderNO;
                this.ddlOrderType.SelectedValue = value.OrderType.ToString();
                //this.ddlShopOrderStatus.SelectedValue = value.Status.ToString();
                this.txtPriority.Text = value.Priority.ToString();
                this.hdnItemId.Value = value.ItemId.ToString();
                this.txtItemName.Text = value.ItemCode + " (" + value.ItemName + ")";
                this.hdnBomId.Value = value.BOMId.ToString();
                this.txtBOM.Text = value.BOMId == -1 ? value.BOMName : value.BOMName + " (" + value.BOMVer + ")";
                this.hdnRId.Value = value.RouterId.ToString();
                this.txtRouter.Text = value.R_Name;
                this.hdnCustomerId.Value = value.CustomerID.ToString();
                this.txtCustomer.Text = value.CustomerName;
                this.txtCustomerOrder.Text = value.CustomerOrder;
                this.txtCustomerOrderQty.Text = value.CustomerOrderQty == 0 ? "" : value.CustomerOrderQty.ToString();
                this.txtQty_to_Build.Text = value.Qty_to_Build.ToString();
                this.txtPlanned_Start_Time.Text = formatDatetimeString(value.Planned_Start_Time);
                this.txtPlanned_Completed_Date.Text = formatDatetimeString(value.Planned_Completed_Date);
                this.ddlPrivacyBOM.SelectedValue = value.PrivacyBOMFlag.ToString();
                this.ddlOpePParam.SelectedValue = value.PrivacyOpeParam.ToString();
                this.ddlItemPParam.SelectedValue = value.PrivacyItemParam.ToString();
                this.txtMaskID.Value = value.MaskId.ToString();
                this.txtMask.Text = value.MaskGroupName;
                this.txtBomVersion.Text = value.BomVersion;
                this.hdStatus.Value = value.Status.ToString();
                this.hdQtyReleased.Value = value.Qty_Released.ToString();

                //Modify By zhiman.yuan 2017-4-19 允许用户释放后修改工单BOM信息，注释其他不能修改的信息
                if (value.Qty_Released > 0)
                {
                    txtOrderNO.Enabled = false;
                    ddlOrderType.Enabled = false;
                    txtPriority.Enabled = false;
                    btnSelectItem.Disabled = true;
                    txtQty_to_Build.Enabled = false;
                    //ddlShopOrderStatus.Enabled = false;
                    btnSelectBom.Disabled = true;
                    btnSelectRouter.Disabled = true;
                    txtPriority.Enabled = false;
                    txtCustomer.Enabled = false;
                    btnSelectCustomer.Disabled = true;
                    txtCustomerOrder.Enabled = false;
                    txtCustomerOrderQty.Enabled = false;
                    txtPlanned_Start_Time.CssClass = "TextBox";
                    txtPlanned_Completed_Date.CssClass = "TextBox";
                    txtPlanned_Start_Time.Enabled = false;
                    txtPlanned_Completed_Date.Enabled = false;
                }
            }
        }

        private string formatDatetimeString(DateTime date)
        {
            string datestring = date.ToString("yyyy-MM-dd");
            return Convert.ToDateTime(datestring).Year.Equals(9999) ? "" : datestring;
        }

        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(int OrderID, int BomID, int ChoosingFlag)
        {
            System.Data.DataTable tb = new System.Data.DataTable();

            SKT.LeanMES.Product.BLL.OrderBom bll = new SKT.LeanMES.Product.BLL.OrderBom();
            tb = bll.ImportToExcel(OrderID,BomID,ChoosingFlag);
            if (tb != null)
            {
                return tb;
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 导出Excel 
        /// </summary>
        /// <param name="table"></param>
        /// <param name="name"></param>
        public static void ExportExcel(DataTable table, string name)
        {
            HttpContext context = HttpContext.Current;
            var book = new NPOI.HSSF.UserModel.HSSFWorkbook();

            //添加一个sheet
            var sheet1 = book.CreateSheet("工单BOM列表");
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
    }
}