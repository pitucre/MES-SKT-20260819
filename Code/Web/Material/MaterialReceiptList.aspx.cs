using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialReceiptList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = ""; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            string txtReveivedNO = this.txtReveivedNO.Value.Trim();
            string txtFBillNO = this.txtFBillNO.Value.Trim();
            string txtVendorCode = this.txtVendorCode.Value.Trim();
            string txtDateFrom = this.txtDateTime.Value.Trim();
            string txtDateTo = this.txtDateTime.Value.Trim();

            string strWhere = "";

            if (!string.IsNullOrEmpty(txtReveivedNO))
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " SerialNumber like '%" + txtReveivedNO + "%'" : " and  SerialNumber like '%" + txtReveivedNO + "%'";
            }

            //按采购订单查询
            if (!string.IsNullOrEmpty(txtFBillNO))
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " FBillNO like '%" + txtFBillNO + "%'" : " and  FBillNO like '%" + txtFBillNO + "%'";
            }

            //按供应商查询
            if (!string.IsNullOrEmpty(txtVendorCode))
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " VendorCode like '%" + txtVendorCode + "%'" : " and  VendorCode like '%" + txtVendorCode + "%'";
            }

            //按时间查询
            if (!string.IsNullOrEmpty(txtDateFrom) || !string.IsNullOrEmpty(txtDateTo))
            {
                string dateFrom = "";
                string dateTo = "";
                //dateFrom = (txtDateFrom == "") ? txtDateTo : txtDateFrom;
                dateFrom = txtDateFrom;
                dateTo = (txtDateTo == "") ? txtDateFrom : txtDateTo;
                this.txtDateTime.Value = dateFrom;
                this.txtDateTime.Value = dateTo;

                //判断日期
                DateTime tmFrom;
                DateTime tmTo;

                if (!DateTime.TryParse(dateFrom, out tmFrom))
                {
                    if (dateFrom != "")
                    {
                        Page.ClientScript.RegisterClientScriptBlock(GetType(), "invalidFromTime", "$(function(){alert('请输入正确的时间格式（yyyy-MM-dd）')})", true);
                    }
                    else
                    {
                        strWhere += String.IsNullOrEmpty(strWhere) ? " (CreateDate < '" + Convert.ToDateTime(dateTo).AddDays(1) + "')" : "and ( CreateDate < '" + Convert.ToDateTime(dateTo).AddDays(1) + "')";
                    }
                }
                else if (!DateTime.TryParse(dateTo, out tmTo))
                {
                    Page.ClientScript.RegisterClientScriptBlock(GetType(), "invalidToTime", "$(function(){alert('请输入正确的时间格式（yyyy-MM-dd）')})", true);
                    return;
                }
                else
                {
                    strWhere += String.IsNullOrEmpty(strWhere) ? " (CreateDate >= '" + Convert.ToDateTime(dateFrom) + "'  and  CreateDate < '" + Convert.ToDateTime(dateTo).AddDays(1) + "')" : "and ( CreateDate >= '" + Convert.ToDateTime(dateFrom) + "'  and  CreateDate < '" + Convert.ToDateTime(dateTo).AddDays(1) + "')";
                }
            }
            //如果前面没有一个查询条件满足，那么不设置查询条件。
            if (strWhere != "")
            {
                searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and " + strWhere;
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}