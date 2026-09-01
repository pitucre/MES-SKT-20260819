using SKT.Common.Account.Model;
using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.SDP.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;

namespace SKT.LeanMES.Web.SDP
{
    public partial class SDPUIPreview2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSerialNumber));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxJoin));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAssemble));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInput));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPacking));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPassStation));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPickListClient));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxRepair));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicesAgeing));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxContainerWeight));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
            if (!IsPostBack)
            {
                //验证登录
                SKT.LeanMES.Web.AccountController.GetCurrentUser();
                if (Request.UrlReferrer == null)
                {
                    Response.Write("<script>alert('请规范操作');window.close();</script>");
                    Response.End();
                }
                else
                {
                    string TempId = Request.QueryString["TempId"];
                    if (!string.IsNullOrWhiteSpace(TempId))
                    {
                        UIModelInfo info = new UIModel().GetInfo(Convert.ToInt32(TempId));
                        if (info != null)
                        {
                            hdnValue.Value = info.Content.Replace("''", "'");
                        }
                    }
                }
            }
        }
    }
}