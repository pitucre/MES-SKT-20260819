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
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Popedom
{
    public partial class AssignPopedom : BasePage,IRequiresSessionState
    {
        Boolean isSupper = false;

        Common.Account.BLL.Role roleBll = new Common.Account.BLL.Role();
        SubSystemGroupSub groupSub = new SubSystemGroupSub();

        List<RoleInfo> lstRolePopedom = null;
        RoleInfo roleInfo = null;
        string ConnStr = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string IsGroup = Request.QueryString["IsGroup"];
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAccount));
            if (!Page.IsPostBack)
            {
                Common.Account.BLL.Role role = new Common.Account.BLL.Role();
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                    roleInfo = role.GetInfo(int.Parse(Request.QueryString["ID"]), ConnStr);
                }
                else {
                    roleInfo = role.GetInfo(int.Parse(Request.QueryString["ID"]));
                }
                lblRoleName.Text = roleInfo.RoleName;
                lblDescription.Text = roleInfo.Description;
                this.ShowSubSystems(IsGroup);
            }
        }


        /// <summary>
        /// 显示子系统。
        /// </summary>
        private void ShowSubSystems(string IsGroup)
        {
            HtmlTableRow row = null;
            HtmlTableCell cell = null;

            SubSystem subSystem = new SubSystem();
            

            List<SubSystemInfo> lstSubSystem = null;
            if (IsGroup == "1")
            {
                ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                lstSubSystem = groupSub.GetAll(ConnStr);
            }
            else {
                lstSubSystem = subSystem.GetAll();
            }

            foreach (SubSystemInfo subSystemInfo in lstSubSystem)
            {
                row = new HtmlTableRow();
                row.Attributes["name"] = subSystemInfo.Name;
                row.Attributes["title"] = (String)this.GetGlobalResourceObject("SubSystems", subSystemInfo.Name);
                row.Height = "25";
                row.BgColor = "#FFFFFF";

                cell = new HtmlTableCell();
                cell.InnerHtml = "<input type='checkbox' name='popedom' value='" + subSystemInfo.Popedom + "'" + GetRolePopedom(subSystemInfo.Popedom,IsGroup) + ">";
                cell.Width = "15";
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                cell.InnerHtml = "<div class='mesLang' style='cursor: pointer;' onclick=\"switchSubSystem('" + subSystemInfo.Name + "')\">" +
                    this.GetGlobalResourceObject("SubSystems", subSystemInfo.Name) + "</div>";
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                //cell.InnerHtml = "<img src=\"" +
                //    WebHelper.ImageRoot + "Icon\\group.png\" style=\"cursor: pointer;\" title=\"查看用户\" onclick=\"showPopedomUsers(" + subSystemInfo.Popedom + ")\">&nbsp;" +
                //    "<img src=\"" + WebHelper.ImageRoot + "Icon\\exporttoexcel.png\" style=\"cursor: pointer;\" onclick=\"exportPopedomUsers('" +
                //    Resources.Common.SubSystems + ": " + this.GetGlobalResourceObject("SubSystems", subSystemInfo.Name) + "'," + subSystemInfo.Popedom + ")\">";

                cell.InnerHtml = "<img src=\"" +
                   WebHelper.ImageRoot + "Icon\\group.png\" style=\"cursor: pointer;\" title=\"查看用户\" onclick=\"showPopedomUsers(" + subSystemInfo.Popedom + ")\">";
                cell.Style.Add("text-align", "center");
                cell.Width = "50";
                row.Cells.Add(cell);

                this.tblSubSystems.Rows.Add(row);

                this.ShowModules(subSystemInfo.Name,IsGroup);
            }
        }

        /// <summary>
        /// 显示子系统下的模块。
        /// </summary>
        /// <param name="subSystem"></param>
        private void ShowModules(String subSystem, string IsGroup)
        {
            HtmlTableRow row = null;
            HtmlTableCell cell = null;

            Common.Framework.BLL.Module module = new Common.Framework.BLL.Module();

            List<ModuleInfo> lstModules = null;
            if (IsGroup == "1")
            {
                ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                lstModules = groupSub.GetBySubSystem(subSystem,ConnStr);
            }
            else
            {
                lstModules = module.GetBySubSystem(subSystem);
            }

            List<ReportInfo> reportInfo = null;
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
            foreach (ModuleInfo moduleInfo in lstModules)
            {
                row = new HtmlTableRow();
                row.Attributes["parent"] = subSystem;
                row.Attributes["name"] = moduleInfo.Name;
                row.Attributes["title"] = (String)this.GetGlobalResourceObject("Modules", moduleInfo.Name);
                row.Height = "25";
                row.BgColor = "#FFFFFF";

                cell = new HtmlTableCell();
                cell.InnerHtml = "<input type='checkbox' name='popedom' value='" + moduleInfo.Popedom + "'" + GetRolePopedom(moduleInfo.Popedom,IsGroup) + " onclick='setPopedom(this, 0)'>";
                cell.Width = "15";
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                //资源文件没有，从二开的菜单中获取描述
                string desc = (String)this.GetGlobalResourceObject("Modules", moduleInfo.Name);
                if (string.IsNullOrWhiteSpace(desc))
                {
                    foreach (ReportInfo r in reportInfo)
                    {
                        if (r.RTModuleName == moduleInfo.Name && r.RTResourcesType == 1)
                        {
                            desc = r.RTModuleCNValue;
                            break;
                        }
                    }
                }
                cell.InnerHtml = "<div class='mesLang' style='cursor: pointer;width:85%;' onclick=\"switchModule('" + moduleInfo.Name + "')\">" + desc + "</div>";
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                //cell.InnerHtml = "<img src=\"" +
                //    WebHelper.ImageRoot + "Icon\\group.png\" style=\"cursor: pointer;\" onclick=\"showPopedomUsers(" + moduleInfo.Popedom + ")\">&nbsp;" +
                //"<img src=\"" + WebHelper.ImageRoot + "Icon\\exporttoexcel.png\" style=\"cursor: pointer;\" onclick=\"exportPopedomUsers('" +
                //Resources.Common.Modules + ": " + this.GetGlobalResourceObject("Modules", moduleInfo.Name) + "'," + moduleInfo.Popedom + ")\">";

                cell.InnerHtml = "<img src=\"" +
                   WebHelper.ImageRoot + "Icon\\group.png\" style=\"cursor: pointer;\" onclick=\"showPopedomUsers(" + moduleInfo.Popedom + ")\">&nbsp;";
                cell.Style.Add("text-align", "center");
                cell.Width = "50";
                row.Cells.Add(cell);

                row.Style.Add("display", "none");
                this.tblModules.Rows.Add(row);

                this.ShowPopedoms(subSystem, moduleInfo.Name, moduleInfo.Popedom,IsGroup);
            }

        }

        /// <summary>
        /// 显示模块下的权限。
        /// </summary>
        /// <param name="moduleName">模块名。</param>
        /// <param name="popedomGroup">权限组。</param>
        private void ShowPopedoms(String subSystem, String moduleName, Int32 popedomGroup, string IsGroup)
        {
            HtmlTableRow row = null;
            HtmlTableCell cell = null;

            Common.Account.BLL.Popedom popedom = new Common.Account.BLL.Popedom();
            List<PopedomInfo> lstPopedoms = null;
            if (IsGroup == "1")
            {
                ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                lstPopedoms = popedom.GetByPopedomGroup(popedomGroup, isSupper, ConnStr);
            }
            else {
                lstPopedoms = popedom.GetByPopedomGroup(popedomGroup, isSupper);
            }

            List<ReportInfo> reportInfo = null;
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
            //如果登陆的是标准版或子账套 集团账套权限不要放出来
            string GroupVersion = Session["GroupVersion"].ToString();
            if (GroupVersion == "0"|| GroupVersion == "2") {
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
                row = new HtmlTableRow();
                row.Attributes["parent"] = moduleName;
                row.Attributes["name"] = popedomInfo.Name;
                string title = (String)this.GetGlobalResourceObject("Popedom", popedomInfo.Name);
                if (string.IsNullOrWhiteSpace(title) && popedomInfo.Popedom >= 100000000)
                    title = popedomInfo.Name;
                row.Attributes["title"] = title;
                row.Height = "25";
                row.BgColor = "#FFFFFF";

                cell = new HtmlTableCell();
                cell.InnerHtml = "<input type='checkbox' name='popedom' value='" + popedomInfo.Popedom + "'" + GetRolePopedom(popedomInfo.Popedom,IsGroup) + " onclick='setPopedom(this, 1)'>";
                cell.Width = "15";
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                string desc = (String)this.GetGlobalResourceObject("Popedom", popedomInfo.Description);
                //资源文件没有，从二开的菜单中获取描述
                if (string.IsNullOrWhiteSpace(desc))
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
                //如果没有取描述信息
                if (string.IsNullOrWhiteSpace(desc) && popedomInfo.Popedom >= 100000000)
                    desc = popedomInfo.Description;
                cell.InnerHtml = "<div class='mesLang' style='cursor: pointer;width:85%;' title='" + desc + "'>" + desc + "</div>";
                row.Cells.Add(cell);

                cell = new HtmlTableCell();

                //cell.InnerHtml = "<img src=\"" +
                //WebHelper.ImageRoot + "Icon\\group.png\" style=\"cursor: pointer;\" onclick=\"showPopedomUsers(" + popedomInfo.Popedom + ")\">&nbsp;" +
                //"<img src=\"" + WebHelper.ImageRoot + "Icon\\exporttoexcel.png\" style=\"cursor: pointer;\" onclick=\"exportPopedomUsers('" +
                //Resources.Common.Popedoms + ": " + this.GetGlobalResourceObject("Popedom", popedomInfo.Name) + "'," + popedomInfo.Popedom + ")\">";

                cell.InnerHtml = "<img src=\"" +
               WebHelper.ImageRoot + "Icon\\group.png\" style=\"cursor: pointer;\" onclick=\"showPopedomUsers(" + popedomInfo.Popedom + ")\">&nbsp;";
                cell.Style.Add("text-align", "center");
                cell.Width = "50";
                row.Cells.Add(cell);

                row.Style.Add("display", "none");
                this.tblPopedoms.Rows.Add(row);
            }
        }

        /// <summary>
        /// 获取组已经存在的权限
        /// </summary>
        /// <param name="popedom"></param>
        /// <returns></returns>
        private string GetRolePopedom(Int32 popedom,string IsGroup)
        {
            string checkString = "";
            //Common.Account.BLL.Role role = new Common.Account.BLL.Role();
            //List<RoleInfo> lstRolePopedom = role.GetPopedomByRoleId(Int32.Parse(Request.QueryString["ID"]));
            //foreach (RoleInfo roleInfo in lstRolePopedom)
            //{
            //    if (popedom == roleInfo.Popedom)
            //    {
            //        checkString = " checked='true'";
            //        break;
            //    }
            //}
            //return checkString;

            if (lstRolePopedom == null)
            {
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                    lstRolePopedom = roleBll.GetPopedomByRoleId(Int32.Parse(Request.QueryString["ID"]),ConnStr);
                }
                else {
                    lstRolePopedom = roleBll.GetPopedomByRoleId(Int32.Parse(Request.QueryString["ID"]));
                }
            }
            if (lstRolePopedom != null && lstRolePopedom.Any(p => p.Popedom == popedom))
            {
                checkString = " checked='true'";
            }
            return checkString;
        }
    }
}