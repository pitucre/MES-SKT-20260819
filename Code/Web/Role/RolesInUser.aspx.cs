using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Role
{
    public partial class RolesInUser : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));

            this.DisplayUserInfo();
            this.BuildOperateButton();
        }

        /// <summary>
        /// 显示用户信息。
        /// </summary>
        private void DisplayUserInfo()
        {
            Common.Account.BLL.Users user = new Common.Account.BLL.Users();
            MembershipInfo userInfo = user.GetInfo(Int32.Parse(Request.QueryString["ID"]));

            if(userInfo != null)
            {
                this.lblCNameText.Text = userInfo.EmployeeCName;
                this.lblEmployeeNOText.Text = userInfo.EmployeeNo;
                this.lblNameText.Text = userInfo.UserName;
                this.lblENameText.Text = userInfo.EmployeeEName;
            }
        }

        /// <summary>
        /// 根据权限显示操作按钮。
        /// </summary>
        private void BuildOperateButton()
        {
            Int32 userId = AccountController.GetCurrentUser().UserId;

            if (Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 10100104)) //分配用户权限组
            {
                this.btnLeftChoose.Visible = true;
                this.btnLeftChoose.Attributes["title"] = "分配角色给用户";
            }
            else
            {
                this.btnLeftChoose.Visible = false;
            }

            if (Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 10100104)) //分配用户权限组
            {
                this.btnRightChoose.Visible = true;
                this.btnRightChoose.Attributes["title"] ="移除用户的角色";
            }
            else
            {
                this.btnRightChoose.Visible = false;
            }
        }
    }
}