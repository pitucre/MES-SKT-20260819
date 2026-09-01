using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Supplier
{
    public partial class ItemsInSupplier : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxItemsInSupplier));
            this.DisplayRoleInfo();
            this.BuildOperateButton();
        }

        /// <summary>
        /// 显示供应商信息。
        /// </summary>
        private void DisplayRoleInfo()
        {
            SKT.LeanMES.Supplier.BLL.Suppliers suply = new SKT.LeanMES.Supplier.BLL.Suppliers();
            SKT.LeanMES.Supplier.Model.SuppliersInfo suplyInfo = suply.GetInfo(Int32.Parse(Request.QueryString["ID"]));
            this.lblRoleName.Text = suplyInfo.VendorName.ToString();
        }
        /// <summary>
        /// 根据权限显示操作按钮。
        /// </summary>
        private void BuildOperateButton()
        {
            Int32 userId = AccountController.GetCurrentUser().UserId;
            if (Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 10200103)) //分配用户权限组
            {
                this.btnLeftChoose.Visible = true;
                this.btnLeftChoose.Attributes["title"] = "分配物料给供应商";
            }
            else
            {
                this.btnLeftChoose.Visible = false;
            }
            if (Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 10200103)) //分配用户权限组
            {
                this.btnRightChoose.Visible = true;
                this.btnRightChoose.Attributes["title"] = "移除供应商中的物料";
            }
            else
            {
                this.btnRightChoose.Visible = false;
            }
        }
    }
}