using System;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.User
{
    public partial class UserOfSupplierEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                if (!string.IsNullOrEmpty(idString))
                {
                    if (idString != "-1")
                    {
                        MembershipInfo membershipInfo = (new Users()).GetInfo(Convert.ToInt32(idString));
                        if (membershipInfo == null)
                        {
                            WebHelper.ShowMessage("对象可能，已被删除！");
                            membershipInfo = new MembershipInfo();

                        }
                        this.PageData = membershipInfo;
                    }
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MembershipInfo PageData
        {
            set
            {
                this.txtUserName.Text = value.UserName;
                this.lblUserName.Text = value.UserName;
                this.txtCName.Text = value.EmployeeCName;
                this.txtEName.Text = value.EmployeeEName;
                this.ddlSex.SelectedValue = value.Sex.ToString();
                this.txtPhone.Text = value.Phone;
                this.txtEmail.Text = value.Email;
                this.txtEmployeeNo.Text = value.EmployeeNo;
                this.hdnDepartId.Value = value.DepartId.ToString();
                this.hdnDepartNo.Value = value.DepartNo;
                this.txtDepartName.Text = value.DepartName;
                this.ddlUserStatus.SelectedValue = value.UserStatus.ToString();
                this.rblUserType.SelectedValue = (value.UserType == -1) ? "-1" : "1";
                if (value.UserType != -1)
                {
                    SKT.LeanMES.Supplier.BLL.Suppliers bll = new LeanMES.Supplier.BLL.Suppliers();
                    SKT.LeanMES.Supplier.Model.SuppliersInfo model = null;
                    model = bll.GetInfo(value.UserType);
                    if (model != null)
                    {
                        this.hdnVendorId.Value = model.SupplierId.ToString();
                        this.txtVendorCode.Text = model.VendorCode + "-" + model.VendorName;
                    }
                }
            }
        }
    }
}