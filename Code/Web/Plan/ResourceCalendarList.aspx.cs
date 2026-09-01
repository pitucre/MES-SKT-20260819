using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using NPOI.SS.Formula.Functions;
using SKT.Common.Model;
using SKT.LeanMES.Plan.BLL;
using SKT.LeanMES.Plan.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Plan
{
    public partial class ResourceCalendarList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
            AjaxPro.Utility.RegisterTypeForAjax(typeof(ResourceCalendarList));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicesShift));
        }
        [AjaxMethod]
        public List<ScheduleRecordInfo> GetList(int resourceId,string startTime,string endTime)
        {
            try
            {
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.AddCondition(" ResourceId", resourceId.ToString());
                searchSettings.ExtensionCondition = "StartTime BETWEEN '"+startTime+" 00:00:00"+"' AND '"+endTime+ " 23:59:59' AND EndTime BETWEEN '" + startTime + " 00:00:00" + "' AND '" + endTime + " 23:59:59'";
                ScheduleRecord bll =new ScheduleRecord();
                var resultList=bll.GetAll(0, 10000, "", searchSettings);


                return resultList;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
        }


        [AjaxMethod]
        public void Edit(ScheduleRecordInfo entity,string startTime,string endTime)
        {
            try
            {
                entity.CreateBy = AccountController.GetCurrentUserInfo().UserName;
                ScheduleRecord bll = new ScheduleRecord();
                startTime = startTime + " 00:00:00";
                endTime = endTime + " 23:59:59";
                entity.StartTime =Convert.ToDateTime(startTime);
                entity.EndTime = Convert.ToDateTime(endTime);
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                
                throw ex; 
            }
        }

        [AjaxMethod]
        public ScheduleRecordInfo GetScheduleRecordInfo(int id)
        {
            try
            {
                ScheduleRecord bll = new ScheduleRecord();
                var resultInfo= bll.GetInfo(Convert.ToInt32(id));
                return resultInfo;
            }
            catch (Exception ex)
            {

                throw ex;
               
            }
         
        }

        [AjaxMethod]
        public void Delete(string id)
        {
            try
            {
                ScheduleRecord bll = new ScheduleRecord();
                var createBy= AccountController.GetCurrentUserInfo().UserName;
                 bll.Delete(id.ToString(), createBy);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}