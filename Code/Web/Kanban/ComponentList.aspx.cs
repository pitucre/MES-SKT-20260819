using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Kanban
{
    public partial class ComponentList : BasePage
    {
        private int columnIndex_TypeName = -1;
        private int columnIndex_DataSource = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_TypeName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "TypeName")) + 1;
            columnIndex_DataSource = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "DataSource")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban)); 
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "KanbanComponentId";
            this.Master.DefaultSortExpression = "KanbanComponentId DESC";

            //生成类型选择
            SKT.Common.Model.SearchSettings ssType = new SKT.Common.Model.SearchSettings();
            ssType.AddCondition("EnableFlag", "1");
            hfCompTypeJson.Value = new PubItems.BLL.PubItems().GetCompType("",ssType);

            //绑定下拉框  modified by zhi.li on 20180816
            JArray item = (JArray)JsonConvert.DeserializeObject(hfCompTypeJson.Value);
            for (int i = 0; i < item.Count; i++)
            {
                JObject obj = (JObject)item[i];
                if (i == 0)
                {
                    this.ddlSelType.Items.Insert(0, new ListItem("=选择=", "-1"));
                }
                this.ddlSelType.Items.Insert(i + 1, new ListItem(obj["ItemName"].ToString(), obj["ItemValue"].ToString().ToString()));
            }
            ddlSelType.SelectedValue = hfSelectedType.Value;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (txtTemplName.Text != "")
            {
                searchSettings.AddCondition("ComponentName", this.txtTemplName.Text.Trim());
            }
            if (ddlSelType.SelectedValue != "-1")
            {
                string strWhere = " ComponentTypeId=" + hfSelectedType.Value;
                searchSettings.ExtensionCondition=strWhere;

            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Kanban.BLL.Master bll = new SKT.LeanMES.Kanban.BLL.Master();
                        bll.DeleteComp(Request.Form["hdnIdString"].ToString());
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }

        //时间格式
        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //2改为columnIndex_TypeName
                //3改为columnIndex_DataSource
                //7改为columnIndex_ModifyBy
                //8改为columnIndex_ModifyTime

                SKT.LeanMES.Kanban.Model.MasterInfo reportInfo = (SKT.LeanMES.Kanban.Model.MasterInfo)e.Row.DataItem;
                if (e.Row.Cells[columnIndex_TypeName].Text.ToLower() == "web")
                {
                    e.Row.Cells[columnIndex_DataSource].Text = "网页地址";
                }
                if (e.Row.Cells[columnIndex_TypeName].Text.ToLower() == "text")
                {
                    e.Row.Cells[columnIndex_DataSource].Text = "文本内容";
                }
                //e.Row.Cells[5].Text = SKT.Common.Utility.TypeHelper.ToLongDateString(Convert.ToDateTime(e.Row.Cells[5].Text));
                //e.Row.Cells[7].Text = SKT.Common.Utility.TypeHelper.ToLongDateString(Convert.ToDateTime(e.Row.Cells[7].Text));
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyTime].Text = "";
            }
        }
    }
}