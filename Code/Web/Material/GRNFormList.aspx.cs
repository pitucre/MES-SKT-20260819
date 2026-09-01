using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class GRNFormList :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));


            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MaterialUnitId";
            this.Master.DefaultSortExpression = "MaterialUnitId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            //searchSettings.AddCondition("Flag", "1");
            if (!string.IsNullOrEmpty(this.txtGRN.Text))
            {
                searchSettings.AddCondition("serialnumber", this.txtGRN.Text);
            }
            if (!string.IsNullOrEmpty(this.txtItemCode.Text))//物料代码
            {
                searchSettings.AddCondition("ItemCode", this.txtItemCode.Text);
            }

            string strWhere = "";
            string createDateTimeStart = this.txtDateTimeStart.Text.Trim();
            string createDateTimeEnd = this.txtDateTimeEnd.Text.Trim();

            if (createDateTimeStart != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " CreateDateTime >= '" + createDateTimeStart + "'" : " and CreateDateTime >= '" + createDateTimeStart + "'";
            }
            if (createDateTimeEnd != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " CreateDateTime <= '" + createDateTimeEnd + "'" : " and CreateDateTime <= '" + createDateTimeEnd + "'";
            }
  
            searchSettings.ExtensionCondition += strWhere;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}