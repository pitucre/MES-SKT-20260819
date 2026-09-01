using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentPressureTestList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        private int columnIndex_TestStatus = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;
            columnIndex_TestStatus = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "TestStatus")) + 1;

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentPressureTestId";
            this.Master.DefaultSortExpression = "NextTestTime "; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (txtEquipmentCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("EquipmentCode", "%"+this.txtEquipmentCode.Text.Trim());
            }
            if (txtTestor.Text.Trim() != "")
            {
                searchSettings.AddCondition("Tester", "%" + this.txtTestor.Text.Trim());
            }
            if (ddlTestStatus.SelectedValue.Trim() != "")
            {
                searchSettings.AddCondition("TestStatus", ddlTestStatus.SelectedValue.Trim());
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                SKT.LeanMES.Equipment.BLL.EquipmentPressureTest bll = new LeanMES.Equipment.BLL.EquipmentPressureTest();

                try
                {
                    if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {

                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    else if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                    {
                        ExportExcel(searchSettings, "机台压力测试-"+DateTime.Now.ToString("yyyyMMddHHmmss")+".xls");
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(String.Empty, ex, true);
                }
            }
        }

        public void ExportExcel(SKT.Common.Model.SearchSettings searchSettings,string fileName)
        {
            SKT.LeanMES.Equipment.BLL.EquipmentPressureTest bll = new LeanMES.Equipment.BLL.EquipmentPressureTest();
            var lists = bll.GetAll(0, -1, "", searchSettings);

            var list2 = lists.Select(k => new
            {
                k.EquipmentCode,
                k.EquipmentName,
                k.TestCycle,
                k.Pressure,
                k.TestTime,
                k.Tester,
                k.NextTestTime,
                k.TestStatus,                
            });

            DataTable tb = CommonHelper.BLL.ComMethod.ConvertToDataTable(list2.ToList());

            if(tb != null)
            {
                tb.Columns["EquipmentCode"].ColumnName = "设备编码";
                tb.Columns["EquipmentName"].ColumnName = "设备名称";
                tb.Columns["TestCycle"].ColumnName = "测试周期（天）";
                tb.Columns["Pressure"].ColumnName = "压力";
                tb.Columns["TestTime"].ColumnName = "最近测试时间";
                tb.Columns["Tester"].ColumnName = "最近测试人";
                tb.Columns["NextTestTime"].ColumnName = "下次测试时间";
                tb.Columns["TestStatus"].ColumnName = "状态"; 
            }
            SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.ExportToExcelSetType(tb, fileName);
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //e.Row.Cells.Count - 1改为columnIndex_TestStatus
                int cellCount = columnIndex_TestStatus;

                switch (e.Row.Cells[cellCount].Text)
                { 
                    case "已超期":
                        e.Row.Cells[cellCount].BackColor = System.Drawing.Color.Red;
                        e.Row.Cells[cellCount].ForeColor = System.Drawing.Color.White;
                        break;
                    case "待测试":
                        e.Row.Cells[cellCount].BackColor = System.Drawing.Color.Yellow;
                        break;
                    case "正常":
                        e.Row.Cells[cellCount].BackColor = System.Drawing.Color.Green;
                        e.Row.Cells[cellCount].ForeColor = System.Drawing.Color.White;
                        break;
                    default:                        
                        break;
                }

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //10改为columnIndex_ModifyBy
                //11改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }

        }
    }
}