using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    public partial class IPQCInspectionAddFile : BasePage
    {
        int id = -1;
        string iod = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Request.QueryString["ID"]);
            iod = Request.QueryString["IOD"];
        }
        protected void linkUploadFileF_Click(object sender, EventArgs e)
        {
            if (!fuLoadingListF.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                return;
            }

            string fileExtension = System.IO.Path.GetExtension(fuLoadingListF.PostedFile.FileName).ToLower();
            string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/IPQCInspection/File");
            string savePath = DateTime.Now.ToString("yyyyMMddHHmmssfff") + "_" + fuLoadingListF.FileName;
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            string filePath = path + "\\" + savePath;

            try
            {

                this.fuLoadingListF.PostedFile.SaveAs(filePath);
                lbFileReadyF.Text = "/UploadFiles/IPQCInspection/File/" + savePath;
                hdnfURL.Value = "/UploadFiles/IPQCInspection/File/" + savePath;


                //保存IPQC上传文件记录
                SKT.LeanMES.ESOP.BLL.ESOPFile bll = new LeanMES.ESOP.BLL.ESOPFile();
                bll.InsertFile("InspectionIPQCFile", Path.GetExtension(fuLoadingListF.FileName).Replace(".", ""),
                    Path.GetFileName(fuLoadingListF.FileName), fuLoadingListF.FileName,
                    hdnfURL.Value, Convert.ToDecimal(id), iod,
                    AccountController.GetCurrentUser().UserName);

            }
            catch
            {

            }
            finally
            {
                fuLoadingListF.PostedFile.InputStream.Close();
                fuLoadingListF.PostedFile.InputStream.Dispose();
            }

        }
    }
}