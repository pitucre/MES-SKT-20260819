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
    public partial class ScheduleUpdateCompare : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSchedule));

            string moCode = Request.QueryString["moCode"];
            string workSEQ = Request.QueryString["workSEQ"];
            string pubufts = Request.QueryString["pubufts"];

            if (!string.IsNullOrEmpty(moCode) && !string.IsNullOrEmpty(workSEQ) && !string.IsNullOrEmpty(pubufts))
            {
                Schedules bll = new Schedules();
                SchedulesInfo model = bll.GetInfo(moCode, workSEQ);
                if (model != null)
                {
                    this.PageDataOld = model;
                }

                ScheduleUpdate ubll = new ScheduleUpdate();
                ScheduleUpdateInfo umodel = ubll.GetInfo(moCode, workSEQ, pubufts);
                if (umodel != null)
                {
                    this.PageDataNew = umodel;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。 原内容
        /// </summary>
        private SchedulesInfo PageDataOld
        {
            set
            {
                lblOldMPID.InnerText = value.MPID.ToString();
                lblOldCreateDate.InnerText = value.CreatDate.ToString();
                lblOldOrderNO.InnerText = value.MoCode.ToString();
                lblOldBusType.InnerText = value.BusType.ToString();
                lblOldBusTypeName.InnerText = value.BusTypeName.ToString();
                lblOldInvCode.InnerText = value.InvCode.ToString();
                lblOldInvName.InnerText = value.InvName.ToString();
                lblOldUnit.InnerText = value.ComUnitCode.ToString();
                lblOldFactoryNO.InnerText = value.MDeptCode.ToString();
                lblOldSortSeq.InnerText = value.SortSeq.ToString();
                lblOldWorkSEQ.InnerText = value.WorkSEQ.ToString();
                lblOldQty.InnerText = value.Qty.ToString();
                lblOldPlanQty.InnerText = value.PlanQty.ToString();
                lblOldPlanDate.InnerText = value.PlanBeginDate.ToString();
                lblOldPlanEndDate.InnerText = value.PlanEndTime.ToString();

            }
        }

        /// <summary>
        /// 设置页面上的数据。 新内容
        /// </summary>
        private ScheduleUpdateInfo PageDataNew
        {
            set
            {
                lblNewMPID.InnerText = value.MPID.ToString();
                lblNewCreateDate.InnerText = value.CreatDate.ToString();
                lblNewOrderNO.InnerText = value.MoCode.ToString();
                lblNewBusType.InnerText = value.BusType.ToString();
                lblNewBusTypeName.InnerText = value.BusTypeName.ToString();
                lblNewInvCode.InnerText = value.InvCode.ToString();
                lblNewInvName.InnerText = value.InvName.ToString();
                lblNewUnit.InnerText = value.ComUnitCode.ToString();
                lblNewFactoryNO.InnerText = value.MDeptCode.ToString();
                lblNewSortSeq.InnerText = value.SortSeq.ToString();
                lblNewWorkSEQ.InnerText = value.WorkSEQ.ToString();
                lblNewQty.InnerText = value.Qty.ToString();
                lblNewPlanQty.InnerText = value.PlanQty.ToString();
                lblNewPlanDate.InnerText = value.PlanBeginDate.ToString();
                lblNewPlanEndDate.InnerText = value.PlanEndTime.ToString();
            }
        }
    }
}