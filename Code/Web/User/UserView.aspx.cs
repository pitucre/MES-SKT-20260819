using System;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.User
{
    public partial class UserView : BasePage
    {
        public MembershipInfo membershipInfo = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            string IsGroup = Request.QueryString["IsGroup"];
            string ConnStr = "";
            if (IsGroup == "1")
            {
                ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
            }
            if (!string.IsNullOrEmpty(ConnStr))
            {
                membershipInfo = (new Users()).GetInfo(Convert.ToInt32(idString), ConnStr);
            }
            else
            {
                membershipInfo = (new Users()).GetInfo(Convert.ToInt32(idString), "");
            }

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
            this.lblIsApproved.Text = (membershipInfo.IsApproved) ? "<span style='color:green'>"+ Resources.lang.Audited + "</span>" : "<span style='color:red'>"+ Resources.lang.Unaudited + "</span>";
            this.lblIsLockout.Text = (membershipInfo.IsLockedOut) ? "<span style='color:red'>" + Resources.lang.Locked + "</span>" : Resources.lang.Normal;
            this.lblLinage.Text = membershipInfo.Linage.ToString();
            if (membershipInfo.UserType == -1)
            {
                this.lblUserType.Text = Resources.lang.SystemUser;
            }
            else
            {
                this.uddlSupplier.SelectedValue = membershipInfo.UserType.ToString();
                this.lblUserType.Text = "["+ Resources.lang.Supplier + "] - " + this.uddlSupplier.SelectedItem.Text.ToString();
            }

            string userstatus = Resources.lang.Normal;
            switch (membershipInfo.UserStatus)
            {
                case 1:
                    userstatus = Resources.lang.Normal;
                    break;
                case 2:
                    userstatus = Resources.lang.Resign;
                    break;
                case 3:
                    userstatus = Resources.lang.Hold;
                    break;
                case 4:
                    userstatus = Resources.lang.Deactivate;
                    break;
                default:
                    break;
            }
            this.lblUserStatus.Text = userstatus;
        }
    }
}