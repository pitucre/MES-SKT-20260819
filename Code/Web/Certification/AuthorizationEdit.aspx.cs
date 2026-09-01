using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Certification
{
    public partial class AuthorizationEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCertification));

            this.DisplayUserInfo();
            this.BuildOperateButton();
        }
        /// <summary>
        /// 显示用户信息。
        /// </summary>
        private void DisplayUserInfo()
        {
            SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
            SKT.Common.Account.Model.MembershipInfo userInfo = user.GetInfo(Int32.Parse(Request.QueryString["ID"]));

            this.lblLogID.Text = userInfo.UserName;
            this.lblEmployeeNOText.Text = userInfo.EmployeeNo;
            this.lblCNameText.Text = userInfo.EmployeeCName;
            this.lblUserNameText.Text = userInfo.EmployeeEName;
            this.txtStart.Text = DateTime.Today.ToString("yyyy/MM/dd");
            this.txtExpiration.Text = DateTime.Today.AddYears(1).ToString("yyyy/MM/dd");
            //this.lblLogID.Enabled = false;
        }

        /// <summary>
        /// 根据权限显示操作按钮。
        /// </summary>
        private void BuildOperateButton()
        {
            Int32 userId = AccountController.GetCurrentUser().UserId;
            SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();

            if (user.GetPopedomUsers(0, -1, 10100105).Count > 0 || userId == -1) //授权用户岗位认证
            {
                this.btnLeftChoose.Disabled = false;
                this.btnLeftChoose.Attributes["title"] = "授权用户岗位认证";
            }
            else
            {
                this.btnLeftChoose.Disabled = true;
                this.btnLeftChoose.Attributes["title"] = "您没有授权权限";
            }

            if (user.GetPopedomUsers(0, -1, 10100105).Count > 0 || userId == -1) //移除用户岗位认证
            {
                this.btnRightChoose.Disabled = false;
                this.btnRightChoose.Attributes["title"] = "移除用户的认证";
            }
            else
            {
                this.btnRightChoose.Disabled = true;
                this.btnRightChoose.Attributes["title"] = "您没有移除权限";
            }
        }
    }
}