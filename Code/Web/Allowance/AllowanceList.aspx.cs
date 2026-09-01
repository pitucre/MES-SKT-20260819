using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Allowance.BLL;

namespace SKT.LeanMES.Web.Allowance
{
    public partial class AllowanceList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAllowance));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AllowanceId";
            this.Master.DefaultSortExpression = "AllowanceId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (this.txtAllowanceNO2.Text != "")
            {
                searchSettings.ExtensionCondition += "UserName LIKE '%" + this.txtAllowanceNO2.Text + "%' OR wages LIKE '%" + this.txtAllowanceNO2.Text + "%' OR OutputAllowance LIKE '%" + this.txtAllowanceNO2.Text + "%' OR CreateBy LIKE '%" + this.txtAllowanceNO2.Text + "%' OR CreateDateTime LIKE '%" + this.txtAllowanceNO2.Text + "%' OR Remark LIKE '%" + this.txtAllowanceNO2.Text + "%'";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Allowance.BLL.Allowance bll = new SKT.LeanMES.Allowance.BLL.Allowance();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

    }
}