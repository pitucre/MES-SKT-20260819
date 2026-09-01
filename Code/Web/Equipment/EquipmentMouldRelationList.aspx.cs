using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.Equipment
{
public partial class EquipmentMouldRelationList : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentItemRelation));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentMouldRelationId";
            this.Master.DefaultSortExpression = "EquipmentMouldRelationId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "isdelete=0";
            //searchSettings.AddCondition(" isdelete ", "0");
            searchSettings.AddCondition(" BomName ", this.txtMouldCode.Text.Trim());
            searchSettings.AddCondition(" EquimentCode ", this.txtEquipmentCode.Text.Trim());
            
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        //删除
        if(IsPostBack) {
            if (Request.Form["hdnOperate"].ToLower() == "delete")
            {
                SKT.LeanMES.Equipment.BLL.EquipmentMouldRelation bll = new SKT.LeanMES.Equipment.BLL.EquipmentMouldRelation();
                bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
            }
        }
    }

  }
}