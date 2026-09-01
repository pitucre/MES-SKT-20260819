using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseLocationEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouse));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                this.ddlWarehouseProperty.Items.Add(new ListItem("一般性仓库", "S"));
                this.ddlWarehouseProperty.Items.Add(new ListItem("在制品仓库", "W"));
                this.ddlProductIsOnly.Items.Add(new ListItem("否", "0"));
                this.ddlProductIsOnly.Items.Add(new ListItem("是", "1"));
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new WarehouseLocation()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WarehouseLocationInfo PageData
        {
            set
            {

                txtScode.Text = value.CStoreCode;
                txtSname.Text = value.CStoreName;

                txtPcode.Text = value.CPosCode;
                txtPname.Text = value.CPosName;

                txtMOrder.Text = value.MOrder;
                txtPOrder.Text = value.POrder;

                txtInOrder.Text = value.InOrder.ToString();
                txtAGVLandmarkCode.Text = value.AGVLandmarkCode;

                txtGrade.Text = Convert.ToString(value.IPosGrade);
                txtPosEnd.Text = Convert.ToString(value.BPosEnd);

                txtMaxCubage.Text = Convert.ToString(value.IMaxCubage);
                txtMaxWeight.Text = Convert.ToString(value.IMaxWeight);

                txtRemark.Text = value.Remark;

                this.hdnWhID.Value = value.WMSWarehouseId.ToString();  //仓库存储ID   
                this.hdnWhCode.Value = value.CWhCode.ToString();         //仓库存储编号 

                this.sltLoctionType.Value = value.LocationType;
                this.txtShiftCode.Text = value.ShiftCode;

                ddlWarehouseProperty.SelectedValue = value.CProperty.ToString();
                ddlProductIsOnly.SelectedValue = value.ProductIsOnly.ToString();

                this.sltUni_pak.Value = value.IsUniPakPos.ToString();
                if (value.WarehouseLocationId != -1)
                {
                    SKT.LeanMES.Warehouse.Model.WarehouseInfo WHInfo = (new SKT.LeanMES.Warehouse.BLL.Warehouse()).GetInfo(Convert.ToInt32(value.WMSWarehouseId));
                    this.txtWhInfo.Text = (WHInfo == null) ? "" : WHInfo.CWhCode + "|" + WHInfo.CWhName;
                }
                else
                {
                    txtWhInfo.Text = "";
                }
            }
        }
    }
}