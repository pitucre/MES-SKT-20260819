using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Text;
using System.IO;

namespace SKT.MES.Web.Help
{
    public partial class CreateMenus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        { 
            //指定上传文件在服务器上的保存路径
            string savePath = Server.MapPath("~/UploadFiles/menuxml");
            //判断是否上传了文件
            if (this.flupload.HasFile)
            {
               
                //检查服务器上是否存在这个物理路径，如果不存在则创建
                if (!System.IO.Directory.Exists(savePath))
                {
                    //需要注意的是，需要对这个物理路径有足够的权限，否则会报错
                    //另外，这个路径应该是在网站之下，而将网站部署在C盘却把文件保存在D盘
                    System.IO.Directory.CreateDirectory(savePath);
                }
                savePath = savePath + "\\" + flupload.FileName;
                flupload.SaveAs(savePath);//保存文件
            }
            string html = Import(savePath);
            #region 读取模板内容
            StringBuilder templateContent = new StringBuilder();
            //模板页面路径
            string templatePath = Server.MapPath("~/Help/Template/leftmenuTemplate.htm");
            if (!File.Exists(templatePath))
            {
                this.lblMessages.Text = "模板文件丢失或不存在！";
                return;
            }
            try
            {
                using (StreamReader sr = new StreamReader(templatePath,System.Text.Encoding.GetEncoding("GB2312")))
                {
                    string line = "";
                    while ((line = sr.ReadLine()) != null)
                    {
                        templateContent.Append(line);
                    }
                    sr.Close();
                }
            }
            catch (Exception ex)
            {
                this.lblMessages.Text = ex.Message.ToString();
                return;
            }
            #endregion

            #region 替换模板标签
            templateContent = templateContent.Replace("{treeview}", html);
            #endregion

            string genHtmlPath = Server.MapPath("~/Help/");

            #region 生成HTML文件
            try
            {
                using (StreamWriter sw = new StreamWriter(genHtmlPath + "leftmenu.htm", false, System.Text.Encoding.GetEncoding("GB2312")))
                {
                    sw.WriteLine(templateContent);
                    sw.Flush();
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                this.lblMessages.Text = ex.Message.ToString();
                return;
            }
            #endregion
            this.lblMessages.Text = "生成菜单成功！";
            Response.Redirect("~/Help/Help.htm");
        }

        private string Import(string menuFileName)
        {

            string str = string.Empty;
            try
            {
                XmlDocument document = new XmlDocument();
                document.Load(menuFileName);

                XmlNode documentElement = document.DocumentElement;

                string strs0 = "<ul id=\"browser\" class=\"filetree\">";
                string strs1 = "";
                string strs2 = "";
                string strs3 = "";
                foreach (XmlNode node3 in documentElement.SelectNodes("subSystem"))
                {
                    string str3 = node3.Attributes["name"].Value;
                    string str5 = node3.Attributes["sequence"].Value;
                    strs1 += "<li><span class=\"folder\">" + (String)this.GetGlobalResourceObject("SubSystems", str3) + "</span>";

                    strs2 = "";
                    foreach (XmlNode node4 in node3.SelectNodes("module"))
                    {
                        string str7 = node4.Attributes["name"].Value;
                        string str9 = node4.Attributes["sequence"].Value;
                        strs2 += "<li><span class=\"folder\">" + (String)this.GetGlobalResourceObject("Modules", str7) + "</span>";
                        strs3 = "";
                        foreach (XmlNode node6 in node4.SelectNodes("page"))
                        {
                            string str15 = null;
                            string str17 = node6.Attributes["url"].Value;
                            string str19 = node6.Attributes["sequence"].Value;
                            string[] strArray = str17.Split(new char[] { '?' });
                            string str20 = strArray[0];
                            if (strArray.Length > 1)
                            {
                                string str21 = strArray[1];
                                foreach (string str22 in str21.Split(new char[] { '&' }))
                                {
                                    if (str22.StartsWith("name="))
                                    {
                                        str15 = str22.Split(new char[] { '=' })[1];
                                        break;
                                    }
                                }
                            }
                            if (str15 == null)
                            {
                                str15 = str20.Substring(str20.LastIndexOf('/') + 1).Replace(".aspx", "");
                            }
                            string pagelink = str15 + ".htm";
                            if (!File.Exists(Server.MapPath("~/Help/Documents/" + pagelink)))
                            {

                                pagelink = "FileNotFound.htm";
                            }
                            else
                            {
                                pagelink = "Documents/" + pagelink;
                            }
                            if (!String.IsNullOrEmpty((String)this.GetGlobalResourceObject("Pages", str15)))
                            {
                                strs3 += "<li><span class=\"file\"><a id='" + pagelink.Replace(".htm", "").Replace("Documents/", "") + "' keyword='" + (String)this.GetGlobalResourceObject("Pages", str15) + "' href='" + pagelink + "' target='main' onclick=\"setCurrentPath('" + (String)this.GetGlobalResourceObject("SubSystems", str3) + " -> " + (String)this.GetGlobalResourceObject("Modules", str7) + " -> " + (String)this.GetGlobalResourceObject("Pages", str15) + "')\">" + (String)this.GetGlobalResourceObject("Pages", str15) + "</a></span></li>";
                            }
                        }
                        strs3 = "<ul id=\"folder21\">" + strs3 + "</ul>";
                        strs2 = strs2 + strs3 + "</li>";

                    }
                    strs2 = "<ul>" + strs2 + "</ul>";
                    strs1 = strs1 + strs2 + "</li>";
                }
                strs0 = strs0 + strs1 + "</ul>";
                return strs0;
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }

        }
    }
}