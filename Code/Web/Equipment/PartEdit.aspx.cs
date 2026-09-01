using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.Supplier.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class PartEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPart));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new Part()).GetInfo(Convert.ToInt32(idString));
                    this.txtPartCode.Enabled = false;
                    this.txtCuStock.Enabled = false;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PartInfo PageData
        {
            set
            {
                txtCuStock.Text = value.CurrentStock.ToString();
                txtMinStock.Text = value.MinStock.ToString();
                txtMaxStock.Text = value.MaxStock.ToString();
               
                this.txtPartName.Text = value.PartName;
                this.txtPartCode.Text = value.PartCode;
                this.hndPardId.Value = Convert.ToString(value.PartId);
                //备件类别
                this.ddlEquipmentType.Text = value.EquipmentTypeName;
                this.HiddenEquipmentTypeId.Value= Convert.ToString(value.EquipmentTypeId);

                this.txtPartStand.Text = value.PartStand;

                //生产厂商
                this.txtFactoryName.Text = value.FactoryName;
                this.hdnFactoryId.Value = Convert.ToString(value.FactoryId);

                //this.txtPartBrand.Text = value.PartBrand;

                //供应商
                this.hdnPartSupplierId.Value = Convert.ToString(value.PartSupplierId);
                this.txtPartSupplierName.Text = value.SupplierName;

                //存放位置
                this.HiddenPosition.Value = Convert.ToString(value.Position);
                this.txtPosition.Text = value.PositionName;

                //this.txtFactoryDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.FactoryDate);
                this.txtPartLive.Text = (value.PartLive!=""?value.PartLive.Split(',')[0]:"");
                //this.selectStatus.Value = Convert.ToString(value.PartStatus);
                //this.hdnEquipmentId.Value = Convert.ToString(value.EquimentId);
                //设备
              
                //this.txtEquipmentName.Text = (eqInfo == null ? "" : eqInfo.EquipmentName);
                this.txtUnitname.Text = value.UnitName;
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}