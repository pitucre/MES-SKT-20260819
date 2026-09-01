using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Web.MaterialCheck
{
    public partial class WarehouseCheckOrderEdit : BasePage
    {
        private int checkOrderId;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouse));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                hfCheckTypeList.Value = (new PubItems.BLL.PubItems()).GetSelectType("Basal_WarehouseCheckType",
        "WarehouseCheckTypeId,WarehouseCheckTypeId,WarehouseCheckTypeName", "");
                checkOrderId = Convert.ToInt32(idString);

                if (idString != null && checkOrderId > 0)
                {
                    this.PageData = (new WarehouseCheckOrder()).GetInfo(Convert.ToInt32(idString));
                    txtCheckOrder.Enabled = false;
                    int warehouseId = Convert.ToInt32(hdnWhID.Value);
                    //hfMaterialList.Value = (new WarehouseCheckOrder()).GetMaterialForCheck(1, checkOrderId, warehouseId);
                    //hfMaterialChossing.Value = (new WarehouseCheckOrder()).GetMaterialForCheck(2, checkOrderId, warehouseId);
                }

            }
        }


        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WarehouseCheckOrderInfo PageData
        {
            set
            {
                this.txtCheckOrder.Text = value.CheckOrder;
                this.hfSelType.Value = value.CheckType;
                lbOrderStatus.Text = value.StatusDesc;
                this.hdnWhID.Value = Convert.ToString(value.WarehouseId);
                txtWhCode.Text = value.Warehouse;
                txtBeginDate.Value = SKT.Common.Utility.TypeHelper.ToShortDateString(value.BeginDate);
                //this.txtCheckOrderStatus.Value = Convert.ToString(value.CheckOrderStatus);
                this.hdnRemark.Value = value.Remark;
                this.txtCheckOrderName.Value = value.CheckOrderName;
            }
        }

    }
}