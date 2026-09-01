using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionIPQCCheck : BasePage
    {
        public string userName = "";
        public int IOrderId = -1;
        public string IOrderNo = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInspectionOQC));
            userName = AccountController.GetCurrentUser().EmployeeCName;
            /*界面类型 1：审核 2：检验  10：综合*/
            var TypeId = 0;
            if (Request["TypeId"] != null)
            {
                TypeId = Convert.ToInt32(Request["TypeId"]);
            }
            
            if (Request["IOrderId"] != null && Request["IOrderId"] != "")
            {
                IOrderId = Convert.ToInt32(Request["IOrderId"]);
            }
            if (Request["IOrderNo"] != null)
            {
                IOrderNo = Request["IOrderNo"];
            }
        }
    }
}