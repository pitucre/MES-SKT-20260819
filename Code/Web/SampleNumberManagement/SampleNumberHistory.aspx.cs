using SKT.LeanMES.Web.Utility;
using System;
using System.Data;

namespace SKT.LeanMES.Web.SampleNumberManagement
{
    public partial class SampleNumberHistory : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SampleNumberOprateLogId";
            this.Master.DefaultSortExpression = "CreateTime DESC"; //也可不赋值
            this.Master.PageSize = 8;
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("OrderNo", txtProOrderNo.Text.Trim());
            searchSettings.AddCondition("SampleNumber", txtSampleNumber.Text.Trim());
            searchSettings.AddCondition("Station", txtStationCode.Text.Trim());
            searchSettings.AddCondition("LineName", txtLineCode.Text.Trim());

            string txtDateF = this.txtDateF.Value.Trim();
            string txtDateT = this.txtDateT.Value.Trim();
            string dateF = "";
            string dateT = "";
            dateF = txtDateF;
            dateT = txtDateT;
            this.txtDateF.Value = dateF;
            this.txtDateT.Value = dateT;
            DateTime tmF;
            DateTime tmT;

            searchSettings.ExtensionCondition = " 1=1 ";
            if (txtDateF != "" && txtDateT != "")
            {
                if (!DateTime.TryParse(txtDateF, out tmF) || !DateTime.TryParse(txtDateT, out tmT))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " AND CreateTime BETWEEN '" + dateF + "' AND '" + Convert.ToDateTime(dateT).AddDays(1).ToString("yyyy-MM-dd") + "' ";
                }
            }
            else
            {
                if (txtDateF != "" && txtDateT == "")
                {
                    if (!DateTime.TryParse(txtDateF, out tmF))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += " AND ( CreateTime >= '" + dateF + "')";

                    }
                }
                if (txtDateT != "" && txtDateF == "")
                {
                    if (!DateTime.TryParse(txtDateT, out tmT))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += "AND (CreateTime <= '" + Convert.ToDateTime(dateT).AddDays(1).ToString("yyyy-MM-dd") + "')";
                    }
                }
            }
           
            this.Master.TableOrView = "vwSampleNumberOprateLog";
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (this.IsPostBack)
            {
                try
                {
                    //导出
                    if (this.hdnOperate.Value.ToLower() == "exportexcel")
                    {
                        DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwSampleNumberOprateLog", "ORDER BY SampleNumberOprateLogId DESC", searchSettings, "SampleNumberOprateLogId", this.hdnIdString.Value);
                        CommonMethod.ExportToSpreadsheet(ds, "样机使用记录列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }
        }
    }
}