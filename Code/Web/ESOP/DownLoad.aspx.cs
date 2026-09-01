using SKT.LeanMES.ESOP.BLL;
using SKT.LeanMES.ESOP.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SKT.LeanMES.Web.ESOP
{
    public partial class DownLoad : System.Web.UI.Page
    {
        private string ftpServerIP = string.Empty;//资源FTP
        private string ftpUserID = string.Empty;//登录FTP用户名
        private string ftpPassword = string.Empty;//登录FTP密码
        private string ftpServerDir = string.Empty;//文件在ftp服务器上的存放目录

        protected void Page_Load(object sender, EventArgs e)
        {
            string folder = string.Empty;
            string fileName = Request.QueryString["fileName"];
            var actionName = Request.QueryString["Action"] == null ? Request["Action"] : Request.QueryString["Action"];
            if (!string.IsNullOrEmpty(fileName))
            {

                switch (actionName)
                {
                    case "UploadRCCA":
                        folder = "/OnlineService/AnormalRCCAFile";
                        break;
                    case "BurnSoft":
                        folder = "/OnlineService/BurnSoftware";
                        break;
                    case "InspectionFile":
                        folder = "/UploadFiles/Inspection";
                        break;
                    case "UploadCustomerLogo":
                        folder = "/OnlineService/CustomerLogo/";
                        break;
                    case "UpalodMedia":
                        folder = "/OnlineService/CorpWeCat";
                        break;
                    case "ExperimentFile":
                        folder = "/UploadFiles/ExperimentFile";
                        break;
                    case "ShippingReport":
                        folder = "/UploadFiles/ShippingReport";
                        break;
                    case "TestReport":
                        folder = "/UploadFiles/TestReport";
                        break;
                    case "CheckItemFileUpload":
                        folder = "/UploadFiles/ShippingReport";
                        break;
                    case "SalOrder":
                        folder = "/UploadFiles/SalOrder";
                        break;
                    case "FileUploadEquiment":
                        folder = "/UploadFiles/EQPicture";
                        break;
                    case "MouldAnormal":
                        folder = "/UploadFiles/MouldAnormalPicture";
                        break;
                    case "EquFile":
                        folder = "/UploadFiles/EQFile";
                        break;

                    case "EquipmentFailure":
                        folder = "/UploadFiles/EquipmentFailure";
                        break;
                    case "MouldMaintenanceLoad": //模具保养图片
                        folder = "UploadFiles/MouldMaintenanceLoad";
                        break;
                    case "FAIInspectionTemplate":
                        folder = "UploadFiles/FAIInspectionTemplate";
                        break;
                    default:
                        folder = "/UploadFiles/ESOP";
                        break;
                }
                try
                {

                    // 不允许 存在 ./ ../  .\ ..\ 
                    if (Regex.IsMatch(fileName, @"(\.\.[/\\]|\.?[/\\])"))
                    {
                        Response.Write("访问的文件不存在");
                        return;
                    }

                    string serverPath = Server.MapPath(WebHelper.WebRoot + folder + "/" + fileName);

                    // 2. 检查文件名是否是 web.config（不区分大小写）
                    string normalizedFileName = Path.GetFileName(serverPath);
                    if (normalizedFileName?.Equals("web.config", StringComparison.OrdinalIgnoreCase) == true)
                    {
                        Response.Write("访问的文件不存在");
                        return;
                    }


             
                    if (!File.Exists(serverPath))
                    {
                        GetFtpConfigInfo(fileName, folder);

                        DownloadToLocalFromServer(serverPath, fileName);
                    }
                    else
                    {
                        DownloadToLocalFromServer(serverPath, fileName);
                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.ToString());

                }
            }
        }

        public void GetFtpConfigInfo(string fileName,string filePath)
        {
            WebClient wc = new WebClient();

         
            string serverPath = Server.MapPath(WebHelper.WebRoot + filePath);

            if (!Directory.Exists(serverPath))
            {
                Directory.CreateDirectory(serverPath);
            }
            FtpServerConfigInfo model = (new FtpServerConfig()).GetInfo();
            ftpServerIP = model.FtpServerName;
            ftpUserID = model.UserName;
            ftpPassword = model.PWD;
            ftpServerDir = filePath;
            string uri = string.Format("ftp://{0}/{1}/{2}", ftpServerIP, ftpServerDir, fileName);
            wc.Credentials = new System.Net.NetworkCredential(ftpUserID, ftpPassword);
            string errorMsg = string.Empty;
            DownloadToServerFromFtp(serverPath, fileName, out errorMsg);

        }
        /// <summary> 
        /// 下载 
        /// </summary> 
        /// <param name="filePath"></param> 
        /// <param name="fileName"></param> 
        public bool Download(string filePath, string fileName, out string errorMsg)
        {
            errorMsg = "";
            FtpWebRequest reqFTP;
            try
            {

                FileStream outputStream = new FileStream(filePath + "//" + fileName, FileMode.Create);
                string uri = string.Format("ftp://{0}/{1}/{2}", ftpServerIP, ftpServerDir, fileName);

                reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri(uri));
                reqFTP.Method = WebRequestMethods.Ftp.DownloadFile;
                reqFTP.UseBinary = true;
                reqFTP.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
                FtpWebResponse response = (FtpWebResponse)reqFTP.GetResponse();
                Stream ftpStream = response.GetResponseStream();
                long cl = response.ContentLength;
                int bufferSize = 2048;
                int readCount;
                byte[] buffer = new byte[bufferSize];

                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(fileName));

                readCount = ftpStream.Read(buffer, 0, bufferSize);
                while (readCount > 0)
                {
                    //Response.BinaryWrite(buffer);
                    Response.OutputStream.Write(buffer, 0, bufferSize);
                    readCount = ftpStream.Read(buffer, 0, bufferSize);
                    Response.Flush();
                }
                Response.Close();
                //Response.End();
                //Response.Clear(); 

                ftpStream.Close();
                outputStream.Close();
                response.Close();
                return true;
            }
            catch (Exception ex)
            {
                errorMsg = ex.Message;
                return false;
            }
        }


        /// <summary>
        /// 下载文件到服务器进行中转
        /// </summary>
        /// <param name="filePath">服务器保存路径</param>
        /// <param name="fileName">文件名</param>
        /// <param name="errorMsg">错误信息</param>
        /// <returns></returns>
        public bool DownloadToServerFromFtp(string filePath, string fileName, out string errorMsg)
        {
            errorMsg = "";
            FtpWebRequest reqFTP;
            try
            {
                String onlyFileName = Path.GetFileName(fileName);
                string newFileName = filePath + "\\" + onlyFileName;
                if (File.Exists(newFileName)) //若存在相同的文件则删除
                {
                    File.Delete(newFileName);
                }
                string uri = string.Format("ftp://{0}/{1}/{2}", ftpServerIP, ftpServerDir, fileName);
                reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri(uri));
                reqFTP.Method = WebRequestMethods.Ftp.DownloadFile;
                reqFTP.UseBinary = true;
                reqFTP.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
                FtpWebResponse response = (FtpWebResponse)reqFTP.GetResponse();
                Stream ftpStream = response.GetResponseStream();
                long cl = response.ContentLength;
                int bufferSize = 2048;
                int readCount;
                byte[] buffer = new byte[bufferSize];
                readCount = ftpStream.Read(buffer, 0, bufferSize);

                FileStream outputStream = new FileStream(newFileName, FileMode.Create);
                while (readCount > 0)
                {
                    outputStream.Write(buffer, 0, readCount);
                    readCount = ftpStream.Read(buffer, 0, bufferSize);
                }
                ftpStream.Close();
                outputStream.Close();
                response.Close();
               // DownloadToLocalFromServer(newFileName, fileName);
                return true;
            }
            catch (Exception ex)
            {
                errorMsg = ex.Message;
                return false;
            }


        }


        /// <summary>
        /// 从服务器下载到本地
        /// </summary>
        /// <param name="filePath"></param>
        /// <param name="fileName"></param>
        /// <param name="errorMsg"></param>
        /// <returns></returns>
        public bool DownloadToLocalFromServer(string filePath, string fileName)
        {
            try
            {
                FileInfo fileInfo = new FileInfo(filePath);
                Response.Clear();
                Response.ClearContent();
                Response.ClearHeaders();
               
                Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
                Response.AddHeader("Content-Length", fileInfo.Length.ToString());
                Response.AddHeader("Content-Transfer-Encoding", "binary");
               
                Response.ContentType = "application/octet-stream";
                Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");
                Response.WriteFile(fileInfo.FullName);
                Response.Flush();
                
                Response.End();
                return true;
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            finally
            {
                //DeleteFile(filePath);
            }
        }

        /// <summary>
        /// 删除缓存文件
        /// </summary>
        /// <param name="fileName"></param>
        public void DeleteCacheFile(string fileName)
        {
            if (!FileValidator.ValidateFileName(fileName))
            {
                throw new Exception("文件名不合法,存在非法字符");
            }
            string serverPath = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/ESOP"); 
            string newFileName = serverPath + "\\" + fileName;
            if (File.Exists(newFileName)) //若存在相同的文件则删除
            {
                File.Delete(newFileName);
            }
        }

        /// <summary>
        /// 删除服务器上的文件
        /// </summary>
        /// <param name="filePath"></param>
        /// <param name="fileName"></param>
        /// <returns></returns>
        public bool DeleteFile(string file)
        {
            try
            {
                if (File.Exists(file))
                {
                    File.Delete(file);
                };
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



    }
}