using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Data;

namespace SKT.LeanMES.Print.BLL
{
    public class LabelConvertCH
    {

        /// <summary>
        /// 2016-2-22 zhibin.chen  用于对内容中的中文字符进行转换
        /// @Font由 “字体名称,是否粗体(1/0)”组成
        /// %CH'+ @Font +'CH1%'+ @RValue + '%CHEnd%
        /// %CH'+ @Font +'CH2%'+ @RValue + '%CHEnd%
        /// %CH'+ @Font +'CH3%'+ @RValue + '%CHEnd%
        /// </summary>
        /// <returns></returns>
        public string ConvertCH(string zplStr, int count)
        {
            string strLabel = zplStr;
            string chStr = "";
            string font = "";
            string fontAndBold = "";
            int width = 20;
            int height = 20;
            int isBold = 0;
            string[] fb = new string[2];

            while (count > 0)
            {
                Match m = Regex.Match(strLabel, @"(?<=%CH{1}.+CH{1}"+ count.ToString() +"%{1}).*?(?=%CHEnd%{1})");
                fontAndBold = Regex.Match(strLabel, @"(?<=%CH{1}).*?(?=CH{1}" + count.ToString() + "%{1})").Groups[0].Value;
                fb = fontAndBold.Split(',');
                font = fb[0];
                isBold = Convert.ToInt32(fb[1]);
                width = Convert.ToInt32(Regex.Match(strLabel, @"(?<=\^A{1}\w{2},{1}\d{1,2},{1})\d{1,2}(?=\^FH\\\^FD%CH{1}.+CH{1}" + count.ToString() + "%{1})").Groups[0].Value);
                height = Convert.ToInt32(Regex.Match(strLabel, @"(?<=\^A{1}\w{2},{1})\d{1,2}(?=,{1}\d{1,2}\^FH\\\^FD%CH{1}.+CH{1}" + count.ToString() + "%{1})").Groups[0].Value);
                chStr = TextToHex(m.Groups[0].Value, count.ToString(), height, width, font, isBold);
                strLabel = Regex.Replace(strLabel, "FD%CH" + fontAndBold + "CH" + count.ToString() + "%" + m.Groups[0].Value + "%CHEnd%", "XG" + chStr);
                count--;
            }

            return strLabel;
        }


        /// <summary>
        /// 转换中文以及指定字体
        /// </summary>
        /// <param name="text"></param>
        /// <param name="textId"></param>
        /// <param name="height"></param>
        /// <returns></returns>
        public string TextToHex(string text, string textId, int height, int width, string font, int isBold)
        {
            StringBuilder hexBuilder = new StringBuilder(4 * 1024);
            int subStrCount = 0;
            subStrCount = ZPLPrinter.GETFONTHEX(text, font, textId, 0, height, width, isBold, 0, hexBuilder);
            return hexBuilder.ToString().Substring(0, subStrCount);
        }
    }
}
