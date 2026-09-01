using System;
using System.Configuration;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialStoragePrintModel : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MaterialIQC bll = new MaterialIQC();
                
                try
                {
                    string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\MaterialStoragePrint.xml";
                    string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                    byte[] buff = bll.GetMaterialStoragePrintPdfByte(Convert.ToInt32(Request.QueryString["ID"]), strXmlPath, CommonMethod.WebRoot);
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