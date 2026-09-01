using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentRepairListNew : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipment));
          //  AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxOA));
            string defaultSort = "EquipmentRepairId DESC";
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentRepairId";
            this.Master.DefaultSortExpression = defaultSort; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("RepairNo", this.txtRepairNo.Text.Replace("'", string.Empty).Trim());
            searchSettings.AddCondition("EquipmentCode", this.txtEquipmentCode.Text.Replace("'", string.Empty).Trim());
            string where = " 1 = 1 ";

            var status = this.ddlStatus.SelectedValue;
            var createTimeStart = this.txtCreateTimeStart.Text.Trim();
            var createTimeEnd = this.txtCreateTimeEnd.Text.Trim();
            var repairTimeStart = this.txtRepairTimeStart.Text.Trim();
            var repairTimeEnd = this.txtRepairTimeEnd.Text.Trim();
            var station = this.txtStation.Text.Replace("'", string.Empty).Trim();
            var repairName = this.RepairName.Text.Replace("'", string.Empty).Trim();
            searchSettings.AddCondition("RepairName", repairName);

            if (!string.IsNullOrEmpty(status))
            {
                where += " AND Status = " + status;
            }
            if (!string.IsNullOrEmpty(createTimeStart))
            {
                where += " AND CreateDateTime >= '" + createTimeStart + "'";
            }
            if (!string.IsNullOrEmpty(createTimeEnd))
            {
                where += " AND CreateDateTime < '" + Convert.ToDateTime(createTimeEnd).AddDays(1) + "'";
            }
            if (!string.IsNullOrEmpty(repairTimeStart))
            {
                where += " AND RepairEndTime >= '" + repairTimeStart + "'";
            }
            if (!string.IsNullOrEmpty(repairTimeEnd))
            {
                where += " AND RepairEndTime < '" + Convert.ToDateTime(repairTimeEnd).AddDays(1) + "'";
            }
            if (station.Length > 0)
            {
                where += " AND Station = '" + station + "'";
            }

            searchSettings.ExtensionCondition = where;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //导出
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "export")
                {
                    //导出
                    string sort = string.IsNullOrWhiteSpace(this.GridView1.SortExpression) ? defaultSort : this.GridView1.SortExpression;
                    if (!string.IsNullOrWhiteSpace(sort) && this.GridView1.SortDirection == SortDirection.Descending)
                    {
                        sort += " DESC";
                    }
                    var ds = new DataSet();
                    var dt = CommonHelper.BLL.ComMethod.ConvertToDataTable(new EquipmentRepair().GetRepairAll(0, int.MaxValue, sort, searchSettings));
                    ds.Tables.Add(dt);
                  
                 
                    CommonMethod.ExportToSpreadsheet(ds, "维修列表-" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1);
                }
            }
        }
    }
}