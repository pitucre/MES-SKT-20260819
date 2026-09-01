using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Anormal
{
    public partial class AnormalResponseList : BasePage
    {
        private int columnIndex_StatusName = -1;

        SKT.Common.Model.SearchSettings searchSettings;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.ProcessBy.Text = AccountController.GetCurrentUser().UserName;
            }

            var defaultSort = "AnormalId DESC";
            columnIndex_StatusName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "StatusName")) + 1;

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AnormalId";
            this.Master.DefaultSortExpression = defaultSort;

            searchSettings = new SKT.Common.Model.SearchSettings();

            var txtAnormalNo = Server.HtmlEncode(this.txtAnormalNo.Text);
            var txtAnormalTypeName = Server.HtmlEncode(this.txtAnormalTypeName.Text);
            var txtAnormalName = Server.HtmlEncode(this.txtAnormalName.Text);
            var txtLineName = Server.HtmlEncode(this.txtLineName.Text);
            var ddlStatus = this.ddlStatus.SelectedValue.ToString();
            var ckbIsLineStopped = (this.ckbIsLineStopped.SelectedValue.ToString() == "-1") ? "" : this.ckbIsLineStopped.SelectedValue.ToString();
            var txtStartTime = Server.HtmlEncode(this.txtStartTime.Text);
            var txtEndTime = Server.HtmlEncode(this.txtEndTime.Text);

            var strWhere = " 1=1 ";
            if (!string.IsNullOrEmpty(txtAnormalTypeName))
            {
                strWhere += " and [AnormalTypeName] like '" + txtAnormalTypeName + "%'";
            }

            if (!string.IsNullOrEmpty(txtAnormalNo))
            {
                strWhere += " and [AbnormalDocumentNo] like '" + txtAnormalNo + "%'";
            }

            if (!string.IsNullOrEmpty(txtAnormalName))
            {
                strWhere += " and [AnormalName] like '" + txtAnormalName + "%'";
            }
            if (!string.IsNullOrEmpty(txtLineName))
            {
                strWhere += " and [LineName] like '" + txtLineName + "%'";
            }

            if (!string.IsNullOrEmpty(ddlStatus) && ddlStatus != "-1")
            {
                strWhere += " and [Status] = " + ddlStatus;
            }

            if (!string.IsNullOrEmpty(txtStartTime))
            {
                strWhere += " and CreateDateTime >= cast('" + txtStartTime + "' as datetime)";
            }

            if (!string.IsNullOrEmpty(txtEndTime))
            {
                strWhere += " and CreateDateTime < cast('" + txtEndTime + "' as datetime) + 1";
            }

            if (!string.IsNullOrEmpty(ckbIsLineStopped))
            {
                if (ckbIsLineStopped == "0")
                {
                    strWhere += " and [IsLineStop] = 0";
                }
                else
                {
                    strWhere += " and [IsLineStop] = 1";
                }
            }

            //异常处理人
            var processBy = this.ProcessBy.Text.Trim();
            if (!string.IsNullOrEmpty(processBy))
            {
                strWhere += $@" AND (
                                    EXISTS(SELECT 1 FROM dbo.Prod_AnormalProcessConfig pc WITH(NOLOCK) INNER JOIN dbo.Prod_AnormalProcessConfigUser pu WITH(NOLOCK) ON pu.AnormalProcessConfigId = pc.AnormalProcessConfigId AND pu.UserType = 0 WHERE dbo.vwAnormal.LineId = pc.LineId AND dbo.vwAnormal.AnormalTypeId = pc.AnormalGroupId AND pu.UserName = '{processBy}')
                                    OR EXISTS(SELECT 1 FROM dbo.Prod_AnormalProcessConfig pc WITH(NOLOCK) INNER JOIN dbo.Prod_AnormalProcessConfigUser pu WITH(NOLOCK) ON pu.AnormalProcessConfigId = pc.AnormalProcessConfigId AND pu.UserType = 0 WHERE dbo.vwAnormal.LineId = pc.LineId AND pc.AnormalGroupId = -1 AND pu.UserName = '{processBy}')
                                )";
            }

            var strResponseTimeStart = this.ResponseTimeStart.Text.Trim();  //异常响应时间-开始
            var strResponseTimeEnd = this.ResponseTimeEnd.Text.Trim();      //异常响应时间-结束
            if (strResponseTimeStart != "")
            {
                strWhere += $" AND ResponseTime >= {Convert.ToDateTime(strResponseTimeStart).ToString("yyyy-MM-dd")}";
            }
            if (strResponseTimeEnd != "")
            {
                strWhere += $" AND ResponseTime < {Convert.ToDateTime(strResponseTimeStart).AddDays(1).ToString("yyyy-MM-dd")}";
            }

            if (!string.IsNullOrEmpty(strWhere))
                searchSettings.ExtensionCondition = strWhere;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                var userName = AccountController.GetCurrentUser().UserName;
                try
                {
                    if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        ProdAnormal.BLL.Anormal bll = new ProdAnormal.BLL.Anormal();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    var operate = Request.Form["hdnOperate"];
                    if (string.Equals(operate, "exportexcel", StringComparison.CurrentCultureIgnoreCase))
                    {
                        var tempFiledNames = new string[] { "ProcessTimeLength", "CloseTimeLength", "EffectPerson" };
                        //导出
                        string sort = string.IsNullOrWhiteSpace(this.GridView1.SortExpression) ? defaultSort : this.GridView1.SortExpression;
                        if (!string.IsNullOrWhiteSpace(sort) && this.GridView1.SortDirection == SortDirection.Descending && !sort.EndsWith(" DESC"))
                        {
                            sort += " DESC";
                        }
                        var list = new SKT.LeanMES.ProdAnormal.BLL.Anormal().GetAll(0, int.MaxValue, sort, searchSettings);
                        var dataSet = list.ToDataSet();
                        CommonMethod.ExportToSpreadsheet(dataSet, Master.PageTitle + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, tempFiledNames);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(userName, ex, true);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[columnIndex_StatusName].Text == "已逾期")
                {
                    e.Row.Cells[columnIndex_StatusName].ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}