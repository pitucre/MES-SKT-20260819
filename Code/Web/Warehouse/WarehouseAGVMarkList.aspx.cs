using SKT.LeanMES.Warehouse.BLL;
using System;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseAGVMarkList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouse));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "Id DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("AGVAreaName", txtAGVAreaName.Text);
            searchSettings.AddCondition("AGVLandMarkCode", txtAGVLandMarkCode.Text);
            searchSettings.AddCondition("CreateBy", txtCreateBy.Text);
            searchSettings.AddCondition("ModifyBy", txtModifyBy.Text);

            string whereStr = "1=1";
            if (ddlStatus.SelectedValue != "-2")
            {
                whereStr += " and Statues = " + ddlStatus.SelectedValue;
            }

            searchSettings.ExtensionCondition = whereStr;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                try
                {
                    //删除
                    if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        WarehouseAGVMark bll = new WarehouseAGVMark();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }

                    //解除占用
                    if (Request.Form["hdnOperate"].ToLower() == "update")
                    {
                        WarehouseAGVMark bll = new WarehouseAGVMark();
                        bll.UpdateSatues(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage("解除占用成功！");
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(String.Empty, ex, true);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           
        }
    }
}