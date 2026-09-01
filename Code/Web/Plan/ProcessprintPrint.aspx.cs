using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace SKT.LeanMES.Web.Plan
{
    public partial class ProcessprintPrint : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPlan));
            SKT.LeanMES.Plan.BLL.LinePlan bll = new SKT.LeanMES.Plan.BLL.LinePlan();
            try
            {
                string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "Processflowcard.xml";
                string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                //byte[] buff = bll.GetProcessPdfPrint(Request.QueryString["ID"], strXmlPath, CommonMethod.WebRoot);
                //Response.ContentType = "application/pdf";
                //Response.BinaryWrite(buff);
                //bll.GetProcessEdit(Request.QueryString["ID"]);


                XmlDocument xmlDocument = new XmlDocument();
                xmlDocument.Load(strXmlPath);
                XmlNode documentElement = xmlDocument.DocumentElement;
                var pageSize = documentElement.ChildNodes[0].Attributes[0].Value;

                List<byte[]> pdfByteContent = new List<byte[]>();
                var ids = Request.QueryString["ID"].Split(',');
                foreach (var id in ids)
                {
                    byte[] buff = bll.GetProcessPdfPrint(id, strXmlPath, CommonMethod.WebRoot);
                    if (buff != null) pdfByteContent.Add(buff);
                }
              
                var resbuff = base.MergePdf(pageSize, pdfByteContent);
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(resbuff);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException("", ex, true);
            }
        }
    }
}