using SKT.LeanMES.ProdUnit.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class PackRelationDtlList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SerialNumberID";
            this.Master.DefaultSortExpression = "SerialNumberID"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("OrderNo", txtOrderNo.Text.Trim().Replace("'", "''"));
            searchSettings.AddCondition("NumberType", ddlNumberType.SelectedValue.Trim().Replace("'", "''"));
            searchSettings.AddCondition("SerialNumber", txtSerialNumber.Text.Trim().Replace("'", "''"));
            searchSettings.AddCondition("Status", ddlStatus.SelectedValue.Trim().Replace("'", "''"));

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}