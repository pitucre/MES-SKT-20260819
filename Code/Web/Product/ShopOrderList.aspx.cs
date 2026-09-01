using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.Controls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.Model;
using SKT.LeanMES.Order.BLL;
using SKT.LeanMES.Web;
using SKT.LeanMES.Order.Model;
using SKT.LeanMES.PubItems.BLL;
using SKT.LeanMES.PubItems.Model;
using System.Linq;

namespace SKT.MES.Web.Production
{
    public partial class ShopOrderList : BasePage
    {
        public int IsFirstLoad = 0;//标记是否初次加载
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(PageSQLService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ProdOrderID";
            this.Master.DefaultSortExpression = "ProdOrderID DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "(1=1) ";

            if (!IsPostBack)
            {
                IsFirstLoad = 1;
                searchSettings.ExtensionCondition += "AND ProdOrderID = -1";
            }
            else
            {
                //if (hdnRId.Value!="-1")
                //{
                //    searchSettings.ExtensionCondition += " AND RouterId =" + hdnRId.Value+ "";
                //}
                if (!string.IsNullOrWhiteSpace(txtRouter.Text))
                {
                    searchSettings.AddCondition("R_Name", txtRouter.Text);
                }
                
                if (ddlOrderType.SelectedValue != "-1")
                {
                    searchSettings.AddCondition("OrderType", ddlOrderType.SelectedValue);
                }

                if (ddlIsMESadd.SelectedValue != "-1")
                {
                    searchSettings.AddCondition("IsMESadd", ddlIsMESadd.SelectedValue);
                }

                if (!string.IsNullOrEmpty(this.txtOrderNo.Text))
                {
                    searchSettings.AddCondition("OrderNO", this.txtOrderNo.Text);
                }

                if (!string.IsNullOrEmpty(this.txtItem.Text))
                {
                    searchSettings.AddCondition("ItemCode", this.txtItem.Text);
                }

                if (!string.IsNullOrEmpty(this.txtCustName.Text))
                {
                    searchSettings.ExtensionCondition += " AND CustomerName LIKE N'%" + txtCustName.Text + "%' ";
                }
                if (!string.IsNullOrEmpty(txtPlanBegin.Text))
                {
                    searchSettings.AddCondition("CONVERT(varchar(10),Planned_Start_Time,120)", txtPlanBegin.Text);
                }
                if (hfStrOrderStatus.Value != "")
                {
                    searchSettings.ExtensionCondition += " AND [Status] IN (" + hfStrOrderStatus.Value.ToString() + ")";
                }
                if (!string.IsNullOrEmpty(this.txtCustomerOrder.Text))
                {
                    searchSettings.AddCondition("CustomerOrder", this.txtCustomerOrder.Text);
                }
            }
            this.Master.SearchSettings = searchSettings;
            if (!this.IsPostBack) { hfStrOrderStatus.Value = ""; }

            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        /***Modify 原来只支持删除单个选项，改后支持删除多个***/
                        //SKT.LeanMES.Order.BLL.ShopOrder bll = new SKT.LeanMES.Order.BLL.ShopOrder();
                        //bll.Delete(Convert.ToInt32(Request.Form["hdnIdString"].ToString()), AccountController.GetCurrentUser().UserName);
                        //WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);                        SKT.LeanMES.Order.BLL.ShopOrder bll = new SKT.LeanMES.Order.BLL.ShopOrder();
                        SKT.LeanMES.Order.BLL.ShopOrder bll = new SKT.LeanMES.Order.BLL.ShopOrder();
                        string idStr = Request.Form["hdnIdString"].ToString();
                        if (idStr != null)
                        {
                            String[] idA = idStr.Split(',');
                            foreach (string id in idA)
                            {
                                bll.Delete(Convert.ToInt32(id), AccountController.GetCurrentUser().UserName);
                            }
                            WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                        }

                        /******/
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
                if (Request.Form["hdnOperate"].ToLower() == "bindgroup")
                {
                    string idStr = Request.Form["hdnIdString"].ToString();
                    SKT.LeanMES.Order.BLL.ShopOrder bll = new SKT.LeanMES.Order.BLL.ShopOrder();
                    String[] idA = idStr.Split(',');
                    Int32 id1 = 0;
                    Int32 id2 = 0;
                    Int32 id3 = 0;
                    Int32 id4 = 0;
                    if(idA.Length ==1)
                    {
                        WebHelper.ShowMessage("至少两个工单才能关联组");
                    }
                    else
                    {
                        if(idA.Length ==2)
                        {
                            id1 = Convert.ToInt32(idA[0]);
                            id2 = Convert.ToInt32(idA[1]);
                        }
                        if (idA.Length == 3)
                        {
                            id1 = Convert.ToInt32(idA[0]);
                            id2 = Convert.ToInt32(idA[1]);
                            id3 = Convert.ToInt32(idA[2]);
                        }
                        if (idA.Length > 3)
                        {
                            id1 = Convert.ToInt32(idA[0]);
                            id2 = Convert.ToInt32(idA[1]);
                            id3 = Convert.ToInt32(idA[2]);
                            id4 = Convert.ToInt32(idA[3]);
                        }
                        try
                        {
                            bll.AddProdOrderGroup(id1, id2, id3, id4, idStr, AccountController.GetCurrentUser().UserName);
                        }
                        catch(Exception ex)
                        {
                            WebHelper.ShowMessage(ex.Message);
                        }
                        
                    }
                    
                }
                if (Request.Form["hdnOperate"].ToLower() == "releasegroup")
                {
                    string idStr = Request.Form["hdnIdString"].ToString();
                    SKT.LeanMES.Order.BLL.ShopOrder bll = new SKT.LeanMES.Order.BLL.ShopOrder();
                    String[] idA = idStr.Split(',');
                    try
                    {
                        Int32 GroupId = 0;
                        foreach(var id in idA)
                        {
                            if(id.Trim()!="")
                            {
                                GroupId = Convert.ToInt32(id);
                                break;
                            }
                        }
                        if(GroupId >0)
                        {
                            bll.ReleaseProdOrderGroup(GroupId, AccountController.GetCurrentUser().UserName);

                        }
                        else
                        {
                            WebHelper.ShowMessage("请选择待解除工单组");
                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }

            //生成工单状态checkbox
            SKT.Common.Model.SearchSettings searchSettingsB = new SKT.Common.Model.SearchSettings();
            searchSettingsB.ExtensionCondition = "StatusID >= 0 AND StatusFlag >0";
            hfCheckBox.Value = (new PubItems()).GetOrderStatus("StatusID", searchSettingsB);

        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                SKT.LeanMES.Order.Model.ShopOrderInfo entity = e.Row.DataItem as SKT.LeanMES.Order.Model.ShopOrderInfo;
                e.Row.Attributes.Add("ItemID", entity.ItemId.ToString());
                e.Row.Attributes.Add("RouteID", entity.RouterId.ToString());
                e.Row.Attributes.Add("ItemVer", entity.ItemVer);
                e.Row.Attributes.Add("ItemName2", entity.ItemName2);
                e.Row.Attributes.Add("BOMID", entity.BOMId.ToString());
                e.Row.Attributes.Add("OrderType", entity.OrderType.ToString());
                e.Row.Attributes.Add("IsMESadd", entity.IsMESadd);
                e.Row.Attributes.Add("RouterName", entity.RouterName);

                //e.Row.Cells[13].Text = SKT.Common.Utility.TypeHelper.ToShortDateString(Convert.ToDateTime(e.Row.Cells[13].Text));
                //e.Row.Cells[14].Text = SKT.Common.Utility.TypeHelper.ToShortDateString(Convert.ToDateTime(e.Row.Cells[14].Text));

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //19改为columnIndex_ModifyBy&nbsp;
                //20改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;" || e.Row.Cells[columnIndex_ModifyBy].Text == "-1") {
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
                    e.Row.Cells[columnIndex_ModifyBy].Text = "";
                }

            }

        }
    }
}