using System;
using System.Data;

namespace SKT.LeanMES.Web.Transfers
{
    public partial class TransfersStorageList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "TransfersDtlId";
            this.Master.DefaultSortExpression = "CreateDateTime desc"; //也可不赋值


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("TransfersNo", txtTransfersNo.Text.Trim());
            searchSettings.AddCondition("SourceNo", txtSourceNo.Text.Trim());
            searchSettings.AddCondition("ErpCode", txtErpCode.Text.Trim());
            searchSettings.AddCondition("CName", txtCreateBy.Text.Trim());
            searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());         

            string txtCreateDateF = this.txtCreateDateF.Value.Trim();
            string txtCreateDateT = this.txtCreateDateT.Value.Trim();
            string createDateF = "";
            string createDateT = "";
            createDateF = txtCreateDateF;
            createDateT = txtCreateDateT;
            this.txtCreateDateF.Value = createDateF;
            this.txtCreateDateT.Value = txtCreateDateT;

            DateTime tmF;
            DateTime tmT;

            searchSettings.ExtensionCondition = " 1=1 ";

            if (createDateF != "" && txtCreateDateT != "")
            {
                if (!DateTime.TryParse(createDateF, out tmF) || !DateTime.TryParse(txtCreateDateT, out tmT))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " AND CreateDateTime BETWEEN '" + createDateF + "' AND '" +
                        Convert.ToDateTime(createDateT).AddDays(1).ToString("yyyy-MM-dd") + "' ";

                }
            }
            else
            {
                if (createDateF != "" && txtCreateDateT == "")
                {
                    if (!DateTime.TryParse(createDateF, out tmF))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += " AND ( CreateDateTime >= '" + createDateF + "')";

                    }
                }
                if (txtCreateDateT != "" && createDateF == "")
                {
                    if (!DateTime.TryParse(txtCreateDateT, out tmT))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += "AND (CreateDateTime <= '" + Convert.ToDateTime(createDateT).AddDays(1).ToString("yyyy-MM-dd") + "')";
                    }
                }
            }


            if (ddlType.SelectedValue != "")
            {
                searchSettings.ExtensionCondition += " AND TransfersType= " + ddlType.SelectedValue;
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //设定视图、表名
            this.Master.TableOrView = "vwTransfersStorageList";

            //删除
            if (IsPostBack)
            {
                //导出
                if (this.hdnOperate.Value.ToLower() == "exportexcel")
                {
                    DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwTransfersStorageList", "ORDER BY TransfersId DESC", searchSettings, "TransfersId", Request.Form["hdnIdString"].ToString());
                    var tempFiledNames = new string[] { "ApplyQty", "FinishQty" };
                    CommonMethod.ExportToSpreadsheet(ds, "调拨出库列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, tempFiledNames);
                }
            }
        }
    }
}