using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;
using SKT.LeanMES.Labels.Pdf;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using SKT.LeanMES.Web.AppCode.Utility;
using Newtonsoft.Json;
using log4net;
using System.Configuration;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// PrintUpdate 的摘要说明
    /// </summary>
    public class PrintUpdate : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            SqlInjectableHelper.Validation(context);

            if (context.Request.Params.HasKeys())
            {
                context.Response.Clear();
                string action = context.Request.Params["action"];
                if (action == "GetUpdateFile")
                {
                    GetUpdateFile(context);
                }
                else if (action == "DownLoadUpdateFile")
                {
                    DownLoadUpdateFile(context);
                }
                else if (action == "UploadTemplateFile")
                {
                    UploadTemplateFile(context);
                }
                else if (action == "UploadCommandFile")
                {
                    UploadCommandFile(context);
                }
                else if (action == "IsTemplateFileExist")
                {
                    IsTemplateFileExist(context);
                }
                if (action == "GetDownLoadFile")
                {
                    GetDownLoadFile(context);
                }
                else if (action == "DownLoadFile")
                {
                    WriteFile(context);
                }
                else if (action == "GetWebSocketPort")
                {
                    GetWebSocketPort(context);
                }
                else if (action == "UploadCommand")
                {
                    UploadCommand(context);
                }
                else if (action == "UploadFile")
                {
                    UploadFile(context);
                }
                else if (action == "GetPrintData")
                {
                    GetPrintData(context);
                }
                else if (action == "GetPrintImg")
                {
                    GetPrintImg(context);
                }
                else if (action == "SaveFileModel")
                {
                    SaveFileModel(context);
                }
                else if (action == "GetFileData")
                {
                    GetAssignFileData(context);
                }
                else if (action == "SyncFile")
                {
                    SyncFile(context);
                }
                else if (action == "IsFileExist")
                {
                    IsFileExist(context);
                }
            }
            context.Response.End();
        }
        public void GetPrintImg(HttpContext context)
        {
            int rotate = Convert.ToInt32(context.Request.Params["rotate"]);
            string url = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PDFPrint/" + context.Request.Params["name"]);
            if (File.Exists(url))
            {
                byte[] byteData = null;
                if (rotate == 90)
                {
                    var img = Image.FromFile(url);
                    img.RotateFlip(RotateFlipType.Rotate90FlipNone);
                    using (MemoryStream stream = new MemoryStream())
                    {
                        img.Save(stream, ImageFormat.Png);
                        byteData = new byte[stream.Length];
                        stream.Seek(0, SeekOrigin.Begin);
                        stream.Read(byteData, 0, Convert.ToInt32(stream.Length));
                    }
                }
                else
                {
                    FileStream fs = new FileStream(url, FileMode.Open);
                    byteData = new byte[fs.Length];
                    fs.Read(byteData, 0, byteData.Length);
                    fs.Close();
                }
                context.Response.ContentType = "image/png";
                context.Response.BinaryWrite(byteData);
                File.Delete(url);
            }
        }
        /// <summary>
        /// 获取打印数据
        /// </summary>
        /// <param name="context"></param>
        public void GetPrintData(HttpContext context)
        {
            try
            {
                string[] DataId = context.Request.Params["DataId"].ToString().Split(new char[] { ',' });
                int printQty = string.IsNullOrEmpty(context.Request.Params["PrintQty"]) ? 0 : Convert.ToInt32(context.Request.Params["PrintQty"]);
                string data = new PrintTemplate().GetPrintData(new Guid(DataId[0]));
                PdfPrintContent content = new PrintDataBusiness().GetPdfPrintContent(Convert.ToInt32(context.Request.Params["TempId"]), data, printQty);
                context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(content));
            }
            catch (Exception ex)
            {
                context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new PdfPrintContent
                {
                    Type = -1,
                    Version = ex.Message
                }));
            }
        }

        public void UploadCommand(HttpContext context)
        {
            try
            {
                LabelDocumentInfo entity = new LabelDocument().GetInfo(Convert.ToInt32(context.Request.Params["id"]));
                int type = Convert.ToInt32(context.Request.Params["type"]);
                string command = context.Request.Params["command"];
                if (entity != null)
                {
                    if (type == 2)
                    {
                        entity.TemplatePath = context.Request.Params["id"] + ".zpl";
                    }
                    else
                    {
                        entity.TemplatePath = context.Request.Params["id"] + ".postek";
                    }


                    string path = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintUpdate/");
                    string url = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintUpdate/" + entity.TemplatePath);
                    if (!Directory.Exists(path))
                        Directory.CreateDirectory(path);
                    if (File.Exists(url))
                        File.Delete(url);
                    StreamWriter sw = File.AppendText(url);
                    sw.Write(command);
                    sw.Close();
                    new LabelDocument().Edit(entity);

                    //上传文件到FTP服务器上 开始----------------------------------------
                    SKT.LeanMES.ESOP.BLL.FtpServerConfig ftpBll = new LeanMES.ESOP.BLL.FtpServerConfig();
                    SKT.LeanMES.ESOP.Model.FtpServerConfigInfo ftpEntity = ftpBll.GetInfo();
                    string dir = "UploadFiles/PrintUpdate";
                    FileStream fileStream = new FileStream(url, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
                    UploadUtility.CheckCreateFolder(ftpEntity.FtpServerName, "UploadFiles", ftpEntity.UserName, ftpEntity.PWD, dir);
                    UploadUtility.UploadFile(fileStream, entity.TemplatePath,
                        dir, ftpEntity.FtpServerName, ftpEntity.UserName,
                        ftpEntity.PWD);
                    fileStream.Close();

                    //上传文件到FTP服务器上 结束----------------------------------------
                    //修改版本
                    //SyncFile(context);
                    context.Response.Write("{\"success\":true}");
                }
                else
                {
                    context.Response.Write("{\"success\":false,\"msg\":\"数据不存在\"}");
                }
            }
            catch (Exception ex)
            {
                context.Response.Write("{\"success\":false,\"msg\":\"" + ex.Message + "\"}");
            }
        }

        public void SyncFile(HttpContext context)
        {
            //修改版本
            //File.WriteAllText(context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintUpdate/version.ini"), DateTime.Now.ToString());
        }

        public void UploadFile(HttpContext context)
        {
            try
            {
                LabelDocumentInfo entity = new LabelDocument().GetInfo(Convert.ToInt32(context.Request.Params["id"]));
                if (entity != null)
                {
                    var files = context.Request.Files;
                    var fileName = context.Request.Params["fileName"];
                    if (files == null || files.Count == 0)
                        return;
                    HttpPostedFile file = files.Get(0);
                    if (file.ContentLength == 0)
                    {
                        context.Response.Write("{\"success\":false,\"msg\":\"上传文件为0字节,请重新选择上传文件\"}");
                        return;
                    }
                    entity.TemplatePath = fileName;
                    string path = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintUpdate/");
                    string url = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintUpdate/" + entity.TemplatePath);
                    if (!Directory.Exists(path))
                        Directory.CreateDirectory(path);

                    if (File.Exists(url))
                        File.Delete(url);
                    file.SaveAs(url);
                    new LabelDocument().Edit(entity);
                    //SyncFile(context);

                    context.Response.Write("{\"success\":true}");
                }
                else
                {
                    context.Response.Write("{\"success\":false,\"msg\":\"数据不存在\"}");
                }
            }
            catch (Exception ex)
            {
                context.Response.Write("{\"success\":false,\"msg\":\"" + ex.Message + "\"}");
            }
        }

        /// <summary>
        /// 设备解析上传文档
        /// </summary>
        public void SaveFileModel(HttpContext context)
        {
            try
            {
                string FileType = "";
                if (context.Request.Files.Count > 0)
                {
                    var file = context.Request.Files.Get(0);
                    FileInfo info = new FileInfo(file.FileName);
                    if (info.Extension.ToLower() == ".xls" || info.Extension.ToLower() == ".xlsx")
                    {
                        FileType = "EXCEL";
                    }
                    else if (info.Extension.ToLower() == ".csv")
                    {
                        FileType = "CSV";
                    }
                    else if (info.Extension.ToLower() == ".xml")
                    {
                        FileType = "XML";
                    }
                    else if (info.Extension.ToLower() == ".txt")
                    {
                        FileType = "TXT";
                    }
                    else
                    {
                        context.Response.Write("{\"success\":false,\"msg\":\"上传的文件类型不对,请上传xls、xlsx、csv、xml、txt类型的文件\"}");
                        return;
                    }


                    //保存数据
                    string FileName = info.Name.Replace(info.Extension, "") + "_" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + info.Extension;
                    string path = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/TestReport/");
                    string url = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/TestReport/" + FileName);
                    if (!Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }
                    if (File.Exists(url))
                    {
                        File.Delete(url);
                    }
                    file.SaveAs(url);

                    System.Collections.ArrayList FileData = GetFileData(url, FileType, context);

                    context.Response.Write("{\"success\":true,\"msg\":\"\",\"FileName\":\"" + info.Name.Replace(info.Extension, "") + "\",\"FilePath\":\"" + url.Replace("\\", "\\\\") +
                        "\",\"FileType\":\"" + FileType + "\",\"Data\":" + Newtonsoft.Json.JsonConvert.SerializeObject(FileData) + "}");
                }
            }
            catch (Exception ex)
            {
                context.Response.Write("{\"success\":false,\"msg\":\"" + ex.Message + "\"}");
            }
        }

        private System.Collections.ArrayList GetFileData(string url, string FileType, HttpContext context)
        {
            System.Collections.ArrayList FileData = new System.Collections.ArrayList();
            if ((eFileType)Enum.Parse(typeof(eFileType), FileType.ToUpper()) == eFileType.EXCEL)
            {
                FileData = SKT.LeanMES.Web.AppCode.Utility.NPOIHelper.ImportExcel(url);
            }
            else if ((eFileType)Enum.Parse(typeof(eFileType), FileType.ToUpper()) == eFileType.CSV)
            {
                FileData = SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.ImportCsv(url);
            }
            else if ((eFileType)Enum.Parse(typeof(eFileType), FileType.ToUpper()) == eFileType.XML)
            {
                FileData = SKT.LeanMES.Web.AppCode.Utility.FilesHelper.ImportXML(url);
            }
            else if ((eFileType)Enum.Parse(typeof(eFileType), FileType.ToUpper()) == eFileType.TXT)
            {
                string SplitChar = context.Request.Params["SplitChar"];
                char[] SplitChars = SplitChar.ToCharArray();
                FileData = SKT.LeanMES.Web.AppCode.Utility.FilesHelper.ImportTXT(url, SplitChars, 1);
            }
            return FileData;
        }

        private void GetAssignFileData(HttpContext context)
        {
            string FileType = "";
            string FileNewPath = context.Request.Params["fileNewPath"];
            string Extension = FileNewPath.Substring(FileNewPath.LastIndexOf('.'), FileNewPath.Length - FileNewPath.LastIndexOf('.'));
            if (Extension.ToLower() == ".xls" || Extension.ToLower() == ".xlsx")
            {
                FileType = "EXCEL";
            }
            else if (Extension.ToLower() == ".csv")
            {
                FileType = "CSV";
            }
            else if (Extension.ToLower() == ".xml")
            {
                FileType = "XML";
            }
            else if (Extension.ToLower() == ".txt")
            {
                FileType = "TXT";
            }
            else
            {
                context.Response.Write("{\"success\":false,\"msg\":\"上传的文件类型不对,请上传xls、xlsx、csv、xml、txt类型的文件\"}");
                return;
            }

            try
            {
                string filename = FileNewPath.Substring(FileNewPath.LastIndexOf('\\') + 1, FileNewPath.LastIndexOf('_') - (FileNewPath.LastIndexOf('\\') + 1));

                System.Collections.ArrayList FileData = GetFileData(FileNewPath, FileType, context);

                context.Response.Write("{\"success\":true,\"msg\":\"\",\"FileName\":\"" + filename + "\",\"FilePath\":\"" + FileNewPath.Replace("\\", "\\\\") +
                    "\",\"FileType\":\"" + FileType + "\",\"Data\":" + Newtonsoft.Json.JsonConvert.SerializeObject(FileData) + "}");
            }
            catch (Exception ex)
            {
                context.Response.Write("{\"success\":false,\"msg\":\"" + ex.Message + "\"}");
            }
        }

        public void GetWebSocketPort(HttpContext context)
        {
            int port = 9000;
            int.TryParse(System.Configuration.ConfigurationManager.AppSettings["WebSocketPort"], out port);
            context.Response.Write(port);
        }
        /// <summary>
        /// 根据版本获取要下载的文件
        /// </summary>
        /// <param name="context"></param>
        public void GetDownLoadFile(HttpContext context)
        {
            string result = "";
            try
            {
                string version = context.Request.Params["version"];
                //获取本地版本,如果文件存在，并且版本不一致
                string url = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintUpdate/version.ini");
                if (version != null && File.Exists(url) && File.ReadAllText(url) != version)
                {
                    context.Response.Write(string.Join(",", GetFiles(url.Replace("version.ini", ""))));
                }
            }
            catch (Exception)
            {

            }
            context.Response.Write(result);
        }
        private void WriteFile(HttpContext context)
        {
            try
            {
                string filePath = HttpUtility.UrlDecode(context.Request.Params["file"]);
                // 不允许 存在 ./ ../  .\ ..\ 
                if (Regex.IsMatch(filePath, @"(\.\.[/\\]|\.?[/\\])"))
                {
                    return;
                }

                string url = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintUpdate/") + HttpUtility.UrlDecode(context.Request.Params["file"]);

                // 2. 检查文件名是否是 web.config（不区分大小写）
                string normalizedFileName = Path.GetFileName(url);
                if (normalizedFileName?.Equals("web.config", StringComparison.OrdinalIgnoreCase) == true)
                {
                    return;
                }

                if (File.Exists(url))
                {
                    context.Response.ClearHeaders();
                    context.Response.ClearContent();
                    FileInfo info = new FileInfo(url);
                    FileStream fileStream = new FileStream(url, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
                    byte[] bytes = new byte[fileStream.Length];
                    fileStream.Read(bytes, 0, bytes.Length);
                    fileStream.Close();
                    context.Response.ContentType = "application/octet-stream";
                    context.Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(info.Name));
                    context.Response.OutputStream.Write(bytes, 0, bytes.Length);
                }
            }
            catch (Exception)
            {

            }
        }
        private List<string> GetFiles(string rootdir, string dir = null)
        {
            if (dir == null)
                dir = rootdir;
            List<string> list = new List<string>();
            string[] files = Directory.GetFiles(dir);
            foreach (var item in files)
            {
                list.Add(item.Replace(rootdir, ""));
            }
            string[] directs = Directory.GetDirectories(dir);
            foreach (var item in directs)
            {
                list.AddRange(GetFiles(rootdir, item));
            }
            return list;
        }

        /// <summary>
        /// 是否文件名已存在
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        private void IsFileExist(HttpContext context)
        {
            string rootDir = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintUpdate");
            string fileName = context.Request.Params["fileName"];
            context.Response.Write(File.Exists(Path.Combine(rootDir, fileName)) ? "1" : "0");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        #region 打印服务更新

        /// <summary>
        /// 获取要下载的文件
        /// </summary>
        /// <param name="context"></param>
        private void GetUpdateFile(HttpContext context)
        {
            FileUpdateResponse response = new FileUpdateResponse()
            {
                UpdateFiles = new List<FileUpdateInfo>(),
                DeleteFiles = new List<string>(),
                ErrorMsg = ""
            };
            try
            {
                FileType fileType = (FileType)Convert.ToInt32(context.Request.Params["fileType"]);
                string version = context.Request.Params["version"];
                string basePath = "";
                //根据版本
                if (!string.IsNullOrWhiteSpace(version))
                {
                    switch (fileType)
                    {
                        case FileType.Software:
                            basePath = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintUpdate/");
                            break;
                    }
                    if (!Directory.Exists(basePath))
                    {
                        Directory.CreateDirectory(basePath);
                    }
                    string versionName = "version.ini";
                    string versionPath = Path.Combine(basePath, versionName);
                    if (version != null && File.Exists(versionPath) && File.ReadAllText(versionPath) != version)
                    {
                        response.UpdateFiles = GetFileInfoList(basePath, null);
                    }
                }
                else {
                    //根据文件列表
                    bool isFileForceDownload = Convert.ToBoolean(context.Request.Params["isFileForceDownload"]);
                    bool isAll = Convert.ToBoolean(context.Request.Params["isAll"]);
                    List<FileUpdateInfo> list = JsonConvert.DeserializeObject<List<FileUpdateInfo>>(context.Request.Params["list"]);
                    List<string> listExt = null;
                    //根据类型区分
                    switch (fileType)
                    {
                        case FileType.PrintTemplate:
                            basePath = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintTemplate/");
                            listExt = (ConfigurationManager.AppSettings["UpdateTemplateFileExt"] ?? "")
                                .Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries).ToList();
                            break;
                    }
                    //开始对比文件
                    if (isAll)
                    {
                        #region 所有文件
                        if (!Directory.Exists(basePath))
                        {
                            Directory.CreateDirectory(basePath);
                        }
                        //获取相关文件
                        List<FileUpdateInfo> listAll = GetFileInfoList(basePath, listExt, false);
                        foreach (var item in listAll)
                        {
                            var match = list.FirstOrDefault(p => p.FileName.ToUpper() == item.FileName.ToUpper());
                            FileInfo fileInfo = new FileInfo(Path.Combine(basePath, item.FileName));
                            if (match == null)
                            {
                                //新增
                                response.UpdateFiles.Add(new FileUpdateInfo()
                                {
                                    FileName = item.FileName,
                                    ModifyDateTime = fileInfo.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")
                                });
                            }
                            else
                            {
                                //修改
                                if (isFileForceDownload)
                                {
                                    response.UpdateFiles.Add(new FileUpdateInfo()
                                    {
                                        FileName = item.FileName,
                                        ModifyDateTime = fileInfo.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")
                                    });
                                }
                                else
                                {
                                    DateTime localFileModifyDateTime = Convert.ToDateTime(item.ModifyDateTime);
                                    DateTime serverFileModifyDateTime = fileInfo.LastWriteTime;
                                    //本地时间小于服务器时间时下载
                                    TimeSpan ts = localFileModifyDateTime.Subtract(serverFileModifyDateTime);
                                    if (ts.TotalSeconds < 0)
                                    {
                                        response.UpdateFiles.Add(new FileUpdateInfo()
                                        {
                                            FileName = item.FileName,
                                            ModifyDateTime = serverFileModifyDateTime.ToString("yyyy-MM-dd HH:mm:ss.fff")
                                        });
                                    }
                                }
                            }
                            //删除
                            var listDelete = list.Where(p => !listAll.Any(q => q.FileName.ToUpper() == p.FileName.ToUpper())).Select(p => p.FileName);
                            response.DeleteFiles.AddRange(listDelete);
                        }

                        #endregion
                    }
                    else
                    {
                        #region  部分文件

                        foreach (var item in list)
                        {
                            FileInfo fileInfo = new FileInfo(Path.Combine(basePath, item.FileName));
                            if (!fileInfo.Exists)
                            {
                                throw new Exception($"模板文件{item.FileName}在服务器上不存在，请重新上传！");
                            }
                            else {
                                if (isFileForceDownload)
                                {
                                    response.UpdateFiles.Add(new FileUpdateInfo()
                                    {
                                        FileName = item.FileName,
                                        ModifyDateTime = fileInfo.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")
                                    });
                                }
                                else
                                {
                                    DateTime localFileModifyDateTime = Convert.ToDateTime(item.ModifyDateTime);
                                    DateTime serverFileModifyDateTime = fileInfo.LastWriteTime;
                                    //本地时间小于服务器时间时下载
                                    TimeSpan ts = localFileModifyDateTime.Subtract(serverFileModifyDateTime);
                                    if (ts.TotalSeconds < 0)
                                    {
                                        response.UpdateFiles.Add(new FileUpdateInfo()
                                        {
                                            FileName = item.FileName,
                                            ModifyDateTime = serverFileModifyDateTime.ToString("yyyy-MM-dd HH:mm:ss.fff")
                                        });
                                    }
                                }
                            }
                        }

                        #endregion
                    }
                }
            }
            catch (Exception ex)
            {
                response.ErrorMsg = ex.Message;
                Log4Helper.Error(ex);
            }
            context.Response.Write(JsonConvert.SerializeObject(response));
        }
        /// <summary>
        /// 下载更新得文件
        /// </summary>
        /// <param name="context"></param>
        private void DownLoadUpdateFile(HttpContext context)
        {
            try
            {
                FileType fileType = (FileType)Convert.ToInt32(context.Request.Params["fileType"]);
                string fileName = HttpUtility.UrlDecode(context.Request.Params["fileName"]);
                string basePath = "";
                //根据类型区分
                switch (fileType)
                {
                    case FileType.PrintTemplate:
                        basePath = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintTemplate/");
                        break;
                    case FileType.Software:
                        basePath = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintUpdate/");
                        break;
                }
                string filePath = Path.Combine(basePath, fileName);
                if (File.Exists(filePath))
                {
                    context.Response.ClearHeaders();
                    context.Response.ClearContent();
                    FileInfo info = new FileInfo(filePath);
                    FileStream fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
                    byte[] bytes = new byte[fileStream.Length];
                    fileStream.Read(bytes, 0, bytes.Length);
                    fileStream.Close();
                    context.Response.ContentType = "application/octet-stream";
                    context.Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(info.Name));
                    context.Response.OutputStream.Write(bytes, 0, bytes.Length);
                }
                else {
                    throw new Exception($"文件[{fileName}]在服务器上不存在文件路径{filePath}");
                }
            }
            catch (Exception ex)
            {
                Log4Helper.Error(ex);
            }
        }
        /// <summary>
        /// 获取指定目录得所有文件
        /// </summary>
        /// <param name="rootdir"></param>
        /// <param name="listExt">支持的文件后缀名</param>
        /// <param name="isRecursive"></param>
        /// <param name="dir"></param>
        /// <returns></returns>
        private List<FileUpdateInfo> GetFileInfoList(string rootdir, List<string> listExt, bool isRecursive = true, string dir = null)
        {
            if (dir == null)
            {
                dir = rootdir;
            }
            List<FileUpdateInfo> list = new List<FileUpdateInfo>();
            string[] files = Directory.GetFiles(dir);
            foreach (var item in files)
            {
                FileInfo fileInfo = new FileInfo(item);
                //不支持的文件格式
                if (listExt != null && listExt.Count > 0 && !listExt.Any(p => p.ToUpper() == fileInfo.Extension.ToUpper()))
                {
                    continue;
                }
                list.Add(new FileUpdateInfo()
                {
                    FileName = item.Replace(rootdir, ""),
                    ModifyDateTime = fileInfo.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")
                });
            }
            if (isRecursive)
            {
                string[] directs = Directory.GetDirectories(dir);
                foreach (var item in directs)
                {
                    list.AddRange(GetFileInfoList(rootdir, listExt, isRecursive, item));
                }
            }
            return list;
        }
        /// <summary>
        /// 上传模板文件
        /// </summary>
        /// <param name="context"></param>
        private void UploadTemplateFile(HttpContext context)
        {
            try
            {
                LabelDocumentInfo entity = new LabelDocument().GetInfo(Convert.ToInt32(context.Request.Params["id"]));
                if (entity != null)
                {
                    var files = context.Request.Files;
                    var fileName = context.Request.Params["fileName"];
                    if (files == null || files.Count == 0)
                        return;
                    HttpPostedFile file = files.Get(0);
                    if (file.ContentLength == 0)
                    {
                        context.Response.Write("{\"success\":false,\"msg\":\"上传文件为0字节,请重新选择上传文件\"}");
                        return;
                    }
                    entity.TemplatePath = fileName;
                    string path = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintTemplate/");
                    string url = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintTemplate/" + entity.TemplatePath);
                    if (!Directory.Exists(path))
                        Directory.CreateDirectory(path);

                    if (File.Exists(url))
                        File.Delete(url);
                    file.SaveAs(url);
                    new LabelDocument().Edit(entity);

                    context.Response.Write("{\"success\":true}");
                }
                else
                {
                    context.Response.Write("{\"success\":false,\"msg\":\"数据不存在\"}");
                }
            }
            catch (Exception ex)
            {
                context.Response.Write("{\"success\":false,\"msg\":\"" + ex.Message + "\"}");
            }
        }
        /// <summary>
        /// 上传指令文件
        /// </summary>
        /// <param name="context"></param>
        private void UploadCommandFile(HttpContext context)
        {
            try
            {
                LabelDocumentInfo entity = new LabelDocument().GetInfo(Convert.ToInt32(context.Request.Params["id"]));
                int type = Convert.ToInt32(context.Request.Params["type"]);
                string command = context.Request.Params["command"];
                if (entity != null)
                {
                    if (type == 2)
                    {
                        entity.TemplatePath = context.Request.Params["id"] + ".zpl";
                    }
                    else
                    {
                        entity.TemplatePath = context.Request.Params["id"] + ".postek";
                    }


                    string path = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintTemplate/");
                    string url = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintTemplate/" + entity.TemplatePath);
                    if (!Directory.Exists(path))
                        Directory.CreateDirectory(path);
                    if (File.Exists(url))
                        File.Delete(url);
                    StreamWriter sw = File.AppendText(url);
                    sw.Write(command);
                    sw.Close();
                    new LabelDocument().Edit(entity);

                    //上传文件到FTP服务器上 开始----------------------------------------
                    SKT.LeanMES.ESOP.BLL.FtpServerConfig ftpBll = new LeanMES.ESOP.BLL.FtpServerConfig();
                    SKT.LeanMES.ESOP.Model.FtpServerConfigInfo ftpEntity = ftpBll.GetInfo();
                    string dir = "UploadFiles/PrintTemplate";
                    FileStream fileStream = new FileStream(url, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
                    UploadUtility.CheckCreateFolder(ftpEntity.FtpServerName, "UploadFiles", ftpEntity.UserName, ftpEntity.PWD, dir);
                    UploadUtility.UploadFile(fileStream, entity.TemplatePath,
                        dir, ftpEntity.FtpServerName, ftpEntity.UserName,
                        ftpEntity.PWD);
                    fileStream.Close();

                    //上传文件到FTP服务器上 结束----------------------------------------
                    //修改版本
                    //SyncFile(context);
                    context.Response.Write("{\"success\":true}");
                }
                else
                {
                    context.Response.Write("{\"success\":false,\"msg\":\"数据不存在\"}");
                }
            }
            catch (Exception ex)
            {
                context.Response.Write("{\"success\":false,\"msg\":\"" + ex.Message + "\"}");
            }
        }
        /// <summary>
        /// 是否模板文件名已存在
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        private void IsTemplateFileExist(HttpContext context)
        {
            string rootDir = context.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintTemplate");
            string fileName = context.Request.Params["fileName"];
            context.Response.Write(File.Exists(Path.Combine(rootDir, fileName)) ? "1" : "0");
        }

        #endregion
    }

    public enum eFileType
    {
        TXT,
        XML,
        EXCEL,
        CSV
    }

    public class PrintDataBusiness
    {
        public PdfPrintContent GetPdfPrintContent(int labelId, string data, int printQty = 0)
        {
            LabelDocumentInfo label = new LabelDocument().GetInfo(labelId);
            Dictionary<int, string> dic = new LabelField().LabelSet(label.LabelDocumentId);
            PrintTemplateInfo Model = new PrintTemplate().GetEnityByTempId(label.TemplateID);
            List<PrintTemplateDtl> templist = Newtonsoft.Json.JsonConvert.DeserializeObject<List<PrintTemplateDtl>>(Model.TempSet);
            templist.AsParallel().ForAll(item =>
            {
                if (!string.IsNullOrWhiteSpace(item.key) && dic.ContainsKey(Convert.ToInt32(item.key)))
                {
                    item.key = dic[Convert.ToInt32(item.key)];
                }
            });

            List<PrintDataInfo> Temp4each1 = Newtonsoft.Json.JsonConvert.DeserializeObject<List<PrintDataInfo>>(data);
            List<PrintDataInfo> Temp4each = new List<PrintDataInfo>();
            //如果指定了打印份数则替换模板中的打印份数
            if (printQty > 0)
            {
                label.Print_Qty = printQty;
            }
            //如果打印多份
            if (label.Print_Qty > 1)
            {
                while (label.Print_Qty > 0)
                {
                    foreach (PrintDataInfo item in Temp4each1)
                    {
                        Temp4each.Add(item);
                    }
                    label.Print_Qty -= 1;
                }
            }
            else
            {
                Temp4each = Temp4each1;
            }
            PdfPrintContent content = new PdfPrintContent()
            {
                Height = Model.PanelHeight,
                Width = Model.PanelWidth,
                List = templist,
                LabFileName = label.TemplatePath,
                Data = Temp4each
            };

            //Modify by wenshun, on 2020-12-10,如果有存储过程(存储过程会改数据的变量名称)，则模板的变量名称需要改变成和数据一样的
            if (Temp4each.Count > 0)
            {
                PrintDataInfo pdi = Temp4each[0];//取第一板进行参数变更
                foreach (var item in content.List)
                {
                    //key不能为空，当PDF打印的名称在数据Key中不存在,但是数据Key中有包含打印名称的数据项时切数据项最初名称不等于PDF的打印名称时候（通过存储过程导致名称变更）,将PDF模板的Key置为数据的数据项名称，数据项的最初名称赋值成数据名称
                    if (!string.IsNullOrWhiteSpace(item.key) &&
                        !pdi.LabelContent.Exists(kk => kk.name.Equals(item.key)) &&
                            (pdi.LabelContent.Exists(kk => kk.name.Contains(item.key)) ||
                                pdi.LabelContent.Exists(kk => item.key.Equals(kk.OriginalName) && !kk.name.Equals(kk.OriginalName))))
                    {
                        PrintKeyValue kv = pdi.LabelContent.Find(kk => kk.name.Contains(item.key) && !kk.name.Equals(kk.OriginalName == null ? "" : kk.OriginalName));
                        if (kv != null)
                        {
                            item.key = kv.name;
                            kv.OriginalName = kv.name;
                        }
                    }
                }
            }

            //连板
            int group = content.List.Max(item => item.group);
            if (group > 1)
            {
                List<PrintDataInfo> newdata = new List<PrintDataInfo>();
                content.List.ForEach(item => { item.key += item.group.ToString(); });
                int index = 0;
                PrintDataInfo pd = null;
                for (int i = 0; i < content.Data.Count; i++)
                {
                    if (i % group == 0)
                    {
                        pd = new PrintDataInfo { LabelContent = new List<PrintKeyValue>() };
                        index = 0;
                        newdata.Add(pd);
                    }
                    index++;
                    if (pd != null)
                    {
                        for (var k = 0; k < content.Data[i].LabelContent.Count; k++)
                        {
                            pd.LabelContent.Add(new PrintKeyValue { name = content.Data[i].LabelContent[k].name + index, value = content.Data[i].LabelContent[k].value });
                        }
                    }
                }
                content.Data = newdata;
            }
            return content;
        }
    }

    /// <summary>
    /// 待更新得文件
    /// </summary>
    public class FileUpdateInfo
    {
        /// <summary>
        /// 文件名/文件相对路径
        /// </summary>
        public string FileName { get; set; }
        /// <summary>
        /// 修改日期字符串(yyyy-MM-dd HH:mm:ss.fff )
        /// </summary>
        public string ModifyDateTime { get; set; }
    }

    /// <summary>
    /// 文件更新响应
    /// </summary>
    public class FileUpdateResponse
    {
        /// <summary>
        /// 要更新的文件
        /// </summary>
        public List<FileUpdateInfo> UpdateFiles { get; set; }
        /// <summary>
        /// 要删除的文件
        /// </summary>
        public List<string> DeleteFiles { get; set; }
        /// <summary>
        /// 错误信息
        /// </summary>
        public string ErrorMsg { get; set; }
    }

    public enum FileType
    {
        /// <summary>
        /// 打印模板
        /// </summary>
        PrintTemplate = 1,
        /// <summary>
        /// 软件更新
        /// </summary>
        Software = 99,
    }
}