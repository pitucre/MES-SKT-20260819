using SKT.LeanMES.Scrap.BLL;
using System;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Scrap
{
    public partial class ScrapApply : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxScrapApply));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ScrapId";
            this.Master.DefaultSortExpression = "ScrapId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            searchSettings.AddCondition("ScrapNo",txtScrapNo.Text.Trim());
            searchSettings.AddCondition("EName", txtCreateBy.Text.Trim());
            searchSettings.AddCondition("DepartName", txtDepartName.Text.Trim());
            searchSettings.AddCondition("WhName", txtOutWhName.Text.Trim());
   

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

            if (ddlState.SelectedValue != "")
            {
                searchSettings.ExtensionCondition += " AND Statue= " + ddlState.SelectedValue;
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

        

            if (this.IsPostBack)
            {
                try
                {
                    //导出
                    if (this.hdnOperate.Value.ToLower() == "exportexcel")
                    {
                        DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwScrapApply", "ORDER BY ScrapId DESC", searchSettings, "ScrapId", this.hdnIdString.Value);
                        CommonMethod.ExportToSpreadsheet(ds, "报废申请列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }


                //删除
                if (this.hdnOperate.Value.ToLower() == "delete")
                {
                    try
                    {
                        Scraps bll = new Scraps();
                        bll.ScrapApplyDelete(this.hdnIdString.Value.ToString(), AccountController.GetCurrentUser().UserName);
                        this.hdnOperate.Value = "";
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //7改为columnIndex_ModifyBy
                //8改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}