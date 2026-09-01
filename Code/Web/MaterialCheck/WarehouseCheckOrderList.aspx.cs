using System;
using SKT.LeanMES.Material.BLL;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Collections.Generic;

namespace SKT.LeanMES.Web.MaterialCheck
{
    public partial class WarehouseCheckOrderList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouse));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ProdWarehouseCheckId";
            this.Master.DefaultSortExpression = "ProdWarehouseCheckId DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("", "");
            if (!IsPostBack)
            {
                BindPandOrderType();
                BindCheckOrderStatus();
            }
            if (txtWhCheckOrder.Text != "")
            {
                searchSettings.AddCondition("CheckOrder", txtWhCheckOrder.Text);
            }
            searchSettings.ExtensionCondition += " 1=1 ";
            if (hdnWhID.Value != "")
            {
                searchSettings.ExtensionCondition += "AND WarehouseId =" + Convert.ToInt32(hdnWhID.Value) + "";
            }
            if (txtDateFrom.Value != "")
            {
                searchSettings.ExtensionCondition += " AND BeginDate >='" + txtDateFrom.Value + "'";
            }
            if (txtDateTo.Value != "")
            {
                searchSettings.ExtensionCondition += " AND BeginDate <='" + txtDateTo.Value + "'";
            }
            if (this.tdOrderStatus.SelectedValue != "-1")
            {
                searchSettings.ExtensionCondition += "AND WarehouseCheckStatusId = " + Convert.ToInt32(this.tdOrderStatus.SelectedValue) + "";
            }
            if (this.tdSelCheckType.SelectedValue != "-1")
            {
                searchSettings.ExtensionCondition += "AND CheckTypeId = " + Convert.ToInt32(this.tdSelCheckType.SelectedValue) + "";
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            string userName = AccountController.GetCurrentUser().UserName;

            if (IsPostBack)
            {
                try
                {
                    //删除
                    if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        SKT.LeanMES.Material.BLL.WarehouseCheckOrder bll = new SKT.LeanMES.Material.BLL.WarehouseCheckOrder();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    //审核
                    if (Request.Form["hdnOperate"].ToLower() == "approve")
                    {
                        WarehouseCheckOrder bll = new WarehouseCheckOrder();
                        bll.Approve(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName, 1);
                        WebHelper.ShowMessage(Resources.Messages.SaveInSuccess);
                    }
                    //取消审核
                    if (Request.Form["hdnOperate"].ToLower() == "disapprove")
                    {
                        WarehouseCheckOrder bll = new WarehouseCheckOrder();
                        bll.Approve(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName, 0);
                        WebHelper.ShowMessage(Resources.Messages.SaveInSuccess);
                    }
                }
                catch (Exception err)
                {
                    WebHelper.HandleException(userName, err, true);
                }


            }
        }

        //绑定盘点类型
        public void BindPandOrderType()
        {
            PubItems.BLL.PubItems bll = new PubItems.BLL.PubItems();
            string jsonStr = bll.GetSelectType("Basal_WarehouseCheckType",
              "WarehouseCheckTypeId,WarehouseCheckTypeId,WarehouseCheckTypeName", "");

            JavaScriptSerializer jsonReader = new JavaScriptSerializer();
            List<WarehouseCheckType> warehouse = jsonReader.Deserialize<List<WarehouseCheckType>>(jsonStr);
            tdSelCheckType.DataSource = warehouse;
            tdSelCheckType.DataTextField = "ItemName";
            tdSelCheckType.DataValueField = "ItemIndex";
            tdSelCheckType.DataBind();
            this.tdSelCheckType.Items.Insert(0, new ListItem("全部", "-1"));
        }

        //绑定单据状态
        public void BindCheckOrderStatus()
        {
            PubItems.BLL.PubItems bll = new PubItems.BLL.PubItems();
            string jsonStr = bll.GetSelectType("Basal_WarehouseCheckStatus",
                "WarehouseCheckStatusId,WarehouseCheckStatusId,WarehouseCheckStatusName", "");

            JavaScriptSerializer jsonReader = new JavaScriptSerializer();
            List<WarehouseCheckType> warehouse = jsonReader.Deserialize<List<WarehouseCheckType>>(jsonStr);
            tdOrderStatus.DataSource = warehouse;
            tdOrderStatus.DataTextField = "ItemName";
            tdOrderStatus.DataValueField = "ItemIndex";
            tdOrderStatus.DataBind();
            this.tdOrderStatus.Items.Insert(0, new ListItem("全部", "-1"));
        }

        public class WarehouseCheckType
        {
            public int ItemIndex
            {
                get; set;
            }
            public string ItemName
            {
                get; set;
            }
            public List<int> Datas
            {
                get; set;
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    try
            //    {
            //        if (e.Row.Cells[1].Text == "")
            //        {
            //            e.Row.Cells[1].Text = "";
            //        } 
            //    }
            //    catch { }
            //}

        }


    }
}