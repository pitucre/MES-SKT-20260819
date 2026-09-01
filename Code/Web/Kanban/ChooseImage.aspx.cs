using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace SKT.LeanMES.Web.Kanban
{
    public partial class ChooseImage : BasePage
    {
        protected string Folder = null;
        public string Path;
        public string Filename;
        public string FilePath;
        protected void Page_Load(object sender, EventArgs e)
        {
            Folder = Request.QueryString["Folder"];
            Path = Server.MapPath("../OnlineService/KanbanImage/");//获取img文件夹的路径 
            if (!File.Exists(Path))//Add By Alen 2017-09-06 如果目录不存在则创建
            {
                try {
                    Directory.CreateDirectory(Path);
                }
                catch (Exception)
                {
                    throw new ApplicationException(string.Format("创建目录失败，请确认对路径{0}有写权限！", Path));
                }
            }

            if (IsPostBack)
            {
                if (impUpload.HasFile && hfOperate.Value != "delete")
                {
                    //取得文件MIME内容类型
                    string type = this.impUpload.PostedFile.ContentType.ToLower();
                    if (!type.Contains("image")) //图片的MIME类型为"image/xxx"，这里只判断是否图片。
                    {
                        Response.Write("<script>alert('请选择图片格式文件')</script>");
                    }
                    else if (impUpload.PostedFile.ContentLength > 1024000)
                    {
                        Response.Write("<script>alert('所选大小不能超过1M')</script>");
                    }
                    else
                    {
                        Filename = impUpload.FileName;
                        FilePath = Path + Filename;
                        impUpload.SaveAs(FilePath); //上传图片                       
                    }

                }
                else if (imgName.Value !="" && hfOperate.Value == "delete")
                {
                    Filename = imgName.Value;
                    FilePath = Path + Filename;
                    if (File.Exists(FilePath))
                    {
                        try
                        {
                            File.Delete(FilePath);      //删除选中图片
                        }
                        catch (Exception ex)
                        {
                            Response.Write("<script>alert('"+ex.Message+"')</script>");
                        }

                    }
                }
            }

            //加载目录下的图片          以下内容已加入pubItem@2016-09-01   BirongLiang
            DirectoryInfo di = new DirectoryInfo(Path);
            // di.GetFiles("*.jpg");只获取jpg图片 di.GetFiles();//获取文件夹下所有的文件 
            var fileInfo = di.GetFiles();
            int fileCount = fileInfo.Count();
            ArrayList fileList = new ArrayList();
            foreach (var file in fileInfo)
            {
                //fileList.Add(file.FullName);
                fileList.Add(file.Name);
            }
            hfImgList.Value = new JavaScriptSerializer().Serialize(fileList);

        }
    }
}