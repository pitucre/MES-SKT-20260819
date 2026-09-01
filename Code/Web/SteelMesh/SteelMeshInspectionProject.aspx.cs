using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelMeshInspectionProject : BasePage
    {
        /// <summary>
        /// 时间列索引
        /// </summary>
        private int columnIndex_SMIPUpdateDateTime = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_SMIPUpdateDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "SMIPUpdateDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipment));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SMIPId";
            this.Master.DefaultSortExpression = "SMIPId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition += " SMIPStatus<>-2  ";
            string SMIPType = this.SMIPType.SelectedValue;
            if (!string.IsNullOrWhiteSpace(SMIPType) && SMIPType != "-1")
            {
                searchSettings.ExtensionCondition += " AND SMIPType = " + SMIPType;
            }
            if (!string.IsNullOrEmpty(this.txtSMIPCode.Text))
            {
                searchSettings.AddCondition("SMIPCode", this.txtSMIPCode.Text);
            }
            if (!string.IsNullOrEmpty(this.txtSMIPName.Text))
            {
                searchSettings.AddCondition("SMIPName", this.txtSMIPName.Text);
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                //if (e.Row.Cells[6].Text == "-2")
                //{
                //    e.Row.Cells[6].Text = "删除";
                //}
                //else if (e.Row.Cells[6].Text == "1")
                //{
                //    e.Row.Cells[6].Text = "启用";
                //}
                //else if (e.Row.Cells[6].Text == "-1")
                //{
                //    e.Row.Cells[6].Text = "禁用";
                //}
                //else
                //{
                //    e.Row.Cells[6].Text = "";
                //}
                //by liwen 20210202 处理时间问题
                if (Convert.ToDateTime(e.Row.Cells[columnIndex_SMIPUpdateDateTime].Text).ToString("yyyy-MM-dd") == "9999-12-31")
                {
                    e.Row.Cells[columnIndex_SMIPUpdateDateTime].Text = "";
                }
            }
        }
    }
}