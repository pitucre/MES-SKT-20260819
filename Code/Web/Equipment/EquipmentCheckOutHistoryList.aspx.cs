using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.Equipment
{
public partial class EquipmentCheckOutHistoryList : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentCheckOutHistory));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentCheckOutHistory";
            this.Master.DefaultSortExpression = "EquipmentCheckOutHistory DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("EqCode", this.txtEqCode.Text.Replace(" ",""));
            //searchSettings.AddCondition("EquipmentTypeName", this.txtEquimentType.Text.Replace(" ", ""));
            //if (ddlObject.SelectedValue != "-1")
            //{
            //    searchSettings.AddCondition("ObjectTypeName", Server.HtmlEncode(this.ddlObject.Text));
            //}
           
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        //删除
        if(IsPostBack) {
            if (Request.Form["hdnOperate"].ToLower() == "delete")
            {
                SKT.LeanMES.Equipment.BLL.EquipmentCheckOutHistory bll = new SKT.LeanMES.Equipment.BLL.EquipmentCheckOutHistory();
                bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
            }
        }
    }

  }
}