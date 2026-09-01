using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Warehouse.BLL;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseCheckTypeList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCheckType));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WarehouseCheckTypeId";
            this.Master.DefaultSortExpression = "WarehouseCheckTypeId DESC"; //也可不赋值
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string name = txtWarehouseCheckTypeNO2.Text.Trim();
            if (!string.IsNullOrEmpty(name))
            {
                searchSettings.AddCondition("WarehouseCheckTypeName", name);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Warehouse.BLL.WarehouseCheckType bll = new SKT.LeanMES.Warehouse.BLL.WarehouseCheckType();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

    }
}