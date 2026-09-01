using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using iTextSharp.text;
using iTextSharp.text.pdf;
using NPOI.HSSF.UserModel;
using NPOI.HSSF.Util;
using NPOI.SS.UserModel;
using NPOI.SS.Util;
using NPOI.XSSF.UserModel;
using Font = iTextSharp.text.Font;
using Image = iTextSharp.text.Image;
using Rectangle = iTextSharp.text.Rectangle;

namespace SKT.LeanMES.Web.AppCode.Utility
{

    public static class ExcelToPdf
    {
        private static float _widthPercent = 88;//设置pdf内容占文档的宽度比例
        private static bool _isLandscape = true;//设置pdf是否横向
        private static string _fontPath = @"C:\Windows\Fonts\simsun.ttc,0";//使itextsharp支持中文
        private static float _marginTop = 15;
        private static float _marginBottom = 15;
        private static Rectangle _pageSize = PageSize.A4;//设置pdf文档纸张大小

        /// <summary>
        /// 生成pdf文件
        /// </summary>
        /// <param name="excelContent"></param>
        /// <returns></returns>
        public static byte[] RenderToXls(byte[] excelContent)
        {
            if (excelContent == null)
                return null;
            byte[] result = null;
            MemoryStream stream = new MemoryStream(excelContent);
            HSSFWorkbook hw = new HSSFWorkbook(stream);
            Document doc;
            if (_isLandscape)
            {
                doc = new Document(_pageSize.Rotate());
            }
            else
            {
                doc = new Document(_pageSize);
            }
            doc.SetMargins(0, 0, _marginTop, _marginBottom);
            try
            {
                ISheet sheet = hw.GetSheetAt(0);
                stream = new MemoryStream();
                PdfWriter pdfWriter = PdfWriter.GetInstance(doc, stream);
                BaseFont bsFont = BaseFont.CreateFont(_fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                doc.Open();
                float[] widths = GetColWidth(sheet);
                PdfPTable table = new PdfPTable(widths);
                table.WidthPercentage = _widthPercent;
                int colCount = widths.Length;

                for (int r = sheet.FirstRowNum; r < sheet.PhysicalNumberOfRows; r++)
                {
                    IRow row = sheet.GetRow(r);
                    if (row != null)
                    {
                        for (int c = row.FirstCellNum; (c < row.PhysicalNumberOfCells || c < colCount) && c > -1; c++)
                        {
                            if (c >= row.PhysicalNumberOfCells)
                            {
                                PdfPCell cell = new PdfPCell(new Phrase(""));
                                cell.Border = 0;
                                table.AddCell(cell);
                                continue;
                            }
                            ICell excelCell = row.Cells[c];
                            string value = "";
                            string horAlign = excelCell.CellStyle.Alignment.ToString();
                            string verAlign = excelCell.CellStyle.VerticalAlignment.ToString();


                            if (excelCell != null)
                            {
                                value = excelCell.ToString().Trim();
                                if (!string.IsNullOrEmpty(value))
                                {
                                    string dataFormat = excelCell.CellStyle.GetDataFormatString();
                                    if (dataFormat != "General" && dataFormat != "@")//数据不为常规或者文本
                                    {
                                        try
                                        {
                                            string numStyle = GetNumStyle(dataFormat);
                                            value = string.Format("{0:" + numStyle + "}", excelCell.NumericCellValue);//如果解析不成功则按字符串处理
                                        }
                                        catch { }
                                    }
                                }
                            }

                            IFont excelFont = excelCell.CellStyle.GetFont(hw);
                            HSSFPalette palette = hw.GetCustomPalette();
                            HSSFColor color = null;
                            BaseColor ftColor = BaseColor.BLACK;
                            short ft = excelFont.Color;
                            color = palette.GetColor(ft);
                            if (color != null && ft != 64)
                            {
                                byte[] ftRGB = color.RGB;
                                ftColor = new BaseColor(ftRGB[0], ftRGB[1], ftRGB[2]);
                            }
                            bool isBorder = HasBorder(excelCell);
                            Font pdfFont = new Font(bsFont, Convert.ToSingle(excelFont.FontHeightInPoints), excelFont.IsBold ? 1 : 0, ftColor);
                            PdfPCell pdfCell = new PdfPCell(new Phrase(value, pdfFont));

                            List<PicturesInfo> info = sheet.GetAllPictureInfos(r, r, c, c, true);//判断单元格中是否有图片，不支持图片跨单元格
                            if (info.Count > 0)
                            {
                                pdfCell = new PdfPCell(Image.GetInstance(info[0].PictureData));
                            }
                            short bg = excelCell.CellStyle.FillForegroundColor;
                            color = palette.GetColor(bg);
                            if (color != null && bg != 64)
                            {
                                byte[] bgRGB = color.RGB;
                                pdfCell.BackgroundColor = new BaseColor(bgRGB[0], bgRGB[1], bgRGB[2]);
                            }
                            if (!isBorder)
                            {
                                pdfCell.Border = 0;

                            }
                            else
                            {
                                short bd = excelCell.CellStyle.TopBorderColor;
                                color = palette.GetColor(bd);
                                if (color != null && bd != 64)
                                {
                                    byte[] bdRGB = color.RGB;
                                    pdfCell.BorderColor = new BaseColor(bdRGB[0], bdRGB[1], bdRGB[2]);
                                }
                            }

                            pdfCell.MinimumHeight = row.HeightInPoints;
                            pdfCell.HorizontalAlignment = GetCellHorAlign(horAlign);
                            pdfCell.VerticalAlignment = GetCellVerAlign(verAlign);

                            if (excelCell.IsMergedCell)
                            {
                                int[] span = GetMergeCellSpan(sheet, r, c);
                                if (span[0] == 1 && span[1] == 1)//合并过的单元直接跳过
                                    continue;
                                pdfCell.Rowspan = span[0];
                                pdfCell.Colspan = span[1];
                                c = c + span[1] - 1;//直接跳过合并过的单元格
                            }
                            table.AddCell(pdfCell);

                        }
                    }
                    else
                    {//空行
                        PdfPCell pdfCell = new PdfPCell(new Phrase(""));
                        pdfCell.Border = 0;
                        pdfCell.MinimumHeight = 13;
                        table.AddCell(pdfCell);
                    }
                }

                doc.Add(table);
                doc.Close();
                result = stream.ToArray();

            }
            finally
            {
                hw.Close();
                stream.Close();
            }

            return result;

        }

        /// <summary>
        /// 生成pdf文件
        /// </summary>
        /// <param name="excelContent">excel文件的字节流</param>
        /// <returns></returns>
        public static byte[] Render(byte[] excelContent)
        {
            if (excelContent == null)
                return null;
            byte[] result = null;
            MemoryStream stream = new MemoryStream(excelContent);
            IWorkbook workbook = null;
            workbook = new XSSFWorkbook(stream);
            Document doc;
            if (_isLandscape)
            {
                doc = new Document(_pageSize.Rotate());
            }
            else
            {
                doc = new Document(_pageSize);
            }
            doc.SetMargins(0, 0, 15, 15);//设置文档的页边距
            try
            {
                string _fontPath = @"C:\Windows\Fonts\simsun.ttc,0";
                ISheet sheet = workbook.GetSheetAt(0);//获取excel中的第一个sheet,如果excel中有多个sheet，此处需要进行循环
                stream = new MemoryStream();
                PdfWriter pdfWriter = PdfWriter.GetInstance(doc, stream);
                BaseFont bsFont = BaseFont.CreateFont(_fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);//创建pdf文档字体
                doc.Open();

                float[] widths = GetColWidth(sheet);//获取excel中每列的宽度
                PdfPTable table = new PdfPTable(widths);//设置pdf中表格每列的宽度
                table.WidthPercentage = 88;//数值可以自己设定
                int colCount = widths.Length;

                //通过循环读取excel内容，并将读取的数据写入pdf文档中
                for (int r = sheet.FirstRowNum; r < sheet.PhysicalNumberOfRows; r++)
                {
                    IRow row = sheet.GetRow(r);
                    if (row != null)
                    {
                        for (int c = row.FirstCellNum; (c <= row.PhysicalNumberOfCells - 1 || c <= colCount - 1) && c > -1; c++)
                        {
                            if (c >= row.PhysicalNumberOfCells)
                            {
                                PdfPCell cell = new PdfPCell(new Phrase(""));
                                cell.Border = 0;
                                table.AddCell(cell);
                                continue;
                            }
                            ICell excelCell = row.Cells[c];
                            string value = "";
                            string horAlign = excelCell.CellStyle.Alignment.ToString();
                            string verAlign = excelCell.CellStyle.VerticalAlignment.ToString();


                            if (excelCell != null)
                            {

                                //原文章代码value =excelCell.ToString().Trim(); 某一格数据为空时，（可能是大量情况下）pdf导出会有问题，导出来是一大片空白
                                value = string.IsNullOrWhiteSpace(excelCell.ToString().Trim()) ? " " : excelCell.ToString().Trim();
                                if (!string.IsNullOrEmpty(value))
                                {
                                    string dataFormat = excelCell.CellStyle.GetDataFormatString();
                                    if (dataFormat != "General" && dataFormat != "@")//数据不为常规或者文本
                                    {
                                        try
                                        {
                                            string numStyle = "";

                                            if (string.IsNullOrEmpty(dataFormat))
                                            {
                                                throw new ArgumentException("");
                                            }
                                            if (dataFormat.IndexOf('%') > -1)
                                            {
                                                numStyle = dataFormat;
                                            }
                                            else
                                            {
                                                numStyle = dataFormat.Substring(0, dataFormat.Length - 2);
                                            }

                                            value = string.Format("{0:" + numStyle + "}", excelCell.NumericCellValue);//如果解析不成功则按字符串处理
                                        }
                                        catch { }
                                    }
                                }
                            }

                            IFont excelFont = excelCell.CellStyle.GetFont(workbook);
                    
                      
                            short ft = excelFont.Color;
                           
                            bool isBorder = HasBorder(excelCell);
                            float dloatFont = float.Parse(excelFont.FontHeightInPoints.ToString());
                            Font pdfFont = new Font(bsFont, dloatFont);
                            PdfPCell pdfPCell = new PdfPCell(new Phrase(value, pdfFont));//这一行是关键，我以为没用 删了什么都没有导出来
                            List<PicturesInfo> info = sheet.GetAllPictureInfos(r, r, c, c, true);//判断单元格中是否有图片，不支持图片跨单元格
                            if (info.Count > 0)
                            {
                                pdfPCell = new PdfPCell(Image.GetInstance(info[0].PictureData));
                            }
                         
                            if (!isBorder)
                            {
                                pdfPCell.Border = 0;

                            }
                            
                          
                            pdfPCell.MinimumHeight = row.HeightInPoints;
                            pdfPCell.HorizontalAlignment = GetCellHorAlign(horAlign);
                            pdfPCell.VerticalAlignment = GetCellVerAlign(verAlign);

                            if (excelCell.IsMergedCell)//合并单元格
                            {
                                int[] span = GetMergeCellSpan(sheet, r, c);
                                if (span[0] == 1 && span[1] == 1)//合并过的单元直接跳过
                                    continue;
                                pdfPCell.Rowspan = span[0];
                                pdfPCell.Colspan = span[1];
                                c = c + span[1] - 1;//直接跳过合并过的单元格
                            }
                            table.AddCell(pdfPCell);

                        }
                    }
                    else
                    {//空行
                        PdfPCell pdfCell = new PdfPCell(new Phrase(""));
                        pdfCell.Border = 0;
                        pdfCell.MinimumHeight = 13;
                        table.AddCell(pdfCell);
                    }
                }

                doc.Add(table);
                doc.Close();
                result = stream.ToArray();

            }
            finally
            {
                //hw.Close();
                workbook.Close();
                stream.Close();
            }

            return result;

        }

        /// <summary>
        /// 获取列的宽度比例
        /// </summary>
        /// <param name="sheet"></param>
        /// <returns></returns>
        private static float[] GetColWidth(ISheet sheet)
        {
            int rowNum = GetMaxColRowNum(sheet);
            IRow row = sheet.GetRow(rowNum);
            int cellCount = row.PhysicalNumberOfCells;
            int[] colWidths = new int[cellCount];
            float[] colWidthPer = new float[cellCount];

            int sum = 0;
            for (int i = row.FirstCellNum; i < cellCount; i++)
            {
                ICell cell = row.Cells[i];
                if (cell != null)
                {
                    colWidths[i] = sheet.GetColumnWidth(i);
                    sum += sheet.GetColumnWidth(i);
                }
            }

            for (int i = row.FirstCellNum; i < cellCount; i++)
            {
                colWidthPer[i] = (float)colWidths[i] / sum * 100;
            }
            return colWidthPer;
        }
        /// <summary>
        /// 取EXCEL中列数最大的行
        /// </summary>
        /// <param name="sheet"></param>
        /// <returns></returns>
        private static int GetMaxColRowNum(ISheet sheet)
        {
            int rowNum = 0;
            int maxCol = 0;
            for (int r = sheet.FirstRowNum; r < sheet.PhysicalNumberOfRows; r++)
            {
                IRow row = sheet.GetRow(r);
                if (row != null && maxCol < row.PhysicalNumberOfCells)
                {
                    maxCol = row.PhysicalNumberOfCells;
                    rowNum = r;
                }
            }
            return rowNum;
        }


        /// <summary>
        /// 合并单元格的rowspan、colspan
        /// </summary>
        /// <param name="sheet"></param>
        /// <param name="rowNum"></param>
        /// <param name="colNum"></param>
        /// <returns></returns>
        private static int[] GetMergeCellSpan(ISheet sheet, int rowNum, int colNum)
        {
            int[] span = { 1, 1 };
            int regionsCount = sheet.NumMergedRegions;
            for (int i = 0; i < regionsCount; i++)
            {
                CellRangeAddress range = sheet.GetMergedRegion(i);
                sheet.IsMergedRegion(range);

                if (range.FirstRow == rowNum && range.FirstColumn == colNum)
                {
                    //if (range.LastRow == range.FirstRow) //当Excel中 合并多行数据不加这一行导出pdf格式无错  没有合并只是一条数据的时候 不加这一个if判断数据会错乱 有的会消失
                    //{
                    //    span[0] = 0;
                    //    span[1] = 1;
                    //    break;
                    //}
                    span[0] = range.LastRow - range.FirstRow + 1;
                    span[1] = range.LastColumn - range.FirstColumn + 1;
                    break;
                }

            }
            return span;
        }
        private static bool HasBorder(ICell cell)
        {
            int bottom = cell.CellStyle.BorderBottom != 0 ? 1 : 0;
            int top = cell.CellStyle.BorderTop != 0 ? 1 : 0;
            int left = cell.CellStyle.BorderLeft != 0 ? 1 : 0;
            int right = cell.CellStyle.BorderRight != 0 ? 1 : 0;
            return (bottom + top + left + right) > 2;
        }

        /// <summary>
        /// 单元格水平对齐方式
        /// </summary>
        /// <param name="align"></param>
        /// <returns></returns>
        private static int GetCellHorAlign(string align)
        {
            switch (align)
            {
                case "Right":
                    return Element.ALIGN_RIGHT;
                case "Center":
                    return Element.ALIGN_CENTER;
                case "Left":
                    return Element.ALIGN_LEFT;
                default:
                    return Element.ALIGN_LEFT;
            }
        }

        /// <summary>
        /// 单元格垂直对齐方式
        /// </summary>
        /// <param name="align"></param>
        /// <returns></returns>
        private static int GetCellVerAlign(string align)
        {
            switch (align)
            {
                case "Center":
                    return Element.ALIGN_MIDDLE;
                case "Top":
                    return Element.ALIGN_TOP;
                case "Bottom":
                    return Element.ALIGN_BOTTOM;
                default:
                    return Element.ALIGN_MIDDLE;
            }
        }
        /// <summary>
        /// 获取单元格的数字格式
        /// </summary>
        /// <param name="style"></param>
        /// <returns></returns>
        private static string GetNumStyle(string style)
        {
            if (string.IsNullOrEmpty(style))
            {
                throw new ArgumentException("");
            }
            if (style.IndexOf('%') > -1)
            {
                return style;
            }
            else
            {
                return style.Substring(0, style.Length - 2);
            }
        }

    }

