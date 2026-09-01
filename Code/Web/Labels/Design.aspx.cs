
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using System.Text;
using System.Linq;
using SKT.LeanMES.Labels.Pdf;
using DataMatrix.net;

namespace SKT.LeanMES.Web.Labels
{
    public partial class Design : BasePage
    {
        public PrintTemplateInfo Model { get; set; }
        public List<FontInfo> FontFamilys = new PdfDesign().GetFontFamilysList();

        private List<LabelFieldInfo> _fields;
        public List<LabelFieldInfo> Fields
        {
            get
            {
                return _fields ?? (_fields = new LabelField().GetAll(0, 100000, "", new Common.Model.SearchSettings()));
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params.HasKeys())
            {
                if (Request.Params["action"] != null)
                {
                    string action = Request.Params["action"];
                    if (action == "writecode")
                        WriteCode();
                    else if (action == "preview")//预览的action改成preview，因为create这个关键字在post传递过程中会被当初sql注入拦截
                        CreatePdf();
                    else if (action == "writepdf")
                        WritePdf();
                    else if (action == "save")
                        Save();
                    else if (action == "getprinter")
                        GetPrinter();
                    else if (action == "setdata")
                    {
                        Guid guid = Guid.NewGuid();
                        new PrintTemplate().AddPrintData(guid, Convert.ToInt32(Request.Params["LabelId"]), Request.Params["Data"]);
                        Response.Write("{\"success\":true,\"data\":\"" + guid + "," + Session.SessionID + "\"}");
                        Response.End();
                    }
                    else if (action == "getBluetoothPrintImgs")
                    {
                        GetBluetoothPrintImgs();
                    }
                }
                else
                {
                    GetModel(Convert.ToInt32(Request.Params["TempId"]));
                }
            }
        }
        /// <summary>
        /// 获取蓝牙打印图片
        /// </summary>
        /// <param name="context"></param>
        public void GetBluetoothPrintImgs()
        {
            PdfPrintContent content = null;
            try
            {
                string data = Request.Params["Data"];
                content = new Handler.PrintDataBusiness().GetPdfPrintContent(Convert.ToInt32(Request.Params["LabelId"]), data);
                int count = Convert.ToInt32(Request.Params["Count"]);
                if (count < 1)
                    count = 1;
                string name = Guid.NewGuid().ToString();
                if (!Directory.Exists(Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PDFPrint/")))
                    Directory.CreateDirectory(Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PDFPrint/"));
                content.List.Sort((a, b) => a.zIndex.CompareTo(b.zIndex));
                content.List.AsParallel().ForAll(item =>
                {
                    if (item.type == "img" && item.url.IndexOf("http") != 0)
                        item.url = Request.Url.Scheme + "://" + Request.Url.Authority + item.url;
                });
                content.PdfUrl = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PDFPrint/" + name + ".pdf");
                new PdfDesign().CreatePdf(content);
                if (!File.Exists(content.PdfUrl))
                {
                    Response.Write("{\"success\":false,\"msg\":\"生成pdf失败\"}");
                }
                else
                {
                    int width = Convert.ToInt32(content.Width * 0.3527);
                    int height = Convert.ToInt32(content.Height * 0.3527);
                    List<string> imgs = new List<string>();
                    using (PdfiumViewer.PdfDocument doc = PdfiumViewer.PdfDocument.Load(content.PdfUrl))
                    {
                        for (int i = 0; i < doc.PageCount; i++)
                        {
                            using (System.Drawing.Image img = doc.Render(i, width * 8, height * 8, Convert.ToSingle(25.4 * 8), Convert.ToSingle(25.4 * 8), true))
                            {
                                img.Save(Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PDFPrint/" + name + i + ".png"), ImageFormat.Png);
                                imgs.Add(name + i + ".png");
                            }
                        }
                    }
                    Response.Write("{\"success\":true,\"data\":\"" + string.Join(",", imgs) + "\",\"width\":" + width + ",\"height\":" + height + "}");
                }
            }
            catch (Exception ex)
            {
                Response.Write("{\"success\":false,\"msg\":\"生成pdf异常:" + ex.Message + "\"}");
            }
            finally
            {
                try
                {
                    if (content != null && !string.IsNullOrWhiteSpace(content.PdfUrl) && File.Exists(content.PdfUrl))
                        File.Delete(content.PdfUrl);
                }
                catch
                {

                }
            }
            Response.End();

        }
        private void GetModel(int tempId)
        {
            Model = new PrintTemplate().GetEnityByTempId(tempId);
            if (Model == null)
            {
                Model = new PrintTemplateInfo();
                Model.TempId = tempId;
                Model.PanelWidth = Convert.ToSingle(90.0 / 0.3527);
                Model.PanelHeight = Convert.ToSingle(60.0 / 0.3527);
                Model.TempName = "";
                Model.TempSet = "[]";
            }
        }

        private void GetPrinter()
        {
            try
            {
                Response.ContentType = "text/plain";
                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new
                {
                    success = true,
                    data = new Printer().GetUserPrinter(AccountController.GetCurrentUser().UserId)
                }));
            }
            catch (Exception ex)
            {
                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new
                {
                    success = false,
                    msg = ex.Message
                }));
            }
            finally
            {
                Response.End();
            }
        }
        private void Save()
        {
            try
            {
                Response.ContentType = "text/plain";
                PrintTemplateInfo temp = new PrintTemplateInfo();
                temp.TempId = Convert.ToInt32(Request.Params["id"]);
                temp.TempName = Request.Params["name"];
                temp.CreateBy = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                temp.ModifyBy = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                temp.PanelWidth = Convert.ToSingle(Request.Params["width"]);
                temp.PanelHeight = Convert.ToSingle(Request.Params["height"]);
                temp.TempSet = Request.Params["set"];
                temp.ModifyDateTime = DateTime.Now;
                temp.CreateDateTime = DateTime.Now;
                List<int> ids = new List<int>();
                List<PrintTemplateDtl> templist = Newtonsoft.Json.JsonConvert.DeserializeObject<List<PrintTemplateDtl>>(temp.TempSet);
                templist.ForEach(item =>
                {
                    if (!string.IsNullOrWhiteSpace(item.key))
                    {
                        ids.Add(Convert.ToInt32(item.key));
                    }
                });
                //删除目录中不存在模板里面的图片
                List<string> list = new List<string>();
                string imgpath = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PdfImg/" + temp.TempId);
                if (!Directory.Exists(imgpath))
                {
                    Directory.CreateDirectory(imgpath);
                }
                string[] datas = Directory.GetFiles(imgpath);
                foreach (var url in datas)
                {
                    if (templist.Exists(item => item.type == "img" && !string.IsNullOrWhiteSpace(item.url) && item.url.Contains(new FileInfo(url).Name)))
                        continue;
                    File.Delete(url);
                }
                string str = string.Join(",", ids.Distinct().ToArray());
                new PrintTemplate().Edit(temp, str);
                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new
                {
                    success = true,
                    data = templist
                }));
            }
            catch (Exception ex)
            {
                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new
                {
                    success = false,
                    msg = ex.Message
                }));
            }
            finally
            {
                Response.End();
            }
        }

        /// <summary>
        /// 输出PDF
        /// </summary>
        private void WritePdf()
        {
            try
            {
                string name = Request.Params["name"];
                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PDFPrint/" + name + ".pdf");
                if (!string.IsNullOrWhiteSpace(path) && File.Exists(path))
                {
                    FileStream fileStream = new FileStream(path, FileMode.Open);
                    long fileSize = fileStream.Length;
                    byte[] fileBuffer = new byte[fileSize];
                    fileStream.Read(fileBuffer, 0, (int)fileSize);
                    fileStream.Close();
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(fileBuffer);
                    File.Delete(path);
                }
            }
            catch (Exception)
            {

            }
            finally
            {
                Response.End();
            }
        }
        /// <summary>
        /// 输出条形码或二维码图片
        /// </summary>
        private void WriteCode()
        {
            System.Drawing.Image img;
            PrintTemplateDtl dtl = Newtonsoft.Json.JsonConvert.DeserializeObject<PrintTemplateDtl>(Request.Params["json"]);
            if (dtl.type == "barcode")
            {
                img = new PdfDesign().GetBarCode(dtl);
            }
            else if (dtl.type == "qrcode")
            {
                img = new PdfDesign().GetQRCode(dtl);
            }
            else
            {
                img = new PdfDesign().GetDataMatrix(dtl);
            }
            if (img != null)
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    img.Save(ms, ImageFormat.Png);
                    Response.Clear();
                    Response.ContentType = "text/html;charset=utf-8";
                    Response.Write(Convert.ToBase64String(ms.ToArray()));
                    Response.End();
                }
            }
            else
            {
                Response.ContentType = "text/html;charset=utf-8";
                Response.Write("");
                Response.End();
            }
        }

        private PrintTemplateInfo RequestTemplate()
        {
            try
            {
                PrintTemplateInfo info;
                if (Request.Params["TempId"] != null)
                {
                    info = new PrintTemplate().GetEnityByTempId(Convert.ToInt32(Request.Params["TempId"]));
                }
                else
                {
                    info = new PrintTemplateInfo
                    {
                        PanelHeight = Convert.ToSingle(Request.Params["height"]),
                        PanelWidth = Convert.ToSingle(Request.Params["width"]),
                        TempSet = Request.Params["temp"]
                    };
                }
                return info;
            }
            catch (Exception)
            {
                return null;
            }
        }
        /// <summary>
        /// 创建pdf
        /// </summary>
        private void CreatePdf()
        {
            Response.ContentType = "text/plain";
            //文件名
            string name = Guid.NewGuid().ToString();
            try
            {
                if (!Directory.Exists(Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PDFPrint")))
                {
                    Directory.CreateDirectory(Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PDFPrint"));
                }
                //模板设计
                PrintTemplateInfo info = RequestTemplate();
                if (info == null)
                {
                    throw new Exception("模板为空");
                }
                List<PrintTemplateDtl> templist = Newtonsoft.Json.JsonConvert.DeserializeObject<List<PrintTemplateDtl>>(info.TempSet);
                templist.Sort((a, b) => a.zIndex.CompareTo(b.zIndex));
                templist.AsParallel().ForAll(item =>
                {
                    if (item.type == "img" && item.url.IndexOf("http") != 0)
                        item.url = Request.Url.Scheme + "://" + Request.Url.Authority + item.url;
                });
                //数据，如果没有数据，则为预览
                List<PrintDataInfo> datas = new List<PrintDataInfo>();
                if (Request.Params["data"] == null)
                {
                    datas.Add(new PrintDataInfo());
                }
                else
                {
                    datas = Newtonsoft.Json.JsonConvert.DeserializeObject<List<PrintDataInfo>>(Request.Params["data"]);
                }
                if (datas == null || datas.Count == 0)
                {
                    throw new Exception("没有数据");
                }
                //将key替换掉，存储的是id，替换成名字
                if (info.TempId > 0)
                {
                    Dictionary<int, string> dic = new LabelField().LabelSet(info.TempId);
                    templist.AsParallel().ForAll(item =>
                    {
                        if (!string.IsNullOrWhiteSpace(item.key) && dic.ContainsKey(Convert.ToInt32(item.key)))
                        {
                            item.key = dic[Convert.ToInt32(item.key)];
                        }
                    });
                }
                new PdfDesign().CreatePdf(new PdfCreateContent(info.PanelWidth, info.PanelHeight, Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PDFPrint/" + name + ".pdf"), null, templist, datas));
                Response.Write("{\"success\":true,\"name\":\"" + name + "\"}");
            }
            catch (Exception ex)
            {
                Response.Write("{\"success\":false,\"msg\":\"" + ex.Message + "\"}");
            }
            Response.End();
        }
    }
}