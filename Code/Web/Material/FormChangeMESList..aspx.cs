using SKT.LeanMES.Warehouse.BLL;
using System;
using System.Data;

namespace SKT.LeanMES.Web.Material
{
    public partial class FormChangeMESList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCpInList));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "FromChangeByMESDtId";
            Master.DefaultSortExpression = "FromChangeByMESDtId DESC"; //也可不赋值

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
                if (!string.IsNullOrEmpty(txtMaterialCode.Text.ToString()))
                {
                    searchSettings.AddCondition("PreConversionMaterial", "%" + txtMaterialCode.Text.ToString() + "%");
                }

                if (!string.IsNullOrEmpty(textInStockNo.Text.ToString()))
                {
                    searchSettings.AddCondition("FromChangeByMESNo", "%" + textInStockNo.Text.ToString() + "%");
                }

                if (!string.IsNullOrEmpty(textWarehouseCode.Text.ToString()))
                {
                    searchSettings.AddCondition("CWhCode", textWarehouseCode.Text.ToString());
                }
                if (!string.IsNullOrEmpty(textInStockBy.Text.ToString()))
                {
                    searchSettings.AddCondition("CreateBy", textInStockBy.Text.ToString());
                }
                if (!string.IsNullOrEmpty(txtERPNo.Text.ToString()))
                {
                    searchSettings.AddCondition("ERPNo", txtERPNo.Text.ToString());
                }
                if (!string.IsNullOrEmpty(txtStrDate.Text.Trim()) && string.IsNullOrEmpty(txtEndDate.Text.Trim()))
                {
                    strWhere += " and  CreateDateTime > '" + txtStrDate.Text.Trim() + "'";
                }
                if (string.IsNullOrEmpty(txtStrDate.Text.Trim()) && !string.IsNullOrEmpty(txtEndDate.Text.Trim()))
                {
                    strWhere += " and  CreateDateTime < '" + txtStrDate.Text.Trim() + "'";
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
                }
  
               
            }
            searchSettings.ExtensionCondition = strWhere;
           
            //删除
            if (IsPostBack)
            {
               
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    try
                    {
                        DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwFromChangeByMES", "ORDER BY FromChangeByMESDtId DESC", searchSettings, "FromChangeByMESDtId", null);
                        var arrTemplateField = new string[] { };
                        CommonMethod.ExportToSpreadsheet(ds, "形态转换列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, arrTemplateField, null, null);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
          
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

    }
}