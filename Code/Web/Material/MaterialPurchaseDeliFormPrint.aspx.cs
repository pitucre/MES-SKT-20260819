using System;
using System.Configuration;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialPurchaseDeliFormPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                SKT.LeanMES.Material.BLL.PurOrder bll = new SKT.LeanMES.Material.BLL.PurOrder();
                try
                {
                    string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "DeliveryPurchaseForm1.xml";
                    string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                 
                    string ID = Request.QueryString["ID"];
                    string[] IDArr = ID.Split(new char[] { ','});
                    for (int i = 0; i < IDArr.Length; i++)
                    {
                        byte[] buff = bll.GetPurchasePdfPrint(Convert.ToInt32(IDArr[i]), strXmlPath, CommonMethod.WebRoot);
                        Response.ContentType = "application/pdf";
                        Response.BinaryWrite(buff);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }

          
        }
    }
}