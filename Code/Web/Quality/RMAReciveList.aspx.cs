using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    public partial class RMAReciveList : BasePage
    {
        private int columnIndex_Status = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Status")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RmaId";
            this.Master.DefaultSortExpression = " Status"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();    
            if (IsPostBack)
            {
                //if (Request.Form["hdnOperate"].ToLower() == "delete")
                //{
                //    SKT.LeanMES.Quality.BLL.Rma bll = new SKT.LeanMES.Quality.BLL.Rma();
                //    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                //    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                //}
            }
           
            if (!string.IsNullOrWhiteSpace(txtRMANO.Text.Trim()))
            {
                searchSettings.AddCondition("RmaNo", txtRMANO.Text.Trim());
            }
            if (!string.IsNullOrWhiteSpace(txtItemCode.Text.Trim()))
            {
                searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //2改为columnIndex_Status
                LeanMES.Quality.Model.RmaInfo rmainfo = e.Row.DataItem as LeanMES.Quality.Model.RmaInfo;
                if (rmainfo.Status == 0)
                {
                    e.Row.Cells[columnIndex_Status].Text = "待接收";
                }
                else if (rmainfo.Status == 1)
                {
                    e.Row.Cells[columnIndex_Status].Text = "接收中";
                }
                else
                {
                    e.Row.Cells[columnIndex_Status].Text = "已接收";
                }
            }
        }
    }
}