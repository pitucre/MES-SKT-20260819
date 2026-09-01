using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Web.AjaxServices.CommonTemplate;

namespace SKT.LeanMES.Web.CustomMenu
{
    public partial class CustomPDFTemplate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    string strXmlPath = CommonMethod.WebRoot + "CustomMenu\\CustomPrintPDF\\" + Request.QueryString["PaName"].ToString()+".xml";
                    string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                    string strJson = Request.QueryString["strJson"];
                    string strSPC = Request.QueryString["strSPC"]==null? "upsGetDeliverPrint": Request.QueryString["strSPC"].ToString();
                    byte[] buff = GetByte(strSPC, strJson, strXmlPath, CommonMethod.WebRoot);
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(buff);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }
        }
        public byte[] GetByte(string strSPC,string strJson, string strXmlFilePath, string strImgPath)
        {
            SqlParameter[] array = ComMethodTemplate.GetSpcParams(strSPC, null);
            array = ComMethodTemplate.setParaValue(strJson, array);

            DataSet ds = ComMethod.GetListDataSet(strSPC, array, "dtDeliveryForm");
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow row in ds.Tables[1].Rows)
                {
                    row["SentQty"] = Convert.ToDecimal(row["SentQty"]).ToString("#.##");
                }
            }
            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }
    }
}