using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.Labels.BLL;
namespace SKT.LeanMES.Web.Labels
{
    public partial class PrinterList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxLabels));


            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "Id DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("Name", Server.HtmlEncode(this.txtName.Text.Trim()));
            searchSettings.AddCondition("GroupName", this.txtGroupName.Text.Trim());

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
                        string [] array= Request.Form["hdnIdString"].Split(new string[] { ",", "，" }, StringSplitOptions.RemoveEmptyEntries);
                        foreach (var item in array)
                        {
                            new Printer().Delete(Convert.ToInt32(item));
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

            }
        }



    }
}