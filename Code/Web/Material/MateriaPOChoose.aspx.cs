using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.Model;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.Material
{
    public partial class MateriaPOChoose : BasePage
    {
        private int columnIndex_FQty = -1;
        private int columnIndex_FMESQty = -1;
        private int columnIndex_FReturnQty = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_FQty = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "FQty")) + 1;
            columnIndex_FMESQty = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "FMESQty")) + 1;
            columnIndex_FReturnQty = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "FReturnQty")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxERPPOorder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "FBILLNO";
            this.Master.DefaultSortExpression = "PODATE";
            this.Master.DefaultSortDirection = SortDirection.Ascending;

            string vendorCode = "";
            int userType = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType;
            if (!IsPostBack)
            {
                if (userType > 0)
                {
                    SKT.LeanMES.Supplier.Model.SuppliersInfo vendorInfo=(new SKT.LeanMES.Supplier.BLL.Suppliers()).GetInfo(userType);
                    if (vendorInfo != null)
                    {
                        this.hdnVendorCodr.Value = vendorInfo.VendorCode;
                        this.txtVendorCode.Text = vendorInfo.VendorCode;
                        this.hdnVendorCode.Value = vendorInfo.VendorCode;
                        this.hdnVendorName.Value = vendorInfo.VendorName;
                        this.lblVendorName.Text = vendorInfo.VendorName;
                    }
                }
                else
                {
                    this.hdnVendorCodr.Value = "";
                    this.txtVendorCode.Text = "";
                    this.hdnVendorCode.Value = "";
                    this.hdnVendorName.Value = "";
                    this.lblVendorName.Text = "";
                }
            }
            
            string strWhere = "";

            //供应商编码
            string vendorCode1 = this.hdnVendorCode.Value.Trim();

            //采购单号
            string po = this.txtPoNum.Text.Trim(); //this.hdnPo.Value.Trim();

            //物料编码
            string itemCode = this.hdnItemCode.Value.Trim();

            //下单日期
            string poDateFrom = this.txtPODateFrom.Text.Trim();
            string poDateTo = this.txtPODateTo.Text.Trim();

            //订单状态
            bool poState = (this.ckbPOState.Checked) ? true : false;

            if (vendorCode1 != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " VendorCode = '" + vendorCode1 + "' " : " and VendorCode = '" + vendorCode1 + "' ";
            }

            if (po != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " FBILLNO = '" + po + "' " : " and FBILLNO = '" + po + "' ";
            }

            if (itemCode != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " ItemCode = '" + itemCode + "' " : " and ItemCode = '" + itemCode + "' ";
            }

            if (poDateFrom != "" || poDateTo != "")
            {
                poDateFrom = String.IsNullOrEmpty(poDateFrom) ? poDateTo : poDateFrom;
                poDateTo = String.IsNullOrEmpty(poDateTo) ? poDateFrom : poDateTo;
                strWhere += String.IsNullOrEmpty(strWhere) ? " PODATE >= '" + poDateFrom + "'  and PODATE <= '" + poDateTo + "' " : " and PODATE >= '" + poDateFrom + "'  and PODATE <= '" + poDateTo + "' ";
            }

            if (poState)
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " FQty > FMESQty " : " and FQty > FMESQty  ";
                //strWhere += String.IsNullOrEmpty(strWhere) ? " POSTATUS <> '关闭' " : " and POSTATUS <> '关闭' ";
            }

            //Add By Alen 2015-08-11 增加Site控制
            string site = WebHelper.Site.ToString();
            if (site != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " [Site] = '" + site + "' " : " and [Site] = '" + site + "' ";
            }

            strWhere = String.IsNullOrEmpty(strWhere) ? "1<>1" : strWhere;

            SearchSettings settings = new SearchSettings();
            settings.ExtensionCondition = String.IsNullOrEmpty(settings.ExtensionCondition) ? strWhere : " and " + strWhere;
            this.Master.SearchSettings = settings;

            ERPPOorderInfo orderInfo = null;
            ERPPOorder entryBll = new ERPPOorder();


            orderInfo = entryBll.GetInfo(this.txtPoNum.Text.Trim());

            if (orderInfo != null)
            {
                if (userType > 0)
                {
                    if (orderInfo.FSupplierFnumber.ToLower() == vendorCode.ToLower())
                    {
                        lbSuplier.Text = String.IsNullOrEmpty(this.hdnVendorName.Value) ? "供应商：" + orderInfo.FSupplierName.ToString() : "供应商：" + this.hdnVendorName.Value.ToString();
                        lbPoDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(orderInfo.FDATE);
                        lbState.Text = orderInfo.FSTATUS;
                    }
                }
                else
                {
                    lbSuplier.Text = String.IsNullOrEmpty(this.hdnVendorName.Value) ? "供应商：" + orderInfo.FSupplierName : "供应商：" + this.hdnVendorName.Value.ToString();
                    lbPoDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(orderInfo.FDATE);
                    lbState.Text = orderInfo.FSTATUS;
                }
            }

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //xiang.yan 2024-4-23 cells取值改为根据列名获取
            //7改为columnIndex_FQty
            //8改为columnIndex_FMESQty
            //9改为columnIndex_FReturnQty
            int col5 = columnIndex_FQty;
            int col6 = columnIndex_FMESQty;
            int col7 = columnIndex_FReturnQty;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[col5].Text = e.Row.Cells[col5].Text.Replace(".000", "");
                e.Row.Cells[col6].Text = e.Row.Cells[col6].Text.Replace(".000", "");
                e.Row.Cells[col7].Text = e.Row.Cells[col7].Text.Replace(".000", "");
            }
        }
    }
}