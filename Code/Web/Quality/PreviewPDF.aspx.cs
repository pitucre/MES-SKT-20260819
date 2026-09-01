using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    /// <summary>
    /// Add by Hanson.Lei on 2016.12.12
    /// </summary>
    public partial class PreviewPDF : System.Web.UI.Page
    {
        string strXmlPath, strImagePath;

        protected void Page_Load(object sender, EventArgs e)
        {
            string previewType = Request.QueryString["PreviewType"];

            if (!string.IsNullOrEmpty(previewType))
            {
                switch (previewType)
                {
                    case "PrepareMaterial":
                        strXmlPath = HttpRuntime.AppDomainAppPath + @"Content\XmlFile\PDF\" + "PrepareMatApplyPrint.xml";
                        strImagePath = "";
                        PrepareMaterial();
                        break;
                    case "InspectionOrder":
                        strXmlPath = HttpRuntime.AppDomainAppPath + @"Content\XmlFile\PDF\" + "InspectionOrderPrint.xml";
                        strImagePath = HttpRuntime.AppDomainAppPath + @"Content\images\" + "IPQC.png";
                        InspectionOrder();
                        break;
                    default:
                        break;
                }
            }
        }

        private void PrepareMaterial()
        {
            string strIds = Request.QueryString["ids"];

            if (String.IsNullOrEmpty(strIds)) { return; }

            try
            {
                byte[] buff = new SKT.LeanMES.Material.BLL.PrepareMatForm().GetApplyPreparePDF(strIds, strXmlPath, strImagePath);

                Response.ContentType = "application/pdf";
                Response.BinaryWrite(buff);
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message);
            }
        }


        /// <summary>
        /// 根据ID显示获取送检单信息
        /// add by peter on 2017-6-3
        /// </summary>
        private void InspectionOrder() 
        {
            string InspectionId = Request.QueryString["ids"];
            if (String.IsNullOrEmpty(InspectionId)) { return; }

            try
            {
                byte[] buff = new SKT.LeanMES.Quality.BLL.InspectionOrder().GetInspectionOrderPDF(InspectionId, strXmlPath, strImagePath);

                Response.ContentType = "application/pdf";
                Response.BinaryWrite(buff);
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message);
            }
        }
    }
}