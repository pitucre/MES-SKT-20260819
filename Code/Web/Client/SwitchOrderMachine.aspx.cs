using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Client
{
    public partial class SwitchOrderMachine : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxLogin));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceResource));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.AjaxCommon.DBService));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ProdOrderID";
            this.Master.DefaultSortExpression = "ProdOrderID asc";
            this.Master.DefaultSortDirection = SortDirection.Ascending;

            var eqCode = Request.QueryString["EqCode"] == "" ? "" : Request.QueryString["EqCode"];
            var EquimetCode = Request.QueryString["EquimetCode"] == "" ? "" : Request.QueryString["EquimetCode"];
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " Planned_Start_Time >='" + DateTime.Now.AddDays(-3).ToString("yyyy-MM-dd") + "' AND Planned_Start_Time <'" + DateTime.Now.AddDays(2).ToString("yyyy-MM-dd") + "'";
            searchSettings.AddCondition("MachineNumber", EquimetCode);
            searchSettings.AddCondition("OrderNO", this.txtLinePlanNo.Text.Trim());
            //if (!IsPostBack)
            //{
            //    //searchSettings.AddCondition("MachineNumber", EquimetCode);
            //    this.txtEquipment.Text = EquimetCode;
            //}
            //else
            //{
            //    if (string.IsNullOrWhiteSpace(this.txtEquipment.Text.Trim()))
            //    {
            //        searchSettings.ExtensionCondition = " ProdOrderID=-1";
            //    }
            //    else
            //    {
            //        //searchSettings.AddCondition("EquipmentCode", this.txtEquipment.Text.Trim());
            //        searchSettings.AddCondition("MachineNumber", this.txtLinePlanNo.Text.Trim());
            //    }
            //}
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}