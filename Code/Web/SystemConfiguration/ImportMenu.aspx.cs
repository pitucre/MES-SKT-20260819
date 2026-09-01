using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using System.Web.UI.HtmlControls;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;
using SKT.Common.Framework.Model;
using SKT.Common.Framework.BLL;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Report.Model;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class ImportMenu : BasePage
    {
        Boolean isSupper = false;
        public string IsGroup = "0";
        public string ConnStr = "";
        SubSystemGroupSub groupSub = new SubSystemGroupSub();
        protected void Page_Load(object sender, EventArgs e)
        {
        
          //  SearchInfo();
            if (this.IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "search")
                {
                    MenuList.InnerHtml = SearchInfo2();

                }
            }
        }
        private Common.Framework.BLL.Module module = new Common.Framework.BLL.Module();
        private List<ModuleInfo> moduleList = null;
        private List<PageInfo> pageList = null;
        private SKT.Common.Framework.BLL.Page page = new SKT.Common.Framework.BLL.Page();
        List<SKT.LeanMES.Report.Model.ReportInfo> reportInfo = null;
        SubSystem subSystem = new SubSystem();

        ////查询信息：
        //String strModuleName = "";
        //String moduleName = "";
        //public string SearchInfo()
        //{
        //    string type = "1";
        //    string subSystemName = "";
        //    int i = 0;
        //    int j = 0;
        //    var k = 0;
        //    StringBuilder sb = new StringBuilder();
        //    sb.Append("<table class=\"ListTable\" width=\"100%\" id=\"table1\" border=\"1\">");
        //    sb.Append("<tr class=\"ListTableHeader\"><th>系统模块</th><th>功能模块</th><th>一级菜单</th></tr>");
        //    if (type == "1")
        //    {
        //        string searchType = ddlSearch.SelectedValue;

        //        List<SubSystemInfo> subSystemList = subSystem.GetWarranttedSubSystems(-1);

        //        foreach (SubSystemInfo subSystemInfo in subSystemList)
        //        {
        //            if (searchType != "-1")
        //            {
        //                if (subSystemInfo.Name != searchType)
        //                {
        //                    continue;
        //                }
        //            }

        //            subSystemName = (String)this.GetGlobalResourceObject("SubSystems", subSystemInfo.Name);
        //            if (subSystemInfo.Name.ToLower() == "leanmes_report" || subSystemInfo.Name.ToLower() == "leanmes_kanban")
        //            {
        //                reportInfo = new SKT.LeanMES.Report.BLL.Report().GetModuleResources(-1, subSystemInfo.Name, "zh-cn");
        //                moduleList = new AjaxFramework().GetWarranttedModulesBySubSystem(-1, subSystemInfo.Name);

        //            }
        //            else
        //            {
        //                moduleList = module.GetWarranttedModulesBySubSystem(-1, subSystemInfo.Name);
        //            }
        //            //查询系统模块
        //            i = 0;
        //            foreach (ModuleInfo moduleInfo in moduleList)
        //            {
        //                i = i + 1;
        //                if (moduleInfo.Popedom > 0)
        //                {
        //                    if (moduleInfo.Name.ToLower() != "client_scanner")
        //                    {
        //                        //Add By Alen 2015-01-13 如果是报表子系统，则资源文件从数据库中读取
        //                        if ((subSystemInfo.Name.ToLower() == "leanmes_report" || subSystemInfo.Name.ToLower() == "leanmes_kanban" || subSystemInfo.Name.ToLower() == "leanmes_custom" || subSystemInfo.Name.ToLower() == "leanmes_pda") && moduleInfo.Flag != 0)
        //                        {
        //                            strModuleName = "";
        //                            pageList = new AjaxFramework().GetWarranttedPagesByModule(-1, moduleInfo.Name, true);
        //                            foreach (ReportInfo r in reportInfo)
        //                            {
        //                                if (r.RTModuleName == moduleInfo.Name && r.RTResourcesType == 1)
        //                                {
        //                                    strModuleName = r.RTModuleCNValue;
        //                                    break;
        //                                }
        //                            }

        //                            j = 0;
        //                            foreach (PageInfo pageInfo in pageList)
        //                            {
        //                                j = j + 1;
        //                                foreach (ReportInfo r in reportInfo)
        //                                {

        //                                    if (r.RTModuleName == pageInfo.Name && r.RTResourcesType == 2)
        //                                    {
        //                                        moduleName = r.RTModuleCNValue;

        //                                        sb.Append("<tr class ='ListTableEvenRow'><td>" + subSystemName + "</td><td>" + i + "." + strModuleName + "</td><td>" + j + "." + moduleName + "" + "</td></tr>");
        //                                        break;
        //                                    }
        //                                }
        //                            }

        //                        }
        //                        else
        //                        {
        //                            strModuleName = (String)this.GetGlobalResourceObject("Modules", moduleInfo.Name);
        //                            pageList = page.GetWarranttedPagesByModule(-1, moduleInfo.Name, true);
        //                            j = 0;
        //                            foreach (PageInfo pageInfo in pageList)
        //                            {
        //                                j = j + 1;
        //                                moduleName = (String)this.GetGlobalResourceObject("Pages", pageInfo.Name);

        //                                sb.Append("<tr class ='ListTableEvenRow'><td>" + subSystemName + "</td><td>" + i + "." + strModuleName + "</td><td>" + j + "." + moduleName + "" + "</td></tr>");
        //                            }
        //                        }
        //                    }
        //                }

        //            }
        //        }
        //    }
        //    sb.Append("</table >");
        //    return sb.ToString();
        //}


        private string subSystemName = string.Empty;
        private string subSystemNameCh = string.Empty;
        private string subModulesName = string.Empty;
        private string subModulesNameCh = string.Empty;
        private string pageName = string.Empty;
        private string pageNameCh = string.Empty;
        public string SearchInfo2()
        {
            SubSystem subSystem = new SubSystem();
            StringBuilder sb = new StringBuilder();
            sb.Append("<table class=\"ListTable\" width=\"100%\" id=\"table1\" border=\"1\">");
            sb.Append("<tr class=\"ListTableHeader\"><th>系统模块</th><th>功能模块</th><th>一级菜单</th><th>功能按钮</th></tr>");

            List<SubSystemInfo> lstSubSystem = null;
            if (IsGroup == "1")
            {
                ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                lstSubSystem = groupSub.GetAll(ConnStr);
            }
            else
            {
                lstSubSystem = subSystem.GetAll();
            }
            string searchType = ddlSearch.SelectedValue;
            foreach (SubSystemInfo subSystemInfo in lstSubSystem)
            {
                if (searchType != "-1")
                {
                    if (subSystemInfo.Name != searchType)
                    {
                        continue;
                    }
                }
                subSystemName = subSystemInfo.Name;
                subSystemNameCh=(String)this.GetGlobalResourceObject("SubSystems", subSystemInfo.Name);
                this.ShowModules(subSystemInfo.Name, IsGroup, ref sb);
            }
            sb.Append("</table >");
            return sb.ToString();
        }

        /// <summary>
        /// 显示子系统下的模块。
        /// </summary>
        /// <param name="subSystem"></param>
        private void ShowModules(String subSystem, string IsGroup, ref StringBuilder sb)
        {
          
            Common.Framework.BLL.Module module = new Common.Framework.BLL.Module();

            List<ModuleInfo> lstModules = null;
            if (IsGroup == "1")
            {
                ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                lstModules = groupSub.GetBySubSystem(subSystem, ConnStr);
            }
            else
            {
                lstModules = module.GetBySubSystem(subSystem);
            }

            List<ReportInfo> reportInfo = null;
            if (subSystem.ToLower() == "leanmes_report" || subSystem.ToLower() == "leanmes_kanban" || subSystem.ToLower() == "leanmes_custom")
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
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                    reportInfo = groupSub.GetModuleResources(-1, subSystem, currentCulture, ConnStr);
                }
                else
                {
                    reportInfo = (new SKT.LeanMES.Report.BLL.Report()).GetModuleResources(-1, subSystem, currentCulture);
                }
            }
            foreach (ModuleInfo moduleInfo in lstModules)
            {
                subModulesName = moduleInfo.Name;
                if ((subSystem.ToLower() == "leanmes_report" || subSystem.ToLower() == "leanmes_kanban" || subSystem.ToLower() == "leanmes_custom") && moduleInfo.Flag != 0)
                {
                    foreach (ReportInfo r in reportInfo)
                    {
                        if (r.RTModuleName == moduleInfo.Name && r.RTResourcesType == 1)
                        {
                            subModulesNameCh = r.RTModuleCNValue;
                            break;
                        }
                    }
                }
                else
                {
                    subModulesNameCh = (String)this.GetGlobalResourceObject("Modules", moduleInfo.Name);
                }
             
                this.ShowPopedoms(subSystem, moduleInfo.Name, moduleInfo.Popedom, IsGroup, ref sb);
            }

        }


        /// <summary>
        /// 显示模块下的权限。
        /// </summary>
        /// <param name="moduleName">模块名。</param>
        /// <param name="popedomGroup">权限组。</param>
        private void ShowPopedoms(String subSystem, String moduleName, Int32 popedomGroup, string IsGroup ,ref StringBuilder sb)
        {


            pageList = page.GetWarranttedPagesByModule(-1, moduleName, true);
            Common.Account.BLL.Popedom popedom = new Common.Account.BLL.Popedom();
            List<PopedomInfo> lstPopedoms = null;
            if (IsGroup == "1")
            {
                ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                lstPopedoms = popedom.GetByPopedomGroup(popedomGroup, isSupper, ConnStr);
            }
            else
            {
                lstPopedoms = popedom.GetByPopedomGroup(popedomGroup, isSupper);
            }

            List<ReportInfo> reportInfo = null;
            if (subSystem.ToLower() == "leanmes_report" || subSystem.ToLower() == "leanmes_kanban" || subSystem.ToLower() == "leanmes_custom")
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
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                    reportInfo = groupSub.GetModuleResources(-1, moduleName, currentCulture, ConnStr);
                }
                else
                {
                    reportInfo = (new SKT.LeanMES.Report.BLL.Report()).GetModuleResources(-1, moduleName, currentCulture);
                }
            }
            string title, desc="";
            //如果登陆的是标准版或子账套 集团账套权限不要放出来
            string GroupVersion = Session["GroupVersion"].ToString();
            if (GroupVersion == "0" || GroupVersion == "2")
            {
                lstPopedoms.RemoveAll(p => { return p.Popedom == 10100400; });
                lstPopedoms.RemoveAll(p => { return p.Popedom == 20140205; });
                lstPopedoms.RemoveAll(p => { return p.Popedom == 10601000; });
                lstPopedoms.RemoveAll(p => { return p.Popedom == 10601001; });
                lstPopedoms.RemoveAll(p => { return p.Popedom == 10601002; });
                lstPopedoms.RemoveAll(p => { return p.Popedom == 10601003; });
                lstPopedoms.RemoveAll(p => { return p.Popedom == 10200105; });
                lstPopedoms.RemoveAll(p => { return p.Popedom == 20190116; });
                lstPopedoms.RemoveAll(p => { return p.Popedom == 30220305; });
                lstPopedoms.RemoveAll(p => { return p.Popedom == 20200105; });

            }

            foreach (PopedomInfo popedomInfo in lstPopedoms)
            {
               
                title = (String)this.GetGlobalResourceObject("Popedom", popedomInfo.Name);
                if (string.IsNullOrWhiteSpace(title) && popedomInfo.Popedom >= 100000000)
                    title = popedomInfo.Name;
                //var pageName2 =  pageList.Select(item=>item.Name=popedomInfo.Name);
                var pageName1 = from m in pageList where m.Name == popedomInfo.Name select m.Name;
                if (pageName1.Any())
                {
                    pageName = pageName1.First();
                }
                pageNameCh = (String)this.GetGlobalResourceObject("Popedom", pageName);

                if ((subSystem.ToLower() == "leanmes_report" || subSystem.ToLower() == "leanmes_kanban" || subSystem.ToLower() == "leanmes_custom") && popedomInfo.Flag != 0)
                {
                    foreach (ReportInfo r in reportInfo)
                    {
                        if (r.RTModuleName == popedomInfo.Name && r.RTResourcesType == 2)
                        {
                            desc = r.RTModuleCNValue;
                            break;
                        }
                    }
                }
                else
                {
                    desc = (String)this.GetGlobalResourceObject("Popedom", popedomInfo.Description);
                    if (string.IsNullOrWhiteSpace(desc) && popedomInfo.Popedom >= 100000000)
                        desc = popedomInfo.Description;
                   
                }
              
                sb.Append("<tr class ='ListTableEvenRow'><td>" + subSystemNameCh + "</td><td>" + subModulesNameCh + "</td><td>" + (string.IsNullOrEmpty(pageNameCh)? desc: pageNameCh) + "" + "</td><td>" + desc + "" + "</td></tr>");
            }
           
        }

    }
}