using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.AccessoryManagement.BLL;

namespace SKT.LeanMES.Web.AccessoryManagement
{
    public partial class AccessoryList : BasePage
    {
        private int columnIndex_UserTime = -1;
        private int columnIndex_StartThawTime = -1;
        private int columnIndex_StartStirTime = -1;
        private int columnIndex_UnsealTime = -1;
        private int columnIndex_ReturnTime = -1;
        private int columnIndex_LoseTime = -1;
        private int columnIndex_ModifyTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_UserTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UserTime")) + 1;
            columnIndex_StartThawTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "StartThawTime")) + 1;
            columnIndex_StartStirTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "StartStirTime")) + 1;
            columnIndex_UnsealTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UnsealTime")) + 1;
            columnIndex_ReturnTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ReturnTime")) + 1;
            columnIndex_LoseTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "LoseTime")) + 1;
            columnIndex_ModifyTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyTime")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessory));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessoryList));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AccessoryId";
            this.Master.DefaultSortExpression = "AccessoryId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (!string.IsNullOrEmpty(txtAccessoryNO2.Text))
            {
                searchSettings.AddCondition("SerialNumber", txtAccessoryNO2.Text);
            }
            if (!string.IsNullOrEmpty(txtAccCode.Text))
            {
                searchSettings.AddCondition("AccessoryCodoe", txtAccCode.Text);
            }
            if (dllStatus.SelectedValue != "-1")
                searchSettings.AddCondition("Status", dllStatus.SelectedValue);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        Accessory bll = new SKT.LeanMES.AccessoryManagement.BLL.Accessory();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {

                        throw;
                    }
                }
            }

            //2018-6-6设置先进先出权限
            int userId = AccountController.GetCurrentUser().UserId;
            this.hdFIFO.Value = Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 30480110) ? "1" : "-1"; //用户FIFO权限  1：有权限 -1：没有权限
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //7改为 columnIndex_UserTime
                //9改为columnIndex_StartThawTime
                //10改为columnIndex_StartStirTime
                //11改为columnIndex_UnsealTime
                //12改为columnIndex_ReturnTime
                //13改为columnIndex_LoseTime
                //20改为columnIndex_ModifyTime
                e.Row.Cells[columnIndex_UserTime].Text = Math.Round(Convert.ToDouble(e.Row.Cells[columnIndex_UserTime].Text), 2).ToString();
                if (Convert.ToDateTime(e.Row.Cells[columnIndex_StartThawTime].Text).ToString("yyyy-MM-dd") == "9999-12-31")
                {
                    e.Row.Cells[columnIndex_StartThawTime].Text = "";
                }
                //by liwen 20201224 处理时间问题
                if (Convert.ToDateTime(e.Row.Cells[columnIndex_StartStirTime].Text).ToString("yyyy-MM-dd") == "9999-12-31")
                {
                    e.Row.Cells[columnIndex_StartStirTime].Text = "";
                }
                if (Convert.ToDateTime(e.Row.Cells[columnIndex_UnsealTime].Text).ToString("yyyy-MM-dd") == "9999-12-31")
                {
                    e.Row.Cells[columnIndex_UnsealTime].Text = "";
                }
                if (Convert.ToDateTime(e.Row.Cells[columnIndex_ReturnTime].Text).ToString("yyyy-MM-dd") == "9999-12-31")
                {
                    e.Row.Cells[columnIndex_ReturnTime].Text = "";
                }
                if (Convert.ToDateTime(e.Row.Cells[columnIndex_LoseTime].Text).ToString("yyyy-MM-dd") == "9999-12-31")
                {
                    e.Row.Cells[columnIndex_LoseTime].Text = "";
                }
                if (e.Row.Cells[columnIndex_ModifyTime].Text == "" || e.Row.Cells[columnIndex_ModifyTime].Text == "&nbsp;" || Convert.ToDateTime(e.Row.Cells[columnIndex_ModifyTime].Text).ToString("yyyy-MM-dd") == "9999-12-31")
                {
                    e.Row.Cells[columnIndex_ModifyTime].Text = "";
                }
            }
        }

    }
}