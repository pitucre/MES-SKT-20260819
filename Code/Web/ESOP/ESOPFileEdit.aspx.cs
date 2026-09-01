using System;
using SKT.LeanMES.ESOP.BLL;
using SKT.LeanMES.ESOP.Model;
using SKT.LeanMES.Web.AjaxServices;
using System.Net;
using System.IO;
using System.Collections.Generic;

namespace SKT.LeanMES.Web.Product
{
public partial class ESOPFileEdit : BasePage
{


    private string ftpServerIP = string.Empty;//资源FTP
    private string ftpUserID = string.Empty;//登录FTP用户名
    private string ftpPassword = string.Empty;//登录FTP密码
    private string ftpServerDir = string.Empty;//文件在ftp服务器上的存放目录

    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
        int compId = Convert.ToInt32(Request.QueryString["ID"]);
        if (compId == -1)
        {
            //this.txtSequence.Text = Request.QueryString["Seq"].ToString();
        }
        if (compId > 0)
        {
            SKT.LeanMES.Product.Model.BomComponentInfo model = null;
            model = (new SKT.LeanMES.Product.BLL.BomComponent()).GetInfo(compId);
            if (model != null)
            {
                this.PageData = model;
            }
        }
        try
        {
            FtpServerConfigInfo ftpModel = (new FtpServerConfig()).GetInfo();
            ftpServerIP = ftpModel.FtpServerName;
            ftpUserID = ftpModel.UserName;
            ftpPassword = ftpModel.PWD;
            ftpServerDir = ftpModel.FtpStoreLocation;
        }catch(Exception ex)
        {
            Response.Write(ex.ToString());  
        }
    }

    private SKT.LeanMES.Product.Model.BomComponentInfo PageData
    {
        set
        {
            this.txtItem.Text = value.ItemName;
            this.hdnItemId.Value = value.ItemID.ToString();
            this.txtAssOperationName.Text = value.OperationName;
            this.hdnAssOperationID.Value = value.AssOperationID.ToString();
        }
    }


    /// <summary>
    /// 上传Excel，并生成html文件
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        #region
        try
        {
            string filePath = flupload.PostedFile.FileName;

            if (string.IsNullOrEmpty(filePath) || string.IsNullOrEmpty(this.hdnItemId.Value) || string.IsNullOrEmpty(this.hdnAssOperationID.Value))
            {
                return;
            }
            string fileName = filePath.Substring(filePath.LastIndexOf("\\") + 1);
            string path = Server.MapPath("./");
            this.flupload.PostedFile.SaveAs(path + "/" + fileName);
            FileInfo fileInf = new FileInfo(path + "/" + fileName);
            string uri = string.Format("ftp://{0}/{1}/{2}", ftpServerIP, ftpServerDir, fileInf.Name);
            FtpWebRequest reqFTP;
            // 根据uri创建FtpWebRequest对象 
            reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri(uri));
            // ftp用户名和密码
            reqFTP.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
            // 默认为true，连接不会被关闭
            // 在一个命令之后被执行
            reqFTP.KeepAlive = false;
            // 指定执行什么命令
            reqFTP.Method = WebRequestMethods.Ftp.UploadFile;
            // 指定数据传输类型
            reqFTP.UseBinary = true;
            // 上传文件时通知服务器文件的大小
            reqFTP.ContentLength = fileInf.Length;
            // 缓冲大小设置为2kb
            int buffLength = 2048 * 1024 * 5;
            byte[] buff = new byte[buffLength];
            int contentLen;
            // 打开一个文件流 (System.IO.FileStream) 去读上传的文件
            FileStream fs = fileInf.OpenRead();

            // 把上传的文件写入流
            Stream strm = reqFTP.GetRequestStream();

            // 每次读文件流的2kb
            contentLen = fs.Read(buff, 0, buffLength);

            // 流内容没有结束
            while (contentLen != 0)
            {
                // 把内容从file stream 写入 upload stream
                strm.Write(buff, 0, contentLen);

                contentLen = fs.Read(buff, 0, buffLength);
            }

            // 关闭两个流
            strm.Close();
            fs.Close();

            SaveToDB(fileName, uri);
            fileInf.Delete();
        }
        catch (Exception ex)
        {
            // MessageBox.Show(ex.Message, "Upload Error");
            Response.Write("Upload Error：" + ex.Message);
        }

        #endregion

    }

    /// <summary>
    /// 把文件信息保存到库里
    /// </summary>
    /// <param name="?"></param>
    /// <returns>1 成功 0 失败</returns>
     public int SaveToDB(string  fileName, string url)
    {
        ESOPFileInfo entity = new ESOPFileInfo();
        ESOPFile bll = new ESOPFile();
        try
        {
            entity.EsopFileId = -1;
            entity.EsopFileName = fileName;
            entity.EsopFileUrl = url;
            entity.ItemId = Convert.ToInt32(this.hdnItemId.Value);
            //entity.StationId =Convert.ToInt32 (this.hdnAssOperationID.Value);
            entity.IsCurrent = true;
            entity.IsVideo = IsVideo(fileName);
            entity.CreateBy = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
            entity.ModifyBy = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
            bll.Edit(entity);
            return 1;
        }catch(Exception ex)
        {
            throw ex; 
        }

        return 0;

    }


    /// <summary>
    /// 判断是否是视频文件
    /// </summary>
    /// <param name="file"></param>
    /// <returns>1 视频文件 0 非视频文件</returns>
     public bool IsVideo(string file)
     {
         string extension = file.Substring(file.LastIndexOf('.')+1).ToLower();
        
         string[] formats= new string[]{"avi","wma","rmvb","rm","flash","mp4","mid","3gp","wmv"};
         List<string> formatList = new List<string>(formats);
         if(formatList.Contains(extension))
         {
             return true;
         }

         return false;

     }

}
}