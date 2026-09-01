using System;
using SKT.LeanMES.WorkShop.BLL;
using SKT.LeanMES.WorkShop.Model;

namespace SKT.LeanMES.Web.WorkShop
{
    public partial class WorkShopEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWorkShop));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.WorkShop.BLL.WorkShop()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WorkShopInfo PageData
        {
            set
            {
                this.txtWorkShopName.Text = value.WorkShopName;
                //this.txtWorkShopCode.Text = value.WorkShopCode;
                //this.txtWorkShopCode.Enabled = false;
                SKT.LeanMES.Factory.BLL.Factory bll = new SKT.LeanMES.Factory.BLL.Factory();
                SKT.LeanMES.Factory.Model.FactoryInfo model = null;
                this.txtShiftList.Text = value.ShiftName;
                this.hdfShiftList.Value = value.ShiftId.ToString();
                this.txtPrincipal.Text = Convert.ToString(value.CName);
                this.hidPrincipal.Value = Convert.ToString(value.Principal);
                model = bll.GetInfo(value.FactoryId);
                if (model != null)
                {
                    this.txtFactoryName.Text = model.FactoryName;
                    this.hdfFactory.Value = model.FactoryID.ToString();
                }
                this.txtRemark.Text = value.Remark;
                this.txtTemperature.Text = value.Temperature;
                this.txtHumidity.Text = value.Humidity;
            }
        }
    }
}