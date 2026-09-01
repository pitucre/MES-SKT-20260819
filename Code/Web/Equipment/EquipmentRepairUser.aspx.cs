using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentRepairUser : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "Id DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("UserName", this.txtUserName.Text.Replace("'", string.Empty).Trim());
            searchSettings.AddCondition("EmployeeNo", this.txtEmployeeNo.Text.Replace("'", string.Empty).Trim());
            searchSettings.AddCondition("CName", this.txtCName.Text.Replace("'", string.Empty).Trim());

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Equipment.BLL.EquipmentRepairUser bll = new SKT.LeanMES.Equipment.BLL.EquipmentRepairUser();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), new EquipmentRepairUserInfo() { ModifyBy = AccountController.GetCurrentUser().UserName });
                        WebHelper.ShowMessage("删除操作成功！");
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }
            }
        }
    }
}