using System;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{
    public partial class Inspection : BasePage
    {
        public string userName = "";
        public int IOrderId = -1;
        public string IOrderNo = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInspection));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterialIQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPurOrder));
            userName = AccountController.GetCurrentUser().EmployeeCName;
            /*界面类型 1：审核 2：检验  10：综合*/
            var TypeId = 0;
            if (Request["TypeId"] != null)
            {
                TypeId = Convert.ToInt32(Request["TypeId"]);
            }

            /*检验单类型*/
            var InspectionTypeId = 0;
            if (Request["InspectionTypeId"] != null)
            {
                InspectionTypeId = Convert.ToInt32(Request["InspectionTypeId"]);
                InspectionType iTypeBLL = new InspectionType();
                InspectionTypeInfo iTypeInfo = iTypeBLL.GetInfo(InspectionTypeId);
                this.lbInspectionTypeName.Text = iTypeInfo.InspectionTypeName + "检单号";
                
            }

            if (Request["IOrderId"] != null && Request["IOrderId"]!="")
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