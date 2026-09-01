using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class SupplierExameResultList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SupplierExameResultID";
            this.Master.DefaultSortExpression = "SupplierExameResultID DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "";
            searchSettings.AddCondition("ExameDate", this.txtExameDate.Text.Trim());
            if(ddlSupplierExameTempletType.SelectedValue != "")
            {
                searchSettings.ExtensionCondition += (searchSettings.ExtensionCondition == "" ? "" : " AND ") + " SupplierExameTempletType = '" + ddlSupplierExameTempletType.SelectedValue + "'";
            }
            if (txtVenCode.Value != "")
            {
                searchSettings.ExtensionCondition += (searchSettings.ExtensionCondition == "" ? "" : " AND ") + " VendorCode = '" + txtVenCode.Value + "'";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                
            }
        }
    }
}