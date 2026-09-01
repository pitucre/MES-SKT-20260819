using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class ItemPreEquipment : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemId";
            this.Master.DefaultSortExpression = "ItemId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            var eqCode = Request.QueryString["EqCode"] == "" ? "" : Request.QueryString["EqCode"];
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition(" ItemCode", this.txtItemCode.Text.Trim());

            searchSettings.ExtensionCondition = " ItemCode not in(select ItemCode from Basal_EquipmentItemRelation where isdelete=0 and  EqCode= '" + eqCode + "')";
            this.Master.SearchSettings = searchSettings;

            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}