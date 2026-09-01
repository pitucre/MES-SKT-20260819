using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldSupplierDeliveryTime : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldSupplierDeliveryTime));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["Id"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new Equipments()).GetInfo(idString);
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentsInfo PageData
        {
            set
            {
                txtDeliveryTime.Text = value.DeliveryTime.ToString("yyyy-MM-dd")== "9999-12-31" ? "":value.DeliveryTime.ToString("yyyy-MM-dd");
            }
        }

        [AjaxMethod]
        public void DeliveryTime(int mouldId, string deliveryTime, decimal maintenanceCosts)
        {
            Equipments bll = new Equipments();
            try
            {
                bll.MouldSupplierDeliveryTime(mouldId, deliveryTime, maintenanceCosts);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}