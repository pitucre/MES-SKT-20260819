using SKT.Common.Framework.BLL;
using SKT.Common.Framework.Model;
using SKT.LeanMES.Report.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public class DDLData
    {
        public string Value { get; set; }
        public string Text { get; set; }
    }
    public partial class MenuButtonList : BasePage
    {
        private int columnIndex_module = -1;
        private int columnIndex_name = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_module = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "module")) + 1;
            columnIndex_name = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "name")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            if (!IsPostBack)
            {
                BindSystem();
            }
            BindData();
        }

        private void BindSystem()
        {
            List<DDLData> list = new List<DDLData>();
            SubSystem subSystem = new SubSystem();
            List<SubSystemInfo> subSystemList = subSystem.GetWarranttedSubSystems(SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId);
            string text;
            foreach (SubSystemInfo subSystemInfo in subSystemList)
            {
                if (subSystemInfo.Name == "LeanMES_Mobile" || subSystemInfo.Name == "LeanMES_Collection" || subSystemInfo.Name == "LeanMES_PDA")
                    continue;
                 text =(string)this.GetGlobalResourceObject("SubSystems", subSystemInfo.Name);
                list.Add(new DDLData { Text = text, Value = subSystemInfo.Name });
            }
            ddlsystem.DataSource = list;
            ddlsystem.DataTextField = "Text";
            ddlsystem.DataValueField = "Value";
            ddlsystem.DataBind();
            BindModule(list[0].Value);
        }

        private void BindModule(string subSystemName)
        {
            List<DDLData> list = new List<DDLData>();
            List<SKT.LeanMES.Report.Model.ReportInfo> reportInfo = null;
            string text;
            if (subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom")
            {
                //判断当前语言
                string currentCulture = "zh-cn";
                reportInfo = new SKT.LeanMES.Report.BLL.Report().GetModuleResources(SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId, subSystemName, currentCulture);
            }
            List<ModuleInfo> moduleList = new Module().GetWarranttedModulesBySubSystem(SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId, subSystemName);
            foreach (ModuleInfo moduleInfo in moduleList)
            {
                if (moduleInfo.Popedom <= 0)
                    continue;
                if (moduleInfo.Name.ToLower() == "client_scanner")
                    continue;
                text = "";
                //Add By Alen 2015-01-13 如果是报表子系统，则资源文件从数据库中读取
                if ((subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom") && moduleInfo.Flag != 0)
                {
                    foreach (ReportInfo r in reportInfo)
                    {
                        if (r.RTModuleName == moduleInfo.Name && r.RTResourcesType == 1)
                        {
                            text = r.RTModuleCNValue;
                            break;
                        }
                    }
                }
                else
                {
                    text =(string)this.GetGlobalResourceObject("Modules", moduleInfo.Name);
                }
                if (!string.IsNullOrWhiteSpace(text))
                    list.Add(new DDLData { Text = text, Value = moduleInfo.Name });
            }
            ddlmodule.DataSource = list;
            ddlmodule.DataTextField = "Text";
            ddlmodule.DataValueField = "Value";
            ddlmodule.DataBind();
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            string subSystemName = ddlsystem.SelectedValue;
            List<SKT.LeanMES.Report.Model.ReportInfo> reportInfo = null;
            if (subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom")
            {
                string currentCulture = "zh-cn";
                reportInfo = new SKT.LeanMES.Report.BLL.Report().GetModuleResources(SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId, subSystemName, currentCulture);
            }

            //xiang.yan 2024-4-24 cells取值改为根据列名获取
            //1改为columnIndex_module
            //2改为columnIndex_name
            //e.Row.Cells[4].Text 改为 DataBinder.Eval(e.Row.DataItem, "url").ToString()
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string url = DataBinder.Eval(e.Row.DataItem, "url").ToString();
                if ((subSystemName.ToLower() == "leanmes_report" || subSystemName.ToLower() == "leanmes_kanban" || subSystemName.ToLower() == "leanmes_custom") && url != "0")
                {
                    foreach (ReportInfo r in reportInfo)
                    {
                        if (r.RTModuleName == e.Row.Cells[columnIndex_module].Text && r.RTResourcesType == 1)
                        {
                            e.Row.Cells[columnIndex_module].Text = r.RTModuleCNValue;
                            break;
                        }
                    }

                    foreach (ReportInfo r in reportInfo)
                    {
                        if (r.RTModuleName == e.Row.Cells[columnIndex_name].Text && r.RTResourcesType == 2)
                        {
                            e.Row.Cells[columnIndex_name].Text = r.RTModuleCNValue;
                            break;
                        }
                    }
                }
                else
                {
                    object text = this.GetGlobalResourceObject("Modules", e.Row.Cells[columnIndex_module].Text);
                    if (text != null)
                        e.Row.Cells[columnIndex_module].Text = text.ToString();
                    text = this.GetGlobalResourceObject("Pages", e.Row.Cells[columnIndex_name].Text);
                    if (text != null)
                        e.Row.Cells[columnIndex_name].Text = text.ToString();
                }
            }
        }

        protected void ddlsystem_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindModule(ddlsystem.SelectedValue);
            BindData();
        }

        protected void ddlmodule_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindData();
        }

        private void BindData()
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.DefaultSortExpression = "pk desc";
            this.Master.RecordIDField = "name";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("name", ddlmodule.SelectedValue);
            searchSettings.AddCondition("id", SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId.ToString());
            searchSettings.AddCondition("search", txtUrl.Text);

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}