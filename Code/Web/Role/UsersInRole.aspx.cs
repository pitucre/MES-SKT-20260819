using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Role
{
    public partial class UsersInRole : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));

             this.BuildOperateButton();
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
                this.btnLeftChoose.Attributes["title"] = "分配用户给角色";
            }
            else
            {
                this.btnLeftChoose.Visible = false;
            }

            if (Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 10200103)) //分配用户权限组
            {
                this.btnRightChoose.Visible = true;
                this.btnRightChoose.Attributes["title"] = "移除角色中的用户";
            }
            else
            {
                this.btnRightChoose.Visible = false;
            }
        }
    }
}