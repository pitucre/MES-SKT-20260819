using System;
using System.Configuration;

namespace SKT.LeanMES.Web.Material
{
    public partial class FormChangeListPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialApply));

                if (!IsPostBack)
                {
                    SKT.LeanMES.Material.BLL.Apply bll = new SKT.LeanMES.Material.BLL.Apply();
                    try
                    {
                        string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "FormChangeListPrint.xml";

                        string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                        byte[] buff = bll.GetFormChangeListPrintPdfByte(Request.QueryString["ID"], 0, strXmlPath, CommonMethod.WebRoot, "");
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
}