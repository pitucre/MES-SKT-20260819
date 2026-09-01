using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SKT.LeanMES.Web.MaskGroup
{
    public partial class MaskGroupList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MaskID";
            this.Master.DefaultSortExpression = "MaskID";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("MaskGroup", Server.HtmlEncode(this.txtName.Text));
            this.Master.SearchSettings = searchSettings;

            this.GridView1.PageIndex = 0;

            //删除
            if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
            {
                string userName = AccountController.GetCurrentUser().UserName;
                try
                {
                    SKT.LeanMES.MaskGroup.BLL.MaskGroup bll = new SKT.LeanMES.MaskGroup.BLL.MaskGroup();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                    SKT.LeanMES.Web.WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
                catch (Exception ex)
                {
                    SKT.LeanMES.Web.WebHelper.HandleException(userName, ex, true);
                }
            }
        }
    }
}