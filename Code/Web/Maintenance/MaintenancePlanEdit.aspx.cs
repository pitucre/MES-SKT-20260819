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
    public partial class MaintenancePlanEdit : BasePage
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
                        model = (new MaintenancePlan()).GetInfo(Id);
                        planObjectType = model.PlanObjectType;
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

                        // Bind();
                        //labLifeTime.Text = "　小时";
                        labCycleTime.Text = "　小时";
                        labPrewarning.Text = "　小时";
                    }
                }
            }
        }

        private MaintenancePlanInfo PageData
        {
            set
            {

                // this.lblStation.Text = value.Station.ToString();
                // this.txtLifeTime.Text = value.LifeTime.ToString();
                this.txtCycleTime.Text = value.CycleTime.ToString();
                // this.txtMaintainContents.Text = value.MaintainContents.ToString();
                this.txtMaintainPerson.Text = value.MaintainPerson.ToString();
                this.txtPrewarning.Text = value.Prewarning.ToString();
                // this.txtWarningEmail.Text = value.WarningEmail.ToString();
                this.txtWarningTo.Text = value.WarningTo.ToString();
                this.ddlCycleType.SelectedValue = value.CycleType.ToString();
                this.ddlMaintainWay.SelectedValue = value.MaintainWay.ToString();
                this.txtPlanName.Text = value.PlanName.ToString();
                string cycletype = ddlCycleType.SelectedValue.ToString();


                if (value.MaintainWay == 1)//周期
                {
                    ddlCycleType.Enabled = true;
                    switch (value.CycleType)
                    {
                        case 1:
                            //labLifeTime.Text = "　小时";
                            labCycleTime.Text = "　小时";
                            labPrewarning.Text = "　小时";
                            break;
                        case 2:
                            //labLifeTime.Text = "　天";
                            labCycleTime.Text = "　天";
                            labPrewarning.Text = "　天";
                            break;
                        case 3:
                            //labLifeTime.Text = "　周";
                            labCycleTime.Text = "　周";
                            labPrewarning.Text = "　天";
                            break;
                        case 4:
                            //labLifeTime.Text = "　月";
                            labCycleTime.Text = "　月";
                            labPrewarning.Text = "　天";
                            break;
                        case 5:
                            //labLifeTime.Text = "　年";
                            labCycleTime.Text = "　年";
                            labPrewarning.Text = "　天";
                            break;
                        default:
                            //labLifeTime.Text = "　时间";
                            labCycleTime.Text = "　时间";
                            labPrewarning.Text = "　时间";
                            break;
                    }
                }
                else
                {
                    ddlCycleType.Enabled = false;
                    //labLifeTime.Text = "　时间";
                    labCycleTime.Text = "　时间";
                    labPrewarning.Text = "　时间";
                }
            }
        }

        /// <summary>
        /// 设备编码和名称的组合    下拉框绑定
        /// </summary>
        private void Bind()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            MaintenancePlan bll = new MaintenancePlan();
            List<MaintenancePlanInfo> dInfos = bll.BindDDL("EquipmentCode", searchSettings);

        }
    }
}