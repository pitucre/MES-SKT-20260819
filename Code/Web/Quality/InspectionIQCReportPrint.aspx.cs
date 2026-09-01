using System;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionIQCReportPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInspection));
            if (!IsPostBack)
            {
                try
                {
                    IQCBatch bll = new IQCBatch();
                    string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IQCReportFile.xml";
                    byte[] buff = bll.GetIQCReportPdfByte(Convert.ToInt32(Request.QueryString["ID"]), strXmlPath, CommonMethod.WebRoot);
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