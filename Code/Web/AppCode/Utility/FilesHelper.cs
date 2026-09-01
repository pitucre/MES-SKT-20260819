using System;
using System.Configuration;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.Security;
using System.IO;
using System.IO.Compression;
using System.Xml;
using System.Diagnostics;
using System.Threading;
using System.Collections;
using LeanMES.FileMonitor.Utility;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    /// <summary>
    /// <para>　常用工具类——文件操作类</para>
    /// <para>　---------------------------------------------------------------------------------------</para>
    /// <para>　FilesUpload：工具方法：ASP.NET上传文件的方法</para>
    /// <para>　FileExists：返回文件是否存在</para>
    /// <para>　IsImgFilename：判断文件名是否为浏览器可以直接显示的图片文件名</para>
    /// <para>　CopyFiles：复制指定目录的所有文件</para>
    /// <para>　MoveFiles：移动指定目录的所有文件</para>
    /// <para>　DeleteDirectoryFiles：删除指定目录的所有文件和子目录</para>
    /// <para>　DeleteFiles：删除指定目录下的指定文件</para>
    /// <para>　CreateDirectory：创建指定目录</para>
    /// <para>　CreateDirectory：建立子目录</para>
    /// <para>　ReNameFloder：重命名文件夹</para>
    /// <para>　DeleteDirectory：删除指定目录</para>
    /// <para>　DirectoryIsExists：检测目录是否存在[+2方法重载]</para>
    /// <para>　DeleteSubDirectory：删除指定目录的所有子目录,不包括对当前目录文件的删除</para>
    /// <para>　GetFileWriteTime：获取文件最后修改时间</para>
    /// <para>　GetFileExtension：返回指定路径的文件的扩展名</para>
    /// <para>　IsHiddenFile：判断是否是隐藏文件</para>
    /// <para>　ReadTxtFile：以只读方式读取文本文件</para>
    /// <para>　WriteStrToTxtFile：将内容写入文本文件(如果文件path存在就打开，不存在就新建)</para>
    /// <para>　GetLocalDrives：获取本地驱动器名列表</para>
    /// <para>　GetAppCurrentDirectory：获取应用程序当前可执行文件的路径</para>
    /// <para>　GetFileSize：获取文件大小并以B，KB，GB，TB方式表示[+2 重载]</para>
    /// <para>　DownLoadFiles:下载文件</para>
    /// </summary>
    public class FilesHelper
    {
        private const string PATH_SPLIT_CHAR = "\\";

        #region 上传文件的方法
        /// <summary>
        /// 上传文件的方法
        /// </summary>
        /// <param name="myFileUpload">上传控件的ID</param>
        /// <param name="allowExtensions">允许上传的扩展文件名类型,如：string[] allowExtensions = { ".doc", ".xls", ".ppt", ".jpg", ".gif" };</param>
        /// <param name="maxLength">允许上传的最大大小，以M为单位</param>
        /// <param name="savePath">保存文件的目录，注意是绝对路径,如：Server.MapPath("~/upload/");</param>
        /// <param name="saveName">保存的文件名，如果是""则以原文件名保存</param>
        public static void FilesUpload(FileUpload myFileUpload, string[] allowExtensions, int maxLength, string savePath, string saveName, out string savedPath)
        {
            savedPath = "";
            // 文件格式是否允许上传
            bool fileAllow = false;
            //检查是否有文件案
            if (myFileUpload.HasFile)
            {
                // 检查文件大小, ContentLength获取的是字节，转成M的时候要除以2次1024
                if (myFileUpload.PostedFile.ContentLength / 1024 / 1024 >= maxLength)
                {
                    throw new Exception("只能上传小于2M的文件！");
                }
                //取得上传文件之扩展文件名，并转换成小写字母
                string fileExtension = System.IO.Path.GetExtension(myFileUpload.FileName).ToLower();
                string tmp = "";   // 存储允许上传的文件后缀名
                //检查扩展文件名是否符合限定类型
                if (allowExtensions != null)
                {
                    for (int i = 0; i < allowExtensions.Length; i++)
                    {
                        tmp += i == allowExtensions.Length - 1 ? allowExtensions[i] : allowExtensions[i] + ",";
                        if (fileExtension == allowExtensions[i])
                        {
                            fileAllow = true;
                        }
                    }
                }
                if (allowExtensions == null) fileAllow = true;

                if (fileAllow)
                {
                    try
                    {
                        if (!Directory.Exists(savePath))
                        {
                            Directory.CreateDirectory(savePath);
                        }

                        string path = savePath + (saveName == "" ? myFileUpload.FileName : saveName);

                        //存储文件到文件夹
                        myFileUpload.SaveAs(path);

                        savedPath = path;
                    }
                    catch (Exception ex)
                    {
                        throw new Exception(ex.Message);
                    }
                }
                else
                {
                    throw new Exception("文件格式不符，可以上传的文件格式为：" + tmp);
                }
            }
            else
            {
                throw new Exception("请选择要上传的文件！");
            }
        }
        #endregion

        #region 返回文件是否存在
        /// <summary>
        /// 返回文件是否存在
        /// </summary>
        /// <param name="filename">文件名</param>
        /// <returns>是否存在</returns>
        public static bool FileExists(string filename)
        {
            return System.IO.File.Exists(filename);
        }
        #endregion

        #region 复制指定目录的所有文件
        /// <summary>
        /// 复制指定目录的所有文件
        /// </summary>
        /// <param name="sourceDir">原始目录</param>
        /// <param name="targetDir">目标目录</param>
        /// <param name="overWrite">如果为true,覆盖同名文件,否则不覆盖</param>
        /// <param name="copySubDir">如果为true,包含目录,否则不包含</param>
        public static void CopyFiles(string sourceDir, string targetDir, bool overWrite, bool copySubDir)
        {
            //复制当前目录文件
            foreach (string sourceFileName in Directory.GetFiles(sourceDir))
            {
                string targetFileName = Path.Combine(targetDir, sourceFileName.Substring(sourceFileName.LastIndexOf(PATH_SPLIT_CHAR) + 1));

                if (File.Exists(targetFileName))
                {
                    if (overWrite == true)
                    {
                        File.SetAttributes(targetFileName, FileAttributes.Normal);
                        File.Copy(sourceFileName, targetFileName, overWrite);
                    }
                }
                else
                {
                    File.Copy(sourceFileName, targetFileName, overWrite);
                }
            }
        }
        #endregion

        #region 移动指定目录的所有文件
        /// <summary>
        /// 移动指定目录的所有文件
        /// </summary>
        /// <param name="sourceDir">原始目录</param>
        /// <param name="targetDir">目标目录</param>
        /// <param name="overWrite">如果为true,覆盖同名文件,否则不覆盖</param>
        /// <param name="moveSubDir">如果为true,包含目录,否则不包含</param>
        public static void MoveFiles(string sourceDir, string targetDir, bool overWrite, bool moveSubDir)
        {
            //移动当前目录文件
            foreach (string sourceFileName in Directory.GetFiles(sourceDir))
            {
                string targetFileName = Path.Combine(targetDir, sourceFileName.Substring(sourceFileName.LastIndexOf(PATH_SPLIT_CHAR) + 1));
                if (File.Exists(targetFileName))
                {
                    if (overWrite == true)
                    {
                        File.SetAttributes(targetFileName, FileAttributes.Normal);
                        File.Delete(targetFileName);
                        File.Move(sourceFileName, targetFileName);
                    }
                }
                else
                {
                    File.Move(sourceFileName, targetFileName);
                }
            }
            if (moveSubDir)
            {
                foreach (string sourceSubDir in Directory.GetDirectories(sourceDir))
                {
                    string targetSubDir = Path.Combine(targetDir, sourceSubDir.Substring(sourceSubDir.LastIndexOf(PATH_SPLIT_CHAR) + 1));
                    if (!Directory.Exists(targetSubDir))
                        Directory.CreateDirectory(targetSubDir);
                    MoveFiles(sourceSubDir, targetSubDir, overWrite, true);
                    Directory.Delete(sourceSubDir);
                }
            }
        }
        #endregion

        #region 删除指定目录的所有文件和子目录
        /// <summary>
        /// 删除指定目录的所有文件和子目录
        /// </summary>
        /// <param name="TargetDir">操作目录</param>
        /// <param name="delSubDir">如果为true,包含对子目录的操作</param>
        public static void DeleteDirectoryFiles(string TargetDir, bool delSubDir)
        {
            foreach (string fileName in Directory.GetFiles(TargetDir))
            {
                File.SetAttributes(fileName, FileAttributes.Normal);
                File.Delete(fileName);
            }
            if (delSubDir)
            {
                DirectoryInfo dir = new DirectoryInfo(TargetDir);
                foreach (DirectoryInfo subDi in dir.GetDirectories())
                {
                    DeleteDirectoryFiles(subDi.FullName, true);
                    subDi.Delete();
                }
            }
        }
        #endregion

        #region 删除指定目录下的指定文件
        /// <summary>
        /// 删除指定目录下的指定文件
        /// </summary>
        /// <param name="TargetFileDir">指定文件的目录</param>
        public static void DeleteFiles(string TargetFileDir)
        {
            File.Delete(TargetFileDir);
        }
        #endregion

        #region 创建指定目录
        /// <summary>
        /// 创建指定目录
        /// </summary>
        /// <param name="targetDir"></param>
        public static void CreateDirectory(string targetDir)
        {
            DirectoryInfo dir = new DirectoryInfo(targetDir);
            if (!dir.Exists)
                dir.Create();
        }
        #endregion

        #region 建立子目录
        /// <summary>
        /// 建立子目录
        /// </summary>
        /// <param name="parentDir">目录路径</param>
        /// <param name="subDirName">子目录名称</param>
        public static void CreateDirectory(string parentDir, string subDirName)
        {
            CreateDirectory(parentDir + PATH_SPLIT_CHAR + subDirName);
        }
        #endregion

        #region 重命名文件夹
        /// <summary>
        /// 重命名文件夹
        /// </summary>
        /// <param name="OldFloderName">原路径文件夹名称</param>
        /// <param name="NewFloderName">新路径文件夹名称</param>
        /// <returns></returns>
        public static bool ReNameFloder(string OldFloderName, string NewFloderName)
        {
            try
            {
                if (Directory.Exists(HttpContext.Current.Server.MapPath("//") + OldFloderName))
                {
                    Directory.Move(HttpContext.Current.Server.MapPath("//") + OldFloderName, HttpContext.Current.Server.MapPath("//") + NewFloderName);
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
        #endregion

        #region 删除指定目录
        /// <summary>
        /// 删除指定目录
        /// </summary>
        /// <param name="targetDir">目录路径</param>
        public static void DeleteDirectory(string targetDir)
        {
            DirectoryInfo dirInfo = new DirectoryInfo(targetDir);
            if (dirInfo.Exists)
            {
                DeleteDirectoryFiles(targetDir, true);
                dirInfo.Delete(true);
            }
        }
        #endregion

        #region 检测目录是否存在
        /// <summary>
        /// 检测目录是否存在
        /// </summary>
        /// <param name="StrPath">路径</param>
        /// <returns></returns>
        public static bool DirectoryIsExists(string StrPath)
        {
            DirectoryInfo dirInfo = new DirectoryInfo(StrPath);
            return dirInfo.Exists;
        }
        /// <summary>
        /// 检测目录是否存在
        /// </summary>
        /// <param name="StrPath">路径</param>
        /// <param name="Create">如果不存在，是否创建</param>
        public static void DirectoryIsExists(string StrPath, bool Create)
        {
            DirectoryInfo dirInfo = new DirectoryInfo(StrPath);
            //return dirInfo.Exists;
            if (!dirInfo.Exists)
            {
                if (Create) dirInfo.Create();
            }
        }
        #endregion

        #region 删除指定目录的所有子目录,不包括对当前目录文件的删除
        /// <summary>
        /// 删除指定目录的所有子目录,不包括对当前目录文件的删除
        /// </summary>
        /// <param name="targetDir">目录路径</param>
        public static void DeleteSubDirectory(string targetDir)
        {
            foreach (string subDir in Directory.GetDirectories(targetDir))
            {
                DeleteDirectory(subDir);
            }
        }
        #endregion

        #region 获取文件最后修改时间
        /// <summary>
        /// 获取文件最后修改时间
        /// </summary>
        /// <param name="FileUrl">文件真实路径</param>
        /// <returns></returns>
        public DateTime GetFileWriteTime(string FileUrl)
        {
            return File.GetLastWriteTime(FileUrl);
        }
        #endregion

        #region 返回指定路径的文件的扩展名
        /// <summary>
        /// 返回指定路径的文件的扩展名
        /// </summary>
        /// <param name="PathFileName">完整路径的文件</param>
        /// <returns></returns>
        public string GetFileExtension(string PathFileName)
        {
            return Path.GetExtension(PathFileName);
        }
        #endregion

        #region 判断是否是隐藏文件
        /// <summary>
        /// 判断是否是隐藏文件
        /// </summary>
        /// <param name="path">文件路径</param>
        /// <returns></returns>
        public bool IsHiddenFile(string path)
        {
            FileAttributes MyAttributes = File.GetAttributes(path);
            string MyFileType = MyAttributes.ToString();
            if (MyFileType.LastIndexOf("Hidden") != -1) //是否隐藏文件
            {
                return true;
            }
            else
                return false;
        }
        #endregion

        #region 以只读方式读取文本文件
        /// <summary>
        /// 以只读方式读取文本文件
        /// </summary>
        /// <param name="FilePath">文件路径及文件名</param>
        /// <returns></returns>
        public static string ReadTxtFile(string FilePath)
        {
            string content = "";//返回的字符串
            using (FileStream fs = new FileStream(FilePath, FileMode.Open))
            {
                using (StreamReader reader = new StreamReader(fs, Encoding.UTF8))
                {
                    string text = string.Empty;
                    while (!reader.EndOfStream)
                    {
                        text += reader.ReadLine() + "\r\n";
                        content = text;
                    }
                }
            }
            return content;
        }
        #endregion

        #region 将内容写入文本文件(如果文件path存在就打开，不存在就新建)
        /// <summary>
        /// 将内容写入文本文件(如果文件path存在就打开，不存在就新建)
        /// </summary>
        /// <param name="FilePath">文件路径</param>
        /// <param name="WriteStr">要写入的内容</param>
        /// <param name="FileModes">写入模式：append 是追加写, CreateNew 是覆盖</param>
        public static void WriteStrToTxtFile(string FilePath, string WriteStr, FileMode FileModes)
        {
            FileStream fst = new FileStream(FilePath, FileModes);
            StreamWriter swt = new StreamWriter(fst, System.Text.Encoding.GetEncoding("utf-8"));
            swt.WriteLine(WriteStr);
            swt.Close();
            fst.Close();
        }
        #endregion

        #region 获取文件大小并以B，KB，GB，TB方式表示[+2 重载]
        /// <summary>
        /// 获取文件大小并以B，KB，GB，TB方式表示
        /// </summary>
        /// <param name="File">文件(FileInfo类型)</param>
        /// <returns></returns>
        public static string GetFileSize(FileInfo File)
        {
            string Result = "";
            long FileSize = File.Length;
            if (FileSize >= 1024 * 1024 * 1024)
            {
                if (FileSize / 1024 * 1024 * 1024 * 1024 >= 1024) Result = string.Format("{0:############0.00} TB", (double)FileSize / 1024 * 1024 * 1024 * 1024);
                else Result = string.Format("{0:####0.00} GB", (double)FileSize / 1024 * 1024 * 1024);
            }
            else if (FileSize >= 1024 * 1024) Result = string.Format("{0:####0.00} MB", (double)FileSize / 1024 * 1024);
            else if (FileSize >= 1024) Result = string.Format("{0:####0.00} KB", (double)FileSize / 1024);
            else Result = string.Format("{0:####0.00} Bytes", FileSize);
            return Result;
        }
        /// <summary>
        /// 获取文件大小并以B，KB，GB，TB方式表示
        /// </summary>
        /// <param name="FilePath">文件的具体路径</param>
        /// <returns></returns>
        public static string GetFileSize(string FilePath)
        {
            string Result = "";
            FileInfo File = new FileInfo(FilePath);
            long FileSize = File.Length;
            if (FileSize >= 1024 * 1024 * 1024)
            {
                if (FileSize / 1024 * 1024 * 1024 * 1024 >= 1024) Result = string.Format("{0:########0.00} TB", (double)FileSize / 1024 * 1024 * 1024 * 1024);
                else Result = string.Format("{0:####0.00} GB", (double)FileSize / 1024 * 1024 * 1024);
            }
            else if (FileSize >= 1024 * 1024) Result = string.Format("{0:####0.00} MB", (double)FileSize / 1024 * 1024);
            else if (FileSize >= 1024) Result = string.Format("{0:####0.00} KB", (double)FileSize / 1024);
            else Result = string.Format("{0:####0.00} Bytes", FileSize);
            return Result;
        }
        #endregion

        #region 下载文件
        /// <summary>
        /// 下载文件
        /// </summary>
        /// <param name="FileFullPath">下载文件下载的完整路径及名称</param>
        public static void DownLoadFiles(string FileFullPath)
        {
            if (!string.IsNullOrEmpty(FileFullPath) && FileExists(FileFullPath))
            {
                FileInfo fi = new FileInfo(FileFullPath);//文件信息
                FileFullPath = HttpUtility.UrlEncode(FileFullPath); //对文件名编码
                FileFullPath = FileFullPath.Replace("+", "%20"); //解决空格被编码为"+"号的问题
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment; filename=" + FileFullPath);
                HttpContext.Current.Response.AppendHeader("content-length", fi.Length.ToString()); //文件长度
                int chunkSize = 102400;//缓存区大小,可根据服务器性能及网络情况进行修改
                byte[] buffer = new byte[chunkSize]; //缓存区
                using (FileStream fs = fi.Open(FileMode.Open))  //打开一个文件流
                {
                    while (fs.Position >= 0 && HttpContext.Current.Response.IsClientConnected) //如果没到文件尾并且客户在线
                    {
                        int tmp = fs.Read(buffer, 0, chunkSize);//读取一块文件
                        if (tmp <= 0) break; //tmp=0说明文件已经读取完毕,则跳出循环
                        HttpContext.Current.Response.OutputStream.Write(buffer, 0, tmp);//向客户端传送一块文件
                        HttpContext.Current.Response.Flush();//保证缓存全部送出
                        Thread.Sleep(10);//主线程休息一下,以释放CPU
                    }
                }
            }
        }
        #endregion

        #region 获取标签模板
        public static String GetLabelContent(string labelType)
        {

            string labelPath = "";
            String labelContent = "";
            switch (labelType.ToLower())
            {
                case "grn":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//GRN/ClickeleGrnLabelTemplate.zpl";
                    break;
                case "grnpack":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//GRN/ClickeleGrnPackLabelTemplate.zpl";
                    break;
                case "grncnt":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//GRN/ClickeleCntLabelTemplate.zpl";
                    break;
                case "itemsn":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//ItemSN/ItemSN.zpl";
                    break;
                case "boxsn":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//BoxSN/BoxSN.zpl";
                    break;
                case "repeatsn":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//ItemSN/RepeatSNconfig.zpl";
                    break;
                case "epp":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//ItemSN/EPP.zpl";
                    break;
                case "approve":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//ItemSN/Approve.zpl";
                    break;
                case "selfmade":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//ItemSN/SelfMade.zpl";
                    break;
                case "outsourcing":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//ItemSN/Outsourcing.zpl";
                    break;
                case "finishedproduct":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//ItemSN/FinishedProduct.zpl";
                    break;
                case "accessory":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//ItemSN/Accessory.zpl";
                    break;
                case "part":
                    labelPath = WebHelper.UploadFileRoot.ToString() + "//LabelTemplate//ItemSN/Part.zpl";
                    break;
                default:
                    break;
            }
            try
            {
                labelContent = Utility.FilesHelper.ReadTxtFile(HttpContext.Current.Server.MapPath(labelPath));
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message);
            }
            return labelContent;
        }
        #endregion


        #region 解析XML文件成数组
        public static ArrayList ImportXML(string filePath)
        {
            ArrayList Data = new ArrayList();

            XmlDocument xmlDoc = new XmlDocument();
            XmlReaderSettings settings = new XmlReaderSettings();
            settings.IgnoreComments = true;//忽略文档里面的注释
            using (XmlReader reader = XmlReader.Create(filePath, settings))
            {
                xmlDoc.Load(reader);
                reader.Close();
            }

            GetNodesAttribute("", xmlDoc.ChildNodes, ref Data);

            return Data;
        }

        /// <summary>
        /// 递归方式循环去获取XML的内容
        /// </summary>
        public static void GetNodesAttribute(string NodePath, XmlNodeList nodes, ref ArrayList Data)
        {
            foreach (XmlNode node in nodes)
            {
                string[] nodeAttribute = new string[(node.Attributes == null ? 0 : node.Attributes.Count) + 1];
                nodeAttribute[0] = (NodePath == "" ? "" : "/") + node.Name;
                if (node.Attributes != null)
                {
                    int k = 1;
                    foreach (XmlAttribute attr in node.Attributes)
                    {
                        nodeAttribute[k] = (NodePath == "" ? "" : "/") + node.Name + "@" + attr.Name + "," + attr.Name;
                        k++;
                    }
                }
                Data.Add(nodeAttribute);

                //自己调用自己来实现子节点的增加
                GetNodesAttribute("", node.ChildNodes, ref Data);
            }
        }
        #endregion

        #region 解析TXT文件组成数组
        public static ArrayList ImportTXT(string filePath, char[] SplitChar, int IsUTF8 = 0)
        {
            ArrayList Data = new ArrayList();
            String content = "";
            // System.Text.Encoding.UTF8处理中文乱码问题
            Encoding encodeType = EncodingType.GetType(filePath);
            using (StreamReader sm = new StreamReader(filePath, encodeType))
            {
                content = sm.ReadToEnd().Replace("\r", "");
                sm.Close();
                sm.Dispose();
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
    }
}

