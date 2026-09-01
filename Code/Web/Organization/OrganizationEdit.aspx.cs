using System;
using SKT.Common.Organization.BLL;
using SKT.Common.Organization.Model;

namespace SKT.LeanMES.Web.Organization
{
    public partial class OrganizationEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxOrganization));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                     OrganizationInfo model= (new Common.Organization.BLL.Organization()).GetInfo(Convert.ToInt32(idString));
                     if (model != null)
                     {
                         this.PageData = model;
                     }
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private OrganizationInfo PageData
        {
            set
            {
                this.hdnParentId.Value = Convert.ToString(value.ParentId);
                this.txtParentDepartName.Text = value.ParentDepartName.ToString();
                this.txtDepartName.Text = value.DepartName.ToString();
                this.txtDepartNo.Text = value.DepartNo.ToString();
                this.txtSupervisor.Text = (String.IsNullOrEmpty(value.EmployeeNo)) ? value.CName.ToString() : (value.CName.ToString() + "(" + value.EmployeeNo.ToString() + ")");
                this.hdnSupervisorId.Value = value.SupervisorId.ToString();
                this.txtDescription.Text = value.Description.ToString();
            }
        }
    }
}