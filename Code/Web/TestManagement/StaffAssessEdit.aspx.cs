using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.TestManagement.Model;

namespace SKT.LeanMES.Web.TestManagement
{
    public partial class StaffAssessEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStaffAssess));
            
            if (!this.IsPostBack)
            {
                String userId = Request.QueryString["ID"];

                if (userId != null && Convert.ToInt32(userId) > 0)
                {
                    SKT.LeanMES.TestManagement.BLL.StaffAssess bll = new LeanMES.TestManagement.BLL.StaffAssess();
                    StaffAssessInfo model = bll.GetInfo(Convert.ToInt32(userId));
                    if (model !=null)
                    {
                        this.PageData = model;
                    }
                }
            }

        }

        private StaffAssessInfo PageData
        {
            set
            {
                this.txtName.Text = value.UserName;
                this.txtEmployeeNo.Text = value.EmployeeNo;
                this.txtDepartName.Text = value.DepartName;
                this.txtPhone.Text = value.Phone.ToString();
                this.txtEmail.Text = value.Email;
                this.ddlSex.SelectedValue = value.Sex;
                this.dllAetGrade.SelectedValue = value.AetGrade;
                this.dllQtyAet.SelectedValue = value.QtyAet;
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}