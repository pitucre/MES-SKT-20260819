using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.MSD.Model;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Web.Plan
{
    public partial class SchedulPlanConfigEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SchedulPlanConfigEdit));
            var pid = Request.QueryString["ID"];
            if (!this.IsPostBack)
            {
                SKT.LeanMES.Plan.BLL.SchedulPlanConfig bll =new SKT.LeanMES.Plan.BLL.SchedulPlanConfig();
                if (pid !="-1")
                {
                    PageData=bll.GetInfo(Convert.ToInt32(pid));
                    hidPid.Value = pid;
                }
              
            }
        }

        private SKT.LeanMES.Plan.Model.SchedulPlanConfigInfo PageData
        {
            set
            {
                this.txtName.Text = value.Name;
                this.txtRemark.Text = value.Remark;
                ddlStatus.SelectedIndex = value.IsEnable;

            }
        }

        [AjaxMethod]
        public  List<SKT.LeanMES.Plan.Model.SchedulPlanConfigDetailInfo> GetDetailAll(int pid)
        {
            SearchSettings search = new SearchSettings();

            search.ExtensionCondition += " Pid="+pid;
            try
            {
                return new SKT.LeanMES.Plan.BLL.SchedulPlanConfig().GetDetailAll(0,Int32.MaxValue,"",search);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }


        [AjaxMethod]
        public void Save(SKT.LeanMES.Plan.Model.SchedulPlanConfigInfo entity)
        {
           
            try
            {
                 new SKT.LeanMES.Plan.BLL.SchedulPlanConfig().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
           
        }
    }
}