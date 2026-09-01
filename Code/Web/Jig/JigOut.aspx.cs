using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Jig.Model;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.Jig.BLL;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.Jig
{
    public partial class JigOut : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxJigHistory));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.Jig.BLL.Jig()).GetInfo(idString);
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private JigInfo PageData
        {
            set
            {
                this.lblJigName.Text = value.JigName;
                this.lblJigNickName.Text = value.JigNickName;
                //类型
                JigType type = new JigType();
                if (value.JigType > 0)
                {
                    this.lblJigType.Text = type.GetInfo(value.JigType).TypeName;
                }
                else
                {
                    this.lblJigType.Text = "";
                }
                //供应商
                Suppliers sup = new Suppliers();
                this.lblVendorId.Text = sup.GetInfo(value.VendorId).VendorName;
                this.lblUseCount.Text = value.UseCount.ToString();
                this.lbStandarLive.Text = value.StandarLive.ToString();
                //出入库申请人
                SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();

                //产品名称
                Item item = new Item();
                if (value.ItemId > 0)
                {
                    this.lblItemId.Text = item.GetInfo(value.ItemId).ItemName;
                }
                else
                {
                    this.lblItemId.Text = "";
                }
                this.lblPosition.Text = value.Position;
                this.lblRemark.Text = value.Remark;
                this.lblCurPosition.Text = value.CurPosition;
            }
        }
    }
}