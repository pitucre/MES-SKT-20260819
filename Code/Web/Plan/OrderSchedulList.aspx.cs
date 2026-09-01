using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;

namespace SKT.LeanMES.Web.Plan
{
    public partial class OrderSchedulList : BasePage
    {
        private int columnIndex_Status = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Status")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(OrderSchedulList));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ProdOrderId";
            this.Master.DefaultSortExpression = " Priority DESC ,Planned_Start_Time ASC";

           
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();


            if (this.txtOrderNo.Text.Trim() != "")
            {
                searchSettings.AddCondition(" OrderNo", this.txtOrderNo.Text);
            }
            if (this.txtItemCode.Text.Trim() != "")
            {
                searchSettings.AddCondition(" ItemCode", this.txtItemCode.Text);
            }
            if (this.txtItemName.Text.Trim() != "")
            {
                searchSettings.AddCondition(" ItemName", this.txtItemName.Text);
            }
            if (this.ddlStatus.SelectedValue.Trim() != "")
            {
                searchSettings.AddCondition(" Status", this.ddlStatus.SelectedValue.Trim());
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
           
        }

        /// <summary>
        /// 取消工单排产
        /// </summary>
        /// <param name="idString">ResourceType实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void CancelOrderSchedul(string idString)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                SKT.LeanMES.Plan.BLL.SchedulOrderDal bll = new SKT.LeanMES.Plan.BLL.SchedulOrderDal();
                bll.CancelOrderSchedul(idString, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(userName, ex);
            }
        }

        /// <summary>
        /// 确认工单排产
        /// </summary>
        /// <param name="idString">ResourceType实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void ConfirmOrderSchedul(string idString)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                SKT.LeanMES.Plan.BLL.SchedulOrderDal bll = new SKT.LeanMES.Plan.BLL.SchedulOrderDal();
                bll.ConfirmOrderSchedul(idString, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(userName, ex);
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //3改为columnIndex_Status
                int col2 = columnIndex_Status;
            
                System.Drawing.Color color = System.Drawing.Color.Black;
                switch (e.Row.Cells[col2].Text)
                {
                    case "待确认":
                        color = System.Drawing.Color.Black;
                        break;
                    case "队列中":
                        color = System.Drawing.Color.Orange;
                        break;
                    case "待生产":
                        color = System.Drawing.Color.Green;
                        break;
                 
                }
                e.Row.Cells[col2].ForeColor = color;
                e.Row.Cells[col2].Font.Bold = true;

            }
        }
    }
}