using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Scrap
{
    public partial class ScrapNoBillOut : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ScrapId";
            this.Master.DefaultSortExpression = "CreateDateTime DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string ScrapNumber = this.txtScrapNumber.Value;
            searchSettings.AddCondition("ScrapOrder", ScrapNumber);

            string txtDateFrom = this.txtDateFrom.Value.Trim();
            string txtDateTo = this.txtDateTo.Value.Trim();
            string dateFrom = "";
            string dateTo = "";

            dateFrom = txtDateFrom;
            dateTo = txtDateTo;
            this.txtDateFrom.Value = dateFrom;
            this.txtDateTo.Value = dateTo;
            DateTime tmFrom;
            DateTime tmTo;
            if (txtDateFrom != "" && txtDateTo == "")
            {
                if (!DateTime.TryParse(txtDateFrom, out tmFrom))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += "( CreateDateTime > '" +dateFrom + "')";
                }
            }
            else if (txtDateTo != "" && txtDateFrom == "")
            {
                if (!DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += "(CreateDateTime <= '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd") + "')";
                }
            }
            else if (txtDateFrom != "" && txtDateTo != "")
            {
                //判断日期
                if (!DateTime.TryParse(txtDateFrom, out tmFrom) || !DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    //判断日期
                    searchSettings.ExtensionCondition += " CreateDateTime between '" + dateFrom + "' and '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd") + "' ";
                }
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}