using System;
using System.Configuration;

namespace SKT.LeanMES.Web.Transfers
{
    public partial class TransfersPrint : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
                SKT.LeanMES.Material.BLL.Deliver bll = new SKT.LeanMES.Material.BLL.Deliver();
                try
                {
                    string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "TransfersOrder.xml";
                    string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                    byte[] buff = bll.GetTransfersPdfByte(Convert.ToInt32(Request.QueryString["ID"]), Convert.ToInt32(Request.QueryString["TransfersCate"]), strXmlPath, CommonMethod.WebRoot);
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