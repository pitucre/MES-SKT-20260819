using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class LanguageList : BasePage
	{
		protected void Page_Load(object sender, EventArgs e)
		{

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "LanguageId";
            this.Master.DefaultSortExpression = "LanguageId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " (1=1) ";
            searchSettings.AddCondition("LanguageKey", this.txtLanguageKey.Text.Trim().Replace("'", "''"));
            if (cbUnTranslateCN.Checked) {
                searchSettings.ExtensionCondition += " AND CN IS NULL OR CN='' ";
            }
            if (cbUnTranslateEN.Checked)
            {
                searchSettings.ExtensionCondition += " AND EN IS NULL OR EN=''";
            }

            this.Master.SearchSettings = searchSettings;

            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        string idStr = Request.Form["hdnIdString"].ToString();
                        SKT.LeanMES.Language.BLL.Language bll = new SKT.LeanMES.Language.BLL.Language();
                        bll.Delete(idStr, SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }
            }
		}
	}
}