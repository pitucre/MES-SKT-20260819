using System;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Role
{
    public partial class RoleView : BasePage
    {
        public RoleInfo roleInfo = null;
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
                roleInfo = (new Common.Account.BLL.Role()).GetInfo(Convert.ToInt32(idString), ConnStr);
            }
            else
            {
                roleInfo = (new Common.Account.BLL.Role()).GetInfo(Convert.ToInt32(idString), "");
            }

            if (roleInfo != null)
            {
                this.lblRoleName.Text = roleInfo.RoleName;
                this.lblDescription.Text = roleInfo.Description;
            }
        }
    }
}