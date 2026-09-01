using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentCheckOutPlanEdit : BasePage
    {
        public int ObjectType = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentCheckOutPlan));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var model = (new EquipmentCheckOutPlan()).GetInfo(Convert.ToInt32(idString));
                    ObjectType = model.ObjectType;
                    this.PageData = model;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentCheckOutPlanInfo PageData
        {
            set
            {
                this.txtEqCode.Text = value.EqCode;
                this.txtCheckType.SelectedValue = value.CheckType.ToString();
                this.txtCheckProject.Text = value.CheckProjectName;
                this.lblEqName.Text = value.EqName;
                HiddentxtCheckProject.Value= value.CheckProject;
                this.lblLastCheckTime.Text = value.LastTime.ToString("yyyy-MM-dd hh:mm:ss") == "9999-12-31 12:00:00" ? "":value.LastTime.ToString("yyyy-MM-dd hh:mm:ss");
                this.lblNextCheckTime.Text = value.NextTime.ToString("yyyy-MM-dd HH:mm:ss");
                this.txtCycleType.SelectedValue =value.CycleType;
                this.txtCycle.Text = Convert.ToString(value.Cycle);
                //this.txtCheckPlanName.Text = value.CheckPlanName;
                this.WarningTime.Text = value.WarningDays.ToString();

                //编辑只能编辑设备 不能编辑设备类型 所以修改效验对象只能设置成设备
                //this.ddlPlanObject.SelectedValue = "1";

                this.ddlPlanObject.SelectedValue = value.ObjectType.ToString();//modified by zhi.li on 20180730
                this.ddlEquipmentType.Text = value.EquipmentTypeName;
                this.HiddenEquipmentTypeId.Value = value.EquipmentType.ToString();


            }
        }
    }
}