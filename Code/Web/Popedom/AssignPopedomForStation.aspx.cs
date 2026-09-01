using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Popedom
{
    public partial class AssignPopedomForStation : BasePage
    {
        Boolean isSupper = false;
        protected void Page_Load(object sender, EventArgs e)
        {/*
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAccount));
            if (!Page.IsPostBack)
            {
                Common.Account.BLL.Role role = new Common.Account.BLL.Role();
                RoleInfo roleInfo = role.GetInfo(int.Parse(Request.QueryString["ID"]));

                lblRoleName.Text = roleInfo.RoleName;
                lblDescription.Text = roleInfo.Description;
                this.ShowSubSystems();
            }*/
        }
        /*
        /// <summary>
        /// 显示子系统。
        /// </summary>
        private void ShowSubSystems()
        {
            HtmlTableRow row = null;
            HtmlTableCell cell = null;

            SubSystem subSystem = new SubSystem();

            List<SubSystemInfo> lstSubSystem = subSystem.GetAll();

            foreach (SubSystemInfo subSystemInfo in lstSubSystem)
            {
                row = new HtmlTableRow();
                row.Attributes["name"] = subSystemInfo.Name;
                row.Attributes["title"] = (String)this.GetGlobalResourceObject("SubSystems", subSystemInfo.Name);
                row.Height = "25";
                row.BgColor = "#FFFFFF";

                cell = new HtmlTableCell();
                cell.InnerHtml = "<input type='checkbox' name='popedom' value='" + subSystemInfo.Popedom + "'" + GetRolePopedom(subSystemInfo.Popedom) + ">";
                cell.Width = "15";
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                cell.InnerHtml = "<div style='cursor: pointer;' onclick=\"switchSubSystem('" + subSystemInfo.Name + "')\">" +
                    this.GetGlobalResourceObject("SubSystems", subSystemInfo.Name) + "</div>";
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                cell.InnerHtml = "<img src=\"" +
                    WebHelper.ImageRoot + "Icon\\group.png\" style=\"cursor: pointer;\" title=\"查看用户\" onclick=\"showPopedomUsers(" + subSystemInfo.Popedom + ")\">&nbsp;" +
                    "<img src=\"" + WebHelper.ImageRoot + "Icon\\exporttoexcel.png\" style=\"cursor: pointer;\" onclick=\"exportPopedomUsers('" +
                    Resources.Common.SubSystems + ": " + this.GetGlobalResourceObject("SubSystems", subSystemInfo.Name) + "'," + subSystemInfo.Popedom + ")\">";
                cell.Width = "50";
                row.Cells.Add(cell);

                this.tblSubSystems.Rows.Add(row);

                this.ShowModules(subSystemInfo.Name);
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

            Common.Framework.BLL.Module module = new Common.Framework.BLL.Module();

            List<ModuleInfo> lstModules = module.GetBySubSystem(subSystem);

            List<ReportInfo> reportInfo = null;
            if (subSystem.ToLower() == "leanmes_report")
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
                cell.InnerHtml = "<input type='checkbox' name='popedom' value='" + moduleInfo.Popedom + "'" + GetRolePopedom(moduleInfo.Popedom) + " onclick='setPopedom(this, 0)'>";
                cell.Width = "15";
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                if (subSystem.ToLower() == "leanmes_report" && moduleInfo.Flag != 0)
                {
                    foreach (ReportInfo r in reportInfo)
                    {
                        if (r.RTModuleName == moduleInfo.Name && r.RTResourcesType == 1)
                        {
                            cell.InnerHtml = "<div style='cursor: pointer;width:85%;' onclick=\"switchModule('" + moduleInfo.Name + "')\">" +
                        r.RTModuleCNValue + "</div>";
                            break;
                        }
                    }
                }
                else
                {
                    cell.InnerHtml = "<div style='cursor: pointer;width:85%;' onclick=\"switchModule('" + moduleInfo.Name + "')\">" +
                        this.GetGlobalResourceObject("Modules", moduleInfo.Name) + "</div>";
                }
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                cell.InnerHtml = "<img src=\"" +
                    WebHelper.ImageRoot + "Icon\\group.png\" style=\"cursor: pointer;\" onclick=\"showPopedomUsers(" + moduleInfo.Popedom + ")\">&nbsp;" +
                "<img src=\"" + WebHelper.ImageRoot + "Icon\\exporttoexcel.png\" style=\"cursor: pointer;\" onclick=\"exportPopedomUsers('" +
                Resources.Common.Modules + ": " + this.GetGlobalResourceObject("Modules", moduleInfo.Name) + "'," + moduleInfo.Popedom + ")\">";
                cell.Width = "50";
                row.Cells.Add(cell);

                row.Style.Add("display", "none");
                this.tblModules.Rows.Add(row);

                this.ShowPopedoms(subSystem, moduleInfo.Name, moduleInfo.Popedom);
            }

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

            Common.Account.BLL.Popedom popedom = new Common.Account.BLL.Popedom();
            List<PopedomInfo> lstPopedoms = popedom.GetByPopedomGroup(popedomGroup, isSupper);

            List<ReportInfo> reportInfo = null;
            if (subSystem.ToLower() == "leanmes_report")
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
                reportInfo = (new SKT.LeanMES.Report.BLL.Report()).GetModuleResources(-1, moduleName, currentCulture);
            }
            foreach (PopedomInfo popedomInfo in lstPopedoms)
            {
                row = new HtmlTableRow();
                row.Attributes["parent"] = moduleName;
                row.Attributes["name"] = popedomInfo.Name;
                row.Attributes["title"] = (String)this.GetGlobalResourceObject("Popedom", popedomInfo.Name);
                row.Height = "25";
                row.BgColor = "#FFFFFF";

                cell = new HtmlTableCell();
                cell.InnerHtml = "<input type='checkbox' name='popedom' value='" + popedomInfo.Popedom + "'" + GetRolePopedom(popedomInfo.Popedom) + " onclick='setPopedom(this, 1)'>";
                cell.Width = "15";
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                if (subSystem.ToLower() == "leanmes_report" && popedomInfo.Flag != 0)
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
                    cell.InnerHtml = "<div style='cursor: pointer;width:85%;' title='" + this.GetGlobalResourceObject("Popedom", popedomInfo.Description) + "'>" + this.GetGlobalResourceObject("Popedom", popedomInfo.Description) + "</div>";
                }
                row.Cells.Add(cell);

                cell = new HtmlTableCell();

                cell.InnerHtml = "<img src=\"" +
                WebHelper.ImageRoot + "Icon\\group.png\" style=\"cursor: pointer;\" onclick=\"showPopedomUsers(" + popedomInfo.Popedom + ")\">&nbsp;" +
                "<img src=\"" + WebHelper.ImageRoot + "Icon\\exporttoexcel.png\" style=\"cursor: pointer;\" onclick=\"exportPopedomUsers('" +
                Resources.Common.Popedoms + ": " + this.GetGlobalResourceObject("Popedom", popedomInfo.Name) + "'," + popedomInfo.Popedom + ")\">";
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
        private string GetRolePopedom(Int32 popedom)
        {
            string checkString = "";

            Common.Account.BLL.Role role = new Common.Account.BLL.Role();
            List<RoleInfo> lstRolePopedom = role.GetPopedomByRoleId(Int32.Parse(Request.QueryString["ID"]));

            foreach (RoleInfo roleInfo in lstRolePopedom)
            {
                if (popedom == roleInfo.Popedom)
                {
                    checkString = " checked='true'";
                    break;
                }
            }
            return checkString;
        }*/
    }
}