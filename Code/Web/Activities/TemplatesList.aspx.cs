using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Activities
{
    public partial class TemplatesList : BasePage
    {
        private int columnIndex_Tmpl_TemplateName = -1;
        private int columnIndex_Flag = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Tmpl_TemplateName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Tmpl_TemplateName")) + 1;
            columnIndex_Flag = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Flag")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxActivity));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "TemplateID";
            this.Master.DefaultSortExpression = "Tmpl_TemplateName DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("Tmpl_TemplateName", this.txtTemplName.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    List<string> modeIds = Request.Form["hdnIdString"].ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
                    try
                    {
                        foreach (var modeId in modeIds)
                        {
                            SKT.LeanMES.Station.BLL.Template bll = new LeanMES.Station.BLL.Template();
                            if (!bll.CheckTemplateStatus(Convert.ToInt32(modeId)))
                            {
                                bll.Delete(modeId, userName);                                
                            }
                            else
                            {
                                WebHelper.ShowMessage("该模板(ID:" + modeId + ")正在使用中，不能删除！");
                                return;
                            }
                        }
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //1改为columnIndex_Tmpl_TemplateName
                //2改为columnIndex_Flag
                //5改为columnIndex_ModifyDateTime
                e.Row.Cells[columnIndex_ModifyDateTime].Text = SKT.Common.Utility.TypeHelper.ToShortDateString(Convert.ToDateTime(e.Row.Cells[columnIndex_ModifyDateTime].Text));
                string s = this.GridView1.DataKeys[e.Row.RowIndex].Values["Tmp_Attribute"].ToString();
                if (s.ToUpper() == "Y")
                {
                    e.Row.Cells[columnIndex_Tmpl_TemplateName].Text = "<img src='../Content/images/lock.png' alt='' title='" + Resources.lang.SysBuiltTemplate + "'/>" + e.Row.Cells[columnIndex_Tmpl_TemplateName].Text;
                }

                TableCell tc = e.Row.Cells[columnIndex_Flag];
                switch (tc.Text)
                {
                    case "False":
                        tc.Text = "";
                        e.Row.Attributes.Add("Flag", e.Row.Cells[columnIndex_Flag].Text);
                        break;
                    case "True":
                        tc.Text = "<img title='系统内置' src=" + SKT.LeanMES.Web.WebHelper.WebRoot + "/Content/images/icon/logout.png />";
                        e.Row.Attributes.Add("Flag", e.Row.Cells[columnIndex_Flag].Text);
                        break;
                    default:
                        tc.Text = "";
                        break;
                }
            }
        }
    }
}