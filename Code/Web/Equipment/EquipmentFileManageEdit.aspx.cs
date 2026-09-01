using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System.IO;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Equipment
{
public partial class EquipmentFileManageEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentFileManage));

        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new EquipmentFileManage()).GetInfo(Convert.ToInt32(idString));
            }
        }
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

           //string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/EQFile");



            string dir = "UploadFiles/EQFile";
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
                this.filepaths.Value = filePath;
                //this.fuLoadingList.PostedFile.SaveAs(filePath);
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                fuLoadingList.PostedFile.InputStream.Close();
                fuLoadingList.PostedFile.InputStream.Dispose();
            }
            this.filepaths.Value = filePath;
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentFileManageInfo PageData
    {
        set
        {
            this.txtEqCode.Text = value.EqCode;
            this.lbFileReady.Text = value.FileName;
        }
    }
  }
}