using System;
using SKT.LeanMES.Maintenance.Model;
using SKT.LeanMES.Maintenance.BLL;

namespace SKT.LeanMES.Web.Maintenance
{
public partial class MaintenanceDemoEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaintenanceDemo));
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaintenanceDemoSub));
        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new MaintenanceDemo()).GetInfo(Convert.ToInt32(idString));
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private MaintenanceDemoInfo PageData
    {
        set
        {
            this.txtDemoCode.Text = value.DemoCode;
            this.txtDemoName.Text = value.DemoName;
            this.txtDescription.Text = value.Description;
            this.txtRemark.Text = value.Remark;
        }
    }
  }
}