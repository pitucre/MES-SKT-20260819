using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Maintenance.BLL;
using SKT.LeanMES.Maintenance.Model;

namespace SKT.LeanMES.Web.Maintenance
{
    public partial class MaintenanceWarningList : BasePage
    {
        private int columnIndex_StatusStr = -1;
        private int columnIndex_LastDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
            }
            columnIndex_StatusStr = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "StatusStr")) + 1;
            columnIndex_LastDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "LastDateTime")) + 1;
            (new MaintenancePlan()).MaintenanceUpdateStatus();
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Eid";
            this.Master.DefaultSortExpression = "Eid";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("EquipmentCode", this.txtEquipmentCode.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

        }
     
         #region GridView行绑定
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                MaintenanceWarningInfo info = e.Row.DataItem as MaintenanceWarningInfo;
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //12改为columnIndex_StatusStr
                //13改为columnIndex_LastDateTime
                if (info.LastDateTime == "1900-01-01 00:00:00")
                {
                    e.Row.Cells[columnIndex_LastDateTime].Text = "";
                }
                else
                {
                    e.Row.Cells[columnIndex_LastDateTime].Text = info.LastDateTime;
                }

                //预警状态为“Warning”的单元格显示为红色填充
                if (info.StatusStr == "Warning")
                {
                    e.Row.Cells[columnIndex_StatusStr].BackColor = System.Drawing.Color.Red;
                }
            }
        }
        #endregion
    }
}