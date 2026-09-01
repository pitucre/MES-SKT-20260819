using SKT.LeanMES.CustomMenu.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.CustomMenu
{
    public partial class CustomPageList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PageId";
            this.Master.DefaultSortExpression = " ";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("PageCName", this.txtPageEName.Text.Trim());
            searchSettings.AddCondition("ModuleCName", this.ddlModule.SelectedItem==null||this.ddlModule.SelectedItem.Text== "=选择=" ? "":this.ddlModule.SelectedItem.Text.Trim());
            //string strWhere = "";
            //if (this.ddlModule.SelectedItem != null && this.ddlModule.SelectedValue != "-1" && this.ddlModule.SelectedValue != "")
            //{
            //    strWhere += " and ModuleCName=" + this.ddlModule.SelectedItem.Text.Trim();
            //}
            //searchSettings.ExtensionCondition = strWhere;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (!IsPostBack) {
                BindType();
            }

            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.CustomMenu.BLL.CustomMenu bll = new LeanMES.CustomMenu.BLL.CustomMenu();
                        bll.DeleteCustomPage(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }

        //绑定模块信息
        public void BindType()
        {
            SKT.LeanMES.CustomMenu.BLL.CustomMenu bll = new LeanMES.CustomMenu.BLL.CustomMenu();
            SKT.Common.Model.SearchSettings search = new SKT.Common.Model.SearchSettings();

            List<CustomMenuInfo> list = bll.GetAll(0, int.MaxValue, "", search);
            ddlModule.DataSource = list;
            ddlModule.DataTextField = "KeyCNValues";
            ddlModule.DataValueField = "fatherKey";
            ddlModule.DataBind();
            this.ddlModule.Items.Insert(0, new ListItem("=选择=", ""));
        }
    }
}