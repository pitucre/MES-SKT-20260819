using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using iTextSharp.text.pdf;

namespace SKT.LeanMES.CommonHelper.BLL
{
    public class PDFFont
    {
        public static BaseFont getFontInfo(PDFHelper.Language language)
        {
            BaseFont result;
            if (language == PDFHelper.Language.Traditional)
            {
                result = BaseFont.CreateFont("C:\\Windows\\Fonts\\kaiu.ttf", "Identity-H", false);
            }
            else
            {
                result = BaseFont.CreateFont("C:\\Windows\\Fonts\\simkai.ttf", "Identity-H", false);
            }
            return result;
        }
        public static BaseFont getFontInfo(string strFont)
        {
            return BaseFont.CreateFont("C:\\Windows\\Fonts\\" + strFont, "Identity-H", false);
        }
    }
}
