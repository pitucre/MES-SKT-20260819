using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;
using SKT.Common.Framework.BLL;
using SKT.Common.Framework.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Report.Model;
using System.Text;
using System.Globalization;
using System.Text.RegularExpressions;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// PopedomHandler 的摘要说明
    /// 权限分配优化 chenglong.zhu  2018-02-02
    /// </summary>
    public class PopedomHandler : BasePage, IHttpHandler, IRequiresSessionState
    {
        HttpResponse response;
        int id = -1;
        string currentCulture = "zh-cn";//默认中文
        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            response = context.Response;
            context.Response.ContentType = "text/plain";

            //获取当前语言
            if (context.Request.Form["lang"] != null)
            {
                currentCulture = context.Request.Form["lang"];
            }
            else if (context.Request.Cookies["lang"] != null)
            {
                currentCulture = context.Request.Cookies["lang"].Value;
            }

            id = Convert.ToInt32(context.Request["id"]);
            var type = context.Request["type"].ToString();

            switch (type)
            {
                case "Modules":
                    var subSystem = context.Request["name"].ToString();
                    ShowModules(subSystem);
                    break;
                case "Popedoms":
                    var subSystems = context.Request["subSystem"].ToString();
                    var Name = context.Request["Name"].ToString();
                    var Popedom = Convert.ToInt32(context.Request["Popedom"]);
                    ShowPopedoms(subSystems, Name, Popedom);
                    break;
                case "HomeModules":
                    var HomesubSystem = context.Request["name"].ToString();
                    var menuName = context.Request["menuName"].ToString();
                    var OrganizationName = context.Request["OrganizationName"].ToString();
                    BuildMenuTree(id, HomesubSystem, menuName, OrganizationName);
                    break;
                case "ModulesPopedom":
                    var module = context.Request["name"].ToString();
                    var system = context.Request["menuName"].ToString();
                    OrganizationName = context.Request["OrganizationName"].ToString();
                    showModulePopedom(id, module, system, OrganizationName);
                    break;
            }
        }
        /// <summary>
        /// 显示子系统下的模块。
        /// </summary>
        /// <param name="subSystem"></param>
        private void ShowModules(String subSystem)
        {
            HtmlTableRow row = null;
            HtmlTableCell cell = null;
            string html = "";
            Common.Framework.BLL.Module module = new Common.Framework.BLL.Module();

            List<ModuleInfo> lstModules = module.GetBySubSystem(subSystem);

            List<ReportInfo> reportInfo = null;
            if (subSystem.ToLower() == "leanmes_report" || subSystem.ToLower() == "leanmes_kanban" || subSystem.ToLower() == "leanmes_custom")
            {               
                reportInfo = (new SKT.LeanMES.Report.BLL.Report()).GetModuleResources(-1, subSystem, currentCulture);
            }
            foreach (ModuleInfo moduleInfo in lstModules)
            {
                row = new HtmlTableRow();

                row.Attributes["parent"] = subSystem;
                row.Attributes["name"] = moduleInfo.Name;
                row.Attributes["title"] = (String)HttpContext.GetGlobalResourceObject("Modules", moduleInfo.Name, new CultureInfo(currentCulture));  //(String)this.GetGlobalResourceObject("Modules", moduleInfo.Name);
                row.Height = "25";
                row.BgColor = "#FFFFFF";


                html += "<tr title=" + row.Attributes["title"] + " parent='" + subSystem + "' name='" + moduleInfo.Name + "' height='25' bgcolor='#FFFFFF'  popedom =" + moduleInfo.Popedom + ">";

                cell = new HtmlTableCell();
                cell.InnerHtml = "<input type='checkbox' name='popedomB' value='" + moduleInfo.Popedom + "'" + GetRolePopedom(moduleInfo.Popedom) + " onclick='setPopedom(this, 0," + moduleInfo.Popedom + ")'>";
                cell.Width = "15";
                row.Cells.Add(cell);
                html += "<td style='width:15px'>" + cell.InnerHtml.ToString() + "</td>";
                cell = new HtmlTableCell();
                if ((subSystem.ToLower() == "leanmes_report" || subSystem.ToLower() == "leanmes_kanban" || subSystem.ToLower() == "leanmes_custom") && moduleInfo.Flag != 0)
                {
                    foreach (ReportInfo r in reportInfo)
                    {
                        if (r.RTModuleName == moduleInfo.Name && r.RTResourcesType == 1)
                        {
                            cell.InnerHtml = "<div style='cursor: pointer;width:85%;' onclick=\"switchModule('" + subSystem + "," + moduleInfo.Name + "," + moduleInfo.Popedom + "')\">" +
                        r.RTModuleCNValue + "</div>";
                            break;
                        }
                    }
                }
                else
                {
                    cell.InnerHtml = "<div style='cursor: pointer;width:85%;' onclick=\"switchModule('" + subSystem + "," + moduleInfo.Name + "," + moduleInfo.Popedom + "')\">" +
                        (String)HttpContext.GetGlobalResourceObject("Modules", moduleInfo.Name, new CultureInfo(currentCulture)) + "</div>";
                }
                row.Cells.Add(cell);
                html += "<td>" + cell.InnerHtml.ToString() + "</td>";

                cell = new HtmlTableCell();
                cell.InnerHtml = "<img src=\"" +
                    WebHelper.ImageRoot + "Icon\\group.png\" style=\"cursor: pointer;\" onclick=\"showPopedomUsers(" + moduleInfo.Popedom + ")\">&nbsp;" +
                "<img src=\"" + WebHelper.ImageRoot + "Icon\\exporttoexcel.png\" style=\"cursor: pointer;\" onclick=\"exportPopedomUsers('" +
                Resources.Common.Modules + ": " + (String)HttpContext.GetGlobalResourceObject("Modules", moduleInfo.Name, new CultureInfo(currentCulture)) + "'," + moduleInfo.Popedom + ")\">";
                cell.Width = "50";
                html += "<td style='width:50px'>" + cell.InnerHtml.ToString() + "</td></tr>";
                row.Cells.Add(cell);

                row.Style.Add("display", "none");
            }
            response.Write(html);

        }
        /// <summary>
        /// 显示模块下的权限。
        /// </summary>
        /// <param name="moduleName">模块名。</param>
        /// <param name="popedomGroup">权限组。</param>
        private void ShowPopedoms(String subSystem, String moduleName, Int32 popedomGroup)
        {
            HtmlTableRow row = null;
            HtmlTableCell cell = null;
            string html = "";
            Common.Account.BLL.Popedom popedom = new Common.Account.BLL.Popedom();
            List<PopedomInfo> lstPopedoms = popedom.GetByPopedomGroup(popedomGroup, false);

            List<ReportInfo> reportInfo = null;
            if (subSystem.ToLower() == "leanmes_report" || subSystem.ToLower() == "leanmes_kanban" || subSystem.ToLower() == "leanmes_custom")
            {
                reportInfo = (new SKT.LeanMES.Report.BLL.Report()).GetModuleResources(-1, moduleName, currentCulture);
            }
            foreach (PopedomInfo popedomInfo in lstPopedoms)
            {
                row = new HtmlTableRow();
                row.Attributes["parent"] = moduleName;
                row.Attributes["name"] = popedomInfo.Name;
                row.Attributes["title"] = (String)HttpContext.GetGlobalResourceObject("Popedom", popedomInfo.Name, new CultureInfo(currentCulture));
                row.Height = "25";
                row.BgColor = "#FFFFFF";

                html += "<tr title=" + row.Attributes["title"] + " parent='" + moduleName + "' name='" + popedomInfo.Name + "' height='25' bgcolor='#FFFFFF' popedom =" + popedomInfo.Popedom + ">";

                cell = new HtmlTableCell();
                cell.InnerHtml = "<input type='checkbox' name='popedomC' value='" + popedomInfo.Popedom + "'" + GetRolePopedom(popedomInfo.Popedom) + " onclick='setPopedom(this, 1," + popedomInfo.Popedom + ")'>";
                cell.Width = "15";
                row.Cells.Add(cell);
                html += "<td style='width:15px'>" + cell.InnerHtml.ToString() + "</td>";
                cell = new HtmlTableCell();
                if ((subSystem.ToLower() == "leanmes_report" || subSystem.ToLower() == "leanmes_kanban") && popedomInfo.Flag != 0)
                {
                    foreach (ReportInfo r in reportInfo)
                    {
                        if (r.RTModuleName == popedomInfo.Name && r.RTResourcesType == 2)
                        {
                            cell.InnerHtml = "<div style='cursor: pointer;width:85%;' title='" + r.RTModuleCNValue + "'>" + r.RTModuleCNValue + "</div>";
                            break;
                        }
                    }
                }
                else
                {
                    cell.InnerHtml = "<div style='cursor: pointer;width:85%;' title='" + (String)HttpContext.GetGlobalResourceObject("Popedom", popedomInfo.Description, new CultureInfo(currentCulture)) + "'>" + (String)HttpContext.GetGlobalResourceObject("Popedom", popedomInfo.Description, new CultureInfo(currentCulture)) + "</div>";
                }
                row.Cells.Add(cell);
                html += "<td>" + cell.InnerHtml.ToString() + "</td>";
                cell = new HtmlTableCell();

                cell.InnerHtml = "<img src=\"" +
                WebHelper.ImageRoot + "Icon\\group.png\" style=\"cursor: pointer;\" onclick=\"showPopedomUsers(" + popedomInfo.Popedom + ")\">&nbsp;" +
                "<img src=\"" + WebHelper.ImageRoot + "Icon\\exporttoexcel.png\" style=\"cursor: pointer;\" onclick=\"exportPopedomUsers('" +
                Resources.Common.Popedoms + ": " + (String)HttpContext.GetGlobalResourceObject("Popedom", popedomInfo.Name, new CultureInfo(currentCulture)) + "'," + popedomInfo.Popedom + ")\">";
                cell.Width = "50";
                row.Cells.Add(cell);
                html += "<td style='width:50px'>" + cell.InnerHtml.ToString() + "</td></tr>";
                row.Style.Add("display", "none");
                //this.tblPopedoms.Rows.Add(row);
            }
            response.Write(html);
        }



        /// <summary>
        /// 加载系统菜单
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="subSystemName"></param>
        /// <param name="subSystemIcon"></param>
        /// <returns></returns>
        private List<ModuleInfo> moduleList = null;
        private Module module = new Module();
        private List<PageInfo> pageList = null;
        private SKT.Common.Framework.BLL.Page page = new SKT.Common.Framework.BLL.Page();
        private void BuildMenuTree(Int32 userId, String subSystemName, String subSystemIcon, String OrganizationName)
        {
            String strOperateImageRoot = WebHelper.ImageRoot;

            //   StringBuilder strLeftMenu = new StringBuilder();
            string strLeftMenu = "";
            //Add  by  weixia on 2015/5/30 如果是报表仔细通过，则从数据库中读取资源begin
            List<SKT.LeanMES.Report.Model.ReportInfo> reportInfo = null;

            if (subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom")
            {
                reportInfo = new SKT.LeanMES.Report.BLL.Report().GetModuleResources(userId, subSystemName, currentCulture);
            }
            //End

            //得到模块
            moduleList = module.GetWarranttedModulesBySubSystem(userId, subSystemName);
            //子账套不能有加载集团菜单 by liwen 2020.11.09
            if (OrganizationName == "null"||OrganizationName.Trim() != "集团总部")
            {
                //moduleList.RemoveAll(p => { return p.Popedom == 12000000; });
                moduleList.RemoveAll(p => { return p.Popedom == 10601000; });
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
                        if ((subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom") && moduleInfo.Flag != 0)
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
                            //strModuleName = (String)this.GetGlobalResourceObject("Modules", moduleInfo.Name);
                            strModuleName = (String)HttpContext.GetGlobalResourceObject("Modules", moduleInfo.Name, new CultureInfo(currentCulture));

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
                        strLeftMenu += "<li title=\"" + strModuleName + "\" id=\"" + moduleInfo.Name + "\" class=\"leftmenu-group\"  onclick=\"showPageList(this,'" + moduleInfo.Name + "','" + strModuleName + "')\" >";
                        // strLeftMenu += "<li title=\"" + strModuleName + "\" id=\"" + moduleInfo.Name + "\" class=\"leftmenu-group\" style='border:1px solid Red;' onclick='javascript:alert('a1');' >";
                        strLeftMenu += "<span class=\"leftmenu-group-item\">";
                        strLeftMenu += "<span class=\"leftmenu-group-item-icon\"><img src=\"" + strIcon + "\" /></span>";
                        strLeftMenu += "<span class=\"leftmenu-group-item-text\"><mesLang>" + strModuleName + "</mesLang></span>";
                        strLeftMenu += "<span class=\"leftmenu-group-item-toggle\"></span>";
                        strLeftMenu += "</span>";
                        //  strLeftMenu += "<ul id=\"" + moduleInfo.Name + "\" >";
                        // strLeftMenu.Append("<li title=\"" + strModuleName + "\" id=\"" + moduleInfo.Name + "\" class=\"leftmenu-group\">");
                        // strLeftMenu.Append("<span class=\"leftmenu-group-item\">");
                        //  strLeftMenu.Append("<span class=\"leftmenu-group-item-icon\"><img src=\"" + strIcon + "\" /></span>");
                        // strLeftMenu.Append("<span class=\"leftmenu-group-item-text\">" + strModuleName + "</span>");
                        //   strLeftMenu.Append("<span class=\"leftmenu-group-item-toggle\"></span>");
                        //  strLeftMenu.Append("</span>");
                        //  strLeftMenu.Append("<ul style=\"display:none\">");
                        //得到页面
                        /* pageList = page.GetWarranttedPagesByModule(userId, moduleInfo.Name, true);
                          if (pageList.Count == 0)
                          {
                              strLeftMenu += "<li  class=\"pagelink\">";
                              strLeftMenu += "<table width=\"198px\" cellspacing=\"0\" cellpadding=\"0\"><tr><td  width=\"15px\" align=\"right\"></td>";
                              strLeftMenu += "<td class=\"leftmenu-group-link-text\" align=\"left\" style=\"padding-left:18px;\">--您没有权限访问--</td>";
                              strLeftMenu += "</tr></table>";
                              strLeftMenu += "</li>";
                              //   strLeftMenu.Append("<li  class=\"pagelink\">");
                              //   strLeftMenu.Append("<table width=\"198px\" cellspacing=\"0\" cellpadding=\"0\"><tr><td  width=\"15px\" align=\"right\"></td>");
                              //   strLeftMenu.Append("<td class=\"leftmenu-group-link-text\" align=\"left\" style=\"padding-left:18px;\">--您没有权限访问--</td>");
                              //    strLeftMenu.Append("</tr></table>");
                              //   strLeftMenu.Append("</li>");
                          }
                          else
                          {
                              //页面
                              foreach (PageInfo pageInfo in pageList)
                              {
                                  strPageUrl = WebHelper.WebRoot + "/" + pageInfo.Url;
                                  //add  by weixia on 2015.5.30 如果是报表子系统，则资源文件从数据库中取
                                  if ((subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban") && pageInfo.Flag != 0)
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
                                  strLeftMenu += "<li title=\"" + strPageName + "\" id=\"" + pageInfo.Name + "\" class=\"pagelink\" onmouseover=\"javascript:$(this).find('img[name]').css('visibility','visible');\" onmouseout=\"javascript:$(this).find('img[name]').css('visibility','hidden');\"  onclick=\"" + onclick + "\">";
                                  strLeftMenu += "<table width=\"198px\" cellspacing=\"0\" cellpadding=\"0\"><tr><td  width=\"15px\" align=\"right\"><div class=\"leftmenu-group-link-icon\"><img src=\"" + strIcon + "\" width=\"16\" height=\"16\"/></div></td>";
                                  //   strLeftMenu.Append("<li title=\"" + strPageName + "\" id=\"" + pageInfo.Name + "\" class=\"pagelink\" onmouseover=\"javascript:$(this).find('img[name]').css('visibility','visible');\" onmouseout=\"javascript:$(this).find('img[name]').css('visibility','hidden');\"  onclick=\"" + onclick + "\">");
                                  //    strLeftMenu.Append("<table width=\"198px\" cellspacing=\"0\" cellpadding=\"0\"><tr><td  width=\"15px\" align=\"right\"><div class=\"leftmenu-group-link-icon\"><img src=\"" + strIcon + "\" width=\"16\" height=\"16\"/></div></td>");
                                  if (pageInfo.Name.Contains("List"))
                                  {
                                      strPageUrl += "&doAction=openAdd";
                                      onclick = "openTab(this,'" + strPageName + "','" + strPageUrl + "','" + pageInfo.Name + "','" + strIcon + "');";
                                      strLeftMenu += "<td class=\"leftmenu-group-link-text\" align=\"left\">&nbsp;" + strPageName + AppendAddLink(onclick) + "</td>";
                                      //      strLeftMenu.Append("<td class=\"leftmenu-group-link-text\" align=\"left\">&nbsp;" + strPageName + AppendAddLink(onclick) + "</td>");
                                  }
                                  else
                                  {
                                      //     strLeftMenu.Append("<td class=\"leftmenu-group-link-text\" align=\"left\">&nbsp;" + strPageName + "</td>");
                                  }
                                  strLeftMenu += "</tr></table>";
                                  strLeftMenu += "</li>";
                                  //  strLeftMenu.Append("</tr></table>");
                                  //  strLeftMenu.Append("</li>");
                                  //strLeftMenu.Append("<li class=\"pagelinkline\">.....................</li>");
                              }
                          } 
                          */
                        strLeftMenu += "<ul id=\"" + moduleInfo.Name + "S\" style=\"display:none\"></ul>";
                        strLeftMenu += "</li>";


                        // strLeftMenu.Append("</ul>");
                        //  strLeftMenu.Append("</li>");
                    }
                }

            }
            if (strLeftMenu == "")
            {
                strLeftMenu += "<li style=\"text-align:center;\">--暂无模块--</li>";
            }
            response.Write(strLeftMenu);
            // return strLeftMenu.ToString();
        }


        //显示模块下面的页面信息
        private void showModulePopedom(Int32 userId, String moduleName, String subSystemName, String OrganizationName)
        {
            String strOperateImageRoot = WebHelper.ImageRoot;
            String strModuleName = "";
            String strPageName = "";
            String strPageUrl = "";
            String strIcon = String.Empty;
            string strLeftMenu = "";
            pageList = page.GetWarranttedPagesByModule(userId, moduleName, true);
            List<SKT.LeanMES.Report.Model.ReportInfo> reportInfo = null;
            //子账套不能有加载集团菜单 by liwen 2020.11.09
            if (OrganizationName == "null"||OrganizationName.Trim() != "集团总部")
            {
                pageList.RemoveAll(p => { return p.Popedom == 10601000; });
                pageList.RemoveAll(p => { return p.Popedom == 10100400; });
                pageList.RemoveAll(p => { return p.Popedom == 10200105; });
                //子账套不显示 全局参数配置
                //pageList.RemoveAll(p => { return p.Popedom == 10600100; });
            }
            reportInfo = new SKT.LeanMES.Report.BLL.Report().GetModuleResources(userId, subSystemName, currentCulture);
            if (pageList.Count == 0)
            {

                strLeftMenu += "<li  class=\"pagelink\" >";
                strLeftMenu += "<table width=\"198px\" cellspacing=\"0\" cellpadding=\"0\"><tr><td  width=\"15px\" align=\"right\"></td>";
                strLeftMenu += "<td class=\"leftmenu-group-link-text\" align=\"left\" style=\"padding-left:18px;\">--您没有权限访问--</td>";
                strLeftMenu += "</tr></table>";
                strLeftMenu += "</li>";
            }
            else
            {
                //页面
                foreach (PageInfo pageInfo in pageList)
                {
                    strPageUrl = WebHelper.WebRoot + "/" + pageInfo.Url;
                    //add  by weixia on 2015.5.30 如果是报表子系统，则资源文件从数据库中取
                    if ((subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom") && pageInfo.Flag != 0)
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
                        //strPageName = (String)this.GetGlobalResourceObject("Pages", pageInfo.Name);
                        strPageName = (String)HttpContext.GetGlobalResourceObject("Pages", pageInfo.Name, new CultureInfo(currentCulture));
                    }
                    //by liwen 如果是二开配置的不走资源文件配置
                    if (IsGuidByReg(pageInfo.Name) == true)
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
                    string onclick = "openTab(this,'" + strPageName + "','" + strPageUrl + "','" + pageInfo.Name + "','" + strIcon + "');event.stopPropagation();";

                    strLeftMenu += "<li title=\"" + strPageName + "\" id=\"" + pageInfo.Name + "\" class=\"pagelink\" onmouseover=\"javascript:$(this).find('img[name]').css('visibility','visible');\" onmouseout=\"javascript:$(this).find('img[name]').css('visibility','hidden');\"  onclick=\"" + onclick + "\">";
                    strLeftMenu += "<table width=\"198px\" cellspacing=\"0\" cellpadding=\"0\"><tr><td  width=\"15px\" align=\"right\"><div class=\"leftmenu-group-link-icon\"><img src=\"" + strIcon + "\" width=\"16\" height=\"16\"/></div></td>";
                    //if (pageInfo.Name.Contains("List"))//by liwen 20200716|| IsGuidByReg(pageInfo.Name)==true
                    //{
                    //    strPageUrl += "&doAction=openAdd";
                    //    onclick = "openTab(this,'" + strPageName + "','" + strPageUrl + "','" + pageInfo.Name + "','" + strIcon + "');event.stopPropagation();";
                    //    strLeftMenu += "<td class=\"leftmenu-group-link-text\" align=\"left\"><mesLang>" + strPageName + "</mesLang>" + AppendAddLink(onclick) + "</td>";
                    //}
                    //else
                    //{
                    //    strLeftMenu += "<td class=\"leftmenu-group-link-text\" align=\"left\"><mesLang>" + strPageName + "</mesLang></td>";
                    //}
                    strLeftMenu += "<td class=\"leftmenu-group-link-text\" align=\"left\"><mesLang>" + strPageName + "</mesLang></td>";
                    strLeftMenu += "</tr></table>";
                    strLeftMenu += "</li>";
                    //strLeftMenu.Append("<li class=\"pagelinkline\">.....................</li>");
                }
            }
            response.Write(strLeftMenu);
        }
        protected bool IsGuidByReg(string strSrc)
        {
            Regex reg = new Regex("^[A-F0-9]{8}(-[A-F0-9]{4}){3}-[A-F0-9]{12}$", RegexOptions.Compiled);
            return reg.IsMatch(strSrc);
        }

        protected String AppendAddLink(string onClick)
        {
            return "<img name='imgAdd' title='添加' style=\"position:absolute;right:12px;margin-top:5px;visibility:hidden;width:18px;height:18px;\"  src='" + SKT.LeanMES.Web.WebHelper.WebRoot + "/Content/images/icon/add.png' onclick=\"" + onClick + "\" />";
        }

        /// <summary>
        /// 获取组已经存在的权限
        /// </summary>
        /// <param name="popedom"></param>
        /// <returns></returns>
        private string GetRolePopedom(Int32 popedom)
        {
            string checkString = "";

            Common.Account.BLL.Role role = new Common.Account.BLL.Role();
            List<RoleInfo> lstRolePopedom = role.GetPopedomByRoleId(id);

            foreach (RoleInfo roleInfo in lstRolePopedom)
            {
                if (popedom == roleInfo.Popedom)
                {
                    checkString = " checked='true'";
                    break;
                }
            }
            return checkString;
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