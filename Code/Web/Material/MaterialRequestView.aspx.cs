using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialRequestView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    int id = Convert.ToInt32(idString);
                    this.PageData = (new SKT.LeanMES.Material.BLL.MaterialRequest()).GetInfo(id);

                }
                else
                {
                    this.lbFormNO.Text = Resources.lang.SystemCreate;
                }
            }
        }

        private SKT.LeanMES.Material.Model.MaterialRequestInfo PageData
        {
            set
            {
                this.lbFormNO.Text = value.FormNO;
                this.lbUserDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.UserDate);

                SKT.Common.Organization.BLL.Organization org = new SKT.Common.Organization.BLL.Organization();
                SKT.Common.Organization.Model.OrganizationInfo depInfo = org.GetInfo(value.DepartId);
                if (depInfo != null)
                {
                    lbDepartment.Text = depInfo.DepartName;
                }

                SKT.Common.Account.BLL.Users userBll = new SKT.Common.Account.BLL.Users();
                SKT.Common.Account.Model.MembershipInfo membershipInfo = userBll.GetInfo(value.RequestUserId);
                if (membershipInfo != null)
                {
                    this.lbRequestUser.Text = membershipInfo.UserName;
                }

                //SKT.LeanMES.ProcessForm.BLL.ProcessForm proBll = new LeanMES.ProcessForm.BLL.ProcessForm();
                //SKT.LeanMES.ProcessForm.Model.ProcessFormInfo processFormInfo = proBll.GetInfo(value.WOId);
                //if(processFormInfo!=null)
                //{
                //    this.lbWONumber.Text = processFormInfo.FormNO;           
                //}

                string PriorityName = "";
                if(value.Prioritys==1)
                {
                    PriorityName = Resources.lang.High;
                }
                else if(value.Prioritys==2)
                {
                    PriorityName = Resources.lang.Middle;
                }
                else if(value.Prioritys==3)
                {
                    PriorityName = Resources.lang.Low;
                }
                this.lbPrioritys.Text = PriorityName;
            }
        }
    }
}