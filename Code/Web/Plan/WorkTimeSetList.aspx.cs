using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Plan
{
    public partial class WorkTimeSetList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WtId";
            this.Master.DefaultSortExpression = "WtId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            
            
            if (this.txtLineName.Text.Trim() != "")
            {
                searchSettings.AddCondition(" LineName",this.txtLineName.Text);
            }
            //if (this.txtResName.Text.Trim() != "")
            //{
            //    searchSettings.AddCondition(" ResName", this.txtResName.Text);
            //}

            searchSettings.AddCondition(" Name", this.txtName.Text);
         
            if (this.txtSetDate.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition = " CONVERT(VARCHAR(10),SetDate,120)=CONVERT(VARCHAR(10),'" + txtSetDate + "',120)";
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
                        SKT.LeanMES.Plan.BLL.WorkTimeSet bll = new SKT.LeanMES.Plan.BLL.WorkTimeSet();
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