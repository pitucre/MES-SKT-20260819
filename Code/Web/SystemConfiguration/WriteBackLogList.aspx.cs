using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class WriteBackLogList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.AjaxCommon.DBService));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WriteBackLogId";
            this.Master.DefaultSortExpression = "WriteBackLogId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("MESBillNo", this.MESBillNo.Text.Trim());
            searchSettings.AddCondition("WriteBackCode", this.WriteBackCode.Text.Trim());
            searchSettings.AddCondition("WriteBackName", this.WriteBackName.Text.Trim());
            searchSettings.AddCondition("CreateBy", this.CreateBy.Text.Trim());
            searchSettings.AddCondition("ERPNo", this.ERPNo.Text.Trim());
            var erpResult = this.ERPResult.SelectedValue;

            var where = " 1 = 1 ";
            if (!string.IsNullOrWhiteSpace(erpResult))
            {
                where += " AND ERPResult = " + erpResult;
            }

            DateTime dtCreateDateTimeBegin;
            DateTime dtCreateDateTimeEnd;
            string createDateTimeBegin = this.CreateDateTimeBegin.Text.Trim();
            string createDateTimeEnd = this.CreateDateTimeEnd.Text.Trim();
            if (!string.IsNullOrEmpty(createDateTimeBegin) && DateTime.TryParse(createDateTimeBegin, out dtCreateDateTimeBegin))
            {
                where += " AND CreateDateTime >= '" + dtCreateDateTimeBegin.ToString("yyyy-MM-dd") + "'";
            }
            if (!string.IsNullOrEmpty(createDateTimeEnd) && DateTime.TryParse(createDateTimeEnd, out dtCreateDateTimeEnd))
            {
                where += " AND CreateDateTime < '" + dtCreateDateTimeEnd.AddDays(1).ToString("yyyy-MM-dd") + "'";
            }
            searchSettings.ExtensionCondition = where;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

    }
}