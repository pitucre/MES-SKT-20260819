using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;


namespace SKT.LeanMES.Web.Kanban
{
    public partial class ComponentEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxCommDataSource));
            //生成控件类型下拉控件
            SKT.Common.Model.SearchSettings ssType = new SKT.Common.Model.SearchSettings();
            ssType.AddCondition("EnableFlag","1");
            hfCompTypeJson.Value = new PubItems.BLL.PubItems().GetCompType("", ssType);

            //初始页面信息
            if (!IsPostBack)
            {
                int componentId = Convert.ToInt32(Request.QueryString["ID"]);
                if (componentId != -1)
                {
                    SKT.LeanMES.Kanban.Model.MasterInfo model = new LeanMES.Kanban.BLL.Master().GetCompInfo(componentId);
                    if (model != null)
                    {
                        hfSelectedType.Value = model.ComponentTypeId + "@" + model.Param1 + "@" + model.Param2;
                        hfEditOptinJS.Value = model.EditOption;
                        txtCompName.Value = model.ComponentName;
                        txtRefresh.Value = model.RefreshSec;
                        txtRemark.Text = model.Remark;

                        if (model.Param2 == "text")
                        {
                            txtArea.Value = model.DataSource;
                        }
                        if (model.Param2 == "web")
                        {
                            txtWebSrc.Value = model.DataSource;
                        }
                        else
                        {
                            txtTable.Text = model.DataSource;
                            hfDsType.Value = model.SourceType;
                        }
                    }

                }
            }
        }
    }
}