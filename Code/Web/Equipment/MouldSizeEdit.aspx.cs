using System;
using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System.Collections.Generic;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldSizeEdit : BasePage
    {
        string action = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldSizeEdit));

            if (!this.IsPostBack)
            {
                action =  Request.QueryString["action"];
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new MoludSizeManger()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        [AjaxMethod]
        public void Edit(MoludSizeMangerInfo entity)
        {
            try
            {
                new MoludSizeManger().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public EquipmentsInfo GetMouldInfo(int mouldId)
        {
            EquipmentsInfo model = null;
            try
            {
                Equipments bll = new Equipments();
                model = bll.GetInfo(mouldId.ToString());
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;
            ;
        }

       

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MoludSizeMangerInfo PageData
        {
            set
            {
                if(action != "Copy")
                {
                    this.txtExternalDiameter1.Text = value.ExternalDiameter1.ToString();
                    this.txtExternalDiameter2.Text = value.ExternalDiameter2.ToString();
                    this.txtExternalDiameter3.Text = value.ExternalDiameter3.ToString();
                    this.lblExternalDiameterAvg.Text = value.ExternalDiameterAvg.ToString();

                    this.txtInternalDiameter1.Text = value.InternalDiameter1.ToString();
                    this.txtInternalDiameter2.Text = value.InternalDiameter2.ToString();
                    this.txtInternalDiameter3.Text = value.InternalDiameter3.ToString();
                    this.lblInternalDiameterAvg.Text = value.InternalDiameterAvg.ToString();

                    this.txtTestItem3_1.Text = value.TestItem3_1.ToString();
                    this.txtTestItem3_2.Text = value.TestItem3_2.ToString();
                    this.txtTestItem3_3.Text = value.TestItem3_3.ToString();
                    this.lblTestItem3Avg.Text = value.TestItem3Avg.ToString();                    
                }
               

                this.txtMouldCode.Text = value.MouldeCode;
                this.lblBomName.Text = value.BomName;
                this.lblMouldTypeName.Text = value.ComponentName;
                this.hdnMouldId.Value = value.MouldId.ToString();
                this.txtHardness.Text = value.Hardness.ToString();
                this.hdnIsHege.Value = value.Result.ToString();
                txtRemark.Text = value.Remark;

                this.txtInternalDiameterMin.Text = value.InternalDiameterMin.ToString();
                this.txtInternalDiameterMax.Text = value.InternalDiameterMax.ToString();
                this.txtExternalDiameterMin.Text = value.ExternalDiameterMin.ToString();
                this.txtExternalDiameterMax.Text = value.ExternalDiameterMax.ToString();

                this.txtTestItemMin3.Text = value.TestItem3Min.ToString();
                this.txtTestItemMax3.Text = value.TestItem3Max.ToString();
                this.txtUnits.Text = value.Units;

            }
        }
    }
}