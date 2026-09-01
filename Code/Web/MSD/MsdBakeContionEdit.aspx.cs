using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.MSD.BLL;
using SKT.LeanMES.MSD.Model;

namespace SKT.LeanMES.Web.MSD
{
    public partial class MsdBakeContionEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MsdBakeContionEdit));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.hdnItemId.Value = idString;
                    btnSelectItem.Disabled = true;
                    var entity = (new MsdBakeContion()).GetInfo(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }
                }
            }
        }

        [AjaxMethod]
        public int Edit(MsdBakeContionInfo entity)
        {
            
            entity.CreateBy = AccountController.GetCurrentUser().UserName;
            var bid = -1;
            try
            {
                bid= new SKT.LeanMES.MSD.BLL.MsdBakeContion().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return bid;

           
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SKT.LeanMES.MSD.Model.MsdBakeContionInfo PageData
        {
            set
            {
               
                this.txtMsl.Text = value.Msl;
                this.txtRemark.Text = Convert.ToString(value.Remark);
                this.txtHoursNumber.Text = Convert.ToString(value.HoursNum);
                this.txtTemperature.Text = Convert.ToString(value.Temperature);
                this.txtTemperature2.Text = Convert.ToString(value.TemperatureTwo);
                this.txtRemark.Text = value.Remark;
                //add HoursNum2、OverrunExposureTime by lizhi 20180605
                this.txtHoursNumber2.Text = Convert.ToString(value.HoursNum2);
                this.txtOverrunExposureTime.Text = Convert.ToString(value.OverrunExposureTime);

            }
        }
    }
}