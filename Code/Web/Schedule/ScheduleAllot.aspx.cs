using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Schedule.BLL;
using SKT.LeanMES.Schedule.Model;

namespace SKT.LeanMES.Web.Schedule
{
    public partial class ScheduleAllot : BasePage
    {
        public decimal PlanQty = 0;
        public int IsKitting = 0;
        public int IsPublish = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSchedule));

            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                Schedules bll = new Schedules();
                SchedulesInfo model = bll.GetInfo(Convert.ToInt32(Id));
                if (model != null)
                {
                    this.PageData = model;
                }

            }
        }


        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SchedulesInfo PageData
        {
            set
            {
                lblWorkSEQ.Text = value.WorkSEQ.ToString();
                lblOrderNO.Text = value.MoCode.ToString();
                lblPlanQty.Text = value.PlanQty.ToString();
                lblAllotQty.Text = value.AllotQty.ToString();

                PlanQty = value.PlanQty;
                IsKitting = value.KittingStatus;
                IsPublish = value.PublishStatus;
            }
        }
    }
}