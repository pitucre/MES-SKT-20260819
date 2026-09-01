using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Net;
using System.Text.RegularExpressions;
using System.Text;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    public static class UploadUtility
    {
        /// <summary>
        /// 上传文件
        /// </summary>
        /// <param name="fileinfo">需要上传的文件</param>
        /// <param name="targetDir">目标路径</param>
        /// <param name="hostname">ftp地址</param>
        /// <param name="username">ftp用户名</param>
        /// <param name="password">ftp密码</param>
        public static string UploadFile(Stream fs,string fileName, string targetDir, string hostname, string username, string password)
        {
            //string ftpUrl = "";
            //1. check target
            //string target;
            //if (targetDir.Trim() == "")
            //{
            //    //return;
            //}
            //target = Guid.NewGuid().ToString();  //使用临时文件名
            
            string URI = "FTP://" + hostname + "/" + targetDir + "/" + fileName;
            ///WebClient webcl = new WebClient();
            System.Net.FtpWebRequest ftp = GetRequest(URI, username, password);

            //设置FTP命令 设置所要执行的FTP命令，
            //ftp.Method = System.Net.WebRequestMethods.Ftp.ListDirectoryDetails;//假设此处为显示指定路径下的文件列表
            ftp.Method = System.Net.WebRequestMethods.Ftp.UploadFile;
           
            //指定文件传输的数据类型
            ftp.UseBinary = true;
            ftp.UsePassive = true;

            //告诉ftp文件大小
            ftp.ContentLength = fs.Length;
            //缓冲大小设置为2KB
            const int BufferSize = 2048;
            byte[] content = new byte[BufferSize];
            int dataRead;

            //打开一个文件流 (System.IO.FileStream) 去读上传的文件
            try
            {
                //把上传的文件写入流
                using (Stream rs = ftp.GetRequestStream())
                {

                    do
                    {
                        //每次读文件流的2KB
                        dataRead = fs.Read(content, 0, BufferSize);
                        rs.Write(content, 0, dataRead);
                    } while (!(dataRead < BufferSize));
                    rs.Close();
                }

            }
            catch (Exception ex) {
                URI = "";
                throw ex;
            }
            finally
            {
                fs.Close();
                ftp = null;
            }

            //ftp = null;
            ////设置FTP命令
            //ftp = GetRequest(URI, username, password);
            //ftp.Method = System.Net.WebRequestMethods.Ftp.Rename; //改名
            //ftp.RenameTo = fileName;
            //try
            //{
            //    ftp.GetResponse();
            //    ftpUrl = "FTP://" + hostname + "/" + targetDir + "/" + fileName;
            //}
            //catch (Exception ex)
            //{
            //    ftp = GetRequest(URI, username, password);
            //    ftp.Method = System.Net.WebRequestMethods.Ftp.DeleteFile; //删除
            //    ftp.GetResponse();
            //    ftpUrl = "failed";
            //    throw ex;
            //}
            //finally
            //{
            //    //fileinfo.Delete();
            //}

            // 可以记录一个日志  "上传" + fileinfo.FullName + "上传到" + "FTP://" + hostname + "/" + targetDir + "/" + fileinfo.Name + "成功." );
           
            return URI;
            #region
            /*****
             *FtpWebResponse
             * ****/
            //FtpWebResponse ftpWebResponse = (FtpWebResponse)ftp.GetResponse();
            #endregion
        }

        public static bool DeleteFile(string fileName, string username, string password)
        {
            bool result = true;
            //string URI = "FTP://" + hostname + "/" + targetDir + "/" + fileinfo.Name;
            System.Net.FtpWebRequest ftp = GetRequest(fileName, username, password);
            ftp.Method = System.Net.WebRequestMethods.Ftp.DeleteFile; //删除
            try
            {
                ftp.GetResponse();
            }
            catch (Exception ex)
            {
                result = false;
                throw ex;
            }
            return result;
        }


        #region 从FTP服务器上获取文件和文件夹列表
        /// <summary>
        /// 获取详细列表 从FTP服务器上获取文件和文件夹列表
        /// </summary>
        /// <returns></returns>
        public static List<string> GetFileDetails(string hostname,string targetDir,string username, string password)
        {
            List<string> result = new List<string>();
            //建立连接
           string url = "FTP://" + hostname + "/" + targetDir  ;
           System.Net.FtpWebRequest ftp = GetRequest(url, username, password);
           ftp.Method = WebRequestMethods.Ftp.ListDirectoryDetails;
            using (FtpWebResponse response = (FtpWebResponse)ftp.GetResponse())
            {
                StreamReader reader = new StreamReader(response.GetResponseStream(), System.Text.Encoding.Default);//中文文件名
                string line = reader.ReadLine();
                while (line != null)
                {
                    result.Add(line);
                    line = reader.ReadLine();
                }
            }
            return result;
        }
        #endregion

        private static FtpWebRequest GetRequest(string URI, string username, string password)
        {
            //根据服务器信息FtpWebRequest创建类的对象
            FtpWebRequest result = (FtpWebRequest)FtpWebRequest.Create(URI);
            //提供身份验证信息
            result.Credentials = new System.Net.NetworkCredential(username, password);
            //设置请求完成之后是否保持到FTP服务器的控制连接，默认值为true
            result.KeepAlive = false;
            return result;
        }

        /// <summary>
        /// 下载文件
        /// </summary>
        /// <param name="localDir">下载至本地路径</param>
        /// <param name="FtpDir">ftp目标文件路径</param>
        /// <param name="FtpFile">从ftp要下载的文件名</param>
        /// <param name="hostname">ftp地址即IP</param>
        /// <param name="username">ftp用户名</param>
        /// <param name="password">ftp密码</param>
        public static void DownloadFile(string localDir, string FtpDir, string FtpFile, string hostname, string username, string password)
        {
            string URI = "FTP://" + hostname + "/" + FtpDir + "/" + FtpFile;
            string tmpname = Guid.NewGuid().ToString();
            string localfile = localDir + @"\" + tmpname;

            System.Net.FtpWebRequest ftp = GetRequest(URI, username, password);
            ftp.Method = System.Net.WebRequestMethods.Ftp.DownloadFile;
            ftp.UseBinary = true;
            ftp.UsePassive = false;

            using (FtpWebResponse response = (FtpWebResponse)ftp.GetResponse())
            {
                using (Stream responseStream = response.GetResponseStream())
                {
                    //loop to read & write to file
                    using (FileStream fs = new FileStream(localfile, FileMode.CreateNew))
                    {
                        try
                        {
                            byte[] buffer = new byte[2048];
                            int read = 0;
                            do
                            {
                                read = responseStream.Read(buffer, 0, buffer.Length);
                                fs.Write(buffer, 0, read);
                            } while (!(read == 0));
                            responseStream.Close();
                            fs.Flush();
                            fs.Close();
                        }
                        catch (Exception)
                        {
                            //catch error and delete file only partially downloaded
                            fs.Close();
                            //delete target file as it's incomplete
                            File.Delete(localfile);
                            throw;
                        }
                    }

                    responseStream.Close();
                }

                response.Close();
            }



            try
            {
                File.Delete(localDir + @"\" + FtpFile);
                File.Move(localfile, localDir + @"\" + FtpFile);


                ftp = null;
                ftp = GetRequest(URI, username, password);
                ftp.Method = System.Net.WebRequestMethods.Ftp.DeleteFile;
                ftp.GetResponse();

            }
            catch (Exception ex)
            {
                File.Delete(localfile);
                throw ex;
            }

            // 记录日志 "从" + URI.ToString() + "下载到" + localDir + @"\" + FtpFile + "成功." );
            ftp = null;
        }

        /// <summary>
        /// 搜索远程文件
        /// </summary>
        /// <param name="targetDir"></param>
        /// <param name="hostname"></param>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <param name="SearchPattern"></param>
        /// <returns></returns>
        public static List<string> ListDirectory(string targetDir, string hostname, string username, string password, string SearchPattern)
        {
            List<string> result = new List<string>();
            try
            {
                string URI = "FTP://" + hostname + "/" + targetDir + "/" + SearchPattern;

                System.Net.FtpWebRequest ftp = GetRequest(URI, username, password);
                ftp.Method = System.Net.WebRequestMethods.Ftp.ListDirectory;
                ftp.UsePassive = true;
                ftp.UseBinary = true;
                
                string str = GetStringResponse(ftp);
                str = str.Replace("\r\n", "\r").TrimEnd('\r');
                str = str.Replace("\n", "\r");
                if (str != string.Empty)
                    result.AddRange(str.Split('\r'));

                return result;
            }
            catch { }
            return null;
        }



        private static string GetStringResponse(FtpWebRequest ftp)
        {
            //Get the result, streaming to a string
            string result = "";
            using (FtpWebResponse response = (FtpWebResponse)ftp.GetResponse())
            {
                long size = response.ContentLength;
                using (Stream datastream = response.GetResponseStream())
                {
                    using (StreamReader sr = new StreamReader(datastream, System.Text.Encoding.Default))
                    {
                        result = sr.ReadToEnd();
                        sr.Close();
                    }

                    datastream.Close();
                }

                response.Close();
            }

            return result;
        }

        /// <summary>
        /// 判断当前目录下指定的子目录是否存在
        /// </summary>
        /// <param name="RemoteDirectoryName">指定的目录名</param>
        public static bool DirectoryExist(string RemoteDirectoryName, string hostname, string username, string password)
        {
            try
            {
                string[] dirList = GetDirectoryList(hostname,username,password);

                foreach (string str in dirList)
                {
                    if (str.Trim() == RemoteDirectoryName.Trim())
                    {
                        return true;
                    }
                }
                return false;
            }
            catch
            {
                return false;
            }

        }

        /// <summary>
        /// 获取当前目录下所有的文件夹列表(仅文件夹)
        /// </summary>
        /// <returns></returns>
        public static string[] GetDirectoryList(string hostname, string username, string password)
        {
            string[] drectory = GetFilesDetailList(hostname, username, password);
            string m = string.Empty;
            foreach (string str in drectory)
            {
                int dirPos = str.IndexOf("<DIR>");
                if (dirPos > 0)
                {
                    /*判断 Windows 风格*/
                    m += str.Substring(dirPos + 5).Trim() + "\n";
                }
                else if (str.Trim().Substring(0, 1).ToUpper() == "D")
                {
                    /*判断 Unix 风格*/
                    string dir = str.Substring(54).Trim();
                    if (dir != "." && dir != "..")
                    {
                        m += dir + "\n";
                    }
                }
            }

            char[] n = new char[] { '\n' };
            return m.Split(n);
        }

        /// <summary>
        /// 获取当前目录下明细(包含文件和文件夹)
        /// </summary>
        /// <returns></returns>
        public static string[] GetFilesDetailList(string hostname, string username, string password)
        {
            
            try
            {
                StringBuilder result = new StringBuilder();
                FtpWebRequest ftp;
                ftp = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + hostname + "/"));
                ftp.Credentials = new NetworkCredential(username, password);
                ftp.Method = WebRequestMethods.Ftp.ListDirectoryDetails;
                WebResponse response = ftp.GetResponse();
                StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.Default);
                if (reader.Read()!=-1)
                {
                    string line = reader.ReadLine();

                    while (line != null)
                    {
                        result.Append(line);
                        result.Append("\n");
                        line = reader.ReadLine();
                    }
                    result.Remove(result.ToString().LastIndexOf("\n"), 1);
                  
                }
                reader.Close();
                response.Close();
                return result.ToString().Split('\n');
            }
            catch (Exception ex)
            {                
                throw ex;
            }
        }
        /// 在ftp服务器上创建目录
        /// </summary>
        /// <param name="dirName">创建的目录名称</param>
        /// <param name="ftpHostIP">ftp地址</param>
        /// <param name="username">用户名</param>
        /// <param name="password">密码</param>
        public static void MakeDir(string dirName, string ftpHostIP, string username, string password)
        {
            FtpWebRequest reqFTP;
            try
            {
                string uri = "ftp://" + ftpHostIP + "/" + dirName;
                reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri(uri));
                reqFTP.Method = WebRequestMethods.Ftp.MakeDirectory;
                reqFTP.UseBinary = true;
                reqFTP.Credentials = new NetworkCredential(username, password);
                FtpWebResponse response = (FtpWebResponse)reqFTP.GetResponse();
                Stream ftpStream = response.GetResponseStream();

                ftpStream.Close();
                response.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            } 
        }

        /// <summary>
        /// 删除目录
        /// </summary>
        /// <param name="dirName">创建的目录名称</param>
        /// <param name="ftpHostIP">ftp地址</param>
        /// <param name="username">用户名</param>
        /// <param name="password">密码</param>
        public static void delDir(string dirName, string ftpHostIP, string username, string password)
        {
            try
            {
                string uri = "ftp://" + ftpHostIP + "/" + dirName;
                System.Net.FtpWebRequest ftp = GetRequest(uri, username, password);
                ftp.Method = WebRequestMethods.Ftp.RemoveDirectory;
                FtpWebResponse response = (FtpWebResponse)ftp.GetResponse();
                response.Close();
            }
            catch (Exception)
            {

                //MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// 文件重命名
        /// </summary>
        /// <param name="currentFilename">当前目录名称</param>
        /// <param name="newFilename">重命名目录名称</param>
        /// <param name="ftpServerIP">ftp地址</param>
        /// <param name="username">用户名</param>
        /// <param name="password">密码</param>
        public static void Rename(string currentFilename, string newFilename, string ftpServerIP, string username, string password)
        {
            try
            {

                FileInfo fileInf = new FileInfo(currentFilename);
                string uri = "ftp://" + ftpServerIP + "/" + fileInf.Name;
                System.Net.FtpWebRequest ftp = GetRequest(uri, username, password);
                ftp.Method = WebRequestMethods.Ftp.Rename;

                ftp.RenameTo = newFilename;
                FtpWebResponse response = (FtpWebResponse)ftp.GetResponse();

                response.Close();
            }
            catch (Exception)
            {
                //MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// 向Ftp服务器上传文件并创建和本地相同的目录结构
        /// 遍历目录和子目录的文件
        /// </summary>
        /// <param name="file"></param>
        private static void GetFileSystemInfos(FileSystemInfo file)
        {
            string FileName = "";
            string getDirecName = file.Name;
            if (!ftpIsExistsFile(getDirecName, "192.168.0.172", "Anonymous", "") && file.Name.Equals(FileName))
            {
                MakeDir(getDirecName, "192.168.0.172", "Anonymous", "");
            }
            if (!file.Exists) return;
            DirectoryInfo dire = file as DirectoryInfo;
            if (dire == null) return;
            FileSystemInfo[] files = dire.GetFileSystemInfos();

            for (int i = 0; i < files.Length; i++)
            {
                FileInfo fi = files[i] as FileInfo;
                if (fi != null)
                {
                    DirectoryInfo DirecObj = fi.Directory;
                    string DireObjName = DirecObj.Name;
                    if (FileName.Equals(DireObjName))
                    {
                        //UploadFile(fi, DireObjName, "192.168.0.172", "Anonymous", "");
                    }
                    else
                    {
                        Match m = Regex.Match(files[i].FullName, FileName + "+.*" + DireObjName);
                        //UploadFile(fi, FileName+"/"+DireObjName, "192.168.0.172", "Anonymous", "");
                        //UploadFile(fi, m.ToString(), "192.168.0.172", "Anonymous", "");
                    }
                }
                else
                {
                    string[] ArrayStr = files[i].FullName.Split('\\');
                    string finame = files[i].Name;
                    Match m = Regex.Match(files[i].FullName, FileName + "+.*" + finame);
                    //MakeDir(ArrayStr[ArrayStr.Length - 2].ToString() + "/" + finame, "192.168.0.172", "Anonymous", "");
                    MakeDir(m.ToString(), "192.168.0.172", "Anonymous", "");
                    GetFileSystemInfos(files[i]);
                }
            }
        }

        /// <summary>
        /// 判断ftp服务器上该目录是否存在
        /// </summary>
        /// <param name="dirName"></param>
        /// <param name="ftpHostIP"></param>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        internal static bool ftpIsExistsFile(string dirName, string ftpHostIP, string username, string password)
        {
            bool flag = true;
            try
            {
                string uri = "ftp://" + ftpHostIP + "/" + dirName;
                System.Net.FtpWebRequest ftp = GetRequest(uri, username, password);
                ftp.Method = WebRequestMethods.Ftp.ListDirectory;

                FtpWebResponse response = (FtpWebResponse)ftp.GetResponse();
                response.Close();
            }
            catch (Exception)
            {
                flag = false;
            }
            return flag;
        }

        /// <summary>
        /// 检查文件夹是否存在，不存在则创建
        /// </summary>
        ///  <param name="hostIp">ftp IP地址</param>
        /// <param name="dirPath">主文件夹路径名称</param>
        /// <param name="userName">FTP用户名</param>
        /// <param name="pwd">FTP密码</param>
        /// <param name="newFolderName">验证的文件夹是否存在，不存在则创建</param>
        public static void CheckCreateFolder(string hostIp, string dirPath, string userName, string pwd, string newFolderName)
        {
            string[] drectory = GetFilesDetailList(hostIp + "/" + dirPath, userName, pwd);
            bool isFloder = false;
            if (drectory.Length > 0)
            {
                foreach (string str in drectory)
                {
                    if (str.Trim().Length == 0)
                        continue;
                    if (str.Trim().Contains("<DIR>"))
                    {
                        if (newFolderName.Split(new char[] { '/' })[1] == str.Substring(38).Trim())
                        {
                            isFloder = true;
                        }
                    }
                    //2024-02-03 qiping.zhou
                    //可能更改了服务器和加了权限导致drectory读取文件夹格式出现变化
                    //由07-16-23 12:20PM   <DIR>    ESOP
                    //变drwxr-xr-x 1 ftp ftp      0 Jan 26 10:52 ESOP
                    //所以增加以下ftp ftp判断
                    else if (str.Trim().Contains("ftp ftp"))
                    {
                        string strname = str.Split(' ')[(str.Split(' ').Length-1)].Trim();
                        if (newFolderName.Split(new char[] { '/' })[1] == strname)
                        {
                            isFloder = true;
                        }
                    }
                    else
                    {
                        if (str.Trim().Substring(0, 1).ToUpper() == "D")
                        {
                            
                            if (newFolderName == str.Substring(55).Trim())
                            {
                                isFloder = true;
                            }

                        }
                    }
                }
            }
            //如果文件夹不存在则创建
            if (!isFloder)
            {
                MakeDir(newFolderName, hostIp, userName, pwd);
            }
        }

    }

}