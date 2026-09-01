using System;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Station.Model;
using SKT.LeanMES.Web.AjaxServices;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Station
{
    public partial class StationTypeView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStation));
            if (!IsPostBack)
            {
                string opeTypeIdStr = Request.QueryString["ID"];

                int OpeTypeId = Convert.ToInt32(opeTypeIdStr);
                GetStationByTypeId(2, OpeTypeId);

                if (OpeTypeId > -1)
                {
                    SKT.LeanMES.Station.Model.StationTypeInfo model = new SKT.LeanMES.Station.BLL.StationType().GetInfo(OpeTypeId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }

        protected void GetStationByTypeId(int flage, int stationTypeId)
        {
            List<SKT.LeanMES.Station.Model.StationInfo> stationInfo = new SKT.LeanMES.Station.BLL.Station().GetStationInfoByStationId(flage, stationTypeId);
            string shtml = "<table class='ListTable' width='100%'>";
            shtml += "<tr class='ListTableHeader'>";
            shtml += "<th width='180px'>工序名称</th>";
            shtml += "<th>备注</th>";
            shtml += "</tr>";
            if (stationInfo.Count == 0)
            {
                shtml += "<tr class='ListTableEmptyDataRow'><td colspan='2'>" + Resources.Messages.EmptyDataText + "</td></tr>";
            }
            for (int i = 0, j = stationInfo.Count; i < j; i++)
            {
                if (i % 2 == 0)
                {
                    shtml += "<tr class='ListTableOddRow'>";
                }
                else
                {
                    shtml += "<tr class='ListTableEvenRow'>";
                }
                shtml += "<td>" + stationInfo[i].Station + "</td>";
                shtml += "<td>" + stationInfo[i].StationDesc + "</td></tr>";
            }
            shtml += "</table>";
            this.llStationList.Text = shtml;
        }
         

        protected SKT.LeanMES.Station.Model.StationTypeInfo PageData
        {
            set
            {
                this.txtOpeType.Text = value.StationType;
                this.txtDescription.Text = value.StationDesc;
                this.txtOperationUITemp.Text = value.TempName;
            }
        }
    }
}