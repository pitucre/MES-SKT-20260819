using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Drawing;
using System.Collections.Generic;
using System.IO;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    public class ITextSharpHelper
    {

        public void CombinePDFByFolder(string inputFolder, string outFile)
        {
            DirectoryInfo dirScan = new DirectoryInfo(inputFolder);
            FileInfo[] fileinfo = dirScan.GetFiles("*.pdf");

            string[] fileList = new string[fileinfo.Length];

            for (int i = 0; i < fileinfo.Length; i++)
            {
                fileList[i] = fileinfo[i].FullName;
            }

            PdfReader reader;
            Document document = new Document();

            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(outFile, FileMode.Create));
            document.Open();

            PdfContentByte cb = writer.DirectContent;

            PdfImportedPage newPage;
            for (int i = 0; i < fileList.Length; i++)
            {
                reader = new PdfReader(fileList[i]);
                int iPageNum = reader.NumberOfPages;
                for (int j = 1; j <= iPageNum; j++)
                {
                    document.NewPage();
                    newPage = writer.GetImportedPage(reader, j);
                    cb.AddTemplate(newPage, 0, 0);
                }
            }
            document.Close();
        }

        public void CombinePDF(List<string> fileList, string outFile, bool isShowPageCount = false)
        {
            PdfReader reader;
            Document document = new Document();
            BaseFont bfHei = BaseFont.CreateFont(@"C:\Windows\Fonts\simhei.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
            iTextSharp.text.Font font = new iTextSharp.text.Font(bfHei, 10);

            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(outFile, FileMode.Create));
            document.Open();

            PdfContentByte cb = writer.DirectContent;

            PdfImportedPage newPage;
            for (int i = 0; i < fileList.Count; i++)
            {
                reader = new PdfReader(fileList[i]);
                int iPageNum = reader.NumberOfPages;
                for (int j = 1; j <= iPageNum; j++)
                {
                    document.NewPage();
                    newPage = writer.GetImportedPage(reader, j);
                    cb.AddTemplate(newPage, 0, 0);
                    if (isShowPageCount)
                    {
                        //增加页码-封面和底页都加
                        Phrase header = new Phrase("第" + writer.PageNumber.ToString() + "页", font);
                        //页脚显示的位置
                        ColumnText.ShowTextAligned(writer.DirectContent, Element.ALIGN_CENTER, header, document.PageSize.Width / 2, document.Bottom, 0);
                    }
                }
            }
            document.Close();
        }
    }
}