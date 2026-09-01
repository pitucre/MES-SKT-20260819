using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.Product
{
    public partial class MaterialBucketItemRelationList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentItemRelation));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "BucketId";
            this.Master.DefaultSortExpression = "BucketId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();


            searchSettings.AddCondition(" MaterialBucketCode ", this.txtMaterialBucketCode.Text.Trim());


            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Product.BLL.MaterialBucket bll = new SKT.LeanMES.Product.BLL.MaterialBucket();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

    }
}