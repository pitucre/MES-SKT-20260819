using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialReceiptPrint : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = ""; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            string txtSerialNumber = this.txtSerialNumber.Value.Trim();
            string txtFBillNO = this.txtFBillNO.Value.Trim();
            string txtVendorCode = this.txtVendorCode.Value.Trim();

            string strWhere = "";
            /*按收货单*/
            if (!string.IsNullOrEmpty(txtSerialNumber))
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " SerialNumber like '%" + txtSerialNumber + "%'" : " and  SerialNumber like '%" + txtSerialNumber + "%'";
            }
            //按采购订单查询
            if (!string.IsNullOrEmpty(txtFBillNO))
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " FBillNO = '" + txtFBillNO + "'" : " and  FBillNO = '" + txtFBillNO + "'";
            }

            //按供应商查询
            if (!string.IsNullOrEmpty(txtVendorCode))
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " VendorCode = '" + txtVendorCode + "'" : " and  VendorCode = '" + txtVendorCode + "'";
            }      
            //如果前面没有一个查询条件满足，那么不设置查询条件。
            if (strWhere != "")
            {
                searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and " + strWhere;
            }

            if (txtFBillNO != "" && txtVendorCode != "" && txtSerialNumber!="")
            {
                SKT.LeanMES.Material.BLL.MaterialUnit bll = new LeanMES.Material.BLL.MaterialUnit();
                DataTable dt = null;//bll.GetWhereMaterialReceipt(txtFBillNO, txtVendorCode, txtSerialNumber);
                if (dt.Rows.Count > 0)
                {
                    this.labFBillNO.InnerText = dt.Rows[0]["FBillNO"].ToString();
                    this.labVendorCode.InnerText = dt.Rows[0]["VendorCode"].ToString();
                    this.labOrderCurrency.InnerText = dt.Rows[0]["OrderCurrency"].ToString();
                    this.labSerialNumber.InnerText = dt.Rows[0]["SerialNumber"].ToString();
                    this.labVendorName.InnerText = dt.Rows[0]["VendorName"].ToString();
                    this.labReceiveDateTime.InnerText = dt.Rows[0]["ReceiveDateTime"].ToString();          
                }
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].Visible = false;
            }
        }
    }
}