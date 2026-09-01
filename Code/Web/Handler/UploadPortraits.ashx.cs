using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// UploadPortraits 的摘要说明
    /// </summary>
    public class UploadPortraits : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();
            context.Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            context.Response.ContentType = "image/jpeg";
            SqlInjectableHelper.Validation(context);
            try
            {
                string type = context.Request["Type"];
                string userId = context.Request["UserId"];
                string dicPath = string.Concat(context.Server.MapPath("~/Content"), "\\images\\portraits");
                if (!System.IO.Directory.Exists(dicPath)) { System.IO.Directory.CreateDirectory(dicPath); }

                //保存用户列表上传图片路径
                string UserPath = string.Concat(context.Server.MapPath("~/Content"), "\\images\\UserImg");
                if (!System.IO.Directory.Exists(UserPath)) { System.IO.Directory.CreateDirectory(UserPath); }

                if (type == "Upload")
                {
                    if (string.IsNullOrEmpty(userId) || int.Parse(userId) < 1)
                        throw new Exception("请先选择责任人！");

                    foreach (string strName in Directory.GetFiles(dicPath + "\\", userId + ".*"))
                    {
                        FileInfo delFile = new FileInfo(strName);

                        if (delFile.Attributes.ToString().IndexOf("ReadOnly") != -1)
                            delFile.Attributes = FileAttributes.Normal;

                        delFile.Delete();
                    }

                    HttpPostedFile file = context.Request.Files["Filedata"];

                    string newFilename = string.Concat(userId, System.IO.Path.GetExtension(context.Request["Filename"]));

                    file.SaveAs(string.Concat(dicPath, "\\", newFilename));

                    context.Response.Write(newFilename);
                }

                if (type == "Refresh")
                {
                    string filename = "default.png";

                    foreach (string strName in Directory.GetFiles(dicPath + "\\", userId + ".*"))
                    {
                        filename = Path.GetFileName(strName);
                        break;
                    }
                    context.Response.Write(filename);
                }

                if (type == "RefreshUser")
                {
                    string filename = "default.png";

                    foreach (string strName in Directory.GetFiles(UserPath + "\\", userId + ".*"))
                    {
                        filename = Path.GetFileName(strName);
                        break;
                    }
                    context.Response.Write(filename);
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}