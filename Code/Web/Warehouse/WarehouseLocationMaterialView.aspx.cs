using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseLocationMaterialView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            var bll = new WarehouseLocationMaterial();
            var entity = bll.GetInfo(Convert.ToInt32(idString));

            BindViewModel(entity);
        }

        /// <summary>
        /// 绑定视图
        /// </summary>
        /// <param name="entity"></param>
        private void BindViewModel(WarehouseLocationMaterialInfo entity)
        {
            this.lblItemCode.Text = entity.ItemCode;
            this.lblCBarCode.Text = entity.CBarCode;
            this.lblCWhCode.Text = entity.CWhCode;
            this.lblRemark.Text = entity.Remark;
        }
    }
}