using System;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;
using System.Security.Cryptography;
using System.Configuration;
using System.Text;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Data;

namespace SKT.LeanMES.Web.User
{
    public partial class UserEdit : BasePage
    {
        public string MandatoryPassword;
        public string WindowsPWDStrength;
        public MembershipInfo membershipInfo = new MembershipInfo();
        protected void Page_Load(object sender, EventArgs e)
        {
            string IsGroup = Request.QueryString["IsGroup"];
            GlobarParameter.Model.GlobarParameterInfo entity = new GlobarParameter.BLL.GlobarParameter().GetInfo("MandatoryPassword");
            if (entity != null && entity.ParaValue == "是")
                MandatoryPassword = "1";
            entity = new GlobarParameter.BLL.GlobarParameter().GetInfo("Windows密码强度");
            WindowsPWDStrength = entity.ParaValue;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {

                    if (IsGroup == "1")
                    {
                        string ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                        membershipInfo = (new Users()).GetInfo(Convert.ToInt32(idString), ConnStr) ?? new MembershipInfo();
                    }
                    else
                    {
                        membershipInfo = (new Users()).GetInfo(Convert.ToInt32(idString), "") ?? new MembershipInfo();
                    }
                    

                    if (membershipInfo == null)
                    {
                        WebHelper.ShowMessage("对象可能，已被删除！");
                        membershipInfo = new MembershipInfo();
                        
                    }

                    this.PageData = membershipInfo;
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
                this.txtUserName.Enabled = false;
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
                this.txtWechatNumber.Text = value.WechatNumber.ToString();
                this.DingTalkUserId.Text = value.DingTalkUserId?.ToString();
                this.chkIsHandle.Checked = value.IsHandle;
                if (value.UserType != -1)
                {
                    SKT.LeanMES.Supplier.BLL.Suppliers bll = new LeanMES.Supplier.BLL.Suppliers();
                    SKT.LeanMES.Supplier.Model.SuppliersInfo model = null;
                    model = bll.GetInfo(value.UserType);
                    if(model!=null)
                    {
                        this.hdnVendorId.Value = model.SupplierId.ToString();
                        this.txtVendorCode.Text = model.VendorCode + "-" + model.VendorName;
                    }
                }
            }
        }
    }
}