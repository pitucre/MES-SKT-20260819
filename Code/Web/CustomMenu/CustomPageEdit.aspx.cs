using SKT.LeanMES.CustomMenu.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Framework.BLL;
using SKT.Common.Framework.Model;
using System.Globalization;

namespace SKT.LeanMES.Web.CustomMenu
{
    public partial class CustomPageEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager2.RegisterAsyncPostBackControl(this.ddlSubName);
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxCustomMenu));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxReport));
            //this.ddlModule.Items.Insert(0, new ListItem("=选择=", ""));
            if (!IsPostBack)
            {
                BindSubSystem();
                ////BindType("");
                int PageId = Convert.ToInt32(Request.QueryString["ID"]);
                if (PageId != -1)
                {
                    CustomMenuInfo model = new LeanMES.CustomMenu.BLL.CustomMenu().GetCustomPageInfo(PageId);
                    if (model != null)
                    {
                        BindType(model.SubSystem);
                        this.txtPageCName.Text = model.PageCName;
                        this.hdnPageName.Value = model.PageName;
                        this.txtPageEName.Text = model.PageEName;
                        this.hdnIcon.Value = model.Icon;
                        this.txtSequence.Text = model.Sequence.ToString();
                        this.ddlModule.SelectedValue = model.Module;
                        //this.ddlModule.SelectedIndex=this.ddlModule.Items.IndexOf(this.ddlModule.Items.FindByValue(model.Module));
                        this.txtPageDesc.Text = model.PageDesc;
                        this.hdnValue.Value = (String.IsNullOrEmpty(model.PageContent)) ? "" : model.PageContent;
                        hfDesignJson.Value = model.DesignJSON ?? "";
                        this.ddlSubName.SelectedValue = model.SubSystem;
                        this.ckIsCodeDesign.Checked = model.IsCodeDesign;
                        this.hdnValueSub.Value = (String.IsNullOrEmpty(model.PageContentSub)) ? "" : model.PageContentSub;
                        this.hdnPType.Value = model.PType.ToString();
                        if (model.Icon != "")
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "setReportIcon", "$(\"#reportIcon\").html(\"<img src='../Content/Theme/Metro/Images/Icon/" + model.Icon + "'/>\");", true);
                        }
                    }
                }
                else
                {
                    BindType("LeanMES_Custom");//默认加载二次开发
                }
            }
        }
        protected void SubSystemChange(object sender, EventArgs e) {
            string subSystemName = this.ddlSubName.SelectedItem.Value;
            this.isIntoSysFrame.Value = subSystemName;
            BindType(subSystemName);
            UpdatePanel2.Update();
        }
        private List<ModuleInfo> moduleList = null;
        private Module module = new Module();
        String strModuleName = "";
        string currentCulture = "zh-cn";
        //绑定模块信息
        public void BindType(string subSystemName)
        {
            Int32 userId = AccountController.GetCurrentUser().UserId;
            SKT.LeanMES.CustomMenu.BLL.CustomMenu bll = new LeanMES.CustomMenu.BLL.CustomMenu();
            SKT.Common.Model.SearchSettings search = new SKT.Common.Model.SearchSettings();

            List<CustomMenuInfo> list = new List<CustomMenuInfo>();  //bll.GetAll(0, int.MaxValue, "", search); //
            if (subSystemName.ToLower() == "leanmes_custom")
            {
                list = bll.GetAll(0, int.MaxValue, "", search);
            }
            //读取系统框架菜单
            List<SKT.LeanMES.Report.Model.ReportInfo> reportInfo = null;
            if (subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom")
            {
                //判断当前语言
                reportInfo = new SKT.LeanMES.Report.BLL.Report().GetModuleResources(userId, subSystemName, currentCulture);
            }
            if (!string.IsNullOrEmpty(subSystemName) && subSystemName.ToLower() != "leanmes_custom")
            {//
                moduleList = module.GetWarranttedModulesBySubSystem(userId, subSystemName);
                foreach (ModuleInfo moduleInfo in moduleList)
                {
                    if (moduleInfo.Popedom > 0)
                    {
                        if (moduleInfo.Name.ToLower() != "client_scanner")
                        {
                            CustomMenuInfo entity = new CustomMenuInfo();
                            if ((subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom") && moduleInfo.Flag != 0)
                            {
                                strModuleName = "";
                                foreach (SKT.LeanMES.Report.Model.ReportInfo r in reportInfo)
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
                                strModuleName = (String)HttpContext.GetGlobalResourceObject("Modules", moduleInfo.Name, new CultureInfo(currentCulture));
                            }
                            entity.KeyCNValues = strModuleName;
                            entity.FatherKey = moduleInfo.Name;
                            list.Add(entity);
                        }
                    }
                }
            }
            ddlModule.DataSource = list;
            ddlModule.DataTextField = "KeyCNValues";
            ddlModule.DataValueField = "fatherKey";
            ddlModule.DataBind();
        }
        //绑定子系统信息
        public void BindSubSystem()
        {
            Int32 userId = AccountController.GetCurrentUser().UserId;
            SubSystem subSystem = new SubSystem();
            List<SubSystemInfo> subSystemList = subSystem.GetWarranttedSubSystems(userId);
            String subSystemName = "";
            List<SubSystemInfo> subSystemList2 = new List<SubSystemInfo>();
            subSystemList.RemoveAll(c => c.Name == "LeanMES_Mobile");
            subSystemList.RemoveAll(c => c.Name == "LeanMES_Collection");
            subSystemList.RemoveAll(c => c.Name == "LeanMES_Collection");
            ////subSystemList.RemoveAll(c => c.Name == "LeanMES_Custom");
            foreach (SubSystemInfo subSystemInfo in subSystemList)
            {
                subSystemName = (String)this.GetGlobalResourceObject("SubSystems", subSystemInfo.Name);
                subSystemInfo.Icon = subSystemName;
            }
            ddlSubName.DataSource = subSystemList;
            ddlSubName.DataTextField = "Icon";
            ddlSubName.DataValueField = "Name";
            ddlSubName.SelectedValue = "LeanMES_Custom";
            ddlSubName.DataBind();
        }
    }
}