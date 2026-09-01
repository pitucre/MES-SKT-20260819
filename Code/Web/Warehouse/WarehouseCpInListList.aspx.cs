using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Warehouse.BLL;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Collections.Generic;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseCpInListList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCpInList));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WarehouseCpInListId";
            Master.DefaultSortExpression = "WarehouseCpInListId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            var strWhere = "";

            if (!IsPostBack)
            {
                strWhere = "1=2";
                DateTime dt = DateTime.Now.Date;
                txtStrDate.Text = dt.AddDays(-7).ToString("yyyy-MM-dd HH:mm:ss");
                txtEndDate.Text = dt.AddDays(+1).AddSeconds(-1).ToString("yyyy-MM-dd HH:mm:ss");
            }
            else
            {
                strWhere = "1=1";
                if (!string.IsNullOrEmpty(textWorkOrderNo.Text.ToString()))
                {
                    //strWhere += " and   WorkOrderNo LIKE '" + textWorkOrderNo.Text.ToString() + "%'";
                    searchSettings.AddCondition("WorkOrderNo", "%" + textWorkOrderNo.Text.ToString() + "%");
                }
                if (!string.IsNullOrEmpty(textInStockNo.Text.ToString()))
                {
                    //strWhere += " and   t5.StorageNumber LIKE '" + textInStockNo.Text.ToString() + "%'";
                    searchSettings.AddCondition("InStockNo", "%" + textInStockNo.Text.ToString() + "%");
                }
                if (!string.IsNullOrEmpty(textItemCode.Text.ToString()))
                {
                    //strWhere += " and   t1.ItemCode LIKE '" + textItemCode.Text.ToString() + "%'";
                    searchSettings.AddCondition("ItemCode", "%" + textItemCode.Text.ToString() + "%");
                }
                if (!string.IsNullOrEmpty(textWarehouseCode.Text.ToString()))
                {
                    //strWhere += " and   t7.CWhCode LIKE '" + textWarehouseCode.Text.ToString() + "%'";
                    searchSettings.AddCondition("CWhCode", textWarehouseCode.Text.ToString());
                }
                if (!string.IsNullOrEmpty(textInStockBy.Text.ToString()))
                {
                    //strWhere += " and  t5.CreateBy LIKE '" + textInStockBy.Text.ToString() + "%'";
                    searchSettings.AddCondition("CreateBy", textInStockBy.Text.ToString());
                }
                if (!string.IsNullOrEmpty(txtStrDate.Text.Trim()) && string.IsNullOrEmpty(txtEndDate.Text.Trim()))
                {
                    strWhere += " and  CreateDateTime > '" + txtStrDate.Text.Trim() + "'";
                    //  searchSettings.ExtensionCondition = " t5.CreateDateTime  >" + txtStrDate.Value.Trim();
                }
                if (string.IsNullOrEmpty(txtStrDate.Text.Trim()) && !string.IsNullOrEmpty(txtEndDate.Text.Trim()))
                {
                    strWhere += " and  CreateDateTime < '" + txtStrDate.Text.Trim() + "'";
                    //searchSettings.ExtensionCondition = " t5.CreateDateTime  <" + txtStrDate.Value.Trim();
                }
                if (!string.IsNullOrEmpty(txtStrDate.Text.Trim()) && !string.IsNullOrEmpty(txtEndDate.Text.Trim()))
                {
                    string sd = txtStrDate.Text.Trim();
                    string ed = txtEndDate.Text.Trim();
                    if (Convert.ToDateTime(ed).CompareTo(Convert.ToDateTime(sd)) < 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('结束时间不能小于开始时间')</script>");
                        return;
                    }
                    strWhere += " and CreateDateTime  between '" + sd + "'  and  '" + ed + "'";
                    // searchSettings.ExtensionCondition = " t5.CreateDateTime   between '" + sd + "'  and  '" + ed + "'";
                    //if (sd == ed)
                    //{
                    //    ed = Convert.ToDateTime(ed).AddDays(1).ToString("yyyy-MM-dd HH:mm:ss");
                    //    searchSettings.ExtensionCondition = " CreateDateTime  between '" + sd + "'  and  '" + ed + "'";
                    //}
                    //else
                    //{
                    //    searchSettings.ExtensionCondition = " CreateDateTime  between '" + sd + "'  and  '" + ed + "'";
                    //}
                }
  
                if (!string.IsNullOrEmpty(txtSerialNumber.Text.ToString()))
                {
                    strWhere += " and   WarehouseCpInListId = (select StorageID from Prod_StorageMember where (SerialNumber='"+ txtSerialNumber.Text.ToString() + "') OR (CustomerSN='" + txtSerialNumber.Text.ToString() + "'))";
                   // searchSettings.AddCondition("SerialNumber", txtSerialNumber.Text.ToString());
                }
            }
            searchSettings.ExtensionCondition = strWhere;
            //if (!string.IsNullOrEmpty(textSN.Text.ToString()))
            //{
            //    searchSettings.AddCondition("SNId", textSN.Text.ToString());
            //}
            //if (!string.IsNullOrEmpty(TextBox_PalletCode.Text.ToString()))
            //{
            //    searchSettings.AddCondition("PalletCode", TextBox_PalletCode.Text.ToString());
            //}
            //if (!string.IsNullOrEmpty(TextBox_ContainerCode.Text.ToString()))
            //{
            //    searchSettings.AddCondition("ContainerCode", TextBox_ContainerCode.Text.ToString());
            //}
            //删除
            if (IsPostBack)
            {
                //if (ddlStatus.SelectedValue != "-1")
                //{
                //    searchSettings.AddCondition("StatusId", ddlStatus.SelectedValue);
                //}
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    WarehouseCpInList bll = new WarehouseCpInList();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    try
                    {
                        DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwCpInStockPar", "ORDER BY WarehouseCpInListId DESC", searchSettings, "WarehouseCpInListId", null);
                        var arrTemplateField = new string[] { };
                        CommonMethod.ExportToSpreadsheet(ds, "成品入库列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, arrTemplateField, null, null);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
            //else
            //{
            //    ddlStatus.SelectedIndex = 4;
            //    searchSettings.AddCondition("StatusId", "3");
            //}
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

    }
}