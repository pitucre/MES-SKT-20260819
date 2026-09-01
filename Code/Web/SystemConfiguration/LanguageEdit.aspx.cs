using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.CommonDataSource.BLL;
using SKT.LeanMES.CommonDataSource.Model;
using SKT.LeanMES.Language.Model;

namespace SKT.LeanMES.Web.SystemConfiguration
{
	public partial class LanguageEdit : BasePage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxLanguage));

            if (!IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SKT.LeanMES.Language.BLL.Language bll = new SKT.LeanMES.Language.BLL.Language();
                    LanguageInfo info = bll.GetInfo(Convert.ToInt32(idString));
                    if (info != null)
                    {
                        txtLanguageKey.Text = info.LanguageKey;
                        txtLanguageKey.ReadOnly = true;
                        txtCN.Text = info.CN;
                        txtEN.Text = info.EN;
                    }
                }
            }
		}
	}
}