    //单元格中图片信息类
    public class PicturesInfo
    {
        public int MinRow { get; set; }
        public int MaxRow { get; set; }
        public int MinCol { get; set; }
        public int MaxCol { get; set; }
        public string Mime { get; set; }
        public Byte[] PictureData { get; private set; }

        public PicturesInfo(int minRow, int maxRow, int minCol, int maxCol, Byte[] pictureData, string mime)
        {
            this.MinRow = minRow;
            this.MaxRow = maxRow;
            this.MinCol = minCol;
            this.MaxCol = maxCol;
            this.PictureData = pictureData;
            this.Mime = mime;
        }
    }

    //NPOI扩展方法类

    public static class NPOIExtend
{
    public static List<PicturesInfo> GetAllPictureInfos(this ISheet sheet)
    {
        return sheet.GetAllPictureInfos(null, null, null, null, true);
    }

    public static List<PicturesInfo> GetAllPictureInfos(this ISheet sheet, int? minRow, int? maxRow, int? minCol, int? maxCol, bool onlyInternal)
    {
        if (sheet is HSSFSheet)
        {
            return GetAllPictureInfos((HSSFSheet)sheet, minRow, maxRow, minCol, maxCol, onlyInternal);
        }
        else if (sheet is XSSFSheet)
        {
            return GetAllPictureInfos((XSSFSheet)sheet, minRow, maxRow, minCol, maxCol, onlyInternal);
        }
        else
        {
            throw new Exception("未处理类型，没有为该类型添加：GetAllPicturesInfos()扩展方法！");
        }
    }

