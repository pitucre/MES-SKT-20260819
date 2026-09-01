using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Warehouse.BLL;

namespace SKT.LeanMES.Web.Warehouse
{
public partial class WarehouseCheckStatusList : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCheckStatus));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WarehouseCheckStatusId";
            this.Master.DefaultSortExpression = "WarehouseCheckStatusId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string WarehouseCheckStatusName = this.TextBox1.Text.ToString().Trim();
            if (!string.IsNullOrEmpty(WarehouseCheckStatusName))
            {
                searchSettings.AddCondition("WarehouseCheckStatusName", WarehouseCheckStatusName);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        //删除
        if(IsPostBack) {
            if (Request.Form["hdnOperate"].ToLower() == "delete")
            {
                SKT.LeanMES.Warehouse.BLL.WarehouseCheckStatus bll = new SKT.LeanMES.Warehouse.BLL.WarehouseCheckStatus();
                bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
            }
        }
    }

  }
}