using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace LeanMES.FileMonitor.Utility
{
    public class TXTHelper
    {

        #region 解析TXT文件组成数组
        public static ArrayList ImportTXT(string filePath, char[] SplitChar)
        {
            ArrayList Data = new ArrayList();
            String content = "";

            Encoding encodeType = EncodingType.GetType(filePath);

            if (Path.GetFileName(filePath).Split('_').Length == 7)
            {
                using (StreamReader sm = new StreamReader(filePath, System.Text.Encoding.UTF8))
                {
                    content = sm.ReadToEnd().Replace("\r", "");
                    //sm.Close();
                    //sm.Dispose();
                }
            }
            else
            {
                //using (StreamReader sm = new StreamReader(filePath, System.Text.Encoding.Default))
                using (StreamReader sm = new StreamReader(filePath, encodeType))
                {
                    content = sm.ReadToEnd().Replace("\r", "");
                    //sm.Close();
                    //sm.Dispose();
                }
            }

            String[] contentArray = content.Split(new char[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);
            if (contentArray == null || contentArray.Length < 1)
            {
                return null;
            }

            for (int i = 0; i < contentArray.Length; i++)
            {
                String[] row = contentArray[i].Split(SplitChar, StringSplitOptions.RemoveEmptyEntries);
                Data.Add(row);
            }
            return Data;
        }


        #endregion



        #region 解析CSV文件成数组
        /// <summary>
        /// 解析CSV文件成数组
        /// </summary>
        public static ArrayList ImportCsv(string filePath)
        {
            ArrayList Data = new ArrayList();
            String content = "";
            using (StreamReader sm = new StreamReader(filePath, System.Text.Encoding.UTF8))
            {
                content = sm.ReadToEnd().Replace("\r", "");
                sm.Close();
                sm.Dispose();
            }
            String[] contentArray = content.Split('\n');
            if (contentArray == null || contentArray.Length < 1)
            {
                return null;
            }

            for (int i = 0; i < contentArray.Length; i++)
            {
                String[] row = contentArray[i].Split(',');
                Data.Add(row);
            }
            return Data;
        }
        #endregion
    }


    /// <summary>
    /// 获取文件的编码格式
    /// </summary>
    public class EncodingType
    {
        /// <summary>
        /// 给定文件的路径，读取文件的二进制数据，判断文件的编码类型
        /// </summary>
        /// <param name=“filePath“>文件路径</param>
        /// <returns>文件的编码类型</returns>
        public static System.Text.Encoding GetType(string filePath)
        {
            FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            Encoding r = GetType(fs);
            fs.Close();
            return r;
        }

        /// <summary>
        /// 通过给定的文件流，判断文件的编码类型
        /// </summary>
        /// <param name=“fs“>文件流</param>
        /// <returns>文件的编码类型</returns>
        public static System.Text.Encoding GetType(FileStream fs)
        {
            byte[] Unicode = new byte[] { 0xFF, 0xFE, 0x41 };
            byte[] UnicodeBIG = new byte[] { 0xFE, 0xFF, 0x00 };
            byte[] UTF8 = new byte[] { 0xEF, 0xBB, 0xBF }; //带BOM
            Encoding reVal = Encoding.Default;

            BinaryReader r = new BinaryReader(fs, System.Text.Encoding.Default);
            int i;
            int.TryParse(fs.Length.ToString(), out i);
            byte[] ss = r.ReadBytes(i);
            if (IsUTF8Bytes(ss) || (ss[0] == 0xEF && ss[1] == 0xBB && ss[2] == 0xBF))
            {
                reVal = Encoding.UTF8;
            }
            else if (ss[0] == 0xFE && ss[1] == 0xFF && ss[2] == 0x00)
            {
                reVal = Encoding.BigEndianUnicode;
            }
            else if (ss[0] == 0xFF && ss[1] == 0xFE && ss[2] == 0x41)
            {
                reVal = Encoding.Unicode;
            }
            r.Close();
            return reVal;

        }

        /// <summary>
        /// 判断是否是不带 BOM 的 UTF8 格式
        /// </summary>
        /// <param name=“data“></param>
        /// <returns></returns>
        private static bool IsUTF8Bytes(byte[] data)
        {
            int charByteCounter = 1; //计算当前正分析的字符应还有的字节数
            byte curByte; //当前分析的字节.
            for (int i = 0; i < data.Length; i++)
            {
                curByte = data[i];
                if (charByteCounter == 1)
                {
                    if (curByte >= 0x80)
                    {
                        //判断当前
                        while (((curByte <<= 1) & 0x80) != 0)
                        {
                            charByteCounter++;
                        }
                        //标记位首位若为非0 则至少以2个1开始 如:110XXXXX...........1111110X
                        if (charByteCounter == 1 || charByteCounter > 6)
                        {
                            return false;
                        }
                    }
                }
                else
                {
                    //若是UTF-8 此时第一位必须为1
                    if ((curByte & 0xC0) != 0x80)
                    {
                        return false;
                    }
                    charByteCounter--;
                }
            }
            if (charByteCounter > 1)
            {
                throw new Exception("非预期的byte格式");
            }
            return true;
        }

    }

}
