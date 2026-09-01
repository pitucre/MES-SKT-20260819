using System;
using System.IO;
using System.Drawing;
using SKT.LeanMES.CommonHelper;
using System.Configuration;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionIQCFormPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxInspection));
            if (!IsPostBack)
            {
                try
                {
                    IQCBatch bll = new IQCBatch();
                    string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IQCFormReportFile.xml";
                    byte[] buff = bll.GetIQCFormByte(Convert.ToInt32(Request.QueryString["ID"]), strXmlPath, CommonMethod.WebRoot);
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