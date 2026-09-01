using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialRequestList : BasePage
    {
        private int columnIndex_RequestUserId = -1;
        private int columnIndex_State = -1;
        private int columnIndex_DepartId = -1;
        private int columnIndex_PrepareState = -1;
        private int columnIndex_Prioritys = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_RequestUserId = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "RequestUserId")) + 1;
            columnIndex_State = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "State")) + 1;
            columnIndex_DepartId = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "DepartId")) + 1;
            columnIndex_PrepareState = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "PrepareState")) + 1;
            columnIndex_Prioritys = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Prioritys")) + 1;
            
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProcessForm));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MaterialRequestId";
            this.Master.DefaultSortExpression = "MaterialRequestId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (this.txtOrderNumber.Text.Trim().Length > 0)
            {
                searchSettings.AddCondition("FormNO", this.txtOrderNumber.Text);
            }
            if (this.txtRequestUser.Text != "")
            {
                searchSettings.AddCondition("RequestUserId", this.hfRequestUserId.Value);
            }

            this.Master.SearchSettings = searchSettings;

            this.GridView1.PageIndex = 0;

            if (this.txtRequestUser.Text != "")
            {
                int userID = Convert.ToInt32(this.hfRequestUserId.Value);
                if (userID != 0)
                {
                    this.txtRequestUser.Text = new SKT.Common.Account.BLL.Users().GetInfo(userID).EmployeeEName;
                }
            }

            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        string idStr = Request.Form["hdnIdString"].ToString();
                        SKT.LeanMES.Material.BLL.MaterialRequest bll = new SKT.LeanMES.Material.BLL.MaterialRequest();
                        if (1 == bll.Editable(Convert.ToInt32(idStr)))
                        {
                            bll.Delete(idStr, AccountController.GetCurrentUser().UserName);
                            WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                        }
                        else
                        {
                            WebHelper.ShowMessage(Resources.Messages.PickedCannotOperation);
                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }
            }
        }

        protected void GridView1_DataBound1(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //3改为columnIndex_ModifyDateTime
                int col1 = columnIndex_RequestUserId;
                int uID = Convert.ToInt32(e.Row.Cells[col1].Text);
                SKT.Common.Account.BLL.Users userBll = new SKT.Common.Account.BLL.Users();
                //SKT.Common.Account.BLL.
                SKT.Common.Account.Model.MembershipInfo membershipInfo = userBll.GetInfo(uID);
                if (membershipInfo != null)
                {
                    e.Row.Cells[col1].Text = membershipInfo.EmployeeEName.Trim().Length > 0 ? membershipInfo.EmployeeEName : membershipInfo.EmployeeCName;
                }

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //5改为columnIndex_State
                int col2 = columnIndex_State;

                int stateID = Convert.ToInt32(e.Row.Cells[col2].Text);
                if (stateID == 0)
                {
                    e.Row.Cells[col2].Text = Resources.lang.ReceivingMaterials_Not;
                }
                else
                {
                    e.Row.Cells[col2].Text = Resources.lang.ReceivingMaterials;
                }

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //4改为columnIndex_DepartId
                int col3 = columnIndex_DepartId;
                int deparID = Convert.ToInt32(e.Row.Cells[col3].Text);
                SKT.Common.Organization.Model.OrganizationInfo organizationInfo = new SKT.Common.Organization.BLL.Organization().GetInfo(deparID);
                if (organizationInfo != null)
                {
                    e.Row.Cells[col3].Text = organizationInfo.DepartName;
                }
                else
                {
                    e.Row.Cells[col3].Text = "";
                }
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_PrepareState
                int col5 = columnIndex_PrepareState;
                int prepareStates = Convert.ToInt32(e.Row.Cells[col5].Text);
                if (prepareStates == 0)
                {
                    e.Row.Cells[col5].Text = "未备料";
                }
                else if (prepareStates == 1)
                {
                    e.Row.Cells[col5].Text = "备料中";
                }
                else if (prepareStates == 2)
                {
                    e.Row.Cells[col5].Text = "已备料";
                }
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //7改为columnIndex_Prioritys
                int col4 = columnIndex_Prioritys;
                int Prioritys = Convert.ToInt32(e.Row.Cells[col4].Text);
                if (Prioritys == 1)
                {
                    e.Row.Cells[col4].Text = Resources.lang.High;
                }
                else if (Prioritys == 2)
                {
                    e.Row.Cells[col4].Text = Resources.lang.Middle;
                }
                else if (Prioritys == 3)
                {
                    e.Row.Cells[col4].Text = Resources.lang.Low;
                }

            }
        }


    }



}