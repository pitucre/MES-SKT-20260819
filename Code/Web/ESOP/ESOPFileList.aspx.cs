using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.ESOP.BLL;

namespace SKT.LeanMES.Web.Product
{
public partial class ESOPFileList : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ESOPFileId";
            this.Master.DefaultSortExpression = "ESOPFileId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (this.hdnItemId.Value!="-1"&&this.txtItem.Text!="")
            {
                searchSettings.AddCondition("pe.ItemId", this.hdnItemId.Value);
            }
            if (this.hdnAssOperationID.Value != "-1" && this.txtItem.Text != "")
            {
                searchSettings.AddCondition("pe.StationId", this.hdnAssOperationID.Value);
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;


            //删除
            if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
            {
                try
                {
                    ESOPFile bll = new ESOPFile();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                }
            }
    }

  }
}