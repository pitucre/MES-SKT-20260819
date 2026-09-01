using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Resource.Model;
using SKT.Common.Utility;
using SKT.LeanMES.Web.Utility;

namespace SKT.LeanMES.Web.Resource
{
    public partial class ResourceList : BasePage
    {
        private int columnIndex_ResStatus = -1;
        private int columnIndex_ValidStartTime = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ResStatus = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ResStatus")) + 1;
            columnIndex_ValidStartTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ValidStartTime")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;
            BindResourceStatus();

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ResourceId";
            this.Master.DefaultSortExpression = "ResourceId DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ResName", this.txtResName.Text.Trim());
            searchSettings.AddCondition("ResTypeName", this.txtResTypeName.Text.Trim());
            searchSettings.AddCondition("LineName", this.txtLineName.Text.Trim());
            if (IsPostBack)
            {
                searchSettings.ExtensionCondition = " ResStatus = " + Request.Form["ctl00$ctl00$ContentPlaceHolder1$SearchContent$ddlStatus"];
            }   
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (this.IsPostBack)
            {
                this.ddlStatus.SelectedValue = Request.Form["ctl00$ctl00$ContentPlaceHolder1$SearchContent$ddlStatus"];
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Resource.BLL.Resource bll = new SKT.LeanMES.Resource.BLL.Resource();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }
            }
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //3改为columnIndex_ResStatus
                //7改为columnIndex_ValidStartTime
                e.Row.Cells[columnIndex_ResStatus].Text = (String)GetGlobalResourceObject("Enum", ((SKT.LeanMES.Resource.Model.EnumResourceStatus)Enum.Parse(typeof(SKT.LeanMES.Resource.Model.EnumResourceStatus), e.Row.Cells[columnIndex_ResStatus].Text)).ToString());

                ResourceInfo model = (ResourceInfo)e.Row.DataItem;
                e.Row.Cells[columnIndex_ValidStartTime].Text = TypeHelper.ToShortDateString(model.ValidStartTime) + " ~ " + ((String.IsNullOrEmpty(TypeHelper.ToShortDateString(model.ValidEndTime))) ? "无限期" : TypeHelper.ToShortDateString(model.ValidEndTime));

                //(e.Row.Cells[4].Text == "") ? "" : SKT.Common.Utility.TypeHelper.ToShortDateString(Convert.ToDateTime(e.Row.Cells[4].Text));
                //e.Row.Cells[5].Text = (e.Row.Cells[5].Text == "") ? "" : SKT.Common.Utility.TypeHelper.ToShortDateString(Convert.ToDateTime(e.Row.Cells[5].Text));

                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //11改为columnIndex_ModifyBy
                //12改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }

        protected void BindResourceStatus()
        {
            List<ListItem> list = EnumHelper.ParseEnumToList(typeof(SKT.LeanMES.Resource.Model.EnumResourceStatus));
            List<ListItem> list2 = new List<ListItem>();
            for (int i = 0, j = list.Count; i < j; i++)
            {
                if (list[i].Value == "1" || list[i].Value == "2")
                {
                    list2.Add(list[i]);
                }
            }
            this.ddlStatus.DataSource = list2;
            this.ddlStatus.DataTextField = "text";
            this.ddlStatus.DataValueField = "value";
            this.ddlStatus.DataBind();
        }       
    }
}