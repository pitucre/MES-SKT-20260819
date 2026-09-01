using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.Web.AjaxServices;
using AjaxPro;
using System.Linq;

namespace SKT.LeanMES.Web.SerialNumber
{
    public partial class SerialNumberList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSerialNumber));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SerialNumberId";
            this.Master.DefaultSortExpression = "SerialNumberId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string strWhere = "SerialNumber_Source = 'S'";

            if (this.ddlNextType.SelectedValue != null && this.ddlNextType.SelectedValue != "-1" && this.ddlNextType.SelectedValue != "")
            {
                strWhere += " and Next_Number_Type=" + ddlNextType.SelectedValue;
            }
            //if (this.ddlApply.SelectedValue != "")
            //{
            //    if (strWhere.Length > 0)
            //    {
            //        strWhere += " and ";
            //    }
            //    strWhere += "Apply_Type ='" + ddlApply.SelectedValue + "'";
            //}
            string txtValue = this.txtValue.Text.Trim();
            if (txtValue != "")
            {
                searchSettings.AddCondition("Type_Value", txtValue);
            }
            searchSettings.ExtensionCondition = strWhere;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (!IsPostBack)
            {
                BindNextNumberType();
            }

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.SerialNumber.BLL.SerialNumber bll = new SKT.LeanMES.SerialNumber.BLL.SerialNumber();
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
        /// <summary>
        /// 绑定产生序列号事件
        /// </summary>
        protected void BindNextNumberType()
        {
            //this.ddlNextType.DataSource = SKT.LeanMES.Web.Utility.EnumHelper.ParseEnumToList(typeof(SKT.LeanMES.SerialNumber.Model.EnumNextNumberType));
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            this.ddlNextType.DataSource = new SerialNumberType().GetAll(0, 100, "SerialNumberTypeId", searchSettings);
            this.ddlNextType.DataTextField = "SerialNumberType";
            this.ddlNextType.DataValueField = "SerialNumberTypeId";
            this.ddlNextType.DataBind();

            this.ddlNextType.Items.Insert(0, new ListItem(Resources.lang.Choose, "-1"));

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //8改为columnIndex_ModifyBy
                //9改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}