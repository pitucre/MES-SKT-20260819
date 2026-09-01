using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Jig.Model;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Jig.BLL;

namespace SKT.LeanMES.Web.Jig
{
    public partial class JigView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            JigInfo jigInfo = (new SKT.LeanMES.Jig.BLL.Jig()).GetInfo(Convert.ToInt32(idString));

            this.lblJigName.Text = jigInfo.JigName;
            this.lblJigNickName.Text = jigInfo.JigNickName;
            //类型
            JigType type = new JigType();
            if (jigInfo.JigType > 0)
            {
                this.lblJigType.Text = type.GetInfo(jigInfo.JigType).TypeName;
            }
            else
            {
                this.lblJigType.Text = "";
            }
            //产品
            Item item = new Item();
            if (jigInfo.ItemId > 0)
            {
                this.lblItemId.Text = item.GetInfo(jigInfo.ItemId).ItemName;
            }
            else
            {
                this.lblItemId.Text = "";
            }
            //供应商
            Suppliers sp = new Suppliers();
            if (jigInfo.VendorId > 0)
            {
                this.lblVendorId.Text = sp.GetInfo(jigInfo.VendorId).VendorName;
            }
            else
            {
                this.lblVendorId.Text = "";
            }
            this.lblPosition.Text = jigInfo.Position;
            this.lblStandarLive.Text = Convert.ToString(jigInfo.StandarLive);
            //this.lblStandarMaint.Text = Convert.ToString(jigInfo.StandarMaint);
            this.lblUseCount.Text = Convert.ToString(jigInfo.UseCount);
            this.lblCreateBy.Text = jigInfo.CreateBy;
            this.lblCreateDateTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(jigInfo.CreateDateTime);
            this.lblModifyBy.Text = jigInfo.ModifyBy;
            this.lblModifyDateTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(jigInfo.ModifyDateTime);
            this.lblRemark.Text = jigInfo.Remark;
            this.lblCurPosition.Text = jigInfo.CurPosition;
            this.lblWarningTime.Text = jigInfo.WarningTime.ToString();
        }
    }
}