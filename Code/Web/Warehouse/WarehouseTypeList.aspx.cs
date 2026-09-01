using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Warehouse.BLL;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseTypeList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouse));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WarehouseTypeId";
            this.Master.DefaultSortExpression = "WarehouseTypeId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("WarehouseType", this.txtKeyWords.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if(IsPostBack){
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Warehouse.BLL.WarehouseType bll = new SKT.LeanMES.Warehouse.BLL.WarehouseType();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch(Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }
    }
}