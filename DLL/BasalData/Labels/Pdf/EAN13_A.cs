using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;

namespace SKT.LeanMES.Labels.Pdf
{
    public class EAN13_A
    {
        private DataTable m_EAN13 = new DataTable();
        public EAN13_A()
        {
            m_EAN13.Columns.Add("ID");
            m_EAN13.Columns.Add("Type");
            m_EAN13.Columns.Add("A");
            m_EAN13.Columns.Add("B");
            m_EAN13.Columns.Add("C");
            m_EAN13.Rows.Add("0", "AAAAAA", "0001101", "0100111", "1110010");
            m_EAN13.Rows.Add("1", "AABABB", "0011001", "0110011", "1100110");
            m_EAN13.Rows.Add("2", "AABBAB", "0010011", "0011011", "1101100");
            m_EAN13.Rows.Add("3", "AABBBA", "0111101", "0100001", "1000010");
            m_EAN13.Rows.Add("4", "ABAABB", "0100011", "0011101", "1011100");
            m_EAN13.Rows.Add("5", "ABBAAB", "0110001", "0111001", "1001110");
            m_EAN13.Rows.Add("6", "ABBBAA", "0101111", "0000101", "1010000");
            m_EAN13.Rows.Add("7", "ABABAB", "0111011", "0010001", "1000100");
            m_EAN13.Rows.Add("8", "ABABBA", "0110111", "0001001", "1001000");
            m_EAN13.Rows.Add("9", "ABBABA", "0001011", "0010111", "1110100");
        }
        public int Width = 210;
        public int Height = 80;

        public int FontSize = 24;

        public Color BackColor = Color.White;

        public Color ForeColor = Color.Black;

        private List<char> Lines;
        public Bitmap GetCodeImage(string p_Text, Font font)
        {
            if (p_Text.Length != 13)
                throw new Exception("数字不是13位!");
            Lines = new List<char>();
            Bitmap bitmap = new Bitmap(Width, Height);
            Graphics graph = Graphics.FromImage(bitmap);
            graph.FillRectangle(new SolidBrush(BackColor), 0, 0, bitmap.Width, bitmap.Height);
            Brush fontColor = new SolidBrush(ForeColor);

            GetLine("101");
            string _CodeText = p_Text.Remove(0, 1);
            char[] _LeftType = GetValue(p_Text.Substring(0, 1), "Type").ToCharArray();
            for (int i = 0; i != 6; i++)
            {
                GetLine(GetValue(_CodeText.Substring(0, 1), _LeftType[i].ToString()));
                _CodeText = _CodeText.Remove(0, 1);
            }
            GetLine("01010");
            for (int i = 0; i != 6; i++)
            {
                GetLine(GetValue(_CodeText.Substring(0, 1), "C"));
                _CodeText = _CodeText.Remove(0, 1);
            }
            GetLine("101");

            int sizeF = Convert.ToInt32(graph.MeasureString(p_Text.Substring(0), font).Height);
            float lineWidth = (Width - sizeF) / Lines.Count + Convert.ToSingle(0.8);
            Pen pen = new Pen(ForeColor, lineWidth);
            float index = (Width - lineWidth * Lines.Count - sizeF) / 2 + sizeF;
            float a = 0, b = 0, c = 0, d = 0;
            for (int i = 0; i < Lines.Count; i++)
            {
                if (Lines[i] == 49)
                {
                    if (i == 0 || i == 2 || i == 46 || i == 48 || i == 92 || i == 94)
                        graph.DrawLine(pen, index, 0, index, Height - (FontSize / 2));
                    else
                        graph.DrawLine(pen, index, 0, index, Height - sizeF);
                }
                if (i == 2)
                {
                    a = index + lineWidth;
                }
                else if (i == 46)
                {
                    b = index;
                }
                else if (i == 48)
                {
                    c = index;
                }
                else if (i == 92)
                {
                    d = index;
                }
                index += lineWidth;
            }
            graph.DrawString(p_Text.Substring(0, 1), font, fontColor, (Width - lineWidth * Lines.Count - FontSize) / 2, Height - sizeF);
            float e = (b - a) / 6;
            float aindex = a;
            for (int i = 1; i <= 6; i++)
            {
                graph.DrawString(p_Text[i].ToString(), font, fontColor, aindex, Height - sizeF);
                aindex += e;
            }
            float f = (d - c) / 6;
            float bindex = c;
            for (int i = 7; i <= 12; i++)
            {
                graph.DrawString(p_Text[i].ToString(), font, fontColor, bindex, Height - sizeF);
                bindex += f;
            }
            return bitmap;
        }
        private void GetLine(string str)
        {
            for (int i = 0; i < str.Length; i++)
            {
                Lines.Add(str[i]);
            }
        }
        private string GetValue(string p_Value, string p_Type)
        {
            if (m_EAN13 == null) return "";
            DataRow[] _Row = m_EAN13.Select("ID='" + p_Value + "'");
            if (_Row.Length != 1) throw new Exception("错误的编码" + p_Value.ToString());
            return _Row[0][p_Type].ToString();
        }
    }
}
