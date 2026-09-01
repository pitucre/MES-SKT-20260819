using System;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionOrderProjectAffirm : BasePage
    {
        public int Id = -1;
        public int ProjectStatus = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
            if (Request["Id"] != null)
            {
                Id = Convert.ToInt32(Request["Id"]);

                InspectionOrder bll = new InspectionOrder();
                InspectionOrderInfo info = bll.GetInfo(Id);

                if (info != null)
                {
                    this.lbInspectionOrderNo.Text = info.InspectionOrderNo;
                    ProjectStatus = info.ProjectAffirmStatus;
                    this.txtRem.Text = info.ProjectAffirmRemark;
                }
            }
        }
    }
}