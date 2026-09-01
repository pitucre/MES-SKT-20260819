using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.MaterialDelivery.BLL;
using SKT.LeanMES.MaterialDelivery.Model;

namespace SKT.LeanMES.Web.MaterialDelivery
{
    public partial class PrepareMaterial : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PrepareId";
            this.Master.DefaultSortExpression = "CreateDateTime";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (!string.IsNullOrEmpty(txtProdOrderNO.Value.Trim()))
            {
                searchSettings.AddCondition("ProdOrderNO", Server.HtmlEncode(this.txtProdOrderNO.Value.Trim()));
            }

            if (!string.IsNullOrEmpty(txtProductCode.Value.Trim()))
            {
                searchSettings.AddCondition("ProductCode", Server.HtmlEncode(this.txtProductCode.Value.Trim()));
            }

            if (!string.IsNullOrEmpty(txtSectionCode.Value.Trim()))
            {
                searchSettings.AddCondition("SectionCode", Server.HtmlEncode(this.txtSectionCode.Value.Trim()));
            }

            if (!string.IsNullOrEmpty(txtRequestDate.Value.Trim()))
            {
                searchSettings.AddCondition("RequestDate", Server.HtmlEncode(this.txtRequestDate.Value.Trim()));
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}