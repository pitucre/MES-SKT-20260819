using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;
using System.IO;
using System.Data;
using System.Drawing;
using System.Drawing.Printing;
using ThoughtWorks.QRCode.Codec;
using SKT.LeanMES.Print.Model;

namespace SKT.LeanMES.Print.BLL
{
    using System = global::System;
    public class ZPLPrinter
    {
        public string Name;
        #region DLL声明
        //ZPL
        [DllImport(@"FNTHEX32.DLL", CharSet = CharSet.Ansi)]
        public static extern int GETFONTHEX(
                          string chnstr,
                          string fontname,
                          string chnname,
                          int orient,
                          int height,
                          int width,
                          int bold,
                          int italic,
                          StringBuilder param1);
        //EPL
        [DllImport(@"Eltronp.dll", CharSet = CharSet.Ansi)]
        public static extern int PrintHZ(int Lpt, //0：LPT1，1 LPT2
                                         int x,
                                         int y,
                                         string HZBuf,
                                         string FontName,
                                         int FontSize,
                                         int FontStyle);
        #endregion

        #region 指令说明
        /**
        ^XA 开始 ^XZ 结束
        ^LH起始坐标  ^PR进纸回纸速度 ^MD 对比度
        ^FO标签左上角坐标  ^XG打印图片参数1图片名称后两个为坐标
        ^FS标签结束符  ^CI切换国际字体 ^FT坐标 ^FD定义一个字符串
        ^A定义字体  ^FH十六进制数 ^BY模块化label ^BC条形码128  
        ^PQ打印设置 参数一 打印数量 参数二暂停 参数三重复数量  参数四为Y时表明无暂停
         **/
        #endregion

        #region PrintDocument 打印条码、二维码
        public void Print()
        {
            System.Drawing.Printing.PrintDocument _Document = new System.Drawing.Printing.PrintDocument();
            _Document.PrintPage += _Document_PrintPage;
            PageSettings pageSet = new PageSettings();
            pageSet.Landscape = false;
            pageSet.Margins.Top = 0;
            pageSet.Margins.Left = 1;
            pageSet.PaperSize = new System.Drawing.Printing.PaperSize("小票", 2, 2);
            _Document.DefaultPageSettings = pageSet;
            _Document.Print();
        }
        void _Document_PrintPage(object sender, System.Drawing.Printing.PrintPageEventArgs e)
        {
            float x = 0;
            float y = 0;
            float width = 300;
            float height = 60;
            e.Graphics.DrawImage(CreateBarcodeImage("--test--", ""), x, y, width, height);
            e.HasMorePages = false;
        }
        #endregion

