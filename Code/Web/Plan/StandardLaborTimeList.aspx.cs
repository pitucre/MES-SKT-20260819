using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Plan
{
    public partial class StandardLaborTimeList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "StandardLaborTimeId";
            this.Master.DefaultSortExpression = "StandardLaborTimeId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            
            string strWhere = "";
            if (this.txtItemName.Text.Trim() != "")
            {
                searchSettings.AddCondition("ItemCode",this.txtItemName.Text);
            }
            if (this.ddlLaborTimeType.SelectedValue != "0")
            {
                strWhere = strWhere+"LaborTimeType=" + this.ddlLaborTimeType.SelectedValue;
            }
            searchSettings.ExtensionCondition = strWhere;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Plan.BLL.StandardLaborTime bll = new SKT.LeanMES.Plan.BLL.StandardLaborTime();
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