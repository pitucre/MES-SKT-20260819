using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialHandover : BasePage
    {
        private int columnIndex_ApplyType = -1;
        private int columnIndex_Statue = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ApplyType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ApplyType")) + 1;
            columnIndex_Statue = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Statue")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialApply));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ApplyId";
            this.Master.DefaultSortExpression = "ApplyId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ApplyNO", txtApplyNO.Text.Trim());
            searchSettings.AddCondition("DepName", txtDepName.Text.Trim());
            searchSettings.AddCondition("WhName", txtWhName.Text.Trim());
            //使用日期
            string txtDateFrom = this.txtDateFrom.Value.Trim();
            string txtDateTo = this.txtDateTo.Value.Trim();
            string dateFrom = "";
            string dateTo = "";

            dateFrom = txtDateFrom;
            dateTo = txtDateTo;
            this.txtDateFrom.Value = dateFrom;
            this.txtDateTo.Value = dateTo;
            DateTime tmFrom;
            DateTime tmTo;
            searchSettings.ExtensionCondition = " 1=1 ";
            if (txtDateFrom != "" && txtDateTo != "")
            {
                //判断日期
                if (!DateTime.TryParse(txtDateFrom, out tmFrom) || !DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " AND UseDateTime BETWEEN '" + dateFrom + "' AND '" + dateTo + "' ";
                }
            }
            else
            {
                if (txtDateFrom != "" && txtDateTo == "")
                {
                    if (!DateTime.TryParse(txtDateFrom, out tmFrom))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += " AND ( UseDateTime >= '" + dateFrom + "')";

                    }
                }
                if (txtDateTo != "" && txtDateFrom == "")
                {
                    if (!DateTime.TryParse(txtDateTo, out tmTo))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += "AND (UseDateTime <= '" + dateTo + "')";
                    }
                }
            }
            if (ddlType.SelectedValue != "")
            {
                searchSettings.ExtensionCondition += " AND ApplyType= " + ddlType.SelectedValue;
            }
            if (ddlState.SelectedValue != "")
            {
                searchSettings.ExtensionCondition += " AND Statue= " + ddlState.SelectedValue;
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Material.BLL.Apply bll = new SKT.LeanMES.Material.BLL.Apply();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        string error = ex.ToString();
                        if (error.IndexOf("包含已经备料") >= 0)
                        {
                            error = "您选择的领料单中包含已经备料的单，请重新选择！";
                        }
                        else
                        {
                            error = "删除失败！";
                        }
                        WebHelper.ShowMessage(error);
                    }

                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                try
                {
                    //xiang.yan 2024-4-23 cells取值改为根据列名获取
                    //1改为columnIndex_ApplyType
                    //11改为columnIndex_Statue
                    //12改为columnIndex_ModifyBy
                    //13改为columnIndex_ModifyDateTime

                    if (e.Row.Cells[columnIndex_ApplyType].Text == "1")
                    {
                        e.Row.Cells[columnIndex_ApplyType].Text = "工单领料";
                    }
                    else
                    {
                        e.Row.Cells[columnIndex_ApplyType].Text = "手工增加";
                    }
                    if (e.Row.Cells[columnIndex_Statue].Text == "0")
                    {
                        e.Row.Cells[columnIndex_Statue].Text = "待备料";
                    }
                    if (e.Row.Cells[columnIndex_Statue].Text == "1")
                    {
                        e.Row.Cells[columnIndex_Statue].Text = "已备料";
                    }
                    else if (e.Row.Cells[columnIndex_Statue].Text == "2")
                    {
                        e.Row.Cells[columnIndex_Statue].Text = "已接收";

                    }
                    else if (e.Row.Cells[columnIndex_Statue].Text == "3")
                    {
                        e.Row.Cells[columnIndex_Statue].Text = "已退料";
                    }
                    else if (e.Row.Cells[columnIndex_Statue].Text == "4")
                    {
                        e.Row.Cells[columnIndex_Statue].Text = "备料中";
                    }
                    else if (e.Row.Cells[columnIndex_Statue].Text == "-1")
                    {
                        e.Row.Cells[columnIndex_Statue].Text = "已删除";
                    }
                    if (e.Row.Cells[columnIndex_Statue].Text != "已接收") {
                        e.Row.Cells[columnIndex_ModifyBy].Text = "";
                        e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
                    }
                }
                catch { }
            }
        }
    }
}