using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.SDP.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SDP
{
    public partial class PDAFunctionPreview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCpInList));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxClient));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));

            string sType = Request.QueryString["type"].ToString();
            if(sType == "model")
            {
                Int32 ID = Convert.ToInt32(Request.QueryString["ID"]);
                string sdpHtml =  new UIModel().GetPDAModelContent(ID);
                sdpUI.InnerHtml = Uri.UnescapeDataString(sdpHtml);
            }
            else
            {
                Int64 ID = Convert.ToInt64(Request.QueryString["ID"]);
                string sdpHtml = new UIModel().GetPDAPreview(ID);

                sdpUI.InnerHtml = sdpHtml;
            }
            

            //Regex rg = new Regex("<sdpscript>(.*)</sdpscript>", RegexOptions.Multiline | RegexOptions.Singleline);

            //string Javascript = rg.Match(sdpHtml).Value.Replace("<sdpscript>", "").Replace("</sdpscript>", "");
            //if (Javascript != "")
            //{
            //    sdpUI.InnerHtml = sdpHtml.Replace(Javascript, " ");
            //    //sdpUI.InnerHtml = sdpUI.InnerHtml.Replace("@", "\"");

            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "SC", Javascript, false);
            //}


        }
    }
}