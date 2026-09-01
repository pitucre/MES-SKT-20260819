using System;
using System.Configuration;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialDeliFormPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SKT.LeanMES.Material.BLL.Deliver bll = new SKT.LeanMES.Material.BLL.Deliver();
                try
                {
                    string DeliverNo = ""; 
                    string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "DeliveryForm.xml";
                    string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                    byte[] buff = bll.GetDeliverPdfByte(Convert.ToInt32(Request.QueryString["ID"]), strXmlPath, CommonMethod.WebRoot,out DeliverNo);
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(buff);
                    if (buff.Length > 0)
                    {
                        var en = new SystemLog.Model.AccreditLogInfo()
                        {
                            UserName = AccountController.GetCurrentUser().UserName,
                            LogType = "补打送货单",
                            ModuleName = "供应商物料管理|送货单列表",
                            PageName = "补打",
                            OederNo = DeliverNo,
                            LogContent = "供应商补打送货单【"+ DeliverNo + "】"
                        };
                        new SystemLog.BLL.AccreditLog().CreateOperationLog(en);
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