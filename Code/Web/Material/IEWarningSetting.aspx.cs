using SKT.Common.DAL.Marshal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class IEWarningSetting : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "ID";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ItemCode", this.txtItemCode.Text);
            searchSettings.AddCondition("ItemName", this.txtItemName.Text);
            searchSettings.AddCondition("LibraryCollar", this.txtLibraryCollar.Text);
            searchSettings.AddCondition("SafetyStock", this.txtSafetyStock.Text);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        string id = Request.Form["hdnIdString"].ToString();
                        SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, "DELETE FROM Basal_EarlyWarning WHERE ID IN (" + id + ")", null);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {

                        throw;
                    }


                }
            }
        }
    }
}