    private static List<PicturesInfo> GetAllPictureInfos(HSSFSheet sheet, int? minRow, int? maxRow, int? minCol, int? maxCol, bool onlyInternal)
    {
        List<PicturesInfo> picturesInfoList = new List<PicturesInfo>();

        var shapeContainer = sheet.DrawingPatriarch as HSSFShapeContainer;
        if (null != shapeContainer)
        {
            var shapeList = shapeContainer.Children;
            foreach (var shape in shapeList)
            {
                if (shape is HSSFPicture && shape.Anchor is HSSFClientAnchor)
                {
                    var picture = (HSSFPicture)shape;
                    var anchor = (HSSFClientAnchor)shape.Anchor;

                    if (IsInternalOrIntersect(minRow, maxRow, minCol, maxCol, anchor.Row1, anchor.Row2, anchor.Col1, anchor.Col2, onlyInternal))
                    {
                        picturesInfoList.Add(new PicturesInfo(anchor.Row1, anchor.Row2, anchor.Col1, anchor.Col2, picture.PictureData.Data, picture.PictureData.MimeType));
                    }
                }
            }
        }

        return picturesInfoList;
    }

    private static List<PicturesInfo> GetAllPictureInfos(XSSFSheet sheet, int? minRow, int? maxRow, int? minCol, int? maxCol, bool onlyInternal)
    {
        List<PicturesInfo> picturesInfoList = new List<PicturesInfo>();

        var documentPartList = sheet.GetRelations();
        foreach (var documentPart in documentPartList)
        {
            if (documentPart is XSSFDrawing)
            {
                var drawing = (XSSFDrawing)documentPart;
                var shapeList = drawing.GetShapes();
                foreach (var shape in shapeList)
                {
                    if (shape is XSSFPicture)
                    {
                        var picture = (XSSFPicture)shape;
                        var anchor = picture.GetPreferredSize();

                        if (IsInternalOrIntersect(minRow, maxRow, minCol, maxCol, anchor.Row1, anchor.Row2, anchor.Col1, anchor.Col2, onlyInternal))
                        {
                            picturesInfoList.Add(new PicturesInfo(anchor.Row1, anchor.Row2, anchor.Col1, anchor.Col2, picture.PictureData.Data, picture.PictureData.MimeType));
                        }
                    }
                }
            }
        }

        return picturesInfoList;
    }

