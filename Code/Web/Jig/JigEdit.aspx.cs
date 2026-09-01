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
    public partial class JigEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxJig));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    try
                    {
                        this.PageData = (new SKT.LeanMES.Jig.BLL.Jig()).GetInfo(Convert.ToInt32(idString));
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(ex);
                    }
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
                this.txtJigName.Text = value.JigName;
                this.txtJigNickName.Text = value.JigNickName;
                this.txtJigType.Text = value.JigType.ToString();
                this.txtPosition.Text = value.Position;
                this.txtStandarLive.Text = value.StandarLive.ToString();
                //this.txtStandarMain.Text = value.StandarMaint.ToString();
                this.txtJigCode.Text = value.JigCode;
                this.txtJigCode.Enabled = false;
                this.txtRemark.Text = value.Remark;
                this.lblUseCount.Text = value.UseCount.ToString();
                this.lblCurPosition.Text = value.CurPosition;
                this.txtWarningTime.Text = value.WarningTime.ToString();

                //供应商
                this.hdnVendor.Value = value.VendorId.ToString();
                Suppliers sp = new Suppliers();
                if (value.VendorId > 0)
                {
                    this.txtVendorName.Text = sp.GetInfo(value.VendorId).VendorName;
                    this.hdnVendor.Value = value.VendorId.ToString();
                }
                else
                {
                    this.txtVendorName.Text = "";
                    this.hdnVendor.Value = "-1";
                }
                //产品
                Item item = new Item();
                if (value.ItemId > 0)
                {
                    this.txtItemName.Text = item.GetInfo(value.ItemId).ItemName;
                    this.hdnItemId.Value = value.ItemId.ToString();
                }
                else
                {
                    this.txtItemName.Text = "";
                    this.hdnItemId.Value = "-1";
                }

                
                //类型
                JigType type = new JigType();
                if (value.JigType > 0)
                {
                    this.txtJigType.Text = type.GetInfo(value.JigType).TypeName;
                    this.hdfType.Value = value.JigType.ToString();
                }
                else
                {
                    this.txtJigType.Text = "";
                    this.hdfType.Value = "-1";
                }
            }
        }
    }
}