using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.SerialNumber.Model;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionAdditional : System.Web.UI.Page
    {
        public string userName = "";
        public int IOrderId = -1;
        public string IOrderNo = "";
        public string ItemCode = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInspection));
            userName = AccountController.GetCurrentUser().UserName;
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

            InspectionOrder bll = new InspectionOrder();
            InspectionOrderInfo info = bll.GetInfo(IOrderId);
            if (info != null)
            {
                ItemCode = info.ItemCode;
            }

            SKT.LeanMES.SerialNumber.BLL.Dictionary bllDictionary = new LeanMES.SerialNumber.BLL.Dictionary();
            List<DictionaryInfo> list = bllDictionary.GetAllByProperty(" Property = 'BadGrades'");
            ddlBadGrades.DataSource = list;
            ddlBadGrades.DataTextField = "Name";
            ddlBadGrades.DataValueField = "Value";
            ddlBadGrades.DataBind();
            ddlBadGrades.Items.Insert(0, new ListItem("无", ""));
        }
    }
}