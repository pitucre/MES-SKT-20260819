using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.Model;
using System.IO;

namespace SKT.LeanMES.Web.Product
{
    public partial class BurnSoftEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMolding));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    //this.PageData = (new SKT.LeanMES.Material.BLL.BurnSoft()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private BurnSoftInfo PageData
        {
            set
            {
                this.txtSoftName.Text = value.SoftName;
                this.txtTestMachine.Text = value.TestMachine;
                this.txtCustomer.Text = value.Customer;
                this.txtSoftMan.Text = value.SoftMan;
                this.txtReceiveDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.ReceiveDate);
                this.txtupdatContent.Text = value.UpdateContent;
                this.txtRemark.Text = value.Remark;
                this.downloaddir.Text = value.DownloadDir;
                this.verifycode.Text = value.VerifyCode;
                this.SoftPath.Text = value.SoftPath;
            }
        }



        public static String defaultPath = "";
        public static String softWareName = "";

        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
            if (!txtUploadControl.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                return;
            }
            else
            {
                string fileExtension = Path.GetExtension(getUploadFileVirtualName(txtUploadControl)).ToLower();
                //string allowExtension = ".exe";

                //if (fileExtension != allowExtension)
                //{
                //    WebHelper.ShowMessage(Resources.Messages.FileTypeError.ToString());
                //    return;
                //}
            }

            try
            {
                if (txtUploadControl.HasFile)
                {
                    string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + Path.GetFileName(getUploadFileVirtualName(txtUploadControl)).ToString();
                    string filePath = SetTmpUploadPath();
                    CreateDir(filePath);
                    filename = SaveFileContent(filename, filePath);
                    this.SoftPath.Text = filename;
                    return;
                }


            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message.ToString());

            }


        }
        private string SaveFileContent(string filename, string filePath)
        {
            txtUploadControl.PostedFile.SaveAs(filePath + "\\" + filename);
            filename = filePath + "\\" + filename;
            softWareName = filename;
            return filename;
        }

        private static void CreateDir(string filePath)
        {
            if (!Directory.Exists(filePath))
            {
                try
                {
                    Directory.CreateDirectory(filePath);
                }
                catch (Exception)
                {
                    throw new ApplicationException("Create folder failed.");
                }
            }
        }


        protected String getUploadFileVirtualName(FileUpload fup)
        {

            return fup.PostedFile.FileName;
        }

        private string SetTmpUploadPath()
        {
            string folderPath = Server.MapPath("..\\TempFile");
            return folderPath;
        }
    }
}