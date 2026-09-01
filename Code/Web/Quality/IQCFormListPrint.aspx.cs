using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Web.AppCode.Utility;
using Spire.Pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SKT.LeanMES.Web.Quality
{
    public partial class IQCFormListPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var action = Request.QueryString["action"];
            if (!string.IsNullOrWhiteSpace(action))
            {
                MergePDF(action);
            }
            else
            {

            }
        }
        public void MergePDF(string action)
        {
            IQCBatch bll = new IQCBatch();
            var strXmlPath = string.Empty;
            try
            {
                if (ConfigurationManager.AppSettings["FilePath"] != null)
                {
                    var strTargePath = CommonMethod.WebRoot + ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                    var fileNames = new List<string>();
                    string[] ids = Request.QueryString["ID"].Split(new char[] { ',' });
                    var type = Request.QueryString["type"];
                    if (!Directory.Exists(strTargePath))
                    {
                        Directory.CreateDirectory(strTargePath);
                    }
                    foreach (var id in ids)
                    {
                        DataSet ds = null;
                        var fileName = strTargePath + Guid.NewGuid() + ".pdf";
                        if (action == "iqcorderreportpdfprint")
                        {
                            strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IQCReceiveReportFile.xml";
                        }
                        else if (action == "iqcreportpdfprint")
                        {
                            strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IQCReportFile.xml";
                        }
                        ds = bll.getIQCPdfReportDs(int.Parse(id));
                        if (ds == null)
                        {
                            throw new Exception($"存储过程[getIQCPdfReportDs {id}]未查询到数据");
                        }
                        
                        var fileByte = PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlPath, ds, CommonMethod.WebRoot);
                        using (FileStream fs = new FileStream(fileName, FileMode.Create))
                        {
                            fs.Write(fileByte, 0, fileByte.Length);
                            fs.Close();
                        }
                        fileNames.Add(fileName);
                    }
                    string outputFileName = strTargePath + Guid.NewGuid() + ".pdf";

                    new ITextSharpHelper().CombinePDF(fileNames, outputFileName);
                    //PdfDocumentBase outpdf = PdfDocument.MergeFiles(fileNames.ToArray());
                    //outpdf.Save(outputFileName);
                    fileNames.Add(outputFileName);

                    var contentType = "application/pdf";
                    if (type == "word")
                    {
                        
                        contentType = "application/msword";
                        PdfDocument doc = new PdfDocument();
                        doc.LoadFromFile(outputFileName);
                        var targetFile = strTargePath + Guid.NewGuid() + ".doc";
                        fileNames.Add(targetFile);
                        //PdfPageBase pb = doc.Pages.Add(); //新增一页
                        //doc.Pages.Remove(pb); //去除第一页水印

                        //免费版最多只能导出10页
                        doc.SaveToFile(outputFileName, FileFormat.DOC);
                        //System.Diagnostics.Process.Start(outputFileName);                        
                    }

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

                    Response.ContentType = contentType;
                    Response.BinaryWrite(outfileByte);
                }
                else
                {
                    WebHelper.ShowMessage("在系统配置文件中未找到文件上传路径节点 [FilePath]！");
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
            }
        }

    }
}