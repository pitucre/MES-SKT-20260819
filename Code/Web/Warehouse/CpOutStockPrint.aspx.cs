using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class CpOutStockPrint : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialApply));

            if (!IsPostBack)
            {
                SKT.LeanMES.Warehouse.BLL.WarehouseCpOutStock bll = new SKT.LeanMES.Warehouse.BLL.WarehouseCpOutStock();
                try
                {
                    string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "CPSalePrint.xml";
                   
                    string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                    byte[] buff = bll.GetCpOutStockPdfByte(Convert.ToInt32(Request.QueryString["ID"]), strXmlPath, CommonMethod.WebRoot);
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