using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;

namespace SKT.LeanMES.CommonHelper.BLL
{
    public class PDFHelper
    {
        public enum Language
        {
            Traditional,
            Simplified
        }
        private static readonly double dobInch = 2.54;
        private static readonly int intPoint = 72;
        private static BaseFont fontFamily;
        private static DataTable dtXml_Info;
        private static PDFEvent pdfEvent;
        private static PdfWriter writerPdf2;//added by zhi.li 20190125
        private static DataTable dt2 = new DataTable();//声明一个DataTable
        private static int index = 0;//索引
        private static void analyzeXmlFile(string strXml_Path)
        {
            PDFHelper.dtXml_Info = new DataTable();
            PDFHelper.dtXml_Info.Columns.Add("PATH");
            PDFHelper.dtXml_Info.Columns.Add("NAME");
            PDFHelper.dtXml_Info.Columns.Add("VALUE");
            PDFHelper.dtXml_Info.Columns.Add("PRE_ID");
            PDFHelper.dtXml_Info.Columns.Add("CHI_ID");
            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.Load(strXml_Path);
            XmlNode documentElement = xmlDocument.DocumentElement;
            for (int i = 0; i <= documentElement.ChildNodes.Count - 1; i++)
            {
                string text = "00" + (i + 1);
                PDFHelper.getXmlInfo("", documentElement.ChildNodes[i], "", text.Substring(text.Length - 2, 2));
            }
        }
        private static void getXmlInfo(string strNode_Path, XmlNode node, string strPre_Id, string strNode_Id)
        {
            switch (node.NodeType)
            {
                case XmlNodeType.Element:
                    {
                        DataRow dataRow = PDFHelper.dtXml_Info.NewRow();
                        dataRow["PATH"] = strNode_Path + node.Name;
                        dataRow["NAME"] = "element";
                        dataRow["VALUE"] = "";
                        dataRow["PRE_ID"] = ((strPre_Id == "") ? "" : (strPre_Id + "00000000").Substring(0, 8));
                        dataRow["CHI_ID"] = strNode_Id;
                        PDFHelper.dtXml_Info.Rows.Add(dataRow);
                        foreach (XmlAttribute xmlAttribute in node.Attributes)
                        {
                            dataRow = PDFHelper.dtXml_Info.NewRow();
                            dataRow["PATH"] = strNode_Path + node.Name;
                            dataRow["NAME"] = xmlAttribute.Name;
                            dataRow["VALUE"] = xmlAttribute.Value;
                            dataRow["PRE_ID"] = ((strPre_Id == "") ? "" : (strPre_Id + "00000000").Substring(0, 8));
                            dataRow["CHI_ID"] = strNode_Id;
                            PDFHelper.dtXml_Info.Rows.Add(dataRow);
                        }
                        for (int i = 0; i <= node.ChildNodes.Count - 1; i++)
                        {
                            string text = "00" + (i + 1);
                            if (node.ChildNodes[i].NodeType == XmlNodeType.Element)
                            {
                                PDFHelper.getXmlInfo(strNode_Path + node.Name + "/", node.ChildNodes[i], strPre_Id + strNode_Id, text.Substring(text.Length - 2, 2));
                            }
                            else
                            {
                                PDFHelper.getXmlInfo(strNode_Path + node.Name + "/", node.ChildNodes[i], strPre_Id, strNode_Id);
                            }
                        }
                        break;
                    }
                case XmlNodeType.Text:
                    {
                        DataRow dataRow = PDFHelper.dtXml_Info.NewRow();
                        dataRow["PATH"] = strNode_Path.TrimEnd(new char[]
                        {
                    '/'
                        });
                        dataRow["NAME"] = "text";
                        dataRow["VALUE"] = node.Value;
                        dataRow["PRE_ID"] = ((strPre_Id == "") ? "" : (strPre_Id + "00000000").Substring(0, 8));
                        dataRow["CHI_ID"] = strNode_Id;
                        PDFHelper.dtXml_Info.Rows.Add(dataRow);
                        break;
                    }
            }
        }
        private static void addReportImageList(Document doc, PdfWriter writer, string strReport_Id, string strNode_Path, DataSet ds, string strImagePath)
        {
            System.Collections.Generic.Dictionary<string, string> settingInfo = PDFHelper.getSettingInfo(strNode_Path);
            if (!settingInfo.ContainsKey("source"))
            {
                throw new System.Exception("未設定資料來源");
            }
            if (!settingInfo.ContainsKey("img-url"))
            {
                throw new System.Exception("未設定文件路径");
            }
            string text = settingInfo["source"];
            if (text == "")
            {
                throw new System.Exception("資料來源不可為空白");
            }
            DataTable dataTable = ds.Tables[text];
            DataRow[] array;
            if (strReport_Id == "")
            {
                array = dataTable.Select();
            }
            else
            {
                array = dataTable.Select("REPORT_ID = '" + strReport_Id + "'");
            }
            string text2 = strImagePath;
            if (!settingInfo.ContainsKey("img-folder"))
            {
                text2 += settingInfo["img-folder"];
            }
            DataRow[] array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                DataRow dataRow = array2[i];
                if (!System.IO.File.Exists(text2 + dataRow[settingInfo["img-url"]].ToString()))
                {
                    throw new System.Exception("找不到圖片檔案 - " + text2 + dataRow[settingInfo["img-url"]]);
                }
                Image instance = Image.GetInstance(text2 + dataRow[settingInfo["img-url"]].ToString());
                if (settingInfo.ContainsKey("size"))
                {
                    instance.ScalePercent(float.Parse(settingInfo["size"].TrimEnd(new char[]
                    {
                        '%'
                    })));
                }
                else
                {
                    float num = settingInfo.ContainsKey("max-weidh") ? (float.Parse(settingInfo["max-weidh"].TrimEnd(new char[]
                    {
                        '%'
                    })) / float.Parse(PDFHelper.dobInch.ToString()) * (float)PDFHelper.intPoint) : instance.Width;
                    float num2 = settingInfo.ContainsKey("max-height") ? (float.Parse(settingInfo["max-height"].TrimEnd(new char[]
                    {
                        '%'
                    })) / float.Parse(PDFHelper.dobInch.ToString()) * (float)PDFHelper.intPoint) : instance.Height;
                    float num3 = (num >= instance.Width) ? 1f : (num / instance.Width);
                    if (instance.Height * num3 > num2)
                    {
                        num3 *= num2 / (instance.Height * num3);
                    }
                    float percent = num3 * 100f;
                    instance.ScalePercent(percent);
                }
                if (settingInfo.ContainsKey("position"))
                {
                    string text3 = settingInfo["position"];
                    if (text3 != null)
                    {
                        if (text3 == "absolute")
                        {
                            if (!settingInfo.ContainsKey("x"))
                            {
                                throw new System.Exception("未設定圖片水平位置");
                            }
                            float margin = float.Parse(settingInfo["x"]);
                            if (!settingInfo.ContainsKey("y"))
                            {
                                throw new System.Exception("未設定圖片垂直位置");
                            }
                            float margin2 = float.Parse(settingInfo["y"]) + instance.Height * (settingInfo.ContainsKey("size") ? (float.Parse(settingInfo["size"].TrimEnd(new char[]
                            {
                                '%'
                            })) / 100f) : 1f);
                            instance.SetAbsolutePosition(doc.PageSize.GetLeft(margin), doc.PageSize.GetTop(margin2));
                            writer.DirectContent.AddImage(instance);
                        }
                    }
                }
                else
                {
                    instance.Alignment = (settingInfo.ContainsKey("align") ? PDFHelper.getAlignment(settingInfo["align"]) : 1);
                    doc.Add(instance);
                }
            }
        }
        private static string addRepeatAera(Document docPdf, PdfWriter writerPdf, string strReport_Id, string strPath, string strReport_Source, DataSet ds, string strImagePath, string strStartElement, string strRepeatColumn)
        {
            System.Collections.Generic.Dictionary<string, string> settingInfo = PDFHelper.getSettingInfo(strPath);
            if (!settingInfo.ContainsKey("source"))
            {
                throw new System.Exception("未设定重复展现资料来源");
            }
            if (!settingInfo.ContainsKey("RepeatId"))
            {
                throw new System.Exception("未设定重复依据栏位RepeatId");
            }
            strRepeatColumn = settingInfo["RepeatId"];
            if (strRepeatColumn == "")
            {
                throw new System.Exception("重复依据栏位不可以为空白");
            }
            string text = settingInfo["source"];
            if (text == "")
            {
                throw new System.Exception("资料来源不可为空");
            }
            DataTable dataTable = ds.Tables[text];
            DataRow[] array = dataTable.Select((strReport_Id == "") ? "" : ("REPORT_ID = '" + strReport_Id + "'"));
            DataRow[] array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                DataRow dataRow = array2[i];
                PDFHelper.saveFile(docPdf, writerPdf, strReport_Id, dataRow[strRepeatColumn].ToString(), strReport_Source, ds, strImagePath, strStartElement + "/repeat", strRepeatColumn);
            }
            return strRepeatColumn;
        }
        private static System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> getPageSetting()
        {
            System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> dictionary = new System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>>();
            bool flag = false;
            dictionary.Add("page", new System.Collections.Generic.Dictionary<string, string>
            {

                {
                    "size",
                    "A4"
                },

                {
                    "orientation",
                    "Portrait"
                }
            });
            System.Collections.Generic.Dictionary<string, string> dictionary2 = new System.Collections.Generic.Dictionary<string, string>();
            dictionary2.Add("top", (2.0 / PDFHelper.dobInch * (double)PDFHelper.intPoint).ToString());
            dictionary2.Add("bottom", (2.0 / PDFHelper.dobInch * (double)PDFHelper.intPoint).ToString());
            dictionary2.Add("left", (1.5 / PDFHelper.dobInch * (double)PDFHelper.intPoint).ToString());
            dictionary2.Add("right", (1.5 / PDFHelper.dobInch * (double)PDFHelper.intPoint).ToString());
            dictionary2.Add("header", (1.5 / PDFHelper.dobInch * (double)PDFHelper.intPoint).ToString());
            dictionary2.Add("footer", (1.5 / PDFHelper.dobInch * (double)PDFHelper.intPoint).ToString());
            dictionary.Add("margin", dictionary2);
            DataRow[] array = PDFHelper.dtXml_Info.Select("PATH = 'margin' AND NAME = 'all'");
            if (array.Length > 0)
            {
                flag = true;
                double num = System.Convert.ToDouble(array[0]["VALUE"]) / PDFHelper.dobInch * (double)PDFHelper.intPoint;
                dictionary2["top"] = num.ToString();
                dictionary2["bottom"] = num.ToString();
                dictionary2["left"] = num.ToString();
                dictionary2["right"] = num.ToString();
            }
            array = PDFHelper.dtXml_Info.Select("PATH = 'margin'AND " + (flag ? "NAME IN ('header', 'footer')" : "NAME <> 'all' AND NAME <> 'element'"));
            DataRow[] array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                DataRow dataRow = array2[i];
                double num = System.Convert.ToDouble(dataRow["VALUE"]) / PDFHelper.dobInch * (double)PDFHelper.intPoint;
                dictionary2[dataRow["NAME"].ToString()] = num.ToString();
            }
            array = PDFHelper.dtXml_Info.Select("(PATH = 'page' OR PATH LIKE 'header%' OR PATH LIKE 'footer%') AND NAME <> 'element'");
            array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                DataRow dataRow = array2[i];
                System.Collections.Generic.Dictionary<string, string> dictionary3 = dictionary.ContainsKey(dataRow["PATH"].ToString()) ? dictionary[dataRow["PATH"].ToString()] : new System.Collections.Generic.Dictionary<string, string>();
                dictionary3[dataRow["NAME"].ToString()] = dataRow["VALUE"].ToString();
                dictionary[dataRow["PATH"].ToString()] = dictionary3;
            }
            return dictionary;
        }
        private static System.Collections.Generic.Dictionary<string, string> getSettingInfo(string strPath)
        {
            System.Collections.Generic.Dictionary<string, string> dictionary = new System.Collections.Generic.Dictionary<string, string>();
            DataRow[] array = PDFHelper.dtXml_Info.Select(string.Format("PATH = '{0}' AND NAME <> 'element'", strPath));
            DataRow[] array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                DataRow dataRow = array2[i];
                dictionary[dataRow["NAME"].ToString()] = dataRow["VALUE"].ToString();
            }
            return dictionary;
        }
        private static System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> getColumnInfo(string strPath, string strSub_Path, string strPre_Id, string strChi_Id)
        {
            System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> dictionary = new System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>>();
            int arg_26_0 = (strPath.Split(new char[]
            {
                '/'
            }).Length == 2) ? 4 : 2;
            int length = (strPath.Split(new char[]
            {
                '/'
            }).Length == 2) ? 2 : 4;
            string filterExpression = string.Format("NAME <> 'element' AND PATH LIKE '{0}%' AND ((PRE_ID = '{1}' AND CHI_ID = '{2}') OR PRE_ID LIKE '{3}%')", new object[]
            {
                strPath,
                strPre_Id,
                strChi_Id,
                strPre_Id.Substring(0, length) + strChi_Id
            });
            DataRow[] array = PDFHelper.dtXml_Info.Select(filterExpression, "PRE_ID, CHI_ID");
            DataRow[] array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                DataRow dataRow = array2[i];
                string key = dataRow["PATH"].ToString() + ((dataRow["PATH"].ToString() == strPath + strSub_Path) ? ("_" + dataRow["CHI_ID"].ToString().TrimStart(new char[]
                {
                    '0'
                })) : "");
                System.Collections.Generic.Dictionary<string, string> dictionary2 = dictionary.ContainsKey(key) ? dictionary[key] : new System.Collections.Generic.Dictionary<string, string>();
                dictionary2[dataRow["NAME"].ToString()] = dataRow["VALUE"].ToString();
                dictionary[key] = dictionary2;
            }
            string arg = (strPre_Id.TrimEnd(new char[]
            {
                '0'
            }) + strChi_Id + "00000000").Substring(0, 8);
            string value = PDFHelper.dtXml_Info.Compute("MIN(CHI_ID)", string.Format("PATH = '{0}' AND NAME <> 'element' AND PRE_ID = '{1}'", strPath + strSub_Path, arg)).ToString();
            string value2 = PDFHelper.dtXml_Info.Compute("MAX(CHI_ID)", string.Format("PATH = '{0}' AND NAME <> 'element' AND PRE_ID = '{1}'", strPath + strSub_Path, arg)).ToString();
            System.Collections.Generic.Dictionary<string, string> dictionary3 = dictionary.ContainsKey(strPath) ? dictionary[strPath] : new System.Collections.Generic.Dictionary<string, string>();
            dictionary3["column-min"] = value;
            dictionary3["column-max"] = value2;
            dictionary[strPath] = dictionary3;
            return dictionary;
        }
        private static System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> getRowInfo(string strPath, string strPre_Id, string strChi_Id)
        {
            System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> dictionary = new System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>>();
            int num = (strPath.Split(new char[]
            {
                '/'
            }).Length == 2) ? 4 : 2;
            int length = (strPath.Split(new char[]
            {
                '/'
            }).Length == 2) ? 2 : 4;
            string text = strPre_Id.Substring(0, length) + strChi_Id;
            string filterExpression = string.Format("NAME <> 'element' AND PATH LIKE '{0}%' AND ((PRE_ID = '{1}' AND CHI_ID = '{2}') \r\n                OR PRE_ID LIKE '{3}%')", new object[]
            {
                strPath,
                strPre_Id,
                strChi_Id,
                text
            });
            DataRow[] array = PDFHelper.dtXml_Info.Select(filterExpression, "PRE_ID, CHI_ID");
            DataRow[] array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                DataRow dataRow = array2[i];
                string key = dataRow["PATH"].ToString() + ((dataRow["PATH"].ToString() == strPath + "/row/column") ? ("_" + ((dataRow["NAME"].ToString() == "width") ? "" : dataRow["PRE_ID"].ToString().Substring(dataRow["PRE_ID"].ToString().Length - num, 2)) + dataRow["CHI_ID"].ToString()) : "");
                System.Collections.Generic.Dictionary<string, string> dictionary2 = dictionary.ContainsKey(key) ? dictionary[key] : new System.Collections.Generic.Dictionary<string, string>();
                dictionary2[dataRow["NAME"].ToString()] = dataRow["VALUE"].ToString();
                dictionary[key] = dictionary2;
            }
            string text2 = PDFHelper.dtXml_Info.Compute("MAX(PRE_ID)", string.Format("PATH = '{0}/row/column' AND NAME <> 'element' AND PRE_ID LIKE '{1}%'", strPath, text)).ToString();
            string value = text2.Substring(text2.Length - num, 2);
            string value2 = PDFHelper.dtXml_Info.Compute("MAX(CHI_ID)", string.Format("PATH = '{0}/row/column' AND NAME <> 'element' AND PRE_ID LIKE '{1}%'", strPath, text)).ToString();
            System.Collections.Generic.Dictionary<string, string> dictionary3 = dictionary.ContainsKey(strPath) ? dictionary[strPath] : new System.Collections.Generic.Dictionary<string, string>();
            dictionary3["row-count"] = value;
            dictionary3["column-count"] = value2;
            dictionary[strPath] = dictionary3;
            string str = text2.Substring(0, text2.Length - num);
            for (int j = 1; j <= System.Convert.ToInt32(value); j++)
            {
                string text3 = (str + ((j <= 9) ? "0" : "") + j.ToString() + "00000000").Substring(0, 8);
                value2 = PDFHelper.dtXml_Info.Compute("MAX(CHI_ID)", string.Concat(new string[]
                {
                    "PATH = '",
                    strPath,
                    "/row/column' AND PRE_ID = '",
                    text3,
                    "' AND NAME <> 'element'"
                })).ToString();
                System.Collections.Generic.Dictionary<string, string> dictionary4 = dictionary.ContainsKey(strPath + "/row_" + j.ToString()) ? dictionary[strPath + "/row_" + j.ToString()] : new System.Collections.Generic.Dictionary<string, string>();
                dictionary4["column-count"] = value2;
                dictionary[strPath + "/row_" + j.ToString()] = dictionary4;
            }
            return dictionary;
        }
        private static void addReportTitle(Document doc, string strReport_Id, string strRepeatColumn, string strRepeatId, string strNode_Path, string strReport_Source, DataSet ds)
        {
            System.Collections.Generic.Dictionary<string, string> settingInfo = PDFHelper.getSettingInfo(strNode_Path);
            if (settingInfo.ContainsKey("text"))
            {
                float size = settingInfo.ContainsKey("font-size") ? float.Parse(settingInfo["font-size"]) : 16f;
                Font font = new Font(PDFHelper.fontFamily, size, settingInfo.ContainsKey("font-style") ? Font.GetStyleValue(settingInfo["font-style"]) : 1);
                string text = settingInfo["text"];
                if (strReport_Source != "")
                {
                    text = PDFHelper.replaceReportData(ds.Tables[strReport_Source], strRepeatColumn, strReport_Id, strRepeatId, text);
                }
                doc.Add(new Paragraph(text, font)
                {
                    Alignment = settingInfo.ContainsKey("align") ? PDFHelper.getAlignment(settingInfo["align"]) : 1
                });
            }
        }
        private static void addReportPhase(Document doc, string strReport_Id, string strRepeatColumn, string strRepeat_Id, string strNode_Path, string strReport_Source, DataSet ds)
        {
            System.Collections.Generic.Dictionary<string, string> settingInfo = PDFHelper.getSettingInfo(strNode_Path);
            if (settingInfo.ContainsKey("text"))
            {
                float size = settingInfo.ContainsKey("font-size") ? float.Parse(settingInfo["font-size"]) : 10f;
                Font font = new Font(PDFHelper.fontFamily, size, settingInfo.ContainsKey("font-style") ? Font.GetStyleValue(settingInfo["font-style"]) : 0);
                Regex regex = new Regex("\\n\\s+");
                string text = regex.Replace(settingInfo["text"].Trim(new char[]
                {
                    '\r',
                    '\n'
                }).Trim(), "");
                if (strReport_Source != "")
                {
                    text = PDFHelper.replaceReportData(ds.Tables[strReport_Source], strReport_Id, strRepeatColumn, strRepeat_Id, text);
                }
                Paragraph paragraph = new Paragraph(text, font);
                if (settingInfo.ContainsKey("align"))
                {
                    paragraph.Alignment = PDFHelper.getAlignment(settingInfo["align"]);
                }
                doc.Add(paragraph);
            }
        }
        private static void addReportImage(Document doc, PdfWriter writer, string strNode_Path, string strImagePath)
        {
            System.Collections.Generic.Dictionary<string, string> settingInfo = PDFHelper.getSettingInfo(strNode_Path);
            if (!settingInfo.ContainsKey("url"))
            {
                throw new System.Exception("未設定圖片路徑");
            }
            if (!System.IO.File.Exists(strImagePath + settingInfo["url"]))
            {
                throw new System.Exception("找不到圖片檔案 - " + strImagePath + settingInfo["url"]);
            }
            Image instance = Image.GetInstance(strImagePath + settingInfo["url"]);
            instance.ScalePercent(settingInfo.ContainsKey("size") ? float.Parse(settingInfo["size"].TrimEnd(new char[]
            {
                '%'
            })) : 100f);
            if (settingInfo.ContainsKey("position"))
            {
                string text = settingInfo["position"];
                if (text != null)
                {
                    if (text == "absolute")
                    {
                        if (!settingInfo.ContainsKey("x"))
                        {
                            throw new System.Exception("未設定圖片水平位置");
                        }
                        float margin = float.Parse(settingInfo["x"]);
                        if (!settingInfo.ContainsKey("y"))
                        {
                            throw new System.Exception("未設定圖片垂直位置");
                        }
                        float margin2 = float.Parse(settingInfo["y"]) + instance.Height * (settingInfo.ContainsKey("size") ? (float.Parse(settingInfo["size"].TrimEnd(new char[]
                        {
                            '%'
                        })) / 100f) : 1f);
                        instance.SetAbsolutePosition(doc.PageSize.GetLeft(margin), doc.PageSize.GetTop(margin2));
                        writer.DirectContent.AddImage(instance);
                    }
                }
            }
            else
            {
                instance.Alignment = (settingInfo.ContainsKey("align") ? PDFHelper.getAlignment(settingInfo["align"]) : 1);
                doc.Add(instance);
            }
        }
        private static Image replacBarCode(string strType, string strBarCodeContent, PdfWriter writerPdf)
        {
            PdfContentByte directContent = writerPdf.DirectContent;
            Image result = null;
            if (strType != null)
            {
                if (!(strType == "barcode128"))
                {
                    if (strType == "barcodeqrcode")
                    {
                        strBarCodeContent = System.Text.Encoding.GetEncoding("utf-8").GetString(System.Text.Encoding.GetEncoding("utf-8").GetBytes(strBarCodeContent));
                        BarcodeQRCode barcodeQRCode = new BarcodeQRCode(strBarCodeContent, 1, 1, null);
                        result = Image.GetInstance(barcodeQRCode.GetImage());
                    }
                }
                else
                {
                    result = new Barcode128
                    {
                        Code = strBarCodeContent
                    }.CreateImageWithBarcode(directContent, null, null);
                }
            }
            return result;
        }
        private static int getAlignment(string strAlign)
        {
            if (strAlign != null)
            {
                System.Collections.Generic.Dictionary<string, int> dic = new System.Collections.Generic.Dictionary<string, int>(6)
                    {

                        {
                            "left",
                            0
                        },

                        {
                            "center",
                            1
                        },

                        {
                            "right",
                            2
                        },

                        {
                            "top",
                            3
                        },

                        {
                            "middle",
                            4
                        },

                        {
                            "bottom",
                            5
                        }
                    };
                int num;
                if (dic.TryGetValue(strAlign, out num))
                {
                    int result;
                    switch (num)
                    {
                        case 0:
                            result = 0;
                            break;
                        case 1:
                            result = 1;
                            break;
                        case 2:
                            result = 2;
                            break;
                        case 3:
                            result = 4;
                            break;
                        case 4:
                            result = 5;
                            break;
                        case 5:
                            result = 6;
                            break;
                        default:
                            goto IL_B0;
                    }
                    return result;
                }
            }
            IL_B0:
            throw new System.Exception("找不到對應位置");
        }
        private static BaseColor getBasicColor(string strColor)
        {
            string text = strColor.ToUpper();
            BaseColor result;
            switch (text)
            {
                case "RED":
                    result = BaseColor.RED;
                    return result;
                case "BLUE":
                    result = BaseColor.BLUE;
                    return result;
                case "WHITE":
                    result = BaseColor.WHITE;
                    return result;
                case "YELLOW":
                    result = BaseColor.YELLOW;
                    return result;
                case "LIGHT_GRAY":
                    result = BaseColor.LIGHT_GRAY;
                    return result;
                case "GREEN":
                    result = BaseColor.GREEN;
                    return result;
                case "ORANGE":
                    result = BaseColor.ORANGE;
                    return result;
                case "MAGENTA":
                    result = BaseColor.MAGENTA;
                    return result;
            }
            result = BaseColor.BLACK;
            return result;
        }
        private static string replaceReportData(DataTable dt, string strReport_Id, string strRepeatColumn, string strRepeatId, string strText)
        {
            if (dt == null)
            {
                throw new System.Exception("資料來源不存在");
            }
            while (strText.IndexOf("#[") != -1)
            {
                int num = strText.IndexOf("#[");
                int num2 = strText.IndexOf("]#");
                string text = strText.Substring(num + 2, num2 - num - 2);
                string text2 = (strReport_Id == "") ? "" : ("REPORT_ID = '" + strReport_Id + "'");
                string text3 = (strRepeatColumn == "") ? "" : (strRepeatColumn + " = '" + strRepeatId + "'");
                text2 += ((text2 == "") ? text3 : ((text3 == "") ? "" : (" AND " + text3)));
                DataRow[] array = dt.Select(text2);
                //xiang.yan 2024-06-27 如果替换值没有找到，这里会超出索引报错
                if (array.Length > 0)
                {
                    strText = strText.Replace("#[" + text + "]#", array[0][text].ToString());
                }
                else
                {
                    strText = strText.Replace("#[" + text + "]#", "");
                }
            }
            return strText;
        }
        private static string replaceReportData(DataRow dr, string str)
        {
            while (str.IndexOf("#[") != -1)
            {
                int num = str.IndexOf("#[");
                int num2 = str.IndexOf("]#");
                string text = str.Substring(num + 2, num2 - num - 2);
                str = str.Replace("#[" + text + "]#", dr[text].ToString());
            }
            return str;
        }
        private static string replaceReportColumns(string str)
        {
            while (str.IndexOf("#[") != -1)
            {
                int num = str.IndexOf("#[");
                int num2 = str.IndexOf("]#");
                str = str.Substring(num + 2, num2 - num - 2);
            }
            return str;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="language">语言选择 例：PDFHelper.Language.Simplified</param>
        /// <param name="strXml_Path">xml格式模块路径</param>
        /// <param name="ds">数据源，DataSet对象可含多个table</param>
        /// <param name="strTarget_Path">输出路径 例：D:\</param>
        /// <param name="strImagePath"></param>
        /// <param name="strFileName"></param>
        /// <returns></returns>
        public static string ExportData(PDFHelper.Language language, string strXml_Path, DataSet ds, string strTarget_Path, string strImagePath = "", string strFileName = null)
        {
            PDFHelper.fontFamily = PDFFont.getFontInfo(language);
            return PDFHelper.createFile(strXml_Path, ds, strTarget_Path, strImagePath, strFileName);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="strFont_Family">语言选择 例：PDFHelper.Language.Simplified</param>
        /// <param name="strXml_Path">xml格式模块路径</param>
        /// <param name="ds">数据源，DataSet对象可含多个table</param>
        /// <param name="strTarget_Path">输出路径 例：D:\</param>
        /// <param name="strImagePath"></param>
        /// <param name="strFileName"></param>
        /// <returns></returns>
		public static string ExportData(string strFont_Family, string strXml_Path, DataSet ds, string strTarget_Path, string strImagePath = "", string strFileName = null)
        {
            PDFHelper.fontFamily = PDFFont.getFontInfo(strFont_Family);
            return PDFHelper.createFile(strXml_Path, ds, strTarget_Path, strImagePath, strFileName);
        }
        public static byte[] getPDFByte(PDFHelper.Language language, string strXml_Path, DataSet ds, string strImagePath = "")
        {
            PDFHelper.fontFamily = PDFFont.getFontInfo(language);
            return PDFHelper.ExportPDFByte(strXml_Path, ds, strImagePath);
        }
        public static byte[] getPDFByte(string strFont_Family, string strXml_Path, DataSet ds, string strImagePath = "")
        {
            PDFHelper.fontFamily = PDFFont.getFontInfo(strFont_Family);
            return PDFHelper.ExportPDFByte(strXml_Path, ds, strImagePath);
        }
        public static void AddObject(string strSource_Path, string strTarget_Path, string strTarget_File, DataTable dtConfig_Info)
        {
            PdfReader pdfReader = new PdfReader(System.IO.File.ReadAllBytes(strSource_Path));
            PdfStamper pdfStamper = new PdfStamper(pdfReader, new System.IO.FileStream(strTarget_Path + strTarget_File, System.IO.FileMode.Create, System.IO.FileAccess.Write));
            foreach (DataRow dataRow in dtConfig_Info.Rows)
            {
                string strRange_Type = dtConfig_Info.Columns.Contains("RANGE_TYPE") ? dataRow["RANGE_TYPE"].ToString() : "AllPage";
                string text = dataRow["OBJECT_TYPE"].ToString();
                if (text != null)
                {
                    if (!(text == "Image"))
                    {
                        if (text == "Text")
                        {
                            BaseColor bc = dtConfig_Info.Columns.Contains("COLOR") ? PDFHelper.getBasicColor(dataRow["COLOR"].ToString()) : BaseColor.BLACK;
                            PDFHelper.Language language = dtConfig_Info.Columns.Contains("LANGUAGE") ? ((PDFHelper.Language)System.Enum.Parse(typeof(PDFHelper.Language), dataRow["LANGUAGE"].ToString())) : PDFHelper.Language.Traditional;
                            BaseFont fontInfo = PDFFont.getFontInfo(language);
                            PDFHelper.AddText(pdfReader, pdfStamper, strRange_Type, dataRow["TEXT"].ToString(), fontInfo, bc, float.Parse(dataRow["FONT_SIZE"].ToString()), float.Parse(dataRow["POSITION_X"].ToString()), float.Parse(dataRow["POSITION_Y"].ToString()));
                        }
                    }
                    else
                    {
                        PDFHelper.AddImage(pdfReader, pdfStamper, dataRow["IMAGE_PATH"].ToString(), strRange_Type, float.Parse(dataRow["POSITION_X"].ToString()), float.Parse(dataRow["POSITION_Y"].ToString()));
                    }
                }
            }
            pdfStamper.Close();
        }
        private static void addReportData(Document doc, string strReport_Id, string strRepeatColumn, string strRepeatId, string strNode_Path, string strPre_Id, string strChi_Id, DataSet ds)
        {
            PdfPTable reportData = PDFHelper.getReportData(doc, strReport_Id, strRepeatColumn, strRepeatId, strNode_Path, strPre_Id, strChi_Id, ds);
            doc.Add(reportData);
            PDFHelper.pdfEvent.TotalUseHeigth += reportData.TotalHeight;
        }
        private static void addReportTable(Document doc, string strReport_Id, string strRepeatColumn, string strRepeat_Id, PdfWriter writerPdf, string strNode_Path, string strReport_Source, string strPre_Id, string strChi_Id, DataSet ds, string strImagePath)
        {
            PdfPTable table = PDFHelper.getTable(doc, strReport_Id, strRepeatColumn, strRepeat_Id, writerPdf, strNode_Path, strReport_Source, strPre_Id, strChi_Id, ds, strImagePath);
            doc.Add(table);
            PDFHelper.pdfEvent.TotalUseHeigth += table.TotalHeight;
        }
        private static PdfPTable getReportData(Document doc, string strReport_Id, string strRepeatColumn, string strRepeatId, string strNode_Path, string strPre_Id, string strChi_Id, DataSet ds)
        {
            System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> columnInfo = PDFHelper.getColumnInfo(strNode_Path, "/column", strPre_Id, strChi_Id);
            if (!columnInfo[strNode_Path].ContainsKey("source"))
            {
                throw new System.Exception("未設定資料來源");
            }
            string text = columnInfo[strNode_Path]["source"];
            if (text == "")
            {
                throw new System.Exception("資料來源不可為空白");
            }
            DataTable dataTable = ds.Tables[text];
            int num = System.Convert.ToInt32(columnInfo[strNode_Path]["column-min"]);
            int num2 = System.Convert.ToInt32(columnInfo[strNode_Path]["column-max"]);
            int num3 = num2 - num + 1;
            if (columnInfo[strNode_Path].ContainsKey("columns"))
            {
                num3 = System.Convert.ToInt32(columnInfo[strNode_Path]["columns"]);
            }
            PdfPTable pdfPTable = new PdfPTable(num3);
            float[] array = new float[num3];
            for (int i = 0; i <= num3 - 1; i++)
            {
                System.Collections.Generic.Dictionary<string, string> dictionary = columnInfo[strNode_Path + "/column_" + (i + num).ToString()];
                if (!dictionary.ContainsKey("width"))
                {
                    throw new System.Exception("未設定欄位寬度");
                }
                array[i] = float.Parse(dictionary["width"].TrimEnd(new char[]
                {
                    '%'
                }));
            }
            pdfPTable.SetWidthPercentage(array, doc.PageSize);
            pdfPTable.SpacingBefore = (float)(columnInfo[strNode_Path].ContainsKey("spacing-before") ? System.Convert.ToInt32(columnInfo[strNode_Path]["spacing-before"]) : 15);
            if (columnInfo[strNode_Path].ContainsKey("spacing-after"))
            {
                pdfPTable.SpacingAfter = (float)System.Convert.ToInt32(columnInfo[strNode_Path]["spacing-after"]);
            }
            pdfPTable.WidthPercentage = (float)(columnInfo[strNode_Path].ContainsKey("size") ? System.Convert.ToInt32(columnInfo[strNode_Path]["size"].TrimEnd(new char[]
            {
                '%'
            })) : 100);
            bool flag = false;
            System.Collections.Generic.List<string> list = new System.Collections.Generic.List<string>();
            for (int i = num; i <= num2; i++)
            {
                System.Collections.Generic.Dictionary<string, string> dictionary = columnInfo[strNode_Path + "/column_" + i.ToString()];
                if (dictionary.ContainsKey("header"))
                {
                    flag = PDFHelper.addTableTitle(strNode_Path, columnInfo, pdfPTable, flag, dictionary);
                }
                if (dictionary.ContainsKey("atuo_rowspan") && dictionary["atuo_rowspan"] == "1")
                {
                    string text2 = PDFHelper.replaceReportColumns(dictionary["text"]);
                    if (text2 != null)
                    {
                        list.Add(text2);
                        dataTable.Columns.Add(text2 + "_autoSpan");
                    }
                }
            }
            if (list.Count > 0)
            {
                string[] array2 = new string[list.Count];
                int[] array3 = new int[list.Count];
                int num4 = 0;
                int num5 = dataTable.Rows.Count - 1;
                foreach (DataRow dataRow in dataTable.Rows)
                {
                    dataRow.BeginEdit();
                    for (int j = 0; j < list.Count; j++)
                    {
                        if (array2[j] != dataRow[list[j]].ToString() && num4 != 0 && num4 < num5)
                        {
                            dataTable.Rows[num4 - array3[j]][list[j] + "_autoSpan"] = array3[j];
                            array3[j] = 1;
                        }
                        else
                        {
                            if (num4 == num5)
                            {
                                dataRow[list[j] + "_autoSpan"] = ((array2[j] != dataRow[list[j]].ToString()) ? 1 : -100);
                                dataTable.Rows[num4 - array3[j]][list[j] + "_autoSpan"] = ((array2[j] != dataRow[list[j]].ToString()) ? array3[j] : (array3[j] + 1));
                                array3[j] = 1;
                            }
                            else
                            {
                                dataRow[list[j] + "_autoSpan"] = -100;
                                array3[j]++;
                            }
                        }
                        array2[j] = dataRow[list[j]].ToString();
                    }
                    dataRow.EndEdit();
                    num4++;
                }
            }
            if (flag && dataTable.Rows.Count > 0)
            {
                pdfPTable.HeaderRows = 1;
            }
            DataRow[] thisDoc = PDFHelper.getThisDoc(strReport_Id, strRepeatColumn, strRepeatId, dataTable);
            int num6 = 1;
            DataRow[] array4 = thisDoc;
            for (int k = 0; k < array4.Length; k++)
            {
                DataRow dataRow2 = array4[k];
                for (int i = num; i <= num2; i++)
                {
                    System.Collections.Generic.Dictionary<string, string> dictionary = columnInfo[strNode_Path + "/column_" + i.ToString()];
                    string str = "";
                    if (dictionary.ContainsKey("text"))
                    {
                        str = dictionary["text"];
                        str = PDFHelper.replaceReportData(dataRow2, str);
                    }
                    else
                    {
                        if (dictionary.ContainsKey("rownum") && dictionary["rownum"] == "1")
                        {
                            str = num6.ToString();
                            num6++;
                        }
                    }
                    float size = dictionary.ContainsKey("font-size") ? float.Parse(dictionary["font-size"]) : 10f;
                    int style = dictionary.ContainsKey("font-style") ? Font.GetStyleValue(dictionary["font-style"]) : 0;
                    Font font = new Font(PDFHelper.fontFamily, size, style);
                    Phrase phrase = new Phrase(str, font);
                    PdfPCell pdfPCell = new PdfPCell(phrase);
                    pdfPCell.MinimumHeight = (float)(columnInfo[strNode_Path].ContainsKey("cell-height") ? System.Convert.ToInt32(columnInfo[strNode_Path]["cell-height"]) : 20);
                    pdfPCell.HorizontalAlignment = (dictionary.ContainsKey("align") ? PDFHelper.getAlignment(dictionary["align"]) : 0);
                    pdfPCell.VerticalAlignment = (dictionary.ContainsKey("valign") ? PDFHelper.getAlignment(dictionary["valign"]) : 5);
                    if (dictionary.ContainsKey("background-color"))
                    {
                        pdfPCell.BackgroundColor = PDFHelper.getBasicColor(dictionary["background-color"]);
                    }
                    if (dictionary.ContainsKey("atuo_rowspan") && dictionary["atuo_rowspan"] == "1")
                    {
                        string text3 = dataRow2[PDFHelper.replaceReportColumns(dictionary["text"]) + "_autoSpan"].ToString();
                        if (text3 != "-100")
                        {
                            pdfPCell.Rowspan = ((text3 == "") ? 1 : System.Convert.ToInt32(text3));
                            pdfPTable.AddCell(pdfPCell);
                        }
                    }
                    else
                    {
                        if (dictionary.ContainsKey("barcode-content"))
                        {
                            if (dt2.Rows.Count <= 0)
                            {
                                dt2 = dataTable.Copy();
                            }
                            if (dt2.Rows.Count > 1 && index > 0)
                            {
                                dt2.Rows.RemoveAt(0);//总数移除第一行的数据 added by zhi.li 20190125
                            }
                            index += 1;
                            string strType = dictionary.ContainsKey("barcode-type") ? dictionary["barcode-type"] : "";
                            string text4 = dictionary.ContainsKey("barcode-content") ? dictionary["barcode-content"] : "";
                            text4 = PDFHelper.replaceReportData(dt2, strReport_Id, strRepeatColumn, strRepeatId, text4);
                            Image image = PDFHelper.replacBarCode(strType, text4, writerPdf2);
                            float newHeight = dictionary.ContainsKey("barcode-height") ? float.Parse(dictionary["barcode-height"]) : 1f;
                            float newWidth = dictionary.ContainsKey("barcode-width") ? float.Parse(dictionary["barcode-width"]) : 1f;
                            image.ScaleAbsoluteHeight(newHeight);
                            image.ScaleAbsoluteWidth(newWidth);
                            PdfPCell pdfPCell2;
                            pdfPCell2 = new PdfPCell(image);
                            pdfPTable.AddCell(pdfPCell2);
                            if (dt2.Rows.Count == 1)
                            {
                                index = 0;
                                dt2.Rows.RemoveAt(0);
                            }
                        }
                        else
                        {
                            pdfPTable.AddCell(pdfPCell);
                        }

                    }
                }
            }
            return pdfPTable;
        }
        private static DataRow[] getThisDoc(string strReport_Id, string strRepeatColumn, string strRepeatId, DataTable dtData_Source)
        {
            string text = (strReport_Id == "") ? "" : ("REPORT_ID = '" + strReport_Id + "'");
            string text2 = (strRepeatColumn == "") ? "" : (strRepeatColumn + " = '" + strRepeatId + "'");
            text += ((text == "") ? text2 : ((text2 == "") ? "" : (" AND " + text2)));
            return dtData_Source.Select(text);
        }
        public static PdfPTable getTable(Document doc, string strReport_Id, string strRepeatColumn, string strRepeat_Id, PdfWriter writerPdf, string strNode_Path, string strReport_Source, string strPre_Id, string strChi_Id, DataSet ds, string strImagePath)
        {
            System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> rowInfo = PDFHelper.getRowInfo(strNode_Path, strPre_Id, strChi_Id);
            int num = System.Convert.ToInt32(rowInfo[strNode_Path]["row-count"]);
            int num2 = System.Convert.ToInt32(rowInfo[strNode_Path]["column-count"]);
            if (rowInfo[strNode_Path].ContainsKey("columns"))
            {
                num2 = System.Convert.ToInt32(rowInfo[strNode_Path]["columns"]);
            }
            PdfPTable pdfPTable = new PdfPTable(num2);
            float[] array = new float[num2];
            for (int i = 1; i <= num2; i++)
            {
                if (!rowInfo.ContainsKey(strNode_Path + "/row/column_" + ("00" + i).Substring(("00" + i).Length - 2, 2)))
                {
                    array[i - 1] = (float)(100 / num2);
                }
                else
                {
                    System.Collections.Generic.Dictionary<string, string> dictionary = rowInfo[strNode_Path + "/row/column_" + ("00" + i).Substring(("00" + i).Length - 2, 2)];
                    if (!dictionary.ContainsKey("width"))
                    {
                        array[i - 1] = (float)(100 / num2);
                    }
                    else
                    {
                        array[i - 1] = float.Parse(dictionary["width"].TrimEnd(new char[]
                        {
                            '%'
                        }));
                    }
                }
            }
            pdfPTable.SetWidthPercentage(array, doc.PageSize);
            pdfPTable.SpacingBefore = (float)(rowInfo[strNode_Path].ContainsKey("spacing-before") ? System.Convert.ToInt32(rowInfo[strNode_Path]["spacing-before"]) : 15);
            if (rowInfo[strNode_Path].ContainsKey("spacing-after"))
            {
                pdfPTable.SpacingAfter = (float)System.Convert.ToInt32(rowInfo[strNode_Path]["spacing-after"]);
            }
            pdfPTable.WidthPercentage = (float)(rowInfo[strNode_Path].ContainsKey("size") ? System.Convert.ToInt32(rowInfo[strNode_Path]["size"].TrimEnd(new char[]
            {
                '%'
            })) : 100);
            for (int i = 1; i <= num; i++)
            {
                int num3 = System.Convert.ToInt32(rowInfo[strNode_Path + "/row_" + i.ToString()]["column-count"]);
                for (int j = 1; j <= num3; j++)
                {
                    string text = "00" + i;
                    string text2 = "00" + j;
                    string key = strNode_Path + "/row/column_" + text.Substring(text.Length - 2, 2) + text2.Substring(text2.Length - 2, 2);
                    if (rowInfo.ContainsKey(key))
                    {
                        System.Collections.Generic.Dictionary<string, string> dictionary = rowInfo[key];
                        string name = rowInfo[strNode_Path].ContainsKey("source") ? rowInfo[strNode_Path]["source"] : strReport_Source;
                        if (ds == null)
                        {
                            throw new System.Exception("找不到表格資料來源");
                        }
                        if (ds.Tables[name] == null)
                        {
                            throw new System.Exception("找不到表格資料來源");
                        }
                        PdfPCell pdfPCell;
                        if (dictionary.ContainsKey("text"))
                        {
                            string text3 = dictionary["text"];
                            text3 = PDFHelper.replaceReportData(ds.Tables[name], strReport_Id, strRepeatColumn, strRepeat_Id, text3);
                            float size = dictionary.ContainsKey("font-size") ? float.Parse(dictionary["font-size"]) : (rowInfo[strNode_Path].ContainsKey("font-size") ? float.Parse(rowInfo[strNode_Path]["font-size"]) : 10f);
                            int style = dictionary.ContainsKey("font-style") ? Font.GetStyleValue(dictionary["font-style"]) : 0;
                            Font font = new Font(PDFHelper.fontFamily, size, style);
                            Phrase phrase = new Phrase(text3, font);
                            pdfPCell = new PdfPCell(phrase);
                            if (dictionary.ContainsKey("line-height"))
                            {
                                pdfPCell.SetLeading((float)System.Convert.ToInt32(dictionary["line-height"]), 0f);
                            }
                        }
                        else
                        {
                            if (dictionary.ContainsKey("image-url"))
                            {
                                Image image = Image.GetInstance(strImagePath + dictionary["image-url"].ToString());
                                if (dictionary.ContainsKey("image-size"))
                                {
                                    image.ScalePercent(float.Parse(dictionary["image-size"].TrimEnd(new char[]
                                    {
                                        '%'
                                    })));
                                }
                                pdfPCell = new PdfPCell(image);
                            }
                            else
                            {
                                if (dictionary.ContainsKey("barcode-content"))
                                {
                                    string strType = dictionary.ContainsKey("barcode-type") ? dictionary["barcode-type"] : "";
                                    string text4 = dictionary.ContainsKey("barcode-content") ? dictionary["barcode-content"] : "";
                                    text4 = PDFHelper.replaceReportData(ds.Tables[name], strReport_Id, strRepeatColumn, strRepeat_Id, text4);
                                    Image image = PDFHelper.replacBarCode(strType, text4, writerPdf);
                                    float newHeight = dictionary.ContainsKey("barcode-height") ? float.Parse(dictionary["barcode-height"]) : 1f;
                                    float newWidth = dictionary.ContainsKey("barcode-width") ? float.Parse(dictionary["barcode-width"]) : 1f;
                                    image.ScaleAbsoluteHeight(newHeight);
                                    image.ScaleAbsoluteWidth(newWidth);
                                    pdfPCell = new PdfPCell(image);
                                }
                                else
                                {
                                    pdfPCell = new PdfPCell();
                                }
                            }
                        }
                        bool flag = dictionary.ContainsKey("border-width") || dictionary.ContainsKey("left-border-width") || dictionary.ContainsKey("right-border-width") || dictionary.ContainsKey("top-border-width") || dictionary.ContainsKey("bottom-border-width");
                        if (dictionary.ContainsKey("border-width"))
                        {
                            pdfPCell.Border = System.Convert.ToInt32(dictionary["border-width"]);
                        }
                        else
                        {
                            if (dictionary.ContainsKey("top-border-width"))
                            {
                                pdfPCell.BorderWidthTop = (float)System.Convert.ToInt32(dictionary["top-border-width"]);
                            }
                            if (dictionary.ContainsKey("bottom-border-width"))
                            {
                                pdfPCell.BorderWidthBottom = (float)System.Convert.ToInt32(dictionary["bottom-border-width"]);
                            }
                            if (dictionary.ContainsKey("left-border-width"))
                            {
                                pdfPCell.BorderWidthLeft = (float)System.Convert.ToInt32(dictionary["left-border-width"]);
                            }
                            if (dictionary.ContainsKey("right-border-width"))
                            {
                                pdfPCell.BorderWidthRight = (float)System.Convert.ToInt32(dictionary["right-border-width"]);
                            }
                        }
                        if (!flag && rowInfo[strNode_Path].ContainsKey("border-width"))
                        {
                            pdfPCell.Border = System.Convert.ToInt32(rowInfo[strNode_Path]["border-width"]);
                        }
                        if (dictionary.ContainsKey("colspan"))
                        {
                            pdfPCell.Colspan = System.Convert.ToInt32(dictionary["colspan"]);
                        }
                        if (dictionary.ContainsKey("rowspan"))
                        {
                            pdfPCell.Rowspan = System.Convert.ToInt32(dictionary["rowspan"]);
                        }
                        pdfPCell.MinimumHeight = (dictionary.ContainsKey("height") ? float.Parse(dictionary["height"]) : 20f);
                        pdfPCell.HorizontalAlignment = (dictionary.ContainsKey("align") ? PDFHelper.getAlignment(dictionary["align"]) : 0);
                        pdfPCell.VerticalAlignment = (dictionary.ContainsKey("valign") ? PDFHelper.getAlignment(dictionary["valign"]) : 5);
                        if (dictionary.ContainsKey("background-color"))
                        {
                            pdfPCell.BackgroundColor = PDFHelper.getBasicColor(dictionary["background-color"]);
                        }
                        pdfPTable.AddCell(pdfPCell);
                    }
                    else
                    {
                        Phrase phrase = new Phrase("", new Font(PDFHelper.fontFamily, 10f));
                        PdfPCell pdfPCell = new PdfPCell(phrase);
                        if (rowInfo[strNode_Path].ContainsKey("border-width"))
                        {
                            pdfPCell.Border = System.Convert.ToInt32(rowInfo[strNode_Path]["border-width"]);
                        }
                        if (rowInfo.ContainsKey("background-color"))
                        {
                            pdfPCell.BackgroundColor = PDFHelper.getBasicColor(rowInfo[strNode_Path]["background-color"]);
                        }
                        pdfPTable.AddCell(pdfPCell);
                    }
                }
            }
            return pdfPTable;
        }
        private static bool addTableTitle(string strNode_Path, System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> dicColumns, PdfPTable tabContent, bool boolHeader, System.Collections.Generic.Dictionary<string, string> dicAttr)
        {
            boolHeader = true;
            Font font;
            if (dicColumns.ContainsKey(strNode_Path + "/header-style"))
            {
                float size = dicColumns[strNode_Path + "/header-style"].ContainsKey("font-size") ? float.Parse(dicColumns[strNode_Path + "/header-style"]["font-size"]) : 10f;
                int style = dicColumns[strNode_Path + "/header-style"].ContainsKey("font-style") ? Font.GetStyleValue(dicColumns[strNode_Path + "/header-style"]["font-style"]) : 1;
                font = new Font(PDFHelper.fontFamily, size, style);
            }
            else
            {
                font = new Font(PDFHelper.fontFamily, 10f, 1);
            }
            Phrase phrase = new Phrase(dicAttr["header"], font);
            PdfPCell pdfPCell = new PdfPCell(phrase);
            if (dicColumns.ContainsKey(strNode_Path + "/header-style"))
            {
                pdfPCell.MinimumHeight = (dicColumns[strNode_Path + "/header-style"].ContainsKey("height") ? float.Parse(dicColumns[strNode_Path + "/header-style"]["height"]) : 20f);
                if (dicColumns[strNode_Path + "/header-style"].ContainsKey("background-color"))
                {
                    pdfPCell.BackgroundColor = PDFHelper.getBasicColor(dicColumns[strNode_Path + "/header-style"]["background-color"]);
                }
            }
            else
            {
                pdfPCell.MinimumHeight = 20f;
            }
            pdfPCell.HorizontalAlignment = 1;
            pdfPCell.VerticalAlignment = 5;
            tabContent.AddCell(pdfPCell);
            return boolHeader;
        }
        private static string createFile(string strXml_Path, DataSet ds, string strTarget_Path, string strImagePath, string strFileName)
        {
            string strFile_Name = (strFileName != null) ? strFileName : string.Format("{0:yyyyMMddHHmmssfff}.pdf", System.DateTime.Now);
            return PDFHelper.createActFile(strXml_Path, ds, strTarget_Path, strFile_Name, strImagePath);
        }
        private static string createActFile(string strXml_Path, DataSet ds, string strTarget_Path, string strFile_Name, string strImagePath)
        {
            if (!System.IO.Directory.Exists(strTarget_Path))
            {
                System.IO.Directory.CreateDirectory(strTarget_Path);
            }
            PDFHelper.analyzeXmlFile(strXml_Path);
            System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> pageSetting = PDFHelper.getPageSetting();
            Rectangle pageSize = (pageSetting["page"]["orientation"] == "Landscape") ? PageSize.GetRectangle(pageSetting["page"]["size"]).Rotate() : PageSize.GetRectangle(pageSetting["page"]["size"]);
            Document document = new Document(pageSize, float.Parse(pageSetting["margin"]["left"]), float.Parse(pageSetting["margin"]["right"]), float.Parse(pageSetting["margin"]["top"]), float.Parse(pageSetting["margin"]["bottom"]));
            PdfWriter instance = PdfWriter.GetInstance(document, new System.IO.FileStream(strTarget_Path + strFile_Name, System.IO.FileMode.Create));
            try
            {
                PDFHelper.writePdf(ds, strFile_Name, strImagePath, pageSetting, document, instance);
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                document.Close();
            }
            return strFile_Name;
        }
        private static byte[] ExportPDFByte(string strXml_Path, DataSet ds, string strImagePath)
        {
            PDFHelper.analyzeXmlFile(strXml_Path);
            System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> pageSetting = PDFHelper.getPageSetting();
            Rectangle pageSize = null;
            //处理纸张大小
            if (pageSetting["page"]["size"] == "Custom")
            {
                //自定义大小
                float width = Convert.ToSingle(pageSetting["page"]["width"]);
                float height = Convert.ToSingle(pageSetting["page"]["height"]);
                pageSize = new Rectangle(0, 0, width, height);
            }
            else
            {
                //纸张类型
                pageSize =  PageSize.GetRectangle(pageSetting["page"]["size"]);
            }
            //处理横向
            if (pageSetting["page"]["orientation"] == "Landscape")
            {
                pageSize = pageSize.Rotate();
            }
            Document document = new Document(pageSize, float.Parse(pageSetting["margin"]["left"]), float.Parse(pageSetting["margin"]["right"]), float.Parse(pageSetting["margin"]["top"]), float.Parse(pageSetting["margin"]["bottom"]));
            System.IO.MemoryStream memoryStream = new System.IO.MemoryStream();
            PdfWriter instance = PdfWriter.GetInstance(document, memoryStream);
            byte[] result;
            try
            {
                PDFHelper.writePdf(ds, "", strImagePath, pageSetting, document, instance);
                document.Close();
                byte[] array = memoryStream.ToArray();
                result = array;
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                document.Close();
            }
            return result;
        }
        private static void writePdf(DataSet ds, string strFile_Name, string strImagePath, System.Collections.Generic.Dictionary<string, System.Collections.Generic.Dictionary<string, string>> dicPage, Document docPdf, PdfWriter writerPdf)
        {
            string text = "";
            DataRow[] array = PDFHelper.dtXml_Info.Select("PATH = 'report' AND NAME = 'source'");
            if (array.Length > 0)
            {
                text = array[0]["VALUE"].ToString();
            }
            docPdf.Open();
            PDFHelper.pdfEvent = new PDFEvent(dicPage, strFile_Name, PDFHelper.fontFamily, text, ds, strImagePath);
            PDFEvent.tempFooter_Page = writerPdf.DirectContent.CreateTemplate(100f, 100f);
            writerPdf.PageEvent = PDFHelper.pdfEvent;
            DataTable dataTable = ds.Tables[text];
            if (!dataTable.Columns.Contains("REPORT_ID"))
            {
                PDFHelper.saveFile(docPdf, writerPdf, "", "", text, ds, strImagePath, "report", "");
            }
            else
            {
                for (int i = 0; i <= dataTable.Rows.Count - 1; i++)
                {
                    DataRow dataRow = dataTable.Rows[i];
                    if (i != 0)
                    {
                        docPdf.NewPage();
                    }
                    PDFHelper.saveFile(docPdf, writerPdf, dataRow["REPORT_ID"].ToString(), "", text, ds, strImagePath, "report", "");
                }
            }
        }
        private static void saveFile(Document docPdf, PdfWriter writerPdf, string strReport_Id, string strRepeat_Id, string strReport_Source, DataSet ds, string strImagePath, string strStartElement = "report", string strRepeatColumn = "")
        {
            string[] array = new string[]
            {
                "title",
                "image",
                "phase",
                "table",
                "data",
                "flow",
                "barcode",
                "barcodeqrcode",
                "imageList",
                "repeat"
            };
            System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
            int num = strStartElement.Split(new char[]
            {
                '/'
            }).Length;
            string[] array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                string text = array2[i];
                stringBuilder.Append(string.Concat(new string[]
                {
                    "'",
                    strStartElement,
                    "/",
                    text,
                    "', "
                }));
            }
            DataRow[] array3 = PDFHelper.dtXml_Info.Select("PATH IN (" + stringBuilder + ") AND NAME = 'element'", "CHI_ID");
            DataRow[] array4 = array3;
            for (int i = 0; i < array4.Length; i++)
            {
                DataRow dataRow = array4[i];
                string strType = dataRow["PATH"].ToString().Split(new char[]
                {
                    '/'
                })[num];
                PDFHelper.addContent(docPdf, writerPdf, strReport_Id, strRepeat_Id, strReport_Source, ds, strImagePath, strStartElement, strRepeatColumn, dataRow, strType);
            }
        }
        public static void setHeader(Document docPdf, PdfWriter writerPdf, string strReport_Id, string strReport_Source, DataSet ds, string strImagePath, string strGetType = "header")
        {
            string[] array = new string[]
            {
                "title",
                "image",
                "phase",
                "data",
                "table",
                "barcode",
                "barcodeqrcode"
            };
            System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
            string[] array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                string text = array2[i];
                stringBuilder.Append(string.Concat(new string[]
                {
                    "'report/",
                    strGetType,
                    "/",
                    text,
                    "', "
                }));
            }
            DataRow[] array3 = PDFHelper.dtXml_Info.Select("PATH IN (" + stringBuilder + ") AND NAME = 'element'", "CHI_ID");
            DataRow[] array4 = array3;
            for (int i = 0; i < array4.Length; i++)
            {
                DataRow dataRow = array4[i];
                string strType = dataRow["PATH"].ToString().Split(new char[]
                {
                    '/'
                })[2];
                PDFHelper.addContent(docPdf, writerPdf, strReport_Id, "", strReport_Source, ds, strImagePath, "", "", dataRow, strType);
            }
        }
        private static void addContent(Document docPdf, PdfWriter writerPdf, string strReport_Id, string strRepeat_Id, string strReport_Source, DataSet ds, string strImagePath, string strStartElement, string strRepeatColumn, DataRow dr, string strType)
        {
            writerPdf2 = writerPdf;//added by zhi.li 20190125

            switch (strType)
            {
                case "title":
                    PDFHelper.addReportTitle(docPdf, strReport_Id, strRepeatColumn, strRepeat_Id, dr["PATH"].ToString(), strReport_Source, ds);
                    break;
                case "image":
                    PDFHelper.addReportImage(docPdf, writerPdf, dr["PATH"].ToString(), strImagePath);
                    break;
                case "phase":
                    PDFHelper.addReportPhase(docPdf, strReport_Id, strRepeatColumn, strRepeat_Id, dr["PATH"].ToString(), strReport_Source, ds);
                    break;
                case "data":
                    PDFHelper.addReportData(docPdf, strReport_Id, strRepeatColumn, strRepeat_Id, dr["PATH"].ToString(), dr["PRE_ID"].ToString(), dr["CHI_ID"].ToString(), ds);
                    break;
                case "table":
                    PDFHelper.addReportTable(docPdf, strReport_Id, strRepeatColumn, strRepeat_Id, writerPdf, dr["PATH"].ToString(), strReport_Source, dr["PRE_ID"].ToString(), dr["CHI_ID"].ToString(), ds, strImagePath);
                    break;
                case "flow":
                    PDFHelper.addReportFlow(docPdf, strReport_Id, dr["PATH"].ToString(), ds);
                    break;
                case "imageList":
                    PDFHelper.addReportImageList(docPdf, writerPdf, strReport_Id, dr["PATH"].ToString(), ds, strImagePath);
                    break;
                case "repeat":
                    strRepeatColumn = PDFHelper.addRepeatAera(docPdf, writerPdf, strReport_Id, dr["PATH"].ToString(), strReport_Source, ds, strImagePath, strStartElement, strRepeatColumn);
                    break;
            }
        }
        public static void setFooter(Document docPdf, PdfWriter writerPdf, string strReport_Id, string strReport_Source, DataSet ds, string strImagePath, float floatLeft, float fHeigth, float floatRigth)
        {
            float num = 0f;
            DataRow[] array = PDFHelper.dtXml_Info.Select("PATH IN ('report/footer/data', 'report/footer/table') AND NAME = 'element'", "CHI_ID");
            float height = docPdf.PageSize.Height;
            DataRow[] array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                DataRow dataRow = array2[i];
                string text = dataRow["PATH"].ToString().Split(new char[]
                {
                    '/'
                })[2];
                string text2 = text;
                if (text2 != null)
                {
                    if (!(text2 == "data"))
                    {
                        if (text2 == "table")
                        {
                            PdfPTable pdfPTable = PDFHelper.getTable(docPdf, strReport_Id, "", "", writerPdf, dataRow["PATH"].ToString(), strReport_Source, dataRow["PRE_ID"].ToString(), dataRow["CHI_ID"].ToString(), ds, strImagePath);
                            pdfPTable.TotalWidth = docPdf.PageSize.Width - floatLeft - floatRigth;
                            pdfPTable.WriteSelectedRows(0, -1, floatLeft, docPdf.PageSize.GetBottom(fHeigth - num), writerPdf.DirectContent);
                            num += pdfPTable.TotalHeight;
                        }
                    }
                    else
                    {
                        PdfPTable pdfPTable = PDFHelper.getReportData(docPdf, strReport_Id, "", "", dataRow["PATH"].ToString(), dataRow["PRE_ID"].ToString(), dataRow["CHI_ID"].ToString(), ds);
                        pdfPTable.TotalWidth = docPdf.PageSize.Width - floatLeft - floatRigth;
                        pdfPTable.WriteSelectedRows(0, -1, floatLeft, docPdf.PageSize.GetBottom(fHeigth - num), writerPdf.DirectContent);
                        num += pdfPTable.TotalHeight;
                    }
                }
            }
        }
        private static void addReportFlow(Document doc, string strReport_Id, string strNode_Path, DataSet ds)
        {
            System.Collections.Generic.Dictionary<string, string> settingInfo = PDFHelper.getSettingInfo(strNode_Path);
            if (!settingInfo.ContainsKey("source"))
            {
                throw new System.Exception("未設定資料來源");
            }
            if (!settingInfo.ContainsKey("row-count"))
            {
                throw new System.Exception("未設定每列欄數");
            }
            if (!settingInfo.ContainsKey("flow-name"))
            {
                throw new System.Exception("未設定站別名稱");
            }
            if (!settingInfo.ContainsKey("flow-esign"))
            {
                throw new System.Exception("未設定站別圖章");
            }
            string text = settingInfo["source"];
            if (text == "")
            {
                throw new System.Exception("資料來源不可為空白");
            }
            DataTable dataTable = ds.Tables[text];
            int num = System.Convert.ToInt32(settingInfo["row-count"]);
            if (settingInfo.ContainsKey("columns"))
            {
                num = System.Convert.ToInt32(settingInfo["columns"]);
            }
            PdfPTable pdfPTable = new PdfPTable(num);
            pdfPTable.SpacingBefore = 15f;
            pdfPTable.WidthPercentage = 100f;
            DataRow[] array;
            if (strReport_Id == "")
            {
                array = dataTable.Select();
            }
            else
            {
                array = dataTable.Select("REPORT_ID = '" + strReport_Id + "'");
            }
            DataRow[] array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                DataRow dataRow = array2[i];
                Phrase phrase = new Phrase(dataRow[settingInfo["flow-name"]].ToString(), new Font(PDFHelper.fontFamily, 10f));
                pdfPTable.AddCell(new PdfPCell(phrase)
                {
                    MinimumHeight = 10f,
                    HorizontalAlignment = 1,
                    VerticalAlignment = 5
                });
            }
            if (array.Length < System.Convert.ToInt32(settingInfo["row-count"]))
            {
                for (int j = 1; j <= System.Convert.ToInt32(settingInfo["row-count"]) - array.Length; j++)
                {
                    pdfPTable.AddCell(new PdfPCell
                    {
                        MinimumHeight = 10f
                    });
                }
            }
            array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                DataRow dataRow = array2[i];
                PdfPCell pdfPCell;
                if (dataRow[settingInfo["flow-esign"]].ToString() != "")
                {
                    Image instance = Image.GetInstance(dataRow[settingInfo["flow-esign"]].ToString());
                    instance.ScalePercent(90f);
                    pdfPCell = new PdfPCell(instance);
                }
                else
                {
                    pdfPCell = new PdfPCell();
                }
                pdfPCell.MinimumHeight = 30f;
                pdfPCell.HorizontalAlignment = 1;
                pdfPCell.VerticalAlignment = 5;
                pdfPTable.AddCell(pdfPCell);
            }
            if (array.Length < System.Convert.ToInt32(settingInfo["row-count"]))
            {
                for (int j = 1; j <= System.Convert.ToInt32(settingInfo["row-count"]) - array.Length; j++)
                {
                    pdfPTable.AddCell(new PdfPCell
                    {
                        MinimumHeight = 10f
                    });
                }
            }
            if (settingInfo.ContainsKey("flow-date"))
            {
                array2 = array;
                for (int i = 0; i < array2.Length; i++)
                {
                    DataRow dataRow = array2[i];
                    Phrase phrase = new Phrase(dataRow[settingInfo["flow-date"]].ToString(), new Font(PDFHelper.fontFamily, 10f));
                    pdfPTable.AddCell(new PdfPCell(phrase)
                    {
                        MinimumHeight = 10f,
                        HorizontalAlignment = 1,
                        VerticalAlignment = 5
                    });
                }
            }
            if (array.Length < System.Convert.ToInt32(settingInfo["row-count"]))
            {
                for (int j = 1; j <= System.Convert.ToInt32(settingInfo["row-count"]) - array.Length; j++)
                {
                    pdfPTable.AddCell(new PdfPCell
                    {
                        MinimumHeight = 10f
                    });
                }
            }
            doc.Add(pdfPTable);
        }
        private static void AddImage(PdfReader pdfSource, PdfStamper pdfTarget, string strImage_Path, string strRange_Type, float floatX, float floatY)
        {
            Image instance = Image.GetInstance(strImage_Path);
            instance.SetAbsolutePosition(floatX, floatY);
            for (int i = 1; i <= pdfSource.NumberOfPages; i++)
            {
                if (!(strRange_Type == "NotFirst") || i != 1)
                {
                    PdfContentByte overContent = pdfTarget.GetOverContent(i);
                    overContent.AddImage(instance);
                    if (strRange_Type == "OnlyFirst" && i == 1)
                    {
                        break;
                    }
                }
            }
            PDFHelper.pdfEvent.TotalUseHeigth += instance.Height;
        }
        private static void AddText(PdfReader pdfSource, PdfStamper pdfTarget, string strRange_Type, string strText, BaseFont bf, BaseColor bc, float floatSize, float floatX, float floatY)
        {
            for (int i = 1; i <= pdfSource.NumberOfPages; i++)
            {
                if (!(strRange_Type == "NotFirst") || i != 1)
                {
                    PdfContentByte overContent = pdfTarget.GetOverContent(i);
                    overContent.SetColorFill(bc);
                    overContent.SetFontAndSize(bf, floatSize);
                    overContent.BeginText();
                    overContent.ShowTextAligned(1, strText, floatX, floatY, 0f);
                    overContent.EndText();
                    if (strRange_Type == "OnlyFirst" && i == 1)
                    {
                        break;
                    }
                }
            }
        }
    }
}