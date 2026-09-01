using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;

namespace SKT.LeanMES.CommonHelper.BLL
{
    public class PDFEvent : PdfPageEventHelper, IPdfPageEvent
    {
        public System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> dicSetting;
        private PdfTemplate tempHeader_Left;
        private PdfTemplate tempHeader_Center;
        private PdfTemplate tempHeader_Right;
        private PdfTemplate tempFooter_Left;
        private PdfTemplate tempFooter_Center;
        private PdfTemplate tempFooter_Right;
        public static PdfTemplate tempFooter_Page = null;
        private string strFile_Name;
        private BaseFont fontFamily;
        private bool boolShowPunNum = false;
        private string strReport_Source;
        private string strImage_Path;
        private DataSet dataset;
        public float TotalUseHeigth
        {
            get;
            set;
        }
        internal PDFEvent(System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> dic, string strName, BaseFont font, string strReportSource, DataSet ds, string strImagePath)
        {
            this.dicSetting = dic;
            this.strFile_Name = strName;
            this.fontFamily = font;
            this.strReport_Source = strReportSource;
            this.dataset = ds;
            this.strImage_Path = strImagePath;
        }
        public override void OnStartPage(PdfWriter writer, Document document)
        {
            base.OnStartPage(writer, document);
            writer.PageCount = writer.PageNumber;
            try
            {
                PdfContentByte directContent = writer.DirectContent;
                Rectangle pageSize = document.PageSize;
                float num = float.Parse(this.dicSetting["margin"]["left"]);
                float num2 = float.Parse(this.dicSetting["margin"]["right"]);
                float num3 = (pageSize.Width - num - num2) / 3f;
                float num4 = float.Parse(this.dicSetting["margin"]["header"]);
                float num5 = float.Parse(this.dicSetting["margin"]["footer"]);
                this.tempHeader_Left = directContent.CreateTemplate(num3, num4);
                directContent.AddTemplate(this.tempHeader_Left, pageSize.GetLeft(num), pageSize.GetTop(num4));
                this.tempHeader_Center = directContent.CreateTemplate(num3, num4);
                directContent.AddTemplate(this.tempHeader_Center, pageSize.GetLeft(num) + num3, pageSize.GetTop(num4));
                this.tempHeader_Right = directContent.CreateTemplate(num3, num4);
                directContent.AddTemplate(this.tempHeader_Right, pageSize.GetLeft(num) + num3 * 2f, pageSize.GetTop(num4));
                this.tempFooter_Left = directContent.CreateTemplate(num3, num5);
                directContent.AddTemplate(this.tempFooter_Left, pageSize.GetLeft(num), pageSize.GetBottom(num5) - num4);
                this.tempFooter_Center = directContent.CreateTemplate(num3, num5);
                directContent.AddTemplate(this.tempFooter_Center, pageSize.GetLeft(num) + num3, pageSize.GetBottom(num5) - num4);
                this.tempFooter_Right = directContent.CreateTemplate(num3, num5);
                directContent.AddTemplate(this.tempFooter_Right, pageSize.GetLeft(num) + num3 * 2f, pageSize.GetBottom(num5) - num4);
                PDFHelper.setHeader(document, writer, "", this.strReport_Source, this.dataset, this.strImage_Path, "header");
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
        }
        public override void OnEndPage(PdfWriter writer, Document document)
        {
            PdfContentByte directContent = writer.DirectContent;
            Rectangle pageSize = document.PageSize;
            string[] array = new string[]
			{
				"header",
				"footer"
			};
            string[] array2 = new string[]
			{
				"left",
				"center",
				"right",
				"pageNum"
			};
            float floatLeft = float.Parse(this.dicSetting["margin"]["left"]);
            float floatRigth = float.Parse(this.dicSetting["margin"]["right"]);
            float fHeigth = float.Parse(this.dicSetting["margin"]["bottom"]);
            this.boolShowPunNum = false;
            string[] array3 = array;
            for (int i = 0; i < array3.Length; i++)
            {
                string str = array3[i];
                string[] array4 = array2;
                for (int j = 0; j < array4.Length; j++)
                {
                    string str2 = array4[j];
                    string text = str + "/" + str2;
                    if (this.dicSetting.ContainsKey(text + "/image"))
                    {
                        System.Collections.Generic.Dictionary<string, string> dictionary = this.dicSetting[text + "/image"];
                        if (!dictionary.ContainsKey("url"))
                        {
                            throw new System.Exception("圖片路徑未設定");
                        }
                        if (!System.IO.File.Exists(dictionary["url"]))
                        {
                            throw new System.Exception("找不到圖片檔案 - " + dictionary["url"]);
                        }
                        float floatPercent = dictionary.ContainsKey("size") ? float.Parse(dictionary["size"].TrimEnd(new char[]
						{
							'%'
						})) : 100f;
                        this.setTemplateImage(text, dictionary["url"], floatPercent);
                    }
                    else
                    {
                        if (this.dicSetting.ContainsKey(text + "/pageNum"))
                        {
                            this.setPageNumText(writer, directContent, document, text + "/pageNum");
                            this.boolShowPunNum = true;
                        }
                        else
                        {
                            if (this.dicSetting.ContainsKey(text) && this.dicSetting[text].ContainsKey("text"))
                            {
                                this.setTemplateText(text, document.PageNumber);
                            }
                        }
                    }
                }
                PDFHelper.setFooter(document, writer, "", this.strReport_Source, this.dataset, this.strImage_Path, floatLeft, fHeigth, floatRigth);
            }
        }
        public override void OnCloseDocument(PdfWriter writer, Document document)
        {
            if (this.boolShowPunNum)
            {
                float size = 9f;
                if (this.dicSetting.ContainsKey("footer/left/pageNum"))
                {
                    size = (this.dicSetting["footer/left/pageNum"].ContainsKey("font-size") ? float.Parse(this.dicSetting["footer/left/pageNum"]["font-size"]) : 9f);
                }
                else
                {
                    if (this.dicSetting.ContainsKey("footer/center/pageNum"))
                    {
                        size = (this.dicSetting["footer/center/pageNum"].ContainsKey("font-size") ? float.Parse(this.dicSetting["footer/center/pageNum"]["font-size"]) : 9f);
                    }
                    else
                    {
                        if (this.dicSetting.ContainsKey("footer/right/pageNum"))
                        {
                            size = (this.dicSetting["footer/right/pageNum"].ContainsKey("font-size") ? float.Parse(this.dicSetting["footer/right/pageNum"]["font-size"]) : 9f);
                        }
                    }
                }
                PDFEvent.tempFooter_Page.BeginText();
                PDFEvent.tempFooter_Page.SetFontAndSize(this.fontFamily, size);
                PDFEvent.tempFooter_Page.ShowText((writer.PageNumber - 1).ToString());
                PDFEvent.tempFooter_Page.EndText();
                PDFEvent.tempFooter_Page.ClosePath();
            }
            base.OnCloseDocument(writer, document);
        }
        private void setTemplateImage(string strType, string strImage_Url, float floatPercent)
        {
            Image instance = Image.GetInstance(strImage_Url);
            instance.ScalePercent(floatPercent);
            if (strType != null)
            {
                if (!(strType == "header/left"))
                {
                    if (!(strType == "header/center"))
                    {
                        if (!(strType == "header/right"))
                        {
                            if (!(strType == "footer/left"))
                            {
                                if (!(strType == "footer/center"))
                                {
                                    if (strType == "footer/right")
                                    {
                                        instance.SetAbsolutePosition(this.tempFooter_Right.Width - instance.ScaledWidth, this.tempFooter_Right.Height - instance.ScaledHeight);
                                        this.tempFooter_Right.AddImage(instance);
                                    }
                                }
                                else
                                {
                                    instance.SetAbsolutePosition(this.tempFooter_Center.Width / 2f - instance.ScaledWidth / 2f, this.tempFooter_Center.Height - instance.ScaledHeight);
                                    this.tempFooter_Center.AddImage(instance);
                                }
                            }
                            else
                            {
                                instance.SetAbsolutePosition(0f, this.tempFooter_Left.Height - instance.ScaledHeight);
                                this.tempFooter_Left.AddImage(instance);
                            }
                        }
                        else
                        {
                            instance.SetAbsolutePosition(this.tempHeader_Right.Width - instance.ScaledWidth, 0f);
                            this.tempHeader_Right.AddImage(instance);
                        }
                    }
                    else
                    {
                        instance.SetAbsolutePosition(this.tempHeader_Center.Width / 2f - instance.ScaledWidth / 2f, 0f);
                        this.tempHeader_Center.AddImage(instance);
                    }
                }
                else
                {
                    instance.SetAbsolutePosition(0f, 0f);
                    this.tempHeader_Left.AddImage(instance);
                }
            }
        }
        private void setTemplateText(string strType, int intPage_No)
        {
            float num = 9f;
            if (this.dicSetting.ContainsKey(strType))
            {
                num = (this.dicSetting[strType].ContainsKey("font-size") ? float.Parse(this.dicSetting[strType]["font-size"]) : 9f);
            }
            string text = this.replaceText(this.dicSetting[strType]["text"], intPage_No);
            if (strType != null)
            {
                if (!(strType == "header/left"))
                {
                    if (!(strType == "header/center"))
                    {
                        if (!(strType == "header/right"))
                        {
                            if (!(strType == "footer/left"))
                            {
                                if (!(strType == "footer/center"))
                                {
                                    if (strType == "footer/right")
                                    {
                                        this.tempFooter_Right.BeginText();
                                        this.tempFooter_Right.SetFontAndSize(this.fontFamily, num);
                                        this.tempFooter_Right.ShowTextAligned(2, text, this.tempFooter_Right.Width, this.tempFooter_Center.Height - num, 0f);
                                        this.tempFooter_Right.EndText();
                                    }
                                }
                                else
                                {
                                    this.tempFooter_Center.BeginText();
                                    this.tempFooter_Center.SetFontAndSize(this.fontFamily, num);
                                    this.tempFooter_Center.ShowTextAligned(1, text, this.tempHeader_Center.Width / 2f, this.tempFooter_Center.Height - num, 0f);
                                    this.tempFooter_Center.EndText();
                                }
                            }
                            else
                            {
                                this.tempFooter_Left.BeginText();
                                this.tempFooter_Left.SetFontAndSize(this.fontFamily, num);
                                this.tempFooter_Left.ShowTextAligned(0, text, 0f, this.tempFooter_Center.Height - num, 0f);
                                this.tempFooter_Left.EndText();
                            }
                        }
                        else
                        {
                            this.tempHeader_Right.BeginText();
                            this.tempHeader_Right.SetFontAndSize(this.fontFamily, num);
                            this.tempHeader_Right.ShowTextAligned(2, text, this.tempHeader_Right.Width, 0f, 0f);
                            this.tempHeader_Right.EndText();
                        }
                    }
                    else
                    {
                        this.tempHeader_Center.BeginText();
                        this.tempHeader_Center.SetFontAndSize(this.fontFamily, num);
                        this.tempHeader_Center.ShowTextAligned(1, text, this.tempHeader_Center.Width / 2f, 0f, 0f);
                        this.tempHeader_Center.EndText();
                    }
                }
                else
                {
                    this.tempHeader_Left.BeginText();
                    this.tempHeader_Left.SetFontAndSize(this.fontFamily, num);
                    this.tempHeader_Left.ShowTextAligned(0, text, 0f, 0f, 0f);
                    this.tempHeader_Left.EndText();
                }
            }
        }
        private void setPageNumText(PdfWriter writer, PdfContentByte page, Document document, string strType)
        {
            float num = 9f;
            if (this.dicSetting.ContainsKey(strType))
            {
                num = (this.dicSetting[strType].ContainsKey("font-size") ? float.Parse(this.dicSetting[strType]["font-size"]) : 9f);
            }
            Phrase phrase = new Phrase("第" + writer.PageNumber + "页/共   页", new Font(this.fontFamily, num));
            if (strType != null)
            {
                if (!(strType == "footer/left/pageNum"))
                {
                    if (!(strType == "footer/center/pageNum"))
                    {
                        if (strType == "footer/right/pageNum")
                        {
                            page.AddTemplate(PDFEvent.tempFooter_Page, document.Right - 60f + num + document.LeftMargin, document.Bottom - 18f);
                            ColumnText.ShowTextAligned(page, 1, phrase, document.Right - 60f + document.LeftMargin, document.Bottom - 18f, 0f);
                        }
                    }
                    else
                    {
                        page.AddTemplate(PDFEvent.tempFooter_Page, document.PageSize.Width / 2f + num, document.Bottom - 18f);
                        ColumnText.ShowTextAligned(page, 1, phrase, document.PageSize.Width / 2f, document.Bottom - 18f, 0f);
                    }
                }
                else
                {
                    page.AddTemplate(PDFEvent.tempFooter_Page, document.Left - 20f + num + document.LeftMargin, document.Bottom - 18f);
                    ColumnText.ShowTextAligned(page, 1, phrase, document.Left - 20f + document.LeftMargin, document.Bottom - 18f, 0f);
                }
            }
        }
        private string replaceText(string strText, int intPage_No)
        {
            strText = strText.Replace("#[NOW]#", System.DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"));
            strText = strText.Replace("#[NOW_DATE]#", System.DateTime.Today.ToString("yyyy/MM/dd"));
            strText = strText.Replace("#[NOW_TIME]#", System.DateTime.Now.ToString("HH:mm:ss"));
            strText = strText.Replace("#[PAGE_NUMBER]#", intPage_No.ToString());
            strText = strText.Replace("#[FILE_NAME]#", this.strFile_Name);
            return strText;
        }
        private void drawBorder()
        {
            this.tempHeader_Left.RoundRectangle(0f, 0f, this.tempHeader_Left.Width, this.tempHeader_Left.Height, 0f);
            this.tempHeader_Left.SetColorStroke(BaseColor.BLUE);
            this.tempHeader_Left.Stroke();
            this.tempHeader_Center.RoundRectangle(0f, 0f, this.tempHeader_Center.Width, this.tempHeader_Center.Height, 0f);
            this.tempHeader_Center.SetColorStroke(BaseColor.GREEN);
            this.tempHeader_Center.Stroke();
            this.tempHeader_Right.RoundRectangle(0f, 0f, this.tempHeader_Right.Width, this.tempHeader_Right.Height, 0f);
            this.tempHeader_Right.SetColorStroke(BaseColor.RED);
            this.tempHeader_Right.Stroke();
            this.tempFooter_Left.RoundRectangle(0f, 0f, this.tempFooter_Left.Width, this.tempFooter_Left.Height, 0f);
            this.tempFooter_Left.SetColorStroke(BaseColor.BLUE);
            this.tempFooter_Left.Stroke();
            this.tempFooter_Center.RoundRectangle(0f, 0f, this.tempFooter_Center.Width, this.tempFooter_Center.Height, 0f);
            this.tempFooter_Center.SetColorStroke(BaseColor.GREEN);
            this.tempFooter_Center.Stroke();
            this.tempFooter_Right.RoundRectangle(0f, 0f, this.tempFooter_Right.Width, this.tempFooter_Right.Height, 0f);
            this.tempFooter_Right.SetColorStroke(BaseColor.RED);
            this.tempFooter_Right.Stroke();
        }
    }
}
