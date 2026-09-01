using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.Plan.BLL;
using SKT.LeanMES.Plan.Model;

namespace SKT.LeanMES.Web.Plan
{
    public partial class ResourceCalendarCopy : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(ResourceCalendarCopy));
            
         
            if (!this.IsPostBack)
            {
                String resourceId = Request.QueryString["ID"];
                String resName = Request.QueryString["ResName"];
                
                if (resourceId != null && Convert.ToInt32(resourceId) > 0)
                {
                    this.lblResName.Text = resName;
                    this.hdnResourceCopyId.Value = resourceId;

                }
            }
            
           
        }

        [AjaxMethod]
        public void CopyResourceCalendar(int resourceCopyId,int resourceId,string startTime,string endTime)
        {
            try
            {
                ScheduleRecord bll=new ScheduleRecord();
                bll.ScheduleRecordCopy(resourceCopyId, resourceId,startTime,endTime);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
       

    }
}