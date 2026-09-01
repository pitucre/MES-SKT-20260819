using NPOI.HPSF;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Labels
{
    public partial class SelectImg : BasePage
    {
        public int LabledId { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params.HasKeys())
            {
                string action = Request.Params["action"];
                string fileName = Request.Params["fileName"];
                if (action == "getdata")
                {
                     GetImgData();
                }
                if (Request.Params["id"] != null)
                {
                    LabledId = Convert.ToInt32(Request.Params["id"]);
                }
                if (action == "deleteImg")
                {
                    DeleteImg(fileName);
                }
            }
        }
        private void GetImgData()
        {
           
            try
            {
                List<string> list = new List<string>();
                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PdfImg/"+ Request.Params["id"]);
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                string[] datas = Directory.GetFiles(path);
                foreach (var url in datas)
                {
                    list.Add(new FileInfo(url).Name);
                }
                Response.ClearContent();
                Response.ContentType = "text/plain";
                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(list));
                Response.End();
            }
            catch
            {

            }
        }
        protected void Upload_Click(object sender, EventArgs e)
        {
            if (!fileBomUrl.HasFile)
            {
                WebHelper.ShowMessage("请上传图片");
                return;
            }
            else
            {
                string[] array = new string[] { ".png", ".jpg", ".jepg", ".icon" };
                string ext = System.IO.Path.GetExtension(fileBomUrl.PostedFile.FileName).ToLower();
                if (!array.Contains(ext))
                {
                    WebHelper.ShowMessage("只支持图片上传,后缀" + string.Join(",", array));
                    return;
                }
                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PdfImg/"+ LabledId);
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                string filePath = path + "/" + fileBomUrl.FileName;
                this.fileBomUrl.PostedFile.SaveAs(filePath);
                fileBomUrl.PostedFile.InputStream.Close();
                fileBomUrl.PostedFile.InputStream.Dispose();
            }
        }

        protected void DeleteImg(string fileName)
        {
            if (string.IsNullOrEmpty(fileName))
            {
                WebHelper.ShowMessage("删除失败，未获取到图片名称！");
                return;
            }
            else
            {
                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PdfImg/" + LabledId+"/"+ fileName);

                if (File.Exists(path))
                {
                    File.Delete(path);
                }
                else
                {
                    WebHelper.ShowMessage("删除失败，文件不存在！");
                    return;
                }
            }
        }
    }

}