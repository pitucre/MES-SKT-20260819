using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SKT.LeanMES.Product.BLL;
namespace SKT.LeanMES.Web.Client
{
    public partial class BatchSendRepair : BasePage
    {
        public String IsMESadd;
        public String IsCopy;

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = " ID desc";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " 1=1 ";
            if (txtOrderNo.Text != "")
            {
                searchSettings.ExtensionCondition += " and OrderNo like '%" + txtOrderNo.Text+"%'";
            }
            if (txtLineName.Text != "")
            {
                searchSettings.ExtensionCondition += " and LineName like '%" + txtLineName.Text + "%'";
            }
            if (txtStationName.Text != "")
            {
                searchSettings.ExtensionCondition += " and StationName like '%" + txtStationName.Text + "%'";
            }
            this.Master.SearchSettings = searchSettings;

        }

    }
}