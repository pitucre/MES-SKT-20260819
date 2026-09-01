using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MaterialDelivery
{
    public partial class LineQtyList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "LineId";
            this.Master.DefaultSortExpression = "LineId DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("LineName", Server.HtmlEncode(this.txtLine.Value));
            searchSettings.AddCondition("SerialNumber", Server.HtmlEncode(this.txtSerialNumber.Text));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}