using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemGroupList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemGroupId";
            this.Master.DefaultSortExpression = "ItemGroupId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("GroupName", this.txtItemGroup.Text.Replace("[", "[[]").Replace("%", "[%]").Replace("_", "[_]"));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Product.BLL.ItemGroup bll = new SKT.LeanMES.Product.BLL.ItemGroup();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }

    }
}