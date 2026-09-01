using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class IQCReceiveFormPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IQCBatch bll = new IQCBatch();
                try
                {
                    string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IQCReceiveReportFile.xml";
                    string strTargePath = CommonMethod.WebRoot + ConfigurationManager.AppSettings["FilePath"].ToString() + "\\Temp\\";

                    var fileNames = new List<string>();
                    string[] ids = Request.QueryString["ID"].Split(new char[] { ',' });

                    if (!Directory.Exists(strTargePath))
                    {
                        Directory.CreateDirectory(strTargePath);
                    }
                    foreach (var id in ids)
                    {
                        var fileName = strTargePath + Guid.NewGuid() + ".pdf";

                        byte[] fileByte = bll.GetIQCReportPdfByte(Convert.ToInt32(id), strXmlPath, CommonMethod.WebRoot);
                        using (FileStream fs = new FileStream(fileName, FileMode.Create))
                        {
                            fs.Write(fileByte, 0, fileByte.Length);
                            fs.Close();
                        }
                        fileNames.Add(fileName);
                    }
                    string outputFileName = strTargePath + Guid.NewGuid() + ".pdf";

                    new ITextSharpHelper().CombinePDF(fileNames, outputFileName);
                    fileNames.Add(outputFileName);

                    byte[] outfileByte = null;
                    using (FileStream fs = new FileStream(outputFileName, FileMode.Open))
                    {
                        //获取文件大小
                        long size = fs.Length;
                        outfileByte = new byte[size];
                        //将文件读到byte数组中
                        fs.Read(outfileByte, 0, outfileByte.Length);
                        fs.Close();
                    }
                    fileNames.Add(outputFileName);
                    foreach (string file in fileNames)
                    {
                        File.Delete(file);
                    }

                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(outfileByte);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }
        }
    }
}