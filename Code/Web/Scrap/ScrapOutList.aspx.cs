using SKT.LeanMES.Scrap.Model;
using System;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Scrap
{
    public partial class ScrapOutList : BasePage
    {
        private int columnIndex_ReceiveData = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ReceiveData = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ReceiveData")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxScrapStorage));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ScrapId";
            this.Master.DefaultSortExpression = "CreateDateTime desc"; //也可不赋值


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ScrapNo", txtScrapNo.Text.Trim());
            searchSettings.AddCondition("ErpCode", txtErpCode.Text.Trim());
            searchSettings.AddCondition("CName", txtCreateBy.Text.Trim());
            searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());

            string txtDateF = this.txtDateF.Value.Trim();
            string txtDateT = this.txtDateT.Value.Trim();
            string dateF = "";
            string dateT = "";
            dateF = txtDateF;
            dateT = txtDateT;
            this.txtDateF.Value = dateF;
            this.txtDateT.Value = dateT;

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
            if (txtDateF != "" && txtDateT != "")
            {
                if (!DateTime.TryParse(txtDateF, out tmF) || !DateTime.TryParse(txtDateT, out tmT))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " AND ScrapDateTime BETWEEN '" + dateF + "' AND '" +
                                            Convert.ToDateTime(dateT).AddDays(1).ToString("yyyy-MM-dd") + "' ";
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
                        searchSettings.ExtensionCondition += " AND ( ScrapDateTime >= '" + dateF + "')";

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
                        searchSettings.ExtensionCondition += "AND (ScrapDateTime <= '" + Convert.ToDateTime(dateT).AddDays(1).ToString("yyyy-MM-dd") + "')";
                    }
                }
            }

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

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;


            if (IsPostBack)
            {
                //导出
                if (this.hdnOperate.Value.ToLower() == "exportexcel")
                {
                    DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwScrapStorageList", "ORDER BY ScrapId DESC", searchSettings, "ScrapId", Request.Form["hdnIdString"].ToString());
                    CommonMethod.ExportToSpreadsheet(ds, "报废出库列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, null);
                }
            }
        }


        #region GridView行绑定
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //11改为columnIndex_ReceiveData
                ScrapStorageInfo info = e.Row.DataItem as ScrapStorageInfo;
                if (info.ReceiveData.ToString("yyyy-MM-dd HH:mm:ss") == "9999-12-31 00:00:00")
                {
                    e.Row.Cells[columnIndex_ReceiveData].Text = "";
                }
                else
                {
                    e.Row.Cells[columnIndex_ReceiveData].Text = info.ReceiveData.ToString("yyyy-MM-dd HH:mm:ss");
                }
            }
        }
        #endregion
    }
}