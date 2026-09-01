using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Warehouse.BLL;
using SKT.Common.Account.Model;
using SKT.Common.Model;
using System.Linq;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseLocationMaterialList : BasePage
    {
        private int columnIndex_CreateBy = -1;
        private int columnIndex_ModifyBy = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_CreateBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "CreateBy")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WarehouseLocationMaterialId";
            this.Master.DefaultSortExpression = "WarehouseLocationMaterialId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("CBarCode", txtCBarCode.Text);
            searchSettings.AddCondition("ItemCode", txtItemCode.Text);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                try
                {
                    //删除
                    if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        var bll = new WarehouseLocationMaterial();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
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
            SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //获取创建人
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //4改为columnIndex_CreateBy
                string userName = e.Row.Cells[columnIndex_CreateBy].Text;
                if (!string.IsNullOrEmpty(userName))
                {
                    MembershipInfo userInfo = user.GetInfo(userName);
                    e.Row.Cells[columnIndex_CreateBy].Text = (userInfo == null) ? "" : userInfo.EmployeeCName;
                }
                //获取修改人
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //6改为columnIndex_ModifyBy
                userName = e.Row.Cells[columnIndex_ModifyBy].Text;
                if (!string.IsNullOrEmpty(userName))
                {
                    MembershipInfo userInfo = user.GetInfo(userName);
                    e.Row.Cells[columnIndex_ModifyBy].Text = (userInfo == null) ? "" : userInfo.EmployeeCName;
                }
            }
        }
    }
}