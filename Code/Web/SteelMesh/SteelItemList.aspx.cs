using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelItemList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSteelItem));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SteelItemId";
            this.Master.DefaultSortExpression = "SteelItemId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ItemName", Server.HtmlEncode(this.txtItemName.Text));
            searchSettings.AddCondition("SteelName", Server.HtmlEncode(this.txtSteelName.Text));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.SteelItem.BLL.SteelItem bll = new SteelItem.BLL.SteelItem();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }
        }
    }
}