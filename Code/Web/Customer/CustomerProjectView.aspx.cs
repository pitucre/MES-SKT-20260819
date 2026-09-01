using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Customer.Model;
using SKT.LeanMES.Customer.BLL;

namespace SKT.LeanMES.Web.Customer
{
    public partial class CustomerProjectView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            SKT.LeanMES.Customer.BLL.Project project = new LeanMES.Customer.BLL.Project();
            ProjectInfo info = project.GetInfo(Convert.ToInt32(idString));
            this.lblCustomerName.Text = info.CustomerName.ToString();
            this.lblProjectName.Text = info.ProName;
            this.lblDesc.Text = info.ProDesc;
        }
    }
}