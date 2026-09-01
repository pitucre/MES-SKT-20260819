using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Maintenance.BLL;
using SKT.LeanMES.Maintenance.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Maintenance
{
    public partial class MaintenanceEquimentEdit : BasePage
    {
        public int planObjectType = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenance));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenancRelation));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenanceDemoSub));
            int i = 0;

            if (Request.QueryString["Id"] != null)
            {
                if (int.TryParse(Request.QueryString["Id"].ToString(), out i))
                {
                    int Id = Convert.ToInt32(Request.QueryString["Id"]);

                    if (Id > 0) //编辑模式，设备选择下拉行隐藏。绑定页面信息数据
                    {


                        MaintenancePlanInfo model = null;
                        model = (new MaintenancePlan()).GetEquimentInfo(Id);
                        planObjectType = model.EquipmentName == "Feeder" ? 3 : model.PlanObjectType;
                        //if (model.PlanObjectType == 1)
                        //{
                        //    trEqptmpadd.Visible = false;
                        //    trPlanObjectadd.Visible = false;
                        //    trPlanObjectedit.Visible = false;
                        //}
                        //else
                        //{
                        //    trEqptmpadd.Visible = false;
                        //    trEqptmpedit.Visible = false;
                        //    trPlanObjectedit.Visible = false;
                        //}

                        if (model != null)
                        {
                            this.PageData = model;
                        }
                    }
                    else //如果是增加模式，那么编辑行隐藏。绑定下拉数据
                    {
                        //trEqptmpedit.Visible = false;
                        //trPlanObjectadd.Visible = false;
                        //trPlanObjectedit.Visible = false;


                        //labLifeTime.Text = "　Hours";

                    }
                }
            }
        }

        private MaintenancePlanInfo PageData
        {
            set
            {
                this.txtLastTime.Text = value.LastMaintainTime.ToString();
                this.txtMaintainTime.Text = value.FinisheDateTime.ToString();
                this.lblEquipmentCode.Text = value.EquipmentCode.ToString();
                this.lblEquipmentName.Text = value.EquipmentName.ToString();
                this.HiddenEquipmentId.Value = value.EquipmentId.ToString();
                this.hdMaintenancePlanId.Value = value.MaintenancePlanId.ToString();



                this.txtPlanName.Text = value.PlanName.ToString();
                this.ddlPlanObject.SelectedValue = value.PlanObjectType.ToString();
                this.ddlEquipmentType.Text = value.EquipmentTypeName;
                this.HiddenEquipmentTypeId.Value = value.EquipmentType.ToString();
                this.txtRemark.Text = value.Remark;
                this.lblEquipmentTypeName.Text = value.EquipmentTypeName;

                HidFeedID.Value = value.EquipmentId.ToString();

            }
        }


    }
}