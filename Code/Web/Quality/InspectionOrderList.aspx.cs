using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;
using System.Drawing;
using System.Reflection;
using System.Text;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using Resources;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionOrderList : BasePage
    {
        //private int columnIndex_AuditResult = -1;
        //private int columnIndex_GroupAffirmStatusName = -1;
        //private int columnIndex_ProjectAffirmStatusName = -1;
        private int columnIndex_Audit = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Audit = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "AuditStatusName")) + 1;
            //columnIndex_AuditResult = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "AuditResult")) + 1;
            //columnIndex_GroupAffirmStatusName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "GroupAffirmStatusName")) + 1;
            //columnIndex_ProjectAffirmStatusName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ProjectAffirmStatusName")) + 1;

            BindType();
            //ddlInspectionType.SelectedValue = hfInspectionType.Value;
            txtLine.Text = hdnLineName.Value;
            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "IOrderId";
            Master.DefaultSortExpression = "IOrderId";
            Master.DefaultSortDirection = SortDirection.Descending;

            var searchSettings = new SearchSettings();
            //searchSettings.AddCondition("InspectionOrderNo", txtInspectionOrderNo.Text.Trim());

            //searchSettings.ExtensionCondition = AccountController.GetCurrentUser().UserId.ToString() + " = -1 or AuditUserId=" + AccountController.GetCurrentUser().UserId + "";

            string whereStr = " InspectionOrderNo like '%"+txtInspectionOrderNo.Text.Trim()+"%' ";
            if (ddlInspectionTypeSelect.SelectedValue != "")
            {
                whereStr += " and InspectionSelectType = '" + ddlInspectionTypeSelect.SelectedValue + "'";
            }
            if (!string.IsNullOrEmpty(txtCPN.Text.Trim()))
            {
                whereStr += " and CPN LIKE '%" + txtCPN.Text.Trim() + "%'";
            }
            //if (hfInspectionType.Value != "-1" && hfInspectionType.Value!="")
            //{
            //    whereStr += " and InspectionTypeId = " + hfInspectionType.Value;
            //}
            //if (ddlGroupAffirmStatus.SelectedValue != "-2")
            //{
            //    whereStr += " and  GroupAffirmStatus = " + ddlGroupAffirmStatus.SelectedValue;
            //}
            //whereStr += " and SourceTarget like '%" + txtOrderNo.Text.Trim() + "%' ";
            //whereStr += " and ItemCode like '%" + txtItemCode.Text.Trim() + "%' ";
            //if (ddlProjectAffirmStatus.SelectedValue != "-2" && ddlProjectAffirmStatus.SelectedValue!="")
            //{
            //    whereStr += " and  ProjectAffirmStatus = " + ddlProjectAffirmStatus.SelectedValue;
            //}
            //if (ddlAuditStatus.SelectedValue != "-1" && ddlAuditStatus.SelectedValue!="")
            //{
            //    whereStr += " and  AuditStatus = " + ddlAuditStatus.SelectedValue;
            //}
            if (hdnLineId.Value.ToString() != "-1" && hdnLineId.Value!="")
            {
                whereStr += " and lineId = " + hdnLineId.Value.ToString();
            }
            if (txtStartTime.Text != "")
            {
                whereStr += " and CreateDateTime >= '" + txtStartTime.Text + " 00:00:00'";
            }
            if (txtEndTime.Text != "")
            {
                whereStr += " and CreateDateTime <= '" + txtEndTime.Text + " 23:59:59'";
            }
            searchSettings.ExtensionCondition = whereStr;
            Master.SearchSettings = searchSettings;
            GridView1.PageIndex = 0;
            if (IsPostBack)
            {
                

                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        var bll = new SKT.LeanMES.Quality.BLL.InspectionOrder();
                        bll.Delete(Request.Form["hdnIdString"], AccountController.GetCurrentUser().UserId.ToString());
                        WebHelper.ShowMessage(Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }


            }
        }

        //请选择放在第一行：
        public void BindType()
        {
            //InspectionType bll = new InspectionType();
            //SearchSettings search = new SearchSettings();
            //List<InspectionTypeInfo> list = bll.GetAll(0, int.MaxValue, "", search);
            //ddlInspectionType.DataSource = list;
            //ddlInspectionType.DataTextField = "InspectionTypeName";
            //ddlInspectionType.DataValueField = "InspectionTypeId";
            //ddlInspectionType.DataBind();
            //ddlInspectionType.Items.Insert(0, new ListItem("请选择", "-1"));
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[columnIndex_Audit].Text == "待审核")
                {
                    e.Row.Cells[columnIndex_Audit].BackColor = Color.Red;
                }
                else
                {
                    e.Row.Cells[columnIndex_Audit].BackColor = Color.Green;
                }
                //if (e.Row.Cells[columnIndex_AuditResult].Text == "2")
                //{
                //    e.Row.Cells[columnIndex_AuditResult].Text = "通过";
                //    e.Row.Cells[columnIndex_AuditResult].BackColor = Color.Green;
                //}
                //else if (e.Row.Cells[columnIndex_AuditResult].Text == "3")
                //{
                //    e.Row.Cells[columnIndex_AuditResult].Text = "不通过";
                //    e.Row.Cells[columnIndex_AuditResult].BackColor = Color.Red;
                //}
                //else
                //{
                //    e.Row.Cells[columnIndex_AuditResult].Text = "待审核";
                //    e.Row.Cells[columnIndex_AuditResult].BackColor = Color.Yellow;
                //}
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //8改为columnIndex_GroupAffirmStatusName
                //if (e.Row.Cells[columnIndex_GroupAffirmStatusName].Text == "不通过")
                //{
                //    e.Row.Cells[columnIndex_GroupAffirmStatusName].BackColor = Color.Red;

                //}
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //9改为columnIndex_ProjectAffirmStatusName
                //if (e.Row.Cells[columnIndex_ProjectAffirmStatusName].Text == "不通过")
                //{
                //    e.Row.Cells[columnIndex_ProjectAffirmStatusName].BackColor = Color.Red;

                //}
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            GridViewExpToExcel(this.GridView1, this.ObjectDataSource1, (name) =>
            {
                return name.Length < 1 || name.IndexOf('<') > -1;
            });
        }


        /// <summary>
        /// 导出GridView数据。
        /// Add by Hanson.Lei on 2016/11/8
        /// </summary>
        /// <param name="grid">GridView</param>
        /// <param name="data">ObjectDataSource</param>
        /// <param name="Filter">筛选不导出的列</param>
        protected void GridViewExpToExcel(GridView grid, ObjectDataSource data, Func<string, bool> Filter = null)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<TABLE border='1'>");
            sb.Append("<TR>");

            //1.筛选列
            ArrayList arrPropertys = new ArrayList();
            foreach (DataControlField dcf in grid.Columns)
            {
                if (Filter != null && Filter(dcf.HeaderText)) continue;

                arrPropertys.Add(((BoundField)dcf).DataField);

                sb.AppendFormat("<TH>{0}</TH>", dcf.HeaderText);
            }
            sb.Append("</TR>");

            //2.添加行
            foreach (var t in data.Select())
            {
                Type type = t.GetType();

                sb.Append("<TR>");

                foreach (string ptyName in arrPropertys)
                {
                    PropertyInfo propertyInfo = type.GetProperty(ptyName);

                    //实体属性名称与绑定gridView的字段有可能存在大小写差异
                    if (propertyInfo == null)
                        foreach (PropertyInfo p in type.GetProperties())
                            if (p.Name.ToLower() == ptyName.ToLower())
                            {
                                propertyInfo = p;
                                break;
                            }

                    object cellValue = propertyInfo.GetValue(t, null);
                    sb.AppendFormat("<TD {0}>{1}</TD>", SetCellStyle(cellValue), cellValue);
                }
                sb.Append("</TR>");
            }
            sb.Append("</TABLE>");

            ExpToExcel(sb.ToString());
        }

        private string SetCellStyle(object cellValue)
        {
            if (cellValue != null)
            {
                //转换文本格式
                if (cellValue.ToString().IndexOf('-') > -1)
                    return "style='vnd.ms-excel.numberformat:@;'";
            }

            return "";
        }

        /// <summary>
        /// 导出网页格式
        /// </summary>
        /// <param name="text"></param>
        protected void ExpToExcel(string text)
        {
            String ExcleName = "";
            ExcleName = DateTime.Now.ToShortDateString().ToString();
            StringBuilder sb = new StringBuilder();
            sb.Append("<head><meta http-equiv=Content-Type content=\"text/html; charset=utf-8\" />");
            sb.Append(text);
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + ExcleName + ".xls");
            Response.ContentType = "application/ms-excel";
            Response.Write(sb.ToString());
            Response.End();
        }
    }
}