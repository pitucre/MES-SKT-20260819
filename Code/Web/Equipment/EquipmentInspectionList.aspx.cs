using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.AppCode.Utility;
using SKT.LeanMES.Web.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentInspectionList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipmentInspectionItem));            

            if (!IsPostBack)
            {
                this.SpotCheckUser.Text = AccountController.GetCurrentUser().UserName;
                String myStationName = Request.QueryString["StationName"];
                String myLineName = Request.QueryString["LineName"];
                if (myStationName != null)
                {
                    this.Station.Text = myStationName;
                }
                if (myLineName != null)
                {
                    this.LineName.Text = myLineName;
                }
            }

            string defaultSort = "InspectionId DESC";

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxInspection));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentInspectionItem));
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxOA));

            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "InspectionId";
            Master.DefaultSortExpression = defaultSort;
            Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
            string where = " 1=1 ";

            searchSettings.AddCondition("InspectionNo", txtInspectionNo.Text.Trim());


            //searchSettings.AddCondition("EquipmentCode", txtEquipmentCode.Text.Trim());
            var eqCode = this.txtEquipmentCode.Text.Trim();
            if (!string.IsNullOrEmpty(eqCode) && eqCode.IndexOf(" ") > -1)
            {
                eqCode = eqCode.Substring(0, eqCode.IndexOf(" "));
            }
            searchSettings.AddCondition("EquipmentCode", eqCode);

            searchSettings.AddCondition("EquipmentName", EquipmentName.Text.Trim());
            searchSettings.AddCondition("LineName", Server.HtmlEncode(this.LineName.Text));
            searchSettings.AddCondition("Station", Server.HtmlEncode(this.Station.Text));
            searchSettings.AddCondition("EquipmentTypeName", Server.HtmlEncode(this.EquipmentTypeName.Text));
            string equipmentStatus = this.ddlEquipmentStatus.SelectedValue;
            string equipmentResult = this.ddlEquipmentResult.SelectedValue;
            //保养状态
            if (!string.IsNullOrWhiteSpace(equipmentStatus))
            {
                where += " AND Status = " + Convert.ToInt32(equipmentStatus).ToString();
            }
            //保养结果
            if (!string.IsNullOrWhiteSpace(equipmentResult))
            {
                where += " AND InspectionResult = " + Convert.ToInt32(equipmentResult).ToString();
            }

            string txtStartDate = this.txtStartDate.Text.Trim();
            string txtEndDate = this.txtEndDate.Text.Trim();
            DateTime dtStartDate;
            DateTime dtEndDate;
            if (!string.IsNullOrEmpty(txtStartDate) && DateTime.TryParse(txtStartDate, out dtStartDate))
            {
                where += " AND InspectionTime >= '" + dtStartDate.ToString("yyyy-MM-dd") + "'";
            }
            if (!string.IsNullOrEmpty(txtEndDate) && DateTime.TryParse(txtEndDate, out dtEndDate))
            {
                where += " AND InspectionTime < '" + dtEndDate.AddDays(1).ToString("yyyy-MM-dd") + "'";
            }

            string createTimeStart = this.CreateTimeStart.Text.Trim();
            string createTimeEnd = this.CreateTimeEnd.Text.Trim();
            DateTime dtCreateTimeStart;
            DateTime dtCreateTimeEnd;
            if (!string.IsNullOrEmpty(createTimeStart) && DateTime.TryParse(createTimeStart, out dtCreateTimeStart))
            {
                where += " AND CreateDateTime >= '" + dtCreateTimeStart.ToString("yyyy-MM-dd") + "'";
            }
            if (!string.IsNullOrEmpty(createTimeEnd) && DateTime.TryParse(createTimeEnd, out dtCreateTimeEnd))
            {
                where += " AND CreateDateTime < '" + dtCreateTimeEnd.AddDays(1).ToString("yyyy-MM-dd") + "'";
            }

            var inspectionEndUserName = this.InspectionEndUserName.Text.Replace("'", string.Empty).Trim();
            if (inspectionEndUserName.Length > 0)
            {
                where += " AND InspectionUserCName LIKE '%" + inspectionEndUserName + "%'";
            }
            //待点检人
            var spotCheckUser = this.SpotCheckUser.Text.Replace("'", string.Empty).Trim();
            var guid = System.Guid.NewGuid().ToString("N");
            if (spotCheckUser.Length > 0)
            {
                where += $" AND OpertionUser = '{spotCheckUser}'";
            }

            searchSettings.ExtensionCondition = where;

            Master.SearchSettings = searchSettings;
            GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                try
                {
                    //导出
                    if (this.hdnOperate.Value.ToLower() == "exportexcel")
                    {
                        //导出
                        string sort = string.IsNullOrWhiteSpace(this.GridView1.SortExpression) ? defaultSort : this.GridView1.SortExpression;
                        if (!string.IsNullOrWhiteSpace(sort) && this.GridView1.SortDirection == SortDirection.Descending && !sort.EndsWith(" DESC"))
                        {
                            sort += " DESC";
                        }
                        var list = new SKT.LeanMES.Equipment.BLL.EquipmentInspectionTemplateItem().GetAllEquipmentInspectionList(0, int.MaxValue, sort, searchSettings);
                        NPOIHelper.Export(list, this.GridView1, "设备点检列表-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx");
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                }
                finally
                {
                    this.hdnOperate.Value = string.Empty;
                }
            }
        }
    }
}