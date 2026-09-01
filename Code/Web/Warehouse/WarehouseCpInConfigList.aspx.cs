using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Warehouse.BLL;

namespace SKT.LeanMES.Web.Warehouse
{
public partial class WarehouseCpInConfigList : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCpInConfig));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "ModifyDateTime DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("", "");
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        //删除
        if(IsPostBack) {
            if (Request.Form["hdnOperate"].ToLower() == "delete")
            {
                SKT.LeanMES.Warehouse.BLL.WarehouseCpInConfig bll = new SKT.LeanMES.Warehouse.BLL.WarehouseCpInConfig();
                bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
            }
        }
    }

  }
}