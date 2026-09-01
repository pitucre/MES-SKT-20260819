using System;
using AjaxPro;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;
using SKT.LeanMES.Plan.BLL;


namespace SKT.LeanMES.Web.Role
{
public partial class RolePopedomCopy : BasePage
{
     RoleInfo roleinfo = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(RolePopedomCopy));
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
      
            this.lblRoleName.Text = value.RoleName;
            this.hdnRoleId.Value = value.RoleID.ToString();
        }
    }
        [AjaxMethod]
        public void CopyRolePopedom(int copyId, int id)
        {
            try
            {
                ScheduleRecord bll = new ScheduleRecord();
                bll.RolePopedomCopy(copyId, id, SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

    }
}