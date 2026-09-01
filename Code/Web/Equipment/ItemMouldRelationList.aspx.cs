using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.Equipment
{
public partial class ItemMouldRelationList : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxItemMouldRelation));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemMouldRelationId";
            this.Master.DefaultSortExpression = "ItemMouldRelationId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition(" isdelete ", "0");
            searchSettings.AddCondition(" ItemCode ",  this.txtItemCode.Text.Trim());
            searchSettings.AddCondition(" BomName ", this.txtMouldName.Text.Trim());
            searchSettings.AddCondition(" ItemName ", this.txtItemName.Text.Trim());
            
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        //删除
        if(IsPostBack) {
            if (Request.Form["hdnOperate"].ToLower() == "delete")
            {
                SKT.LeanMES.Equipment.BLL.ItemMouldRelation bll = new SKT.LeanMES.Equipment.BLL.ItemMouldRelation();
                bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
            }
        }
    }

  }
}