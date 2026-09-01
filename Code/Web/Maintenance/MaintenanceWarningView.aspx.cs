using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Maintenance.Model;
using SKT.LeanMES.Maintenance.BLL;

namespace SKT.LeanMES.Web.Maintenance
{
    public partial class MaintenanceWarningView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenancRelation));
            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                int maintainId = Convert.ToInt32(Request.QueryString["Id"]);

                MaintenanceWarningInfo model = null;
                model = (new MaintenanceWarning()).GetInfo(maintainId);

                if (model != null)
                {
                    this.PageData = model;
                }
            }

        }

        private MaintenanceWarningInfo PageData
        {
            set
            {
                if (value.MaintainWay == 1)
                {
                    this.lblWillMaintainOfDateTime.Text = value.WillMaintainOfDateTime.ToString();
                    this.lblWillSendWarningDateTime.Text = value.WillSendWarningDateTime.ToString();
                    this.tr1ByUsage.Visible = false;
                    this.tr2ByUsage.Visible = false;
                }
                else if (value.MaintainWay == 2)
                {
                    this.lblUsage.Text = value.UsedTimes.ToString();
                    this.lblLastTimes.Text = value.LastTimes.ToString();
                    this.lblLifeTime.Text = value.LifeTime.ToString();
                    this.trByCycle.Visible = false;
                }
                this.hdfPlanId.Value = value.MaintenancePlanId.ToString();
                this.lblWillSendWarningTimes.Text = value.WillSendWarningTimes.ToString();
                this.lblWillMaintainOfTimes.Text = value.WillMaintainOfTimes.ToString();
                this.lblEquipmentCode.Text = value.EquipmentCode.ToString();
                this.lblEquipmentName.Text = value.EquipmentName.ToString();
                //this.lblLineName.Text = value.LineName.ToString();
                //this.lblStation.Text = value.StationName.ToString();
                this.lblCycleTime.Text = value.CycleTime.ToString();
                this.lblCycleType.Text = value.CycleTypeStr.ToString();
                this.lblLastDateTime.Text = value.LastDateTime.ToString().Replace("/", "-");
                this.lblMaintainActionPerson.Text = value.MaintainPerson.ToString();
                //this.lblMaintainContents.Text = value.MaintainContents.ToString();
                this.lblMaintainWay.Text = value.MaintainWayStr.ToString();
                this.lblStatusStr.Text = value.StatusStr.ToString();
                this.lblTimeoutWarning.Text = value.TimeoutWarning.ToString();
                this.lblWarningEmail.Text = value.WarningEmail.ToString();
                this.lblWarningTo.Text = value.WarningTo.ToString();


                if (value.MaintainWay == 1)//周期
                {
                    switch (value.CycleType)
                    {
                        case 1: lblLifeTime.Text += "　Hours";
                                lblCycleTime.Text += "　Hours";
                            break;
                        case 2: lblLifeTime.Text += "　Day";
                                lblCycleTime.Text += "　Day";
                            break;
                        case 3: lblLifeTime.Text += "　Weeks";
                                lblCycleTime.Text += "　Weeks";
                            break;
                        case 4: lblLifeTime.Text += "　Months";
                                lblCycleTime.Text += "　Months";
                            break;
                        case 5: lblLifeTime.Text += "　Years";
                                lblCycleTime.Text += "　Years";
                            break;
                        default: lblLifeTime.Text += "　Times";
                                 lblCycleTime.Text += "　Times";
                            break;
                    }
                }
                else
                {
                    lblLifeTime.Text += "　Times";
                    lblCycleTime.Text += "　Times";

                }
            }
        }

    }
}