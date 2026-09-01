using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Anormal
{
    public partial class AnormalCompleteList : BasePage
    {
        SKT.Common.Model.SearchSettings searchSettings;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.ReceiveBy.Text = AccountController.GetCurrentUser().UserName;
            }

            var defaultSort = "AnormalId DESC";

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AnormalId";
            this.Master.DefaultSortExpression = "AnormalId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

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
            var receiveBy = this.ReceiveBy.Text.Trim();
            if (!string.IsNullOrEmpty(receiveBy))
            {
                strWhere += $@" AND (
                                    EXISTS(SELECT 1 FROM dbo.Prod_AnormalProcessConfig pc WITH(NOLOCK) INNER JOIN dbo.Prod_AnormalProcessConfigUser pu WITH(NOLOCK) ON pu.AnormalProcessConfigId = pc.AnormalProcessConfigId AND pu.UserType = 1 WHERE dbo.vwAnormal.LineId = pc.LineId AND dbo.vwAnormal.AnormalTypeId = pc.AnormalGroupId AND pu.UserName = '{receiveBy}')
                                    OR EXISTS(SELECT 1 FROM dbo.Prod_AnormalProcessConfig pc WITH(NOLOCK) INNER JOIN dbo.Prod_AnormalProcessConfigUser pu WITH(NOLOCK) ON pu.AnormalProcessConfigId = pc.AnormalProcessConfigId AND pu.UserType = 1 WHERE dbo.vwAnormal.LineId = pc.LineId AND pc.AnormalGroupId = -1 AND pu.UserName = '{receiveBy}')
                                )";
            }

            var strCompleteTimeStart = this.CompleteTimeStart.Text.Trim();  //异常响应时间-开始
            var strCompleteTimeEnd = this.CompleteTimeEnd.Text.Trim();      //异常响应时间-结束
            if (strCompleteTimeStart != "")
            {
                strWhere += $" AND CompleteTime >= {Convert.ToDateTime(strCompleteTimeStart).ToString("yyyy-MM-dd")}";
            }
            if (strCompleteTimeEnd != "")
            {
                strWhere += $" AND CompleteTime < {Convert.ToDateTime(strCompleteTimeEnd).AddDays(1).ToString("yyyy-MM-dd")}";
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
                    var operate = Request.Form["hdnOperate"];
                    if (string.Equals(operate, "exportexcel", StringComparison.CurrentCultureIgnoreCase))
                    {
                        //导出
                        string sort = string.IsNullOrWhiteSpace(this.GridView1.SortExpression) ? defaultSort : this.GridView1.SortExpression;
                        if (!string.IsNullOrWhiteSpace(sort) && this.GridView1.SortDirection == SortDirection.Descending && !sort.EndsWith(" DESC"))
                        {
                            sort += " DESC";
                        }
                        var tempFiledNames = new string[] { "ProcessTimeLength", "CloseTimeLength", "EffectPerson" };
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
    }
}