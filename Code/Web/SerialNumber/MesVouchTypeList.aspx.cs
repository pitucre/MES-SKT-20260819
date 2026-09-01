using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.SerialNumber.BLL;

namespace SKT.LeanMES.Web.SerialNumber
{
    public partial class MesVouchTypeList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MesVouchTypeId";
            this.Master.DefaultSortExpression = "MesVouchTypeId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("", "");
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.SerialNumber.BLL.MesVouchType bll = new SKT.LeanMES.SerialNumber.BLL.MesVouchType();
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
    }
}