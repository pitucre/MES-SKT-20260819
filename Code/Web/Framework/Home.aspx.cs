using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Threading;
using System.Text;
using System.Globalization;

using SKT.Common.Framework.BLL;
using SKT.Common.Framework.Model;
using SKT.LeanMES.Report.Model;
using System.IO;
using System.Text.RegularExpressions;
using System.Configuration;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Framework
{
    public partial class Home : Systems.Web.AccessPage
    {
        private Module module = new Module();
        private SKT.Common.Framework.BLL.Page page = new SKT.Common.Framework.BLL.Page();
        private List<ModuleInfo> moduleList = null;
        private List<PageInfo> pageList = null;


        protected void Page_Load(object sender, EventArgs e)
        {
            //验证Anti-Xsrf Token
            AntiXSRFHelper.VerifyToken(this.Page, hdnCsrfToken);

            hfMESLang.Value = Request.Cookies["lang"].Value;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AccountController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClient));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));


            if (!IsPostBack)
            {
                this.lblAppVersionName.Text = AppCode.Utility.GetAssemblyInfo.GetApplicationSoftwareName();
                this.lblAppVersion.Text = Resources.Common.ApplicationVersion + Resources.Common.Colon + AppCode.Utility.GetAssemblyInfo.GetApplicationVersion();
            }

            try
            {
                Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
                AppSettingsSection appseting = (AppSettingsSection)config.GetSection("appSettings");
                var logoPath = (appseting.Settings["CustomerLogo"] != null) ? appseting.Settings["CustomerLogo"].Value : "";
                this.hdnCustomerLogoPath.Value = logoPath;
            }
            catch (Exception ex)
            {
                throw ex;
            }

            StringBuilder leftMenuString = new StringBuilder();

            String subSystemName = "";
            String subSystemIcon = "";

            Int32 userId = AccountController.GetCurrentUser().UserId;

            SubSystem subSystem = new SubSystem();
            List<SubSystemInfo> subSystemList = subSystem.GetWarranttedSubSystems(userId);
            StringBuilder strTopMenu = new StringBuilder();
            strTopMenu.Append("<ul>");
            Int32 counter = 0;
            #region 子系统
            foreach (SubSystemInfo subSystemInfo in subSystemList)
            {
                /*Starry 2015/5/5过滤移动端模块*/
                /*Modify By Alen 2016-09-29过滤数据采集模块，不在系统后台显示*/
                if (subSystemInfo.Name == "LeanMES_Mobile" || subSystemInfo.Name == "LeanMES_Collection" || subSystemInfo.Name == "LeanMES_PDA") { continue; }

                subSystemName = (String)this.GetGlobalResourceObject("SubSystems", subSystemInfo.Name);
                if (counter == 0)
                {
                    strTopMenu.Append("<li class=\"iselected\" id=\"sub-" + subSystemInfo.Name + "\" title=\"" + subSystemName + "\" onclick=\"showTest(this,'" + subSystemInfo.Name + "','" + subSystemName + "')\"><span class=\"topmenutext\">" + subSystemName + "</span></li>");
                    this.lbTopMenuHeader.Text = subSystemName;
                    this.lbTopMenuHeader.ToolTip = subSystemName;
                }
                else
                {
                    strTopMenu.Append("<li id=\"sub-" + subSystemInfo.Name + "\" title=\"" + subSystemName + "\" onclick=\"showTest(this,'" + subSystemInfo.Name + "','" + subSystemName + "')\"><span class=\"topmenutext\">" + subSystemName + "</span></li>");
                    //    strTopMenu.Append("<li id=\"sub-" + subSystemInfo.Name + "\" title=\"" + subSystemName + "\" onclick=\"showMenu(this,'" + subSystemInfo.Name + "','" + subSystemName + "')\"><span class=\"topmenutext\">" + subSystemName + "</span></li>");
                }


                if (counter == 0)
                {
                    leftMenuString.Append("<div class=\"menugroup\" id=\"menugroup" + subSystemInfo.Name.ToString() + "\"><ul>");
                }
                else
                {
                    leftMenuString.Append("<div class=\"menugroup\" style=\"display:none;\" id=\"menugroup" + subSystemInfo.Name.ToString() + "\"><ul>");
                }

                leftMenuString.Append("<ul id=\"" + subSystemInfo.Name + "\" style=\"display:none\">");
                //update by weixia on 2018.5.9
                /* string leftMenuContent = BuildMenuTree(userId, subSystemInfo.Name, subSystemIcon);
                 if (leftMenuContent == "")
                 {
                     leftMenuString.Append("<li style=\"text-align:center;\">--暂无模块--</li>");
                 }
                 else
                 {
                     leftMenuString.Append(leftMenuContent);
                 }*/

                leftMenuString.Append("</ul></div>");
                counter++;
            }
            #endregion
           // strTopMenu.Append("</ul>");
            this.llTopMenu.Text = strTopMenu.ToString();
            this.llLeftMenu.Text = String.IsNullOrEmpty(leftMenuString.ToString()) ? (String)this.GetGlobalResourceObject("Messages", "NotWarranttedToPage") : leftMenuString.ToString();
        }

        /// <summary>
        /// 加载系统菜单
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="subSystemName"></param>
        /// <param name="subSystemIcon"></param>
        /// <returns></returns>
        private string BuildMenuTree(Int32 userId, String subSystemName, String subSystemIcon)
        {
            String strOperateImageRoot = WebHelper.ImageRoot;

            StringBuilder strLeftMenu = new StringBuilder();
            //Add  by  weixia on 2015/5/30 如果是报表仔细通过，则从数据库中读取资源begin
            List<SKT.LeanMES.Report.Model.ReportInfo> reportInfo = null;

            if (subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom" || subSystemName.ToLower() == "leanmes_pda")
            {
                //判断当前语言
                string currentCulture = "zh-cn";
                HttpCookie cookieLang = new HttpCookie("lang");
                if (Request.Form["lang"] != null)
                {
                    String strlang = Request.Form["lang"];
                    currentCulture = strlang;
                }
                else if (Request.Cookies["lang"] != null)
                {
                    currentCulture = Request.Cookies["lang"].Value;
                }
                reportInfo = new SKT.LeanMES.Report.BLL.Report().GetModuleResources(userId, subSystemName, currentCulture);
            }
            //End

            ////得到模块
            if (subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban")
            {
                moduleList = new AjaxFramework().GetWarranttedModulesBySubSystem(userId, subSystemName);
            }
            else
            {
                moduleList = module.GetWarranttedModulesBySubSystem(userId, subSystemName);
            }



            String strModuleName = "";
            String strPageName = "";
            String strPageUrl = "";
            String strIcon = String.Empty;
            //模块
            foreach (ModuleInfo moduleInfo in moduleList)
            {
                if (moduleInfo.Popedom > 0)
                {
                    if (moduleInfo.Name.ToLower() != "client_scanner")
                    {
                        //Add By Alen 2015-01-13 如果是报表子系统，则资源文件从数据库中读取
                        if ((subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom" || subSystemName.ToLower() == "leanmes_pda") && moduleInfo.Flag != 0)
                        {
                            strModuleName = "";
                            foreach (ReportInfo r in reportInfo)
                            {
                                if (r.RTModuleName == moduleInfo.Name && r.RTResourcesType == 1)
                                {
                                    strModuleName = r.RTModuleCNValue;
                                    break;
                                }
                            }
                        }
                        else
                        {
                            strModuleName = (String)this.GetGlobalResourceObject("Modules", moduleInfo.Name);

                        }
                        strIcon = moduleInfo.Icon.Trim();
                        if (strIcon.Equals(String.Empty))
                        {
                            strIcon = strOperateImageRoot + "module.png";
                        }
                        else
                        {
                            if (strIcon.IndexOf(".") > 0)
                            {
                                strIcon = strOperateImageRoot + strIcon;
                            }
                            else
                            {
                                strIcon = strOperateImageRoot + "Icon/" + strIcon + ".png";
                            }
                        }
                        strLeftMenu.Append("<li title=\"" + strModuleName + "\" id=\"" + moduleInfo.Name + "\" class=\"leftmenu-group\">");
                        strLeftMenu.Append("<span class=\"leftmenu-group-item\">");
                        strLeftMenu.Append("<span class=\"leftmenu-group-item-icon\"><img src=\"" + strIcon + "\" /></span>");
                        strLeftMenu.Append("<span class=\"leftmenu-group-item-text\">" + strModuleName + "</span>");
                        strLeftMenu.Append("<span class=\"leftmenu-group-item-toggle\"></span>");
                        strLeftMenu.Append("</span>");
                        strLeftMenu.Append("<ul style=\"display:none\">");
                        //得到页面
                        if (subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban")
                        {
                            pageList = new AjaxFramework().GetWarranttedPagesByModule(userId, moduleInfo.Name, true);
                        }
                        else
                        {
                            pageList = page.GetWarranttedPagesByModule(userId, moduleInfo.Name, true);
                        }



                        if (pageList.Count == 0)
                        {
                            strLeftMenu.Append("<li  class=\"pagelink\">");
                            strLeftMenu.Append("<table width=\"198px\" cellspacing=\"0\" cellpadding=\"0\"><tr><td  width=\"15px\" align=\"right\"></td>");
                            strLeftMenu.Append("<td class=\"leftmenu-group-link-text\" align=\"left\" style=\"padding-left:18px;\">--您没有权限访问--</td>");
                            strLeftMenu.Append("</tr></table>");
                            strLeftMenu.Append("</li>");
                        }
                        else
                        {
                            //页面
                            foreach (PageInfo pageInfo in pageList)
                            {
                                strPageUrl = WebHelper.WebRoot + "/" + pageInfo.Url;
                                //add  by weixia on 2015.5.30 如果是报表子系统，则资源文件从数据库中取
                                if ((subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom"|| subSystemName.ToLower() == "leanmes_pda") && pageInfo.Flag != 0)
                                {
                                    strPageName = "";
                                    foreach (ReportInfo r in reportInfo)
                                    {
                                        if (r.RTModuleName == pageInfo.Name && r.RTResourcesType == 2)
                                        {
                                            strPageName = r.RTModuleCNValue;
                                            break;
                                        }
                                    }
                                }
                                else
                                {
                                    strPageName = (String)this.GetGlobalResourceObject("Pages", pageInfo.Name);
                                }
                                strIcon = pageInfo.Icon.Trim();

                                if (strIcon.Equals(String.Empty))
                                {
                                    strIcon = strOperateImageRoot + "page.png";
                                }
                                else
                                {
                                    if (strIcon.IndexOf(".") > 0)
                                    {
                                        strIcon = WebHelper.OperateImageRoot + strIcon;
                                    }
                                    else
                                    {
                                        strIcon = WebHelper.OperateImageRoot + strIcon + ".png";
                                    }
                                }
                                //Starry 2015.4.25
                                string onclick = "openTab(this,'" + strPageName + "','" + strPageUrl + "','" + pageInfo.Name + "','" + strIcon + "');";

                                strLeftMenu.Append("<li title=\"" + strPageName + "\" id=\"" + pageInfo.Name + "\" class=\"pagelink\" onmouseover=\"javascript:$(this).find('img[name]').css('visibility','visible');\" onmouseout=\"javascript:$(this).find('img[name]').css('visibility','hidden');\"  onclick=\"" + onclick + "\">");
                                strLeftMenu.Append("<table width=\"198px\" cellspacing=\"0\" cellpadding=\"0\"><tr><td  width=\"15px\" align=\"right\"><div class=\"leftmenu-group-link-icon\"><img src=\"" + strIcon + "\" width=\"16\" height=\"16\"/></div></td>");
                                //if (pageInfo.Name.Contains("List"))
                                //{
                                //    strPageUrl += "&doAction=openAdd";
                                //    onclick = "openTab(this,'" + strPageName + "','" + strPageUrl + "','" + pageInfo.Name + "','" + strIcon + "');";
                                //    strLeftMenu.Append("<td class=\"leftmenu-group-link-text\" align=\"left\">&nbsp;" + strPageName + AppendAddLink(onclick) + "</td>");
                                //}
                                //else
                                //{
                                //    strLeftMenu.Append("<td class=\"leftmenu-group-link-text\" align=\"left\">&nbsp;" + strPageName + "</td>");
                                //}
                                strLeftMenu.Append("<td class=\"leftmenu-group-link-text\" align=\"left\">&nbsp;" + strPageName + "</td>");
                                strLeftMenu.Append("</tr></table>");
                                strLeftMenu.Append("</li>");
                                //strLeftMenu.Append("<li class=\"pagelinkline\">.....................</li>");
                            }
                        }
                        strLeftMenu.Append("</ul>");
                        strLeftMenu.Append("</li>");
                    }
                }

            }

            return strLeftMenu.ToString();
        }


        /// <summary>
        /// Starry 2015.4.25 用于添加的快捷方式
        /// </summary>
        /// <returns></returns>
        protected String AppendAddLink(string onClick)
        {
            return "<img name='imgAdd' title='添加' style=\"position:absolute;right:12px;margin-top:5px;visibility:hidden;width:18px;height:18px;\"  src='" + SKT.LeanMES.Web.WebHelper.WebRoot + "/Content/images/icon/add.png' onclick=\"" + onClick + "\" />";
        }

        /// <summary>
        /// 设置页面语言
        /// </summary>
        protected override void InitializeCulture()
        {
            HttpCookie cookieLang = new HttpCookie("lang");
            if (Request.Form["lang"] != null)
            {
                String strlang = Request.Form["lang"];
                cookieLang.Value = strlang;
                Response.Cookies.Add(cookieLang);
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(strlang);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(strlang);
            }
            else if (Request.Cookies["lang"] != null)
            {
                cookieLang = Request.Cookies["lang"];
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(cookieLang.Value);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(cookieLang.Value);
            }
            else
            {
                cookieLang.Value = "zh-cn";
                Response.Cookies.Add(cookieLang);
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("zh-cn");
                Thread.CurrentThread.CurrentUICulture = new CultureInfo("zh-cn");
            }
            base.InitializeCulture();
        }


        protected override void Render(HtmlTextWriter writer)
        {
            StringWriter sw = new StringWriter();
            HtmlTextWriter htmlWriter = new HtmlTextWriter(sw);
            base.Render(htmlWriter);
            string html = sw.ToString();
            html = html.Replace("//<![CDATA[", "");
            html = html.Replace("//]]>", "");
            html = Regex.Replace(html, "[\f\n\r\t\v]", "");
            html = Regex.Replace(html, " {2,}", " ");
            html = Regex.Replace(html, ">[ ]{1}", ">");
            writer.Write(html);
        }
    }
}