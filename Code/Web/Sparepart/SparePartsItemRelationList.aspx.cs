using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Sparepart
{
    public partial class SparePartsItemRelationList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentItemRelation));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentItemRelationId";
            this.Master.DefaultSortExpression = "EquipmentItemRelationId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition(" isdelete ", "0");
            searchSettings.AddCondition(" ItemCode ", this.txtItemCode.Text.Replace(" ", ""));
            searchSettings.AddCondition(" EqCode ", this.txtEquipmentCode.Text.Replace(" ", ""));

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Equipment.BLL.EquipmentItemRelation bll = new SKT.LeanMES.Equipment.BLL.EquipmentItemRelation();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }
    }
}