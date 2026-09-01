using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.Controls;
using SKT.LeanMES.Resource.BLL;
using SKT.Common.Model;
using SKT.LeanMES.Resource.Model;

namespace SKT.LeanMES.Web.Resource
{
    public partial class LineView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string lineIdStr = Request.QueryString["ID"];
                int lineId = Convert.ToInt32(lineIdStr);
                BindLineProPeriodList(lineId);
                BindResouceByLineId(2, lineId);
                if (lineId > -1)
                {
                    SKT.LeanMES.Resource.Model.LineInfo model = new LeanMES.Resource.BLL.Line().GetInfo(lineId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }

        protected void BindResouceByLineId(int flage, int lineId)
        {
            List<SKT.LeanMES.Resource.Model.ResourceInfo> resource = new SKT.LeanMES.Resource.BLL.Resource().GetResourceByLineId(flage, lineId);
            string shtml = "<table class='ListTable' width='100%'>";
            shtml += "<tr class='ListTableHeader'>";
            shtml += "<th>"+Resources.lang.Resource+"</th>";
            shtml += "<th width='120px'>资源类型</th>";
            shtml += "</tr>";
            if (resource.Count == 0)
            {
                shtml += "<tr class='ListTableEmptyDataRow'><td colspan='2'>" + Resources.Messages.EmptyDataText + "</td></tr>";
            }
            for (int i = 0, j = resource.Count; i < j; i++)
            {
                if (i % 2 == 0)
                {
                    shtml += "<tr class='ListTableOddRow'>";
                }
                else
                {
                    shtml += "<tr class='ListTableEvenRow'>";
                }
                shtml += "<td>" + resource[i].ResName + "</td>";
                shtml += "<td>" + resource[i].ResTypeName + "</td></tr>";
            }
            shtml += "</table>";
            this.llResourcesList.Text = shtml;

        }

        protected void BindLineProPeriodList(int lineId)
        {
            LineTimePeriod lt = new LineTimePeriod();
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = " lineId = " + lineId;
            List<LineTimePeriodInfo> list = lt.GetAll(0, int.MaxValue, "TimePeriodId", searchSettings);
            string shtml = "<table class='ListTable' width='100%'>";
            shtml += "<tr class='ListTableHeader'>";
            shtml += "<th width='50%'>开始时间</th>";
            shtml += "<th width='50%'>结束时间</th>";
            shtml += "</tr>";
            if (list.Count == 0)
            {
                shtml += "<tr class='ListTableEmptyDataRow'><td colspan='2'>" + Resources.Messages.EmptyDataText + "</td></tr>";
            }
            for (int i = 0, j = list.Count; i < j; i++)
            {
                if (i % 2 == 0)
                {
                    shtml += "<tr class='ListTableOddRow'>";
                }
                else
                {
                    shtml += "<tr class='ListTableEvenRow'>";
                }
                shtml += "<td>" + list[i].StartDatetime + "</td>";
                shtml += "<td>" + list[i].EndDatetime + "</td></tr>";
            }
            shtml += "</table>";
            this.llPeriodList.Text = shtml;
        }

        protected SKT.LeanMES.Resource.Model.LineInfo PageData
        {
            set
            {
                this.txtLineName.Text = value.LineName;
                this.txtDescription.Text = value.LineDescription;
            }
        }
    }
}