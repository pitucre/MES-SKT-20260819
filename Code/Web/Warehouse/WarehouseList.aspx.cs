using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Warehouse.BLL;
using SKT.Common.Account.Model;
using System.Linq;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseList : BasePage
    {
        private int columnIndex_CDepCode = -1;
        private int columnIndex_CWhPerson = -1;
        private int columnIndex_IWHProperty = -1;
        private int columnIndex_CWhAddress = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_CDepCode = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "CDepCode")) + 1;
            columnIndex_CWhPerson = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "CWhPerson")) + 1;
            columnIndex_IWHProperty = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IWHProperty")) + 1;
            columnIndex_CWhAddress = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "CWhAddress")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouse));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WarehouseId";
            this.Master.DefaultSortExpression = "WarehouseId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("CWhCode", txtCodeName.Text);
            searchSettings.AddCondition("CWhName", txtKeyWords.Text);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                try
                {
                    //删除
                    if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        SKT.LeanMES.Warehouse.BLL.Warehouse bll = new SKT.LeanMES.Warehouse.BLL.Warehouse();
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
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //6改为columnIndex_IWHProperty
                if (e.Row.Cells[columnIndex_IWHProperty].Text == "&nbsp;")
                {
                    e.Row.Cells[columnIndex_IWHProperty].Text = "";
                }
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //3改为columnIndex_CDepCode
                //部门
                if (e.Row.Cells[columnIndex_CDepCode].Text == "&nbsp;")
                {
                    e.Row.Cells[columnIndex_CDepCode].Text = "";
                }
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //7改为columnIndex_CWhAddress
                if (e.Row.Cells[columnIndex_CWhAddress].Text == "&nbsp;")
                {
                    e.Row.Cells[columnIndex_CWhAddress].Text = "";
                }
                //获取部门id
                string depeteId = e.Row.Cells[columnIndex_CDepCode].Text;
                if (depeteId != "")
                {
                    SKT.Common.Organization.BLL.Organization org = new Common.Organization.BLL.Organization();
                    SKT.Common.Organization.Model.OrganizationInfo orginfo = org.GetInfo(Convert.ToInt32(depeteId));
                    e.Row.Cells[columnIndex_CDepCode].Text = (orginfo == null) ? "" : orginfo.DepartName + "|" + "(" + orginfo.DepartNo + ")";
                }
                else
                {
                    e.Row.Cells[columnIndex_CDepCode].Text = "";
                }
                //获取负责人：
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //5改为columnIndex_CWhPerson
                int userId = Convert.ToInt32(e.Row.Cells[columnIndex_CWhPerson].Text);
                if (userId == -1)
                {
                    e.Row.Cells[columnIndex_CWhPerson].Text = "";
                }
                else
                {
                    SKT.Common.Account.BLL.Users userName = new Common.Account.BLL.Users();
                    MembershipInfo userInfo = user.GetInfo(userId);
                    //e.Row.Cells[5].Text = (userInfo == null) ? "" : userInfo.EmployeeCName + "|" + userInfo.EmployeeEName + "(" + userInfo.EmployeeNo + ")";
                    e.Row.Cells[columnIndex_CWhPerson].Text = (userInfo == null) ? "" : userInfo.EmployeeCName;
                }

                string whTypeId = e.Row.Cells[columnIndex_IWHProperty].Text;
                if (whTypeId != "-1")
                {
                    SKT.LeanMES.Warehouse.Model.WarehouseTypeInfo whTypeInfo = (new SKT.LeanMES.Warehouse.BLL.WarehouseType()).GetInfo(Convert.ToInt32(whTypeId));
                    e.Row.Cells[columnIndex_IWHProperty].Text = (whTypeInfo == null) ? "" : whTypeInfo.WarehouseType;
                }
                else
                {
                    e.Row.Cells[columnIndex_IWHProperty].Text = "";
                }

                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //10改为columnIndex_ModifyBy
                //11改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}