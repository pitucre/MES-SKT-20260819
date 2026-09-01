using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.BLL;
using System.Configuration;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionIPQCList : BasePage
    {
        private int columnIndex_Statue = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Statue = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Statue")) + 1;
            Master.PageGridView = GridView1;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "ProductIPQCId";
            Master.DefaultSortExpression = "ProductIPQCId desc";

            Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
            searchSettings.AddCondition("ProductIPQCNo", txtIqcBatchNO.Text.Trim());
            if (this.selIQCType.Value != "")
            {
                searchSettings.AddCondition("Statue", this.selIQCType.Value);
            }
            searchSettings.AddCondition("ItemName", txtItemName.Text.Trim());
            searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());

            Master.SearchSettings = searchSettings;
            GridView1.PageIndex = 0;

            //设定视图、表名
            this.Master.TableOrView = "vwProductIPQCList";

            ProductIPQC IpqcBLL = new ProductIPQC();
            ProductPQC PqcBLL = new ProductPQC();
            if (this.hdnOperate.Value.ToLower() == "oqcpdfprint")
            {
                string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "PQCFormReportFile.xml";
                string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                string strFileName = PqcBLL.GetPQCFormPdf(Convert.ToInt32(Request.Form["hdnIdString"]), strTargePath, strXmlPath, CommonMethod.WebRoot);
                this.hdnOperate.Value = "";
                if (strFileName != "")
                {
                    //导出文件
                    CommonMethod.exportFile(strFileName, strTargePath);
                }
            }
            else if (this.hdnOperate.Value.ToLower() == "ipqcreportpdfprint")
            {
                string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IPQCReportFile.xml";
                if (this.hdShiftType.Value == "晚班")
                {
                    strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IPQCReportFileS.xml";
                }
                string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                string strFileName = IpqcBLL.GetIPQCReportPdf(Convert.ToInt32(Request.Form["hdnIdString"]), strTargePath, strXmlPath, CommonMethod.WebRoot);
                this.hdnOperate.Value = "";
                //导出文件
                CommonMethod.exportFile(strFileName, strTargePath);
            }
        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //7改为columnIndex_Statue
                if (e.Row.Cells[columnIndex_Statue].Text == "0")
                {
                    e.Row.Cells[columnIndex_Statue].Text = "待检";
                }
                else if (e.Row.Cells[columnIndex_Statue].Text == "1")
                {
                    e.Row.Cells[columnIndex_Statue].Text = "已检";
                }
                else
                {
                    e.Row.Cells[columnIndex_Statue].Text = "";
                }
            }
        }
    }
}