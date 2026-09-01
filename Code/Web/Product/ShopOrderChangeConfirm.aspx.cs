using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.Controls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.Model;
using SKT.LeanMES.Order.BLL;
using SKT.LeanMES.Web;
using SKT.LeanMES.Order.Model;

namespace SKT.LeanMES.Web.Product
{
    public partial class ShopOrderChangeConfirm : BasePage
    {
        private int columnIndex_BusType = -1;
        private int columnIndex_MOStatus = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_BusType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "BusType")) + 1;
            columnIndex_MOStatus = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "MOStatus")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = ""; 

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (ddStatus.SelectedValue != "-1")
            {
                searchSettings.AddCondition("[MoStatus]", ddStatus.SelectedValue);
            }

            if (ddlOrderType.SelectedValue != "-1")
            {
                searchSettings.AddCondition("BusType", ddlOrderType.SelectedValue);
            }

            if (!string.IsNullOrEmpty(this.txtOrderNo.Text))
            {
                searchSettings.AddCondition("MoCode", this.txtOrderNo.Text);
            }

            searchSettings.AddCondition("ChangeStatus" , "0");

            this.Master.SearchSettings = searchSettings;

        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //3改为columnIndex_BusType
                int i = columnIndex_BusType;
                switch (e.Row.Cells[i].Text)
                {
                    case "1": e.Row.Cells[i].Text = "正常";
                        break;
                    case "2": e.Row.Cells[i].Text = "RMA";
                        break;
                    case "3": e.Row.Cells[i].Text = "返工";
                        break;
                    case "4": e.Row.Cells[i].Text = "委外加工";
                        break;
                    case "5": e.Row.Cells[i].Text = "受托加工";
                        break;
                    case "6": e.Row.Cells[i].Text = "重复生产";
                        break;
                    default: ;
                        break;
                }

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //12改为columnIndex_MOStatus
                int s = columnIndex_MOStatus;
                switch (e.Row.Cells[s].Text)
                {
                    case "1": e.Row.Cells[s].Text = Resources.lang.Normal;
                        break;
                    case "2": e.Row.Cells[s].Text = Resources.lang.Hold;
                        break;
                    case "3": e.Row.Cells[s].Text = Resources.lang.Completed;
                        break;
                    case "4": e.Row.Cells[s].Text = Resources.lang.Closed;
                        break;
                    default: ;
                        break;
                }

            }
        }
    }
}