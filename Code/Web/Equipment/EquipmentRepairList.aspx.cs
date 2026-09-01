using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;
using System.Linq;
using SKT.AjaxCommon;
using System.Data;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentRepairList : BasePage
    {
        private int columnIndex_RepairSTime = -1;
        private int columnIndex_RepairETime = -1;
        private int columnIndex_ConfirmDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_RepairSTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "RepairSTime")) + 1;
            columnIndex_RepairETime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "RepairETime")) + 1;
            columnIndex_ConfirmDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ConfirmDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentRepair));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(DBService));

            string defaultSort = "EquipmentRepairId DESC";

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentRepairId";
            this.Master.DefaultSortExpression = "EquipmentRepairId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string ddlStates = this.ddlStates.SelectedValue;          //状态
            searchSettings.ExtensionCondition = " 1=1 ";
            searchSettings.ExtensionCondition += " and RepairNo like '%" + this.txtRepairNo.Text.Replace(" ", "") + "%' ";
            searchSettings.ExtensionCondition += " and EqCode like '%" + this.txtEqCode.Text.Replace(" ", "") + "%' ";
            searchSettings.ExtensionCondition += " and RepairBy like '%" + this.txtRepairBy.Text.Replace(" ", "") + "%' ";
            searchSettings.ExtensionCondition += " and EquipmentName like '%" + this.txtEquipmentName.Text.Replace(" ", "") + "%' ";
            if (ddlStates != "-1")
            {
                searchSettings.AddCondition(" Status ", ddlStates);
            }
            //送检时间
            var repairTimeFrom = txtDateFrom.Value;
            var repairTimeTo = txtDateTo.Value;
            DateTime tmRepairTimeFrom;
            DateTime tmRepairTimeTo;
            bool isRepairTimeOK = true;
            if (string.IsNullOrEmpty(repairTimeFrom))
            {
                tmRepairTimeFrom = Convert.ToDateTime("1900-01-01");
            }
            else if (!DateTime.TryParse(repairTimeFrom, out tmRepairTimeFrom))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                isRepairTimeOK = false;
            }
            if (string.IsNullOrEmpty(repairTimeTo))
            {
                tmRepairTimeTo = Convert.ToDateTime(DateTime.Now);
            }
            else if (!DateTime.TryParse(repairTimeTo, out tmRepairTimeTo))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                isRepairTimeOK = false;
            }
            if (tmRepairTimeFrom > tmRepairTimeTo)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('修送开始时间不能大于结束时间')</script>");
                isRepairTimeOK = false;
            }
            if (isRepairTimeOK)
            {
                searchSettings.ExtensionCondition += " and RepairTime between '" + tmRepairTimeFrom.ToString("yyyy-MM-dd") + "' and '" + tmRepairTimeTo.AddDays(1).ToString("yyyy-MM-dd") + "' ";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Equipment.BLL.EquipmentRepair bll = new SKT.LeanMES.Equipment.BLL.EquipmentRepair();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
                else if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    //导出
                    string sort = string.IsNullOrWhiteSpace(this.GridView1.SortExpression) ? defaultSort : this.GridView1.SortExpression;
                    if (!string.IsNullOrWhiteSpace(sort) && this.GridView1.SortDirection == SortDirection.Descending)
                    {
                        sort += " DESC";
                    }
                    var ds = new DataSet();
                    var dt = CommonHelper.BLL.ComMethod.ConvertToDataTable(new EquipmentRepair().GetAll(0, int.MaxValue, sort, searchSettings));
                    ds.Tables.Add(dt);
                    CommonMethod.ExportToSpreadsheet(ds, "维修列表-" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                if (e.Row.Cells[columnIndex_RepairSTime].Text == "1900-01-01 00:00:00")
                {
                    e.Row.Cells[columnIndex_RepairSTime].Text = "";
                }
                if (e.Row.Cells[columnIndex_RepairETime].Text == "1900-01-01 00:00:00")
                {
                    e.Row.Cells[columnIndex_RepairETime].Text = "";
                }
                if (e.Row.Cells[columnIndex_ConfirmDateTime].Text == "1900-01-01 00:00:00")
                {
                    e.Row.Cells[columnIndex_ConfirmDateTime].Text = "";
                }
            }
        }
    }
}