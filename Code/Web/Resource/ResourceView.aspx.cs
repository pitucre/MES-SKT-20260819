using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.Resource.Model;
using SKT.Common.Utility;

namespace SKT.LeanMES.Web.Resource
{
    public partial class ResourceView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceResource));
            if (!IsPostBack)
            {
                string resIdStr = Request.QueryString["ID"];
                int resId = Convert.ToInt32(resIdStr);
                 BindCertiByResId(2, resId);
 
                if (resId > -1)
                {
                    SKT.LeanMES.Resource.Model.ResourceInfo model = new LeanMES.Resource.BLL.Resource().GetInfo(resId);
                    if (model != null)
                    {
                        this.PageData = model;
                     }
                }
            }
        }

        protected void BindCertiByResId(int flage, int resId)
        {
            List<SKT.LeanMES.Station.Model.CertificationInfo> resourceType = new SKT.LeanMES.Station.BLL.Certification().GetInfoByResId(flage, resId);
            string shtml = "<table class='ListTable' width='100%'>";
            shtml += "<tr class='ListTableHeader'>";
            shtml += "<th>资源证书</th>";
            shtml += "<th width='120px'>证书类型</th>";
            shtml += "</tr>";
            if (resourceType.Count == 0)
            {
                shtml += "<tr class='ListTableEmptyDataRow'><td colspan='2'>" + Resources.Messages.EmptyDataText + "</td></tr>";
            }
            for (int i = 0, j = resourceType.Count; i < j; i++)
            {
                if (i % 2 == 0)
                {
                    shtml += "<tr class='ListTableOddRow'>";
                }
                else
                {
                    shtml += "<tr class='ListTableEvenRow'>";
                }
                shtml += "<td>"+resourceType[i].Certification+"</td>";
                shtml += "<td>"+resourceType[i].Type+"</td></tr>";
            }
            shtml += "</table>";
            this.llCertificationList.Text = shtml;
        }
        
        
        protected ResourceInfo PageData
        {
            set
            {
                this.lblResName.Text = value.ResName;
                this.lblResType.Text = value.ResTypeName;
                this.lblLine.Text = value.LineName;
                this.lblEquipmentName.Text = value.EquipmentName;
                this.lblStatus.Text = Enum.GetName(typeof(EnumResourceStatus), value.ResStatus);
                this.lblValidTime.Text = TypeHelper.ToShortDateString(value.ValidStartTime) + " ~ " + ((String.IsNullOrEmpty(TypeHelper.ToShortDateString(value.ValidEndTime))) ? "无限期" : TypeHelper.ToShortDateString(value.ValidEndTime));
                this.lblDescription.Text = value.ResDescription;
            }
        }
    }
}