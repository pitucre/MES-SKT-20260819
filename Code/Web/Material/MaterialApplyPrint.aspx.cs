using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialApplyPrint : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialApply));

            if (!IsPostBack)
            {
                SKT.LeanMES.Material.BLL.Apply bll = new SKT.LeanMES.Material.BLL.Apply();
                try
                {
                    string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "MaterialApplyPrint.xml";
                    if (Convert.ToInt32(Request.QueryString["ApplyCate"]) == 0)
                    {
                        strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "MaterialApplyPrint.xml";
                    }
                    string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                    byte[] buff = bll.GetApplyPdfByte(Convert.ToInt32(Request.QueryString["ID"]), Convert.ToInt32(Request.QueryString["ApplyType"]), strXmlPath, CommonMethod.WebRoot, Request.QueryString["ItemIds"]);
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(buff);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }
        }
    }
}