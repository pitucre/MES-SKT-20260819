using System;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Transfers
{
    public partial class TransfersApply : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "TransfersId";
            this.Master.DefaultSortExpression = "CreateDateTime DESC"; //也可不赋值
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("TransfersNo", txtTransfersNo.Text.Trim());
            searchSettings.AddCondition("SourceNo", txtSourceNo.Text.Trim());
            searchSettings.AddCondition("EName", txtCreateBy.Text.Trim());
            searchSettings.AddCondition("DepartName", txtDepartName.Text.Trim());
            searchSettings.AddCondition("OutWhName", txtOutWhName.Text.Trim());
            searchSettings.AddCondition("InWhName", txtInWhName.Text.Trim());

            string txtDateF = this.txtDateF.Value.Trim();
            string txtDateT = this.txtDateT.Value.Trim();
            string dateF = "";
            string dateT = "";
            dateF = txtDateF;
            dateT = txtDateT;
            this.txtDateF.Value = dateF;
            this.txtDateT.Value = dateT;
            DateTime tmF;
            DateTime tmT;

            searchSettings.ExtensionCondition = " 1=1 ";
            if (txtDateF != "" && txtDateT != "")
            {
                if (!DateTime.TryParse(txtDateF, out tmF) || !DateTime.TryParse(txtDateT, out tmT))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " AND CreateDateTime BETWEEN '" + dateF + "' AND '" + Convert.ToDateTime(dateT).AddDays(1).ToString("yyyy-MM-dd") + "' ";
                }
            }
            else
            {
                if (txtDateF != "" && txtDateT == "")
                {
                    if (!DateTime.TryParse(txtDateF, out tmF))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += " AND ( CreateDateTime >= '" + dateF + "')";

                    }
                }
                if (txtDateT != "" && txtDateF == "")
                {
                    if (!DateTime.TryParse(txtDateT, out tmT))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += "AND (CreateDateTime <= '" + Convert.ToDateTime(dateT).AddDays(1).ToString("yyyy-MM-dd") + "')";
                    }
                }
            }
            if (ddlType.SelectedValue != "")
            {
                searchSettings.ExtensionCondition += " AND TransfersType= " + ddlType.SelectedValue;
            }

            if (ddlState.SelectedValue != "")
            {
                searchSettings.ExtensionCondition += " AND Statue= " + ddlState.SelectedValue;
            }

            this.Master.TableOrView = "vwTransfersApply";
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (this.IsPostBack)
            {
                try
                {
                    //导出
                    if (this.hdnOperate.Value.ToLower() == "exportexcel")
                    {
                        DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwTransfersApply", "ORDER BY TransfersId DESC", searchSettings, "TransfersId", this.hdnIdString.Value);
                        CommonMethod.ExportToSpreadsheet(ds, "调拨申请列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //10改为columnIndex_ModifyBy
                //11改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text)|| e.Row.Cells[columnIndex_ModifyBy].Text =="&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}