    private static bool IsInternalOrIntersect(int? rangeMinRow, int? rangeMaxRow, int? rangeMinCol, int? rangeMaxCol,
        int pictureMinRow, int pictureMaxRow, int pictureMinCol, int pictureMaxCol, bool onlyInternal)
    {
        int _rangeMinRow = rangeMinRow ?? pictureMinRow;
        int _rangeMaxRow = rangeMaxRow ?? pictureMaxRow;
        int _rangeMinCol = rangeMinCol ?? pictureMinCol;
        int _rangeMaxCol = rangeMaxCol ?? pictureMaxCol;

        if (onlyInternal)
        {
            return (_rangeMinRow <= pictureMinRow && _rangeMaxRow >= pictureMaxRow &&
                    _rangeMinCol <= pictureMinCol && _rangeMaxCol >= pictureMaxCol);
        }
        else
        {
            return ((Math.Abs(_rangeMaxRow - _rangeMinRow) + Math.Abs(pictureMaxRow - pictureMinRow) >= Math.Abs(_rangeMaxRow + _rangeMinRow - pictureMaxRow - pictureMinRow)) &&
            (Math.Abs(_rangeMaxCol - _rangeMinCol) + Math.Abs(pictureMaxCol - pictureMinCol) >= Math.Abs(_rangeMaxCol + _rangeMinCol - pictureMaxCol - pictureMinCol)));
        }
    }

}
}