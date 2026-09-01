using System;
using SKT.LeanMES.Maintenance.Model;
using SKT.LeanMES.Maintenance.BLL;

namespace SKT.LeanMES.Web.Maintenance
{
public partial class MaintenanceDemoView : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String idString = Request.QueryString["ID"];
        MaintenanceDemoInfo maintenanceDemoInfo = (new MaintenanceDemo()).GetInfo(Convert.ToInt32(idString));
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaintenanceDemoSub));
            this.lblDemoCode.Text = maintenanceDemoInfo.DemoCode;
        this.lblDemoName.Text = maintenanceDemoInfo.DemoName;
        this.lblDescription.Text = maintenanceDemoInfo.Description;
        this.txtRemark.Text = maintenanceDemoInfo.Remark;
        this.txtRemark.Enabled = false;
    }
  }
}