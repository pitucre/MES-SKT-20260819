using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Maintenance.BLL;
using SKT.LeanMES.Maintenance.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Maintenance
{
    public partial class MaintenanceEquimentPlanView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenancRelation));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenanceDemoSub));
            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                MaintenancePlanInfo model = null;
                model = (new MaintenancePlan()).GetEquimentInfo(Id);
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }

        private MaintenancePlanInfo PageData
        {
            set
            {
                this.lblEquipmentCode.Text = value.EquipmentCode.ToString();
                this.lblEquipmentName.Text = value.EquipmentName.ToString();
                hdMaintenancePlanId.Value = value.MaintenancePlanId.ToString();
                //this.lblLineName.Text = value.LineName.ToString();
                //this.lblStationName.Text = value.Station.ToString();
                //this.lblLifeTime.Text = value.LifeTime.ToString();
                this.lblCycleTime.Text = value.CycleTime.ToString();
                //this.lblMaintainDetail.Text = value.MaintainContents.ToString();
                this.lblMaintainActionPerson.Text = value.MaintainPerson.ToString();
                this.lblPrewarning.Text = value.Prewarning.ToString();
               // this.lblPreWarningReceiveEmail.Text = value.WarningEmail.ToString();
                this.lblPreWarningReceivePerson.Text = value.WarningTo.ToString();
                this.lblCycleType.Text = value.CycleTypeStr.ToString();
                this.lblMaintainWay.Text = value.MaintainWayStr.ToString();
                this.lblPlanName.Text = value.PlanName.ToString();
                this.txtLastTime.Text = value.LastMaintainTime.ToString() == "01/01/1971 00:00:00" ? "" : value.LastMaintainTime.ToString();
                this.lblMaintainTime.Text = value.FinisheDateTime.ToString("yyyy-MM-dd HH:mm:ss");
                string cycletype = lblCycleType.Text.ToString();
                if (value.MaintainWay == 1)//周期
                {
                    switch (value.CycleType)
                    {
                        case 1:
                            //lblLifeTime.Text += "　Hours";
                            lblCycleTime.Text += "　Hours";
                            lblPrewarning.Text += "　Hours";
                            break;
                        case 2:
                            //lblLifeTime.Text += "　Day";
                            lblCycleTime.Text += "　Day";
                            lblPrewarning.Text += "　Day";
                            break;
                        case 3:
                            //lblLifeTime.Text += "　Weeks";
                            lblCycleTime.Text += "　Weeks";
                            lblPrewarning.Text += "　Day";
                            break;
                        case 4:
                            //lblLifeTime.Text += "　Months";
                            lblCycleTime.Text += "　Months";
                            lblPrewarning.Text += "　Day";
                            break;
                        case 5:
                            //lblLifeTime.Text += "　Years";
                            lblCycleTime.Text += "　Years";
                            lblPrewarning.Text += "　Day";
                            break;
                        default:
                            //lblLifeTime.Text += "　Times";
                            lblCycleTime.Text += "　Times";
                            lblPrewarning.Text += "　Times";
                            break;
                    }
                }
                else
                {
                    //lblLifeTime.Text += "　Times";
                    lblCycleTime.Text += "　Times";
                    lblPrewarning.Text += "　Times";
                }
            }
        }
    }
}