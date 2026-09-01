using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using System;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseAGVMarkEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouse));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                BindCategoryName();
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    WarehouseAGVMark avg = new WarehouseAGVMark();
                    this.PageData = avg.GetInfo(Convert.ToInt32(idString));
                }
            }
        }
        /// <summary>
        /// 绑定区域名称
        /// </summary>
        protected void BindCategoryName()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            this.ddlAGVAreaName.DataSource = new WarehouseAGVMark().GetAGVAreaAll(0, 100, "Id", searchSettings);
            this.ddlAGVAreaName.DataTextField = "CategoryName";
            this.ddlAGVAreaName.DataValueField = "CategoryName";
            this.ddlAGVAreaName.DataBind();
            this.ddlAGVAreaName.Items.Insert(0, new ListItem(Resources.lang.Choose, ""));
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WarehouseAGVMarkInfo PageData
        {
            set
            {
                this.txtAGVLandMarkCode.Text = value.AGVLandMarkCode.ToString();
                this.ddlAGVAreaName.Text = value.AGVAreaName.ToString();
                this.txtAGVLandMarkCodeSort.Text = value.AGVLandMarkCodeSort.ToString();
                this.hdnAGVDeliveryLocation.Value = value.AGVDeliveryLocation.ToString();
                this.hdnAGVMaterialLocation.Value = value.AGVMaterialLocation.ToString();
                this.txtRemark.Text = value.Remark.ToString();
                this.ddlAGVAreaName.SelectedValue = value.AGVAreaName;
                txtLaneSort.Text= value.LaneSort.ToString();


            }
        }
    }
}