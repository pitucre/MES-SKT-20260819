using System;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Role
{
public partial class RoleEdit : BasePage
{
     RoleInfo roleinfo = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));
        string IsGroup = Request.QueryString["IsGroup"];
        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                    if (IsGroup=="1")
                    {
                        string ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                        roleinfo = (new Common.Account.BLL.Role()).GetInfo(Convert.ToInt32(idString), ConnStr);
                    }
                    else {
                        roleinfo = (new Common.Account.BLL.Role()).GetInfo(Convert.ToInt32(idString), "");
                    }
                    
                if (roleinfo == null)
                {
                    WebHelper.ShowMessage("对象可能，已被删除！");
                    roleinfo = new RoleInfo();
                }

                this.PageData = roleinfo;
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private RoleInfo PageData
    {
        set
        {
            this.txtRoleName.Text = value.RoleName;
            this.txtRoleName.Enabled = false;
            this.lblRoleName.Text = value.RoleName;
            this.txtDescription.Text = value.Description;
        }
    }
  }
}