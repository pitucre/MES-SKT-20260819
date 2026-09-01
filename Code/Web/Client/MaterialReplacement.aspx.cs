using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Client
{
    public partial class MaterialReplacement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var prodOrderId = Request.QueryString["prodOrderId"];
            var linePlanType = Request.QueryString["linePlanType"];

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MaterialUnitId";
            this.Master.DefaultSortExpression = "SerialNumber DESC"; //也可不赋值

            //设置数据源
            this.ObjectDataSource1.SelectMethod = string.Equals(linePlanType, "1") ? "GetItemBomGRNListSMT" : "GetItemBomGRNListDIP";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " 1 = 1";
            string ncPosition = this.txtNCPosition.Text.Replace("'", string.Empty).Trim();//不良位置
            string itemCode = this.txtItemCode.Text.Replace("'", string.Empty).Trim();//物料编码
            if (!string.IsNullOrEmpty(ncPosition))
            {
                //searchSettings.AddCondition("UsePosition", ncPosition);
                searchSettings.ExtensionCondition += " AND UsePosition = '" + ncPosition + "'";
            }
            if (!string.IsNullOrEmpty(itemCode))
            {
                //searchSettings.AddCondition("ItemCode", itemCode);
                searchSettings.ExtensionCondition += " AND ItemCode = '" + itemCode + "'";
            }
            searchSettings.ExtensionCondition += " AND ProdOrderId = " + prodOrderId;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxRepair));

            if (!IsPostBack)
            {
                var ncDataId = Request.QueryString["ncdataid"];
                if (!string.IsNullOrWhiteSpace(ncDataId))
                {
                    this.hidNcDataId.Value = ncDataId.Trim();
                }
            }
        }
    }
}