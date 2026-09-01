using System;
using SKT.Common.Organization.BLL;
using SKT.Common.Organization.Model;

namespace SKT.LeanMES.Web.Organization
{
    public partial class OrganizationView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            OrganizationInfo organizationInfo = (new Common.Organization.BLL.Organization()).GetInfo(Convert.ToInt32(idString));

            if (organizationInfo != null)
            {
                this.lblParenDepartName.Text = organizationInfo.ParentDepartName.ToString();
                this.lblDepartName.Text = organizationInfo.DepartName.ToString();
                this.lblDepartNo.Text = organizationInfo.DepartNo.ToString();

                string supervisor = organizationInfo.CName;
                if (organizationInfo.EmployeeNo != "")
                {
                    supervisor += "(" + organizationInfo.EmployeeNo + ")";
                }
                this.lblSupervisor.Text = supervisor;
                this.lblDesc.Text = organizationInfo.Description.ToString();
            }
        }
    }
}