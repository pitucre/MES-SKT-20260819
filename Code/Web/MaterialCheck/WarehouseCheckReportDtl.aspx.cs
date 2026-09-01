using SKT.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MaterialCheck
{
    public partial class WarehouseCheckReportDtl :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             var CheckNo= Request.QueryString["CheckNo"];
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCheck));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCpInList));
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("CheckOrder", CheckNo);
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Number";
            this.Master.DefaultSortExpression = ""; //也可不赋值
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}