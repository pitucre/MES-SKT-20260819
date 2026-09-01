using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.BLL;
using System.Web.UI;
using System.Linq;

namespace SKT.LeanMES.Web.Material
{
    public partial class UrgentMaterialList : BasePage
    {
        private int columnIndex_UpdateDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_UpdateDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UpdateDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxUrgentMaterial));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "UrgentMaterialId";
            this.Master.DefaultSortExpression = "CreateDateTime DESC"; //也可不赋值


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "1=1";
            if (!string.IsNullOrEmpty(txtItemCode.Text))
                searchSettings.AddCondition("ItemCode", txtItemCode.Text);
            if (!string.IsNullOrEmpty(txtPOCode.Text))
                searchSettings.AddCondition("POCode", txtPOCode.Text);
            //有效时间
            DateTime starDateTime;
            DateTime endDateTime;
            if (!string.IsNullOrEmpty(txtStarDateTime.Text))
            {
                if (!DateTime.TryParse(txtStarDateTime.Text, out starDateTime))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('开始时间格式不正确')</script>");
                    return;
                }
                else
                {
                    searchSettings.ExtensionCondition += " AND StarDateTime>='" + txtStarDateTime.Text + "'";
                }
            }
            if (!string.IsNullOrEmpty(txtEndDateTime.Text))
            {
                if (!DateTime.TryParse(txtEndDateTime.Text, out endDateTime))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('结束时间格式不正确')</script>");
                    return;
                }
                else
                {
                    searchSettings.ExtensionCondition += " AND EndDateTime<='" + txtEndDateTime.Text + "'";
                }
            }
            if (!string.IsNullOrEmpty(txtEndDateTime.Text) && !string.IsNullOrEmpty(txtStarDateTime.Text))
            {
                if (DateTime.Compare(Convert.ToDateTime(txtStarDateTime.Text), Convert.ToDateTime(txtEndDateTime.Text)) > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('结束时间不能小于开始时间')</script>");
                    return;
                }
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Material.BLL.UrgentMaterial bll = new SKT.LeanMES.Material.BLL.UrgentMaterial();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //8改为columnIndex_UpdateDateTime
                if (e.Row.Cells[columnIndex_UpdateDateTime].Text == "1900/1/1 0:00:00")
                {
                    e.Row.Cells[columnIndex_UpdateDateTime].Text = "";
                }
            }
        }
    }
}