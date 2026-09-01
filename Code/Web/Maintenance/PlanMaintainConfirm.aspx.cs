using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Maintenance.BLL;
using SKT.LeanMES.Maintenance.Model;

namespace SKT.LeanMES.Web.Maintenance
{
    public partial class PlanMaintainConfirm : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenance));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenancRelation));
            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                int eId = Convert.ToInt32(Request.QueryString["Id"]);

                MaintenancePlanInfo model = null;
                model = (new MaintenancePlan()).GetEquimentInfo(eId);
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
                if (value.MaintainWay == 1)
                {
                    trByUsage.Visible = false;
                }
                else
                {
                    lblEquipmentLifeTime.Text = value.LifeTime.ToString();
                    lblEquipmentUserCount.Text = value.Usage.ToString();
                }
                hdPlanId.Value = value.MaintenancePlanId.ToString();
                lblEquipmentCode.Text = value.EquipmentCode.ToString();
                lblEquipmentName.Text = value.EquipmentName.ToString();
                //lblLineName.Text = value.LineName.ToString();
                //lblStation.Text = value.Station.ToString();
                //lblLastDateTime.Text = value.FinisheDateTime.ToString();

                lblLastDateTime.Text = value.LastMaintainTime.ToString();

                lblMaintainWay.Text = value.MaintainWayStr.ToString();
                lblCycleType.Text = value.CycleTypeStr.ToString();
            
                lblMaintainPerson.Text = value.MaintainPerson.ToString();
                lblRecipient.Text = value.MaintainPerson.ToString();
                lblRecipientEmail.Text = value.WarningEmail.ToString();
                lblPrewarning.Text = value.Prewarning.ToString();
                lblCycleTime.Text = value.CycleTime.ToString();

                if (value.MaintainWay == 1)//周期
                {
                    switch (value.CycleType)
                    {
                        case 1: lblPrewarning.Text += "　Hours";
                            lblCycleTime.Text += "　Hours";
                            break;
                        case 2: lblPrewarning.Text += "　Day";
                            lblCycleTime.Text += "　Day";
                            break;
                        case 3: lblPrewarning.Text += "　Weeks";
                            lblCycleTime.Text += "　Weeks";
                            break;
                        case 4: lblPrewarning.Text += "　Months";
                            lblCycleTime.Text += "　Months";
                            break;
                        case 5: lblPrewarning.Text += "　Years";
                            lblCycleTime.Text += "　Years";
                            break;
                        default: lblPrewarning.Text += "　Times";
                            lblCycleTime.Text += "　Times";
                            break;
                    }
                }
                else
                {

                    lblCycleTime.Text += "　Times";
                    lblPrewarning.Text += "　Times";
                }
            }
        }

    }
}