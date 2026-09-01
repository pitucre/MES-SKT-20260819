using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.Web.Controls;
using SKT.LeanMES.Web.AjaxServices;
//using SKT.MES.Web.AppCode.AjaxServices.CirculationContainer;
//using SKT.MES.Web.AjaxServices.BasalData;
//using SKT.MES.Web.AjaxServices.Production;

namespace SKT.MES.Web.BasalData
{
    public partial class ContainerPrint :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            AjaxPro.Utility.RegisterTypeForAjax(typeof(PageSQLService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxContainer));
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCirContainer));
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicesNextNumber));
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicePOD));
        }
    }
}