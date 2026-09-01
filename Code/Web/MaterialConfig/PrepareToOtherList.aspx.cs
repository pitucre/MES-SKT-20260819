using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Web.MaterialConfig
{
    public partial class PrepareToOtherList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RID";
            this.Master.DefaultSortExpression = "RID DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("EnableFlag", "1");
            if (txtPrepareTo.Text != "")
            {
                searchSettings.AddCondition("PrepareDesc", txtPrepareTo.Text);                
            }
            
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Material.BLL.PrepareToOther bll = new LeanMES.Material.BLL.PrepareToOther();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }

        }
    }
}