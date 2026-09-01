using System;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Station.Model;
using SKT.LeanMES.Web.AjaxServices;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Station
{
    public partial class StationView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStation));
            if (!IsPostBack)
            {
                string opeIdStr = Request.QueryString["ID"];
                int opeId = Convert.ToInt32(opeIdStr);
                BindListBoxByOpeId(2, opeId);

                if (opeId > -1)
                {
                    SKT.LeanMES.Station.Model.StationInfo model = new SKT.LeanMES.Station.BLL.Station().GetInfo(opeId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }

        protected void BindListBoxByOpeId(int flage, int opeId)
        {
            List<SKT.LeanMES.Station.Model.CertificationInfo> certification = new SKT.LeanMES.Station.BLL.Certification().GetStationCertMember(flage, opeId);
            string shtml = "<table class='ListTable' width='100%'>";
            shtml += "<tr class='ListTableHeader'>";
            shtml += "<th width='200px'>技能证书名称</th>";
            shtml += "<th>备注</th>";
            shtml += "</tr>";
            if (certification.Count == 0)
            {
                shtml += "<tr class='ListTableEmptyDataRow'><td colspan='2'>" + Resources.Messages.EmptyDataText + "</td></tr>";
            }
            for (int i = 0, j = certification.Count; i < j; i++)
            {
                if (i % 2 == 0)
                {
                    shtml += "<tr class='ListTableOddRow'>";
                }
                else
                {
                    shtml += "<tr class='ListTableEvenRow'>";
                }
                shtml += "<td>" + certification[i].Certification + "</td>";
                shtml += "<td>" + certification[i].Description + "</td></tr>";
            }
            shtml += "</table>";
            this.llStationSkill.Text = shtml;
        }


        protected SKT.LeanMES.Station.Model.StationInfo PageData
        {
            set
            {
                this.txtOperation.Text = value.Station;
                this.lblStatus.Text = Enum.GetName(typeof(EnumOperationStatus), value.StationStatus);
                this.txtDescription.Text = value.StationDesc;
                this.txtOpeType.Text = value.OpeType;
                this.txtResType.Text = value.ResTypeName;
                this.txtResDefault.Text = value.ResName;
                this.txtVersion.Text = value.StationRevision;
                this.lblIsCurrent.Text = (value.StationIsCurrentRev) ? Resources.Common.Yes : Resources.Common.No;
                this.txtOperationUITemp.Text = value.TempName.ToString();
                this.lblShortLetter.Text = value.ShortLetter;
            }
        }
    }
}