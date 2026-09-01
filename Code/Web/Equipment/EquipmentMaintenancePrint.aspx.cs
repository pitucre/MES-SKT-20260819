using SKT.LeanMES.Equipment.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentMaintenancePrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    string strXmlPath = HttpRuntime.AppDomainAppPath.ToString() + "Content\\XmlFile\\PDF\\";
                    var type = Request.QueryString["type"];
                    strXmlPath += "EquipmentSpotCheckReport.xml";
                    byte[] buff = new EquipmentInspectionTemplateItem().GetEquipmentMaintenancePdfByte(Convert.ToInt32(Request.QueryString["Id"]), strXmlPath, HttpRuntime.AppDomainAppPath.ToString());
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