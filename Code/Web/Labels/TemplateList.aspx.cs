using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.Labels.BLL;
using System.Collections.Generic;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.Labels.Model;

namespace SKT.LeanMES.Web.Labels
{
    public partial class TemplateList : BasePage
    {
        private int columnIndex_PanelWidth = -1;
        private int columnIndex_PanelHeight = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_PanelWidth = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "PanelWidth")) + 1;
            columnIndex_PanelHeight = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "PanelHeight")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxLabels));

  
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "TempId";
            this.Master.DefaultSortExpression = "TempId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("TempName", Server.HtmlEncode(this.txtTempName.Text.Trim()));
          
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        string[] array = Request.Form["hdnIdString"].Split(new string[] { ",", "，" }, StringSplitOptions.RemoveEmptyEntries);
                        foreach (var item in array)
                        {
                            new PrintTemplate().Delete(Convert.ToInt32(item));
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

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //2改为columnIndex_PanelWidth
                //3改为columnIndex_PanelHeight
                e.Row.Cells[columnIndex_PanelWidth].Text = (Math.Round(Convert.ToSingle(e.Row.Cells[columnIndex_PanelWidth].Text) * 35.27) / 100).ToString();
                e.Row.Cells[columnIndex_PanelHeight].Text = (Math.Round(Convert.ToSingle(e.Row.Cells[columnIndex_PanelHeight].Text) * 35.27) / 100).ToString();
            }
        }



    }
}