        #region ZPL 打印条码、二维码
        /// <summary>
        /// 条码打印(标签两列)
        /// </summary>
        /// <param name="l">左边距 推荐值：0</param>
        /// <param name="h">上边距 推荐值：0</param>
        /// <param name="cl">第一列与第二列的距离 推荐值：0</param>
        /// <param name="bch">条码高 推荐值：0</param>
        /// <param name="str">条码内容1，内容2两个字符串 推荐值：11位字母数字组成</param>
        /// <returns>true /false 执行状态</returns>
        public string PrintBarcode(int l, int h, int cl, int bch, params string[] str)
        {
            l = l == 0 ? 0 : l;
            h = h == 0 ? 8 : h;
            cl = cl == 0 ? 30 : cl;
            bch = bch == 0 ? 100 : bch;
            StringBuilder sb = new StringBuilder();
            sb.Append("^XA");
            //连续打印两列（单列只写一条）
            sb.Append(string.Format("^MD30^LH{0},{1}^FO{2},{3}^ACN,18,10^BY1.8,3,{4}^BC,,Y,N^FD{5}^FS", l, h, l, h, bch, str[0]));
            sb.Append(string.Format("^MD30^LH{0},{1}^FO{2},{3}^ACN,18,10^BY1.8,3,{4}^BC,,Y,N^FD{5}^FS", l, h, l + cl, h, bch, str[1]));

            sb.Append("^XZ");
            return sb.ToString();
        }
        /// <summary>
        /// 二维码打印(标签两列)
        /// </summary>
        /// <param name="l">左边距 推荐值：0</param>
        /// <param name="h">上边距 推荐值：0</param>
        /// <param name="cl">第一列与第二列的距离 推荐值：0</param>
        /// <param name="bch">二维码放大倍数 推荐值：0</param>
        /// <param name="str">内容1，内容2两个字符串 推荐值：字母数字组成（位数不限制）</param>
        /// <returns>true /false 执行状态</returns>
        public string PrintQRCode(int l, int h, int cl, int bch, params string[] str)
        {
            if (str.Length < 2) return "";
            string[] str0 = str[0].Split(',');
            string[] str1 = str[1].Split(',');

            l = l == 0 ? 5 : l;
            h = h == 0 ? 8 : h;
            cl = cl == 0 ? 360 : cl;
            bch = bch == 0 ? 5 : bch;

            StringBuilder sb = new StringBuilder();
            sb.Append("^XA");
            sb.Append(string.Format("^LH{0},{1}^FO{2},{3}^BQ,2,{4}^FDQA,{5}^FS", l, h, 0, h, bch, str0[0]));
            sb.Append(TextToHex(str0[1], str0[0], 24));
            sb.Append(string.Format("^FT{0},{1}^XG{2},1,1^FS", 125 + l, h + 60, str0[0]));
            sb.Append(TextToHex(str0[0], str0[0], 20));
            sb.Append(string.Format("^FT{0},{1}^XG{2},1,1^FS", 125 + l, h + 90, str0[0]));

            sb.Append(string.Format("^LH{0},{1}^FO{2},{3}^BQ,2,{4}^FDQA,{5}^FS", l, h, 0 + cl, h, bch, str1[0]));
            sb.Append(TextToHex(str1[1], str1[0], 24));
            sb.Append(string.Format("^FT{0},{1}^XG{2},1,1^FS", 125 + cl + l, h + 60, str1[0]));
            sb.Append(TextToHex(str1[0], str1[0], 20));
            sb.Append(string.Format("^FT{0},{1}^XG{2},1,1^FS", 125 + cl + l, h + 90, str1[0]));
            sb.Append("^XZ");
            return sb.ToString();
        }
        #endregion

        #region 条码、二维码图片生成
        /// <summary>
        /// 生成条形码图片
        /// </summary>
        /// <param name="num">条形码序列号</param>
        /// <param name="path">图片存放路径（绝对路径）</param>
        /// <returns>返回图片</returns>
        public System.Drawing.Image CreateBarcodeImage(string num, string path)
        {
            BarcodeLib.Barcode b = new BarcodeLib.Barcode();
            b.BackColor = System.Drawing.Color.White;
            b.ForeColor = System.Drawing.Color.Black;
            b.IncludeLabel = true;
            b.Alignment = BarcodeLib.AlignmentPositions.CENTER;
            b.LabelPosition = BarcodeLib.LabelPositions.BOTTOMCENTER;
            b.ImageFormat = System.Drawing.Imaging.ImageFormat.Png;
            System.Drawing.Font font = new System.Drawing.Font("verdana", 10f);
            b.LabelFont = font;
            try
            {
                System.Drawing.Image image = b.Encode(BarcodeLib.TYPE.CODE128B, num);
                image.Save(path);
                return image;
            }
            catch (Exception)
            {

            }
            return null;
        }
        /// <summary>
        /// 生成二维码图片
        /// </summary>
        /// <param name="num">二维码序列号</param>
        /// <param name="path">图片存放路径（绝对路径）</param>
        /// <returns>返回图片</returns>
        public System.Drawing.Image CreateQRCodeImage(string num, string path)
        {
            QRCodeEncoder qrCodeEncoder = new QRCodeEncoder();
            String encoding = "Byte";
            if (encoding == "Byte")
            {
                qrCodeEncoder.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.BYTE;
            }
            else if (encoding == "AlphaNumeric")
            {
                qrCodeEncoder.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.ALPHA_NUMERIC;
            }
            else if (encoding == "Numeric")
            {
                qrCodeEncoder.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.NUMERIC;
            }
            try
            {
                int scale = Convert.ToInt16(4);
                qrCodeEncoder.QRCodeScale = scale;
            }
            catch (Exception)
            {

            }
            try
            {
                int version = Convert.ToInt16(7);
                qrCodeEncoder.QRCodeVersion = version;
            }
            catch (Exception)
            {

            }

            string errorCorrect = "M";
            if (errorCorrect == "L")
                qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.L;
            else if (errorCorrect == "M")
                qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.M;
            else if (errorCorrect == "Q")
                qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.Q;
            else if (errorCorrect == "H")
                qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.H;
            try
            {
                Bitmap bm = qrCodeEncoder.Encode(num);
                bm.Save(path);
                MemoryStream ms = new MemoryStream();
                bm.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                return System.Drawing.Image.FromStream(ms);
            }
            catch (Exception)
            {

            }
            return null;
        }
        #endregion

