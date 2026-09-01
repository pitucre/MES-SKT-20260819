using System;
using SKT.LeanMES.WorkShop.BLL;
using SKT.LeanMES.WorkShop.Model;

namespace SKT.LeanMES.Web.WorkShop
{
    public partial class WorkShopView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            WorkShopInfo workShopInfo = (new SKT.LeanMES.WorkShop.BLL.WorkShop()).GetInfo(Convert.ToInt32(idString));



            this.lblWorkShopName.Text = workShopInfo.WorkShopName;
            this.lblFactoryName.Text = workShopInfo.ShiftName;

            SKT.LeanMES.Factory.BLL.Factory bll = new SKT.LeanMES.Factory.BLL.Factory();
            SKT.LeanMES.Factory.Model.FactoryInfo model = null;
            model = bll.GetInfo(workShopInfo.FactoryId);
            if (model != null)
            {
                this.lblWorkShopCode.Text = model.FactoryName;
            }
            this.lblRemark.Text = workShopInfo.Remark;

        }
    }
}