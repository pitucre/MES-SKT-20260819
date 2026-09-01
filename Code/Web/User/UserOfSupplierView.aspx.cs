using System;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;


namespace SKT.LeanMES.Web.User
{
    public partial class UserOfSupplierView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            MembershipInfo membershipInfo = (new Users()).GetInfo(Convert.ToInt32(idString));
            if (membershipInfo == null)
            {
                WebHelper.ShowMessage("对象可能，已被删除！");
                membershipInfo = new MembershipInfo();
            }

            this.lblUserName.Text = membershipInfo.UserName;
            this.lblCName.Text = membershipInfo.EmployeeCName;
            this.lblEName.Text = membershipInfo.EmployeeEName;
            this.lblEmployeeNo.Text = membershipInfo.EmployeeNo;
            this.lblDepartName.Text = membershipInfo.DepartName;
            this.lblSex.Text = (membershipInfo.Sex == 1) ? Resources.Common.Male : Resources.Common.Female;
            this.lblPhone.Text = membershipInfo.Phone;
            this.lblEmail.Text = "<a href='mailto:" + membershipInfo.Email + "'>" + membershipInfo.Email + "</a>";
            this.lblIsApproved.Text = (membershipInfo.IsApproved) ? "<span style='color:green'>已审核</span>" : "<span style='color:red'>未审核</span>";
            this.lblIsLockout.Text = (membershipInfo.IsLockedOut) ? "<span style='color:red'>已锁定</span>" : "正常";
            this.lblLinage.Text = membershipInfo.Linage.ToString();
            if (membershipInfo.UserType == -1)
            {
                this.lblUserType.Text = "系统用户";
            }
            else
            {
                this.uddlSupplier.SelectedValue = membershipInfo.UserType.ToString();
                this.lblUserType.Text = "[供应商] - " + this.uddlSupplier.SelectedItem.Text.ToString();
            }
            string userstatus = "正常";
            switch (membershipInfo.UserStatus)
            {
                case 1:
                    userstatus = "正常";
                    break;
                case 2:
                    userstatus = "离职";
                    break;
                case 3:
                    userstatus = "锁定";
                    break;
                case 4:
                    userstatus = "停用";
                    break;
                default:
                    break;
            }
            this.lblUserStatus.Text = userstatus;
        }
    }
}