        #region ZPL 打印中文小票
        public string TextToHex(string text, string textId, int height)
        {
            StringBuilder hexBuilder = new StringBuilder(4 * 1024);
            int subStrCount = 0;
            subStrCount = GETFONTHEX(text, "宋体", textId, 0, height, 0, 1, 0, hexBuilder);
            return hexBuilder.ToString().Substring(0, subStrCount);
        }
        public string DeviceLabelToHex(string text, string textId)
        {
            StringBuilder hexBuilder = new StringBuilder(4 * 1024);
            int subStrCount = 0;
            subStrCount = 1; // GETFONTHEX(text, "Arial", textId, 0, 40, 0, 1, 0, hexBuilder);
            return hexBuilder.ToString().Substring(0, subStrCount);
        }
        public bool IsZebraPrinter(string printerName)
        {
            return printerName.IndexOf("ZDesigner") + printerName.IndexOf("Zebra") >= -1;
        }
        /**********打印包装箱**********/
        public string ZPLPrintCartonNumberLabel(DataTable dt, bool isRequireTextToHex, string left)
        {
            string strReturn = "";
            SKT.LeanMES.Print.Model.Label label = null;
            foreach (DataRow row in dt.Rows)
            {
                List<SKT.LeanMES.Print.Model.Label> labelList = new List<Print.Model.Label>();
                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "order";
                label.Text = row["order"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "qty";
                label.Text = row["qty"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "endor";
                label.Text = row["endor"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "rohs";
                label.Text = row["rohs"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "date";
                label.Text = row["date"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "box";
                label.Text = row["box"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "model";
                label.Text = row["model"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "po";
                label.Text = row["po"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "spec";
                label.Text = row["spec"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                if (isRequireTextToHex)
                {
                    strReturn = ZPLPrintCartonLabels(labelList.ToArray(), 50, left);
                }
                else
                {
                    strReturn = ZPLPrintGRNLabelsWithHexText(labelList.ToArray());
                }
            }
            return strReturn;
        }

    /*    public string ZPLPrintBoxCartonLabel(DataTable dt, bool isRequireTextToHex, string lblName, string left)
        {
            string strReturn = "";
            Int32 intHeight = 50;
            SKT.MES.Print.Model.Label label = null;
            List<SKT.MES.Print.Model.Label> labelList = new List<Print.Model.Label>();
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                if (dt.Columns[i].ColumnName.ToUpper().Trim() == "HEIGHT") //增加条码中字体高度设置  add by watson 2015-04-17
                {
                    intHeight = Int32.Parse(dt.Rows[0][i].ToString());
                }
                else
                {
                    label = new SKT.MES.Print.Model.Label();
                    label.Id = dt.Columns[i].ColumnName;
                    label.Text = dt.Rows[0][i].ToString();
                    if (label.Id.ToUpper().Trim().Length >= 7 && label.Id.ToUpper().Trim().Substring(0, 7) == "BARCODE")
                    {
                        label.chnFont = 0;
                    }
                    else
                    {
                        label.chnFont = 1;
                    }
                    labelList.Add(label);
                }
            }

            if (isRequireTextToHex)
            {
                strReturn = ZPLPrintContainerLabels(labelList.ToArray(), intHeight, lblName, left);
            }
            else
            {
                // strReturn = ZPLPrintGRNLabelsWithHexText(labelList.ToArray());
            }

            return strReturn;
        }*/

        private string ZPLPrintCartonLabels(SKT.LeanMES.Print.Model.Label[] labels, int height, string left)
        {
            string labelContentCmd = string.Empty;
            foreach (SKT.LeanMES.Print.Model.Label label in labels)
            {
                if (label.chnFont == 1)
                {
                    labelContentCmd += TextToHex(label.Text, label.Id, height);
                }
            }
            string content = "CT~~CD,~CC^~CT~^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH00,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ"
            + labelContentCmd;

          //  SKT.MES.BasalData.BLL.ZPL bllZPL = new BasalData.BLL.ZPL();
            SKT.LeanMES.Labels.BLL.LabelZPL bllZPL = new Labels.BLL.LabelZPL();
            DataTable dtZPL = bllZPL.GetZPLValueByName("Box_Carton");
            if (dtZPL == null || dtZPL.Rows.Count == 0)
            {
                content += "^XA^MMT^PW496^LL0614^LS0"
                + @"
              ^FT32,352^XGorder^FS
              ^FT32,544^XGqty^FS
              ^FT32,64^XGvendor^FS
              ^FT32,480^XGrohs^FS
              ^FT32,608^XGdate^FS
              ^FT32,160^XGbox^FS
              ^FT32,416^XGmodel^FS
              ^FT32,224^XGpo^FS
              ^FT32,288^XGspec^FS
              ^BY80,80^FT205,147^BXN,5,200,16,16,1
              ^FH\^FDITM2014001^FS
              ^PQ1,0,1,Y^XZ";
            }
            else
            {
                for (int i = 0; i < dtZPL.Rows.Count; i++)
                {
                    content += dtZPL.Rows[i]["zplvalues"].ToString();
                }
            }

            //替换非文字变量
            foreach (SKT.LeanMES.Print.Model.Label label in labels)
            {
                if (label.chnFont == 0)
                {
                    content = content.Replace(label.Id, label.Text);
                }
            }

            //整体左移，右移
            if (left.Trim().Length > 0)
            {
                content = content.Replace("LH00", "LH" + left.Trim());
            }

            return content;
        }

       /* private string ZPLPrintContainerLabels(SKT.MES.Print.Model.Label[] labels, int height, string lblName, string left)
        {
            string labelContentCmd = string.Empty;
            foreach (SKT.MES.Print.Model.Label label in labels)
            {
                if (label.chnFont == 1)
                {
                    labelContentCmd += TextToHex(label.Text, label.Id, height);
                }
            }
            string content = "CT~~CD,~CC^~CT~^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH00,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ"
            + labelContentCmd;

            SKT.MES.BasalData.BLL.ZPL bllZPL = new BasalData.BLL.ZPL();
            DataTable dtZPL = bllZPL.GetZPLValueByName(lblName);
            if (dtZPL != null || dtZPL.Rows.Count > 0)
            {
                for (int i = 0; i < dtZPL.Rows.Count; i++)
                {
                    content += dtZPL.Rows[i]["zplvalues"].ToString();
                }
            }

            //替换非文字变量
            foreach (SKT.MES.Print.Model.Label label in labels)
            {
                if (label.chnFont == 0)
                {
                    content = content.Replace(label.Id, label.Text);
                }
            }

            //整体左移，右移
            if (left.Trim().Length > 0)
            {
                content = content.Replace("LH00", "LH" + left.Trim());
            }

            return content;
        }*/
        /*******end************/
        public string ZPLPrintGRNLabel(DataTable dt, bool isRequireTextToHex, string left)
        {
            string strReturn = "";
            SKT.LeanMES.Print.Model.Label label = null;
            foreach (DataRow row in dt.Rows)
            {
                List<SKT.LeanMES.Print.Model.Label> labelList = new List<SKT.LeanMES.Print.Model.Label>();
                label = new SKT.LeanMES.Print.Model.Label();
                #region Data
                label.Id = "vendor";
                label.Text = row["vendor"].ToString();
                label.chnFont = 1;
                //label.XPos = 150;
                //label.YPos = 60;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "grn";
                label.Text = row["grn"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "ItemName";
                label.Text = row["ItemName"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "Code";
                label.Text = row["Code"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "Desc";
                label.Text = row["Desc"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "Qty";
                label.Text = row["Qty"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "Date";
                label.Text = row["Date"].ToString();
                label.chnFont = 1;
                labelList.Add(label);

                label = new SKT.LeanMES.Print.Model.Label();
                label.Id = "2DBar";
                label.Text = row["2DBar"].ToString();
                label.chnFont = 0;
                #endregion
                labelList.Add(label);

                if (isRequireTextToHex)
                {
                    strReturn = ZPLPrintGRNLabels(labelList.ToArray(), 50, left);
                }
                else
                {
                    strReturn = ZPLPrintGRNLabelsWithHexText(labelList.ToArray());
                }
            }
            return strReturn;
        }
        private string ZPLPrintGRNLabelsWithHexText(SKT.LeanMES.Print.Model.Label[] labels)
        {
            string labelIdCmd = string.Empty;
            string labelContentCmd = string.Empty;
            foreach (SKT.LeanMES.Print.Model.Label label in labels)
            {
                labelIdCmd += "^FT" + label.XPos.ToString() + "," + label.YPos.ToString() + "^XG" + label.Id + ",1,1^FS";
                labelContentCmd += label.Text;
            }
            string content = labelContentCmd
                + "^XA^LH0,0^PR2,2^MD20^FO0,0"
                + labelIdCmd
                + "^PQ1,0,1,Y^XZ";
            return content;
        }
        private string ZPLPrintGRNLabels(SKT.LeanMES.Print.Model.Label[] labels, int height, string left)
        {
            string labelContentCmd = string.Empty;
            foreach (SKT.LeanMES.Print.Model.Label label in labels)
            {
                if (label.chnFont == 1)
                {
                    labelContentCmd += TextToHex(label.Text, label.Id, height);
                }
            }
            #region 打印GRN条码

            string content = "CT~~CD,~CC^~CT~^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH00,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ"
            + labelContentCmd;

            SKT.LeanMES.Labels.BLL.LabelZPL bllZPL = new Labels.BLL.LabelZPL();
            DataTable dtZPL = bllZPL.GetZPLValueByName("Vendor_GRN");
            if (dtZPL == null || dtZPL.Rows.Count == 0)
            {
                content += "^XA^MMT^PW496^LL0614^LS0"
            + @"
            ^FT30,96^XGvendor,1,1^FS
            ^FT30,490^XGQty,1,1^FS
            ^FT30,576^XGDate,1,1^FS
            ^FT30,192^XGgrn,1,1^FS
            ^FT30,404^XGDesc,1,1^FS
            ^FT30,275^XGItemName,1,1^FS
            ^FT30,320^XGCode,1,1^FS
            ^BY80,80^FT150,214^BXN,5,200,20,20,1
            ^FH\^FD2DBar^FS 
            ^FT270,180^A0N,33,33^FH\^FD2DBar^FS           
            ^PQ1,0,1,Y^XZ";
            }
            else
            {
                for (int i = 0; i < dtZPL.Rows.Count; i++)
                {
                    content += dtZPL.Rows[i]["zplvalues"].ToString();
                }
            }

            //替换非文字变量
            foreach (SKT.LeanMES.Print.Model.Label label in labels)
            {
                if (label.chnFont == 0)
                {
                    content = content.Replace(label.Id, label.Text);
                }
            }

            //整体左移，右移
            if (left.Trim().Length > 0)
            {
                content = content.Replace("LH00", "LH" + left.Trim());
            }

            return content;
            #endregion
        }
        #endregion
    }
}