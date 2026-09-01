using DataMatrix.net;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Drawing.Text;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Caching;
using Font = iTextSharp.text.Font;
using Image = iTextSharp.text.Image;
using Rectangle = iTextSharp.text.Rectangle;

namespace SKT.LeanMES.Labels.Pdf
{
    public class PdfDesign
    {
        /// <summary>
        /// 根据标签设置生成pdf
        /// </summary>
        /// <param name="content"></param>
        public void CreatePdf(PdfCreateContent content)
        {
            Document document = null;
            PdfWriter writer = null;
            string msg = null;
            try
            {
                if (content == null)
                    throw new Exception("参数不能为空");
                if (content.Data == null || content.Data.Count == 0)
                    throw new Exception("请传入数据");
                if (content.List == null || content.List.Count == 0)
                    throw new Exception("请传入标签设计");
                if (content.Count < 1)
                    content.Count = 1;
                //连板数
                int group = 1;
                content.List.ForEach(item =>
                {
                    if (item.group > group)
                        group = item.group;
                    //图片处理
                    if (item.type == "img" && !string.IsNullOrWhiteSpace(item.url) && item.url.IndexOf("http") == 0)
                    {
                        var array = item.url.Split('/');
                        var url = AppDomain.CurrentDomain.BaseDirectory + "Img\\" + array[array.Length - 2] + "\\" + array[array.Length - 1];
                        if (!File.Exists(url))
                        {
                            if (!Directory.Exists(AppDomain.CurrentDomain.BaseDirectory + "Img\\" + array[array.Length - 2]))
                                Directory.CreateDirectory(AppDomain.CurrentDomain.BaseDirectory + "Img\\" + array[array.Length - 2]);
                            try
                            {
                                using (var img = System.Drawing.Image.FromStream(System.Net.WebRequest.Create(item.url).GetResponse().GetResponseStream()))
                                {
                                    img.Save(url);
                                }
                            }
                            catch
                            {
                                throw new Exception("当前模板中的图片链接已失效，请重新上传！");
                            }
                        }
                        item.url = url;
                    }
                });

                document = new Document(new Rectangle(content.Width, content.Height), 0, 0, 0, 0);
                writer = PdfWriter.GetInstance(document, new FileStream(content.PdfUrl, FileMode.Create));
                document.Open();

                List<int> groups = new List<int>();
                for (int i = 0; i < content.Data.Count; i++)
                {
                    if (i > 0)
                    {
                        document.NewPage();
                    }
                    //替换内容
                    if (content.Data[i].LabelContent != null)
                    {
                        content.Data[i].LabelContent.ForEach(a =>
                        {
                            content.List.ForEach(b =>
                            {
                                if (b.key == a.name)
                                {
                                    if (group > 1 && i == content.Data.Count - 1)
                                    {
                                        groups.Add(b.group);
                                    }
                                    b.text = a.value;
                                }
                            });
                        });
                    }
                    if (group > 1 && i == content.Data.Count - 1)
                    {
                        //如果是连扳，并且是最后一页，可能存在不满的情况，则删除多余的标签设置
                        content.List.RemoveAll(a => !groups.Exists(b => a.group == b));
                    }
                    //开始绘制
                    for (int c = 0; c < content.Count; c++)
                    {
                        if (c > 0)
                        {
                            document.NewPage();
                        }
                        content.List.ForEach(item =>
                        {
                            AddRectangle(content.Height, item, writer);
                            FillRectangle(content.Height, item, writer);
                            if (item.type == "text")
                            {
                                AddText(content.Height, item, writer);
                            }
                            else if (item.type == "line")
                            {
                                AddLine(content.Height, item, writer);
                            }
                            else if (item.type == "barcode")
                            {
                                AddImg(content.Height, item, writer, GetBarCode(item), true);
                            }
                            else if (item.type == "qrcode")
                            {
                                AddImg(content.Height, item, writer, GetQRCode(item));
                            }
                            else if (item.type == "matrix")
                            {
                                AddImg(content.Height, item, writer, GetDataMatrix(item));
                            }
                            else if (item.type == "img")
                            {
                                if (item.url.StartsWith("data:image", StringComparison.OrdinalIgnoreCase))
                                {
                                    //base64位图片
                                    AddImgBase64(content.Height, item, writer, item.url);
                                }
                                else
                                {
                                    if (!File.Exists(item.url))
                                    {
                                        throw new Exception("当前模板中的图片已失效，请重新上传！");
                                    }
                                    //本地图片
                                    AddImg(content.Height, item, writer, item.url);
                                }
                            }
                        });
                    }
                }
            }
            catch
            {
                msg = "打印异常";
                throw;
            }
            finally
            {
                try
                {
                    if (document != null && document.IsOpen())
                    {
                        document.Close();
                    }
                    if (writer != null)
                    {
                        writer.Close();
                    }
                    if (!string.IsNullOrWhiteSpace(msg) && File.Exists(content.PdfUrl))
                    {
                        File.Delete(content.PdfUrl);
                    }
                }
                catch
                {
                    //非正常关闭不处理
                }
            }
        }
        /// <summary>
        /// 二维条码
        /// </summary>
        /// <param name="dtl"></param>
        /// <returns></returns>
        public System.Drawing.Image GetDataMatrix(PrintTemplateDtl dtl)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(dtl.text))
                {
                    return null;
                }
                DmtxImageEncoderOptions opt = new DmtxImageEncoderOptions();
                opt.ModuleSize = dtl.scale;
                opt.MarginSize = dtl.version;
                opt.Encoding = Encoding.UTF8;
                DmtxImageEncoder encoder = new DmtxImageEncoder();
                return encoder.EncodeImage(dtl.text, opt);
            }
            catch (Exception ex)
            {
                throw new Exception("二维条码生成失败：" + ex.Message);
            }
        }

        /// <summary>
        /// 获取条码图片
        /// </summary>
        /// <param name="dtl"></param>
        /// <returns></returns>
        public System.Drawing.Image GetBarCode(PrintTemplateDtl dtl)
        {
            try
            {
                if (dtl.version < 0)
                    return GetBarCodeDef(dtl);
                if (string.IsNullOrWhiteSpace(dtl.text))
                {
                    return null;
                }
                FontStyle style = FontStyle.Regular;
                if (dtl.fontWeight == "bold")
                    style = style | FontStyle.Bold;
                if (dtl.fontStyle == "italic")
                    style = style | FontStyle.Italic;
                if (dtl.underline)
                    style = style | FontStyle.Underline;
                if (dtl.linethrough)
                    style = style | FontStyle.Strikeout;
                //默认字体
                if (string.IsNullOrEmpty(dtl.fontFamily))
                {
                    dtl.fontFamily = "Arial";
                }
                //系统字体库检索
                FontInfo fontInfo = GetFontFamilysList().FirstOrDefault(p => p.Name == dtl.fontFamily);
                if (fontInfo == null)
                {
                    throw new Exception($"字体:{dtl.fontFamily}不支持");
                }

                Tuple<int, int, int> t1 = HexToRgb(dtl.color);
                Tuple<int, int, int> t2 = HexToRgb(dtl.backgroundColor);

                //字体处理
                System.Drawing.Font barcodeFont = new System.Drawing.Font(fontInfo.Name, dtl.fontSize == 0 ? 10 : dtl.fontSize, style);

                if (dtl.version == 35)
                {
                    return new EAN13_A()
                    {
                        BackColor = System.Drawing.Color.FromArgb(t2.Item1, t2.Item2, t2.Item3),
                        ForeColor = System.Drawing.Color.FromArgb(t1.Item1, t1.Item2, t1.Item3),
                        Width = (dtl.line_bx <= 0 ? 300 : Convert.ToInt32(dtl.line_bx)),
                        Height = (dtl.line_by <= 0 ? 150 : Convert.ToInt32(dtl.line_by))
                    }.GetCodeImage(dtl.text, barcodeFont);
                }
                else if (dtl.version == 36)
                {
                    //默认传进来的像素值比较大 所以做了一个除100的处理，否则生成的图片比较大
                    int h = dtl.line_by <= 0 ? 2 : Convert.ToInt32(dtl.line_by);
                    h = h > 10 ? h / 100 : h;
                    int w = dtl.line_bx <= 0 ? 2 : Convert.ToInt32(dtl.line_bx);
                    w = w > 10 ? w / 100 : w;
                    return new PDF417().CreatePdf417BitMap(dtl.text, h, w, new SolidBrush(System.Drawing.Color.FromArgb(t1.Item1, t1.Item2, t1.Item3)), new SolidBrush(System.Drawing.Color.FromArgb(t2.Item1, t2.Item2, t2.Item3)));
                }
                //条码字体
                using (BarcodeLib.Barcode code = new BarcodeLib.Barcode()
                {
                    IncludeLabel = dtl.includeLabel,
                    IncludeBorder = dtl.includeBorder,
                    BackColor = System.Drawing.Color.FromArgb(t2.Item1, t2.Item2, t2.Item3),
                    ForeColor = System.Drawing.Color.FromArgb(t1.Item1, t1.Item2, t1.Item3),
                    Width = (dtl.line_bx <= 0 ? 300 : Convert.ToInt32(dtl.line_bx)),
                    Height = (dtl.line_by <= 0 ? 150 : Convert.ToInt32(dtl.line_by)),
                    LabelFont = barcodeFont,
                    Alignment = BarcodeLib.AlignmentPositions.LEFT,
                    BarWidth = dtl.barWidth <= 0 ? null : dtl.barWidth
                })
                {
                    return code.Encode((BarcodeLib.TYPE)dtl.version, dtl.text);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("条码生成失败：" + ex.Message);
            }
        }

        /// <summary>
        /// 获取条码图片
        /// </summary>
        /// <param name="dtl"></param>
        /// <returns></returns>
        public System.Drawing.Image GetBarCodeDef(PrintTemplateDtl dtl)
        {
            if (string.IsNullOrWhiteSpace(dtl.text))
                return null;
            try
            {
                Barcode128 code128 = new Barcode128();
                code128.CodeType = Barcode.CODE128;
                code128.Code = dtl.text;
                code128.AltText = "";
                Tuple<int, int, int> t1 = HexToRgb(dtl.color);
                Tuple<int, int, int> t2 = HexToRgb(dtl.backgroundColor);
                return code128.CreateDrawingImage(System.Drawing.Color.FromArgb(t1.Item1, t1.Item2, t1.Item3), System.Drawing.Color.FromArgb(t2.Item1, t2.Item2, t2.Item3));
            }
            catch (Exception ex)
            {
                throw new Exception("条码生成失败：" + ex.Message);
            }
        }

        /// <summary>
        /// 获取二维码图片
        /// </summary>
        /// <param name="dtl"></param>
        /// <returns></returns>
        public System.Drawing.Image GetQRCode(PrintTemplateDtl dtl)
        {
            if (string.IsNullOrWhiteSpace(dtl.text))
            {
                return null;
            }
            try
            {
                if (dtl.scale < 1)
                    dtl.scale = 1;
                if (dtl.scale > 40)
                    dtl.scale = 40;
                if (dtl.version < 0)
                    dtl.version = 0;
                if (dtl.version > 40)
                    dtl.version = 40;
                return new ThoughtWorks.QRCode.Codec.QRCodeEncoder() { QRCodeScale = dtl.scale, QRCodeVersion = dtl.version }.Encode(string.IsNullOrWhiteSpace(dtl.overflow) ? dtl.text : dtl.text.Replace(dtl.overflow, "\r\n"), Encoding.UTF8);
            }
            catch (Exception)
            {
                throw new Exception("二维码生成失败：试试改大密度！");
            }
        }

        /// <summary>
        /// 获取字体文件
        /// </summary>
        /// <returns></returns>
        public List<FontInfo> GetFontFamilysList()
        {
            //缓存时间配置
            int cache = Convert.ToInt32(ConfigurationManager.AppSettings["FontFamilysCacheTime"] ?? "60");
            string cacheKey = "SKT.LeanMES.Labels.Pdf.PdfDesign.GetFontFamilysList";
            //缓存处理
            List<FontInfo> list = HttpRuntime.Cache.Get(cacheKey) as List<FontInfo>;
            if (list == null)
            {
                list = new List<FontInfo>();
                string[] extensions = new string[] { ".ttf", ".ttc" };
                string[] files = Directory.GetFiles(Environment.ExpandEnvironmentVariables(@"%SystemRoot%\Fonts"))
                    .Where(p => extensions.Any(q => p.EndsWith(q, StringComparison.OrdinalIgnoreCase)))
                    .ToArray();
                foreach (var file in files)
                {
                    using (PrivateFontCollection fontCollection = new PrivateFontCollection())
                    {
                        try
                        {
                            fontCollection.AddFontFile(file);
                        }
                        catch (Exception ex)
                        {
                            WriteLog($"预加载字体文件失败：错误原因{ex.Message}，错误字体文件：{file}");
                            continue;
                        }

                        int i = 0;
                        foreach (var fontFamily in fontCollection.Families)
                        {
                            if (!list.Any(p => p.Name == fontFamily.Name))
                            {
                                list.Add(new FontInfo
                                {
                                    Name = fontFamily.Name,
                                    FileName = Path.GetFileName(file),
                                    Index = i
                                });
                            }
                            i++;
                        }
                    }
                }
                list = list.OrderBy(x => x.Name).ToList();
                //添加到缓存
                HttpRuntime.Cache.Insert(cacheKey, list, null, DateTime.Now.AddSeconds(cache), Cache.NoSlidingExpiration);
            }
            return list;
        }

        #region 私有方法
        /// <summary>
        /// 添加文字
        /// </summary>
        /// <param name="panelHeight"></param>
        /// <param name="item"></param>
        /// <param name="writer"></param>
        private void AddText(float panelHeight, PrintTemplateDtl item, PdfWriter writer)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(item.text))
                {
                    return;
                }
                Tuple<int, int, int> t = HexToRgb(item.color);

                int style = Font.NORMAL;
                if (item.fontWeight == "bold")
                    style = style | Font.BOLD;
                if (item.fontStyle == "italic")
                    style = style | Font.ITALIC;
                if (item.underline)
                    style = style | Font.UNDERLINE;
                if (item.linethrough)
                    style = style | Font.STRIKETHRU;

                //默认字体
                if (string.IsNullOrEmpty(item.fontFamily))
                {
                    item.fontFamily = "Arial";
                }
                //系统字体库检索
                FontInfo fontInfo = GetFontFamilysList().FirstOrDefault(p => p.Name == item.fontFamily);
                if (fontInfo == null)
                {
                    throw new Exception($"字体:{item.fontFamily}不支持");
                }

                //多字体准备（更好的支持中文）
                string baseFontPath = Path.Combine(Environment.ExpandEnvironmentVariables(@"%SystemRoot%\Fonts"), fontInfo.FileName);
                if (!File.Exists(baseFontPath))
                {
                    throw new Exception($"系统字体库未找到字体文件：{fontInfo.FileName}");
                }
                baseFontPath = baseFontPath.EndsWith(".ttc") ? $"{baseFontPath},{fontInfo.Index}" : baseFontPath;
                string baseFontChinesePath = Path.Combine(Environment.ExpandEnvironmentVariables(@"%SystemRoot%\Fonts"), "simsun.ttc");
                if (!File.Exists(baseFontChinesePath))
                {
                    throw new Exception($"系统字体库未找到缺省中文字体文件（宋体）：simsun.ttc");
                }
                baseFontChinesePath = baseFontChinesePath.EndsWith(".ttc") ? $"{baseFontChinesePath},0" : baseFontChinesePath;

                BaseFont baseFont = BaseFont.CreateFont(baseFontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                BaseFont baseFontChinese = BaseFont.CreateFont(baseFontChinesePath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

                RoteRectangle rr = Rotate(true, panelHeight, item, writer);
                ColumnText ct = new ColumnText(writer.DirectContent);
                if (item.textAlign == "center")
                {
                    ct.Alignment = Element.ALIGN_CENTER;
                }
                else if (item.textAlign == "right")
                {
                    ct.Alignment = Element.ALIGN_RIGHT;
                }
                else
                {
                    ct.Alignment = Element.ALIGN_LEFT;
                }

                if (item.paddingLeft > 0)
                {
                    rr.left += item.paddingLeft;
                    rr.width -= item.paddingLeft;
                }
                if (item.paddingRight > 0)
                {
                    rr.width -= item.paddingRight;
                }
                //处理文本
                if (item.enaleAutoTextSize)
                {
                    bool fits = true;
                    int status = 0;

                    Action<bool> action = simulate =>
                    {
                        ct.SetLeading(0, 1);
                        ct.SetSimpleColumn(rr.left, rr.top, rr.width + rr.left, rr.height + rr.top);
                        //设置多字体
                        FontSelector fontSelector = new FontSelector();
                        Font font = new Font(baseFont, item.fontSize, style, new BaseColor(t.Item1, t.Item2, t.Item3));
                        Font fontChinese = new Font(baseFontChinese, item.fontSize, style, new BaseColor(t.Item1, t.Item2, t.Item3));
                        fontSelector.AddFont(font);
                        fontSelector.AddFont(fontChinese);

                        Phrase phrase = fontSelector.Process(item.text);
                        foreach (var chunk in phrase.Chunks)
                        {
                            chunk.SetCharacterSpacing(item.fontSpace);
                        }
                        ct.SetText(phrase);
                        status = ct.Go(simulate);
                        fits = !(ColumnText.HasMoreText(status) || item.fontSize + item.fontSpace > rr.width);
                    };
                    action(true);
                    if (!fits)
                    {
                        while (true)
                        {
                            item.fontSize -= 0.1f;
                            action(true);
                            if (fits || item.fontSize <= 2)
                            {
                                break;
                            }
                        }
                    }
                    else
                    {
                        while (true)
                        {
                            item.fontSize += 0.1f;
                            action(true);
                            if (!fits)
                            {
                                item.fontSize -= 0.1f;
                                break;
                            }
                        }
                    }
                    action(false);
                }
                else
                {
                    var val = (item.lineHeight - item.fontSize) / 2 + 2;
                    if (val < 0)
                        val = 0;
                    //设置多字体
                    FontSelector fontSelector = new FontSelector();
                    Font font = new Font(baseFont, item.fontSize, style, new BaseColor(t.Item1, t.Item2, t.Item3));
                    Font fontChinese = new Font(baseFontChinese, item.fontSize, style, new BaseColor(t.Item1, t.Item2, t.Item3));
                    fontSelector.AddFont(font);
                    fontSelector.AddFont(fontChinese);

                    Phrase phrase = fontSelector.Process(item.text);
                    foreach (var chunk in phrase.Chunks)
                    {
                        chunk.SetCharacterSpacing(item.fontSpace);
                    }
                    ct.SetLeading(item.lineHeight - item.fontSize, 1);
                    ct.SetSimpleColumn(rr.left, rr.top, rr.width + rr.left, rr.height + rr.top + val);
                    ct.SetText(phrase);
                    ct.Go();
                }
                Rotate(true, panelHeight, item, writer, true);
            }
            catch (Exception ex)
            {
                throw new Exception($"文字生成失败：{ex.Message},错误堆栈：{ex.StackTrace}");
            }
        }
        /// <summary>
        /// 添加线条
        /// </summary>
        /// <param name="panelHeight"></param>
        /// <param name="item"></param>
        /// <param name="writer"></param>
        private void AddLine(float panelHeight, PrintTemplateDtl item, PdfWriter writer)
        {
            try
            {
                if (item.lineWidth <= 0)
                    return;
                var margin_bottom = panelHeight - item.height - item.top;
                var bx = item.line_bx + item.borderWidth + item.left;
                var by = ((item.height - item.borderWidth * 2) - item.line_by) + item.borderWidth + margin_bottom;
                var ex = item.line_ex + item.borderWidth + item.left;
                var ey = ((item.height - item.borderWidth * 2) - item.line_ey) + item.borderWidth + margin_bottom;

                Tuple<int, int, int> t = HexToRgb(item.strokeStyle);
                //绘制线条
                writer.DirectContent.SetLineWidth(item.lineWidth);
                if (item.borderStyle == "dashed")
                {
                    writer.DirectContent.SetLineDash(item.unitsOn, item.unitsOff, 0);
                }
                //还原原来设置，线条实现画虚线问题 update by beichang.zhong 2024
                //else
                //{
                //    writer.DirectContent.SetLineDash(0, 0, 0);
                //}
                writer.DirectContent.SetColorStroke(new BaseColor(t.Item1, t.Item2, t.Item3));
                writer.DirectContent.MoveTo(bx, by);
                writer.DirectContent.LineTo(ex, ey);
                //还原原来设置，线条实现画虚线问题 update by beichang.zhong 2024
                //writer.DirectContent.Stroke();
                writer.DirectContent.ClosePathStroke();

            }
            catch (Exception ex)
            {
                throw new Exception("线条生成失败:" + ex.Message);
            }
        }
        /// <summary>
        /// 旋转，得到一个新的矩形
        /// </summary>
        /// <param name="borderbox"></param>
        /// <param name="panelHeight"></param>
        /// <param name="item"></param>
        /// <param name="writer"></param>
        /// <param name="reset"></param>
        /// <returns></returns>
        private RoteRectangle Rotate(bool borderbox, float panelHeight, PrintTemplateDtl item, PdfWriter writer, bool reset = false)
        {
            RoteRectangle rr = new RoteRectangle();
            if (borderbox)
            {
                //内边框
                rr.top = panelHeight - item.top - item.height + item.borderWidth;
                rr.left = item.left + item.borderWidth;
                rr.width = item.width - item.borderWidth * 2;
                rr.height = item.height - item.borderWidth * 2;
            }
            else
            {
                //外边框
                rr.top = panelHeight - item.top - item.height + item.borderWidth / 2;
                rr.left = item.left + item.borderWidth / 2;
                rr.width = item.width - item.borderWidth;
                rr.height = item.height - item.borderWidth;
            }
            if (item.rote < 0)
                item.rote = 0;
            if (item.rote > 360)
                item.rote = 360;
            if (item.rote == 0 || item.rote == 360 || item.origin == null)
                return rr;
            double px = 0;
            double py = 0;
            if (item.origin == "center center")
            {
                var angle = item.rote * Math.PI / 180;
                px = item.left - item.width / 2 * Math.Cos(angle) - item.height / 2 * Math.Sin(angle) + item.width / 2;
                py = item.top + item.height / 2 * Math.Cos(angle) - item.width / 2 * Math.Sin(angle) + item.height / 2;
                rr.left = Convert.ToSingle(px + item.borderWidth / 2);
                rr.top = Convert.ToSingle(panelHeight - py + item.borderWidth / 2);
                py = panelHeight - py;
            }
            else
            {
                px = item.left;
                py = panelHeight - item.top - item.height;
                if (item.origin.Contains("right"))
                    px += item.width;
                if (item.origin.Contains("top"))
                    py += item.height;
            }

            System.Drawing.Drawing2D.Matrix atf = new System.Drawing.Drawing2D.Matrix();
            if (reset)
                atf.RotateAt(item.rote - 360, new System.Drawing.PointF(Convert.ToSingle(px), Convert.ToSingle(py)));
            else
                atf.RotateAt(360 - item.rote, new System.Drawing.PointF(Convert.ToSingle(px), Convert.ToSingle(py)));

            writer.DirectContent.Transform(atf);
            return rr;
        }
        /// <summary>
        /// 添加矩形
        /// </summary>
        /// <param name="panelHeight"></param>
        /// <param name="item"></param>
        /// <param name="writer"></param>
        private void AddRectangle(float panelHeight, PrintTemplateDtl item, PdfWriter writer)
        {
            try
            {
                if (item.borderWidth <= 0)
                    return;

                RoteRectangle rr = Rotate(false, panelHeight, item, writer);

                Tuple<int, int, int> t = HexToRgb(item.borderColor);
                writer.DirectContent.SetLineWidth(item.borderWidth);
                if (item.borderStyle == "dashed")
                    writer.DirectContent.SetLineDash(item.borderWidth * 2, Convert.ToSingle(item.borderWidth * 1.5), 0);
                writer.DirectContent.SetColorStroke(new BaseColor(t.Item1, t.Item2, t.Item3));
                if (item.radius > 0)
                {
                    var r = item.radius;
                    if (rr.width > rr.height)
                    {
                        if (r > rr.height / 2)
                            r = rr.height / 2;
                    }
                    else
                    {
                        if (r > rr.width / 2)
                            r = rr.width / 2;
                    }
                    writer.DirectContent.RoundRectangle(rr.left, rr.top, rr.width, rr.height, r);
                }
                else
                    writer.DirectContent.Rectangle(rr.left, rr.top, rr.width, rr.height);
                writer.DirectContent.Stroke();

                Rotate(false, panelHeight, item, writer, true);
            }
            catch (Exception ex)
            {
                throw new Exception("矩形生成失败:" + ex.Message);
            }
        }
        /// <summary>
        /// 填充矩形背景
        /// </summary>
        /// <param name="panelHeight"></param>
        /// <param name="item"></param>
        /// <param name="writer"></param>
        private void FillRectangle(float panelHeight, PrintTemplateDtl item, PdfWriter writer)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(item.backgroundColor))
                    return;

                RoteRectangle rr = Rotate(true, panelHeight, item, writer);

                Tuple<int, int, int> t = HexToRgb(item.backgroundColor);
                writer.DirectContent.SetRGBColorFill(t.Item1, t.Item2, t.Item3);
                if (item.radius > 0)
                {
                    var r = item.radius;
                    if (rr.width > rr.height)
                    {
                        if (r > rr.height / 2)
                            r = rr.height / 2;
                    }
                    else
                    {
                        if (r > rr.width / 2)
                            r = rr.width / 2;
                    }
                    writer.DirectContent.RoundRectangle(rr.left, rr.top, rr.width, rr.height, r);
                }
                else
                    writer.DirectContent.Rectangle(rr.left, rr.top, rr.width, rr.height);
                writer.DirectContent.Fill();

                Rotate(true, panelHeight, item, writer, true);
            }
            catch (Exception ex)
            {
                throw new Exception("背景生成失败:" + ex.Message);
            }
        }
        /// <summary>
        /// 添加图片
        /// </summary>
        /// <param name="panelHeight"></param>
        /// <param name="item"></param>
        /// <param name="writer"></param>
        /// <param name="drawimg"></param>
        private void AddImg(float panelHeight, PrintTemplateDtl item, PdfWriter writer, System.Drawing.Image drawimg, bool isBarcode =false)
        {
            try
            {
                if (drawimg == null)
                    return;
                //计算条码的宽度（根据生成的图片）
                if (isBarcode && item.barWidth.HasValue && item.barWidth > 0)
                {
                    item.width = drawimg.Width;
                }

                RoteRectangle rr = Rotate(true, panelHeight, item, writer);
                Image img = Image.GetInstance(drawimg, BaseColor.BLACK);
                img.ScaleAbsoluteWidth(rr.width);
                img.ScaleAbsoluteHeight(rr.height);
                img.SetAbsolutePosition(rr.left, rr.top);
                writer.DirectContent.AddImage(img);
                Rotate(true, panelHeight, item, writer, true);
            }
            catch (Exception ex)
            {
                throw new Exception("添加图片失败:" + ex.Message);
            }
        }
        private void AddImg(float panelHeight, PrintTemplateDtl item, PdfWriter writer, string url)
        {
            try
            {
                RoteRectangle rr = Rotate(true, panelHeight, item, writer);
                Image img = Image.GetInstance(url);
                img.ScaleAbsoluteWidth(rr.width);
                img.ScaleAbsoluteHeight(rr.height);
                img.SetAbsolutePosition(rr.left, rr.top);
                writer.DirectContent.AddImage(img);
                Rotate(true, panelHeight, item, writer, true);
            }
            catch (Exception ex)
            {
                throw new Exception("添加图片失败:" + ex.Message);
            }
        }
        private void AddImgBase64(float panelHeight, PrintTemplateDtl item, PdfWriter writer, string base64Image)
        {
            try
            {
                if (base64Image.StartsWith("data:image", StringComparison.OrdinalIgnoreCase))
                {
                    base64Image = base64Image.Substring(base64Image.IndexOf(',') + 1);
                }
                RoteRectangle rr = Rotate(true, panelHeight, item, writer);
                Image img = Image.GetInstance(Convert.FromBase64String(base64Image));
                img.ScaleAbsoluteWidth(rr.width);
                img.ScaleAbsoluteHeight(rr.height);
                img.SetAbsolutePosition(rr.left, rr.top);
                writer.DirectContent.AddImage(img);
                Rotate(true, panelHeight, item, writer, true);
            }
            catch (Exception ex)
            {
                throw new Exception("添加图片失败:" + ex.Message);
            }
        }
        private Tuple<int, int, int> HexToRgb(string hex)
        {
            try
            {
                hex = hex.Replace("#", "");
                ASCIIEncoding encoding = new ASCIIEncoding();
                byte[] bytes = encoding.GetBytes(hex);
                int[] array = null;
                if (bytes.Length == 3)
                    array = new int[] { bytes[0], bytes[0], bytes[1], bytes[1], bytes[2], bytes[2] };
                else if (bytes.Length == 6)
                    array = new int[] { bytes[0], bytes[1], bytes[2], bytes[3], bytes[4], bytes[5] };
                else
                    return new Tuple<int, int, int>(0, 0, 0);
                for (int i = 0; i < array.Length; i++)
                {
                    if (array[i] >= 48 && array[i] <= 57)
                        array[i] -= 48;
                    else if (array[i] >= 97 && array[i] <= 102)
                        array[i] -= 87;
                    else
                        return new Tuple<int, int, int>(0, 0, 0);
                }
                return new Tuple<int, int, int>(Convert.ToInt32(16 * array[0] + array[1]), Convert.ToInt32(16 * array[2] + array[3]), Convert.ToInt32(16 * array[4] + array[5]));
            }
            catch (Exception ex)
            {
                throw new Exception("RGB解析失败:" + ex.Message);
            }
        }

        #region 日志记录

        /// <summary>
        /// 写入异常在根目录Error文件夹中
        /// </summary>
        /// <param name="ex"></param>
        private void WriteException(Exception ex)
        {
            StringBuilder sb = new StringBuilder();
            if (ex.InnerException != null)
            {
                sb.AppendLine("异常消息:" + ex.InnerException.Message);
                sb.AppendLine("来源:" + ex.InnerException.StackTrace);
            }
            else
            {
                sb.AppendLine("异常消息:" + ex.Message);
                sb.AppendLine("来源:" + ex.StackTrace);
            }
            WriteLog(sb.ToString(), "error");
        }
        /// <summary>
        /// 写入日志在根目录Log文件夹中
        /// </summary>
        /// <param name="msg"></param>
        /// <param name="folder"></param>
        private void WriteLog(string msg, string folder = "log")
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("----------------------" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "--------------------------");
            sb.AppendLine(msg);
            string path = AppDomain.CurrentDomain.BaseDirectory + folder + "\\" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt";
            if (!Directory.Exists(AppDomain.CurrentDomain.BaseDirectory + folder))
                Directory.CreateDirectory(AppDomain.CurrentDomain.BaseDirectory + folder);
            if (!File.Exists(path))
            {
                FileStream stream = File.Create(path);
                stream.Dispose();
            }
            StreamWriter sw = File.AppendText(path);
            sw.Write(sb.ToString());
            sw.Dispose();
        }
        #endregion

        #endregion
    }
}
