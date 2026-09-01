using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.AccessoryManagement
{
    public partial class AccessoryAndItemRelation : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessoryItemRelation));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "CreateTime DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (!string.IsNullOrEmpty(txtAccessoryItemRelationNO2.Text))
            {
                searchSettings.AddCondition("ItemCode", txtAccessoryItemRelationNO2.Text.Trim());
            }
            if (!string.IsNullOrEmpty(txtItemSpec.Text))
            {
                searchSettings.AddCondition("MachineTypeId", txtItemSpec.Text.Trim());
            }
            if (!string.IsNullOrEmpty(txtAccCode.Text))
            {
                searchSettings.AddCondition("AccessoryCode", txtAccCode.Text.Trim());
            }
            if (!string.IsNullOrEmpty(txtAccName.Text))
            {
                searchSettings.AddCondition("ItemName", txtAccName.Text.Trim());
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.AccessoryManagement.BLL.AccessoryItemRelation bll = new SKT.LeanMES.AccessoryManagement.BLL.AccessoryItemRelation();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }
    }
}