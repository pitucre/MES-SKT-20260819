using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class SupplierExameResultView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int groudId = Convert.ToInt32(Request.QueryString["ID"]);
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SupplierExameContentResultID";
            this.Master.DefaultSortDirection = SortDirection.Ascending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "SupplierExameResultID =" + groudId + "";
            this.Master.SearchSettings = searchSettings;

            SKT.LeanMES.Warehouse.BLL.SupplierExameResult bll = new LeanMES.Warehouse.BLL.SupplierExameResult();
            SupplierExameResultInfo  info= bll.GetInfo(groudId);
            if(info != null)
            {
                this.PageData = info;
            }
        }

        private SupplierExameResultInfo PageData
        {
            set
            {
                this.lblExamDate.Text = value.ExameDate;
                this.lblExamType.Text = value.SupplierExameTempletType;
                this.lblSupplierExameName.Text = value.SupplierExameTempletName;
                this.lblTotalGrades.Text = value.TotalGrades.ToString();
                this.lblVendorCode.Text = value.VendorCode;
                this.lblVendorName.Text = value.VendorName;
            }
        }
    }
}