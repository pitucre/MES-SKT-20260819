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
    public partial class InspectionPQCList : BasePage
    {
        private int columnIndex_Statue = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Statue = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Statue")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));

            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "ProductPQCId";
            Master.DefaultSortExpression = "ProductPQCId";
            Master.DefaultSortDirection = SortDirection.Descending;
            Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
            searchSettings.AddCondition("ProductPQCNo", txtIqcBatchNO.Text.Trim());
            if (this.selIQCType.Value != "")
            {
                searchSettings.AddCondition("Statue", this.selIQCType.Value);
            }
            searchSettings.AddCondition("ItemName", txtItemName.Text.Trim());
            searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());

            //searchSettings.ExtensionCondition = "InspectionTypeId=1";
            Master.SearchSettings = searchSettings;
            GridView1.PageIndex = 0;
            ProductOQC OqcBLL = new ProductOQC();
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
            else if (this.hdnOperate.Value.ToLower() == "oqcreportpdfprint")
            {
                string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "PQCReportFile.xml";
                string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                string strFileName = PqcBLL.GetPQCReportPdf(Convert.ToInt32(Request.Form["hdnIdString"]), strTargePath, strXmlPath, CommonMethod.WebRoot);
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