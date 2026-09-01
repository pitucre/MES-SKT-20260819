using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MSD
{
    public partial class MsdOperationList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Oid";
            this.Master.DefaultSortExpression = "OperateTime DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
   
            string whereStr = " 1=1 ";

            if (this.txtItem.Text.Trim() != "")
            {
                whereStr += string.Format(" and  (ItemCode like '%{0}%' or  ItemName  like '%{1}%' )  ", this.txtItem.Text.Trim(), this.txtItem.Text.Trim());
            }

            if (txtStartTime.Text != "")
            {
                whereStr += " and OperateTime >= '" + txtStartTime.Text + " 00:00:00'";
            }
            if (txtEndTime.Text != "")
            {
                whereStr += " and OperateTime <= '" + txtEndTime.Text + " 23:59:59'";
            }

            searchSettings.ExtensionCondition = whereStr;
            searchSettings.AddCondition("SerialNumber", this.txtSerialNumber.Text.Trim().Replace("'", "''"));
            var operateDes = this.selOperateDes.SelectedValue;
            if (operateDes != "")
            {
                searchSettings.AddCondition("OperateDes", operateDes);
            }
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
                        SKT.LeanMES.MSD.BLL.Msl bll = new SKT.LeanMES.MSD.BLL.Msl();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }
    }
}