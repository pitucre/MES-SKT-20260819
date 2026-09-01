using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class IqcReturnPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IQCReturnForm.xml";
            string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
            byte[] buff = (new SKT.LeanMES.PubItems.BLL.PubItems()).GetPdfBuff("uspGetIqcReturnpPrint", Request.QueryString["spJson"], strXmlPath, CommonMethod.WebRoot);
            Response.ContentType = "application/pdf";
            Response.BinaryWrite(buff);
        }
    }
}