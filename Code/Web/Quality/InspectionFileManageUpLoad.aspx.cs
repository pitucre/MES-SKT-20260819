using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionFileManageUpLoad : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterialIQC));
        }
        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
            string filePath = "";
            if (!fuLoadingList.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                return;
            }

            string fileExtension = System.IO.Path.GetExtension(fuLoadingList.PostedFile.FileName).ToLower();


            //string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/Inspection");

            string dir = "UploadFiles/Inspection";
            SKT.LeanMES.ESOP.BLL.FtpServerConfig ftpBll = new LeanMES.ESOP.BLL.FtpServerConfig();
            SKT.LeanMES.ESOP.Model.FtpServerConfigInfo ftpEntity = ftpBll.GetInfo();
           
            //if (!Directory.Exists(path))
            //{
            //    Directory.CreateDirectory(path);
            //}
            try
            {

                UploadUtility.CheckCreateFolder(ftpEntity.FtpServerName, "UploadFiles", ftpEntity.UserName, ftpEntity.PWD, dir);

                filePath = UploadUtility.UploadFile(fuLoadingList.PostedFile.InputStream, fuLoadingList.FileName,
                    dir, ftpEntity.FtpServerName, ftpEntity.UserName,
                    ftpEntity.PWD);
                //filePath = path + "/" + fuLoadingList.FileName;
                lbFileReady.Text = fuLoadingList.FileName;
                Label1.Text = filePath;
                
                this.filepaths.Value = filePath;
                //this.fuLoadingList.PostedFile.SaveAs(filePath);
            }
            catch (Exception)
            {

                throw;
            }
            finally {
                fuLoadingList.PostedFile.InputStream.Close();
                fuLoadingList.PostedFile.InputStream.Dispose();
            }
            this.filepaths.Value = filePath;
        }
    }
}