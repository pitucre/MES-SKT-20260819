using SKT.LeanMES.Sparepart.BLL;
using SKT.LeanMES.Warehouse.BLL;
using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.ESOP
{
    public partial class ESOPFastView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEsop));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ESOPId";
            this.Master.DefaultSortExpression = " ESOPId Desc ";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            searchSettings.ExtensionCondition = " 1=1 ";
            if (txtItemCode.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += " and (ItemCode like '%" + txtItemCode.Text.Trim() + "%' or ItemName like '%" + txtItemCode.Text.Trim() + "%' )";
            }
            if (txtESOPStationName.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += " and StationName like '%" + txtESOPStationName.Text.Trim() + "%' ";
            }
            if (txtESOPName.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += " and ESOPName like '%" + txtESOPName.Text.Trim() + "%' ";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    try
                    {
                        DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vw_ESOPFastViewList", "ORDER BY ESOPId DESC", searchSettings, "ESOPId", null);
                        var arrTemplateField = new string[] { "ESOPFileName" };
                        CommonMethod.ExportToSpreadsheet(ds, "ESOP快速查看列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, arrTemplateField, null, null);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //string fileName = e.Row.Cells[5].Text;

                //LocalFileExists
                //if (fileName.Contains("pdf"))
                //{
                //    e.Row.Cells[5].Text = "<a  class='media' href='"+ WebHelper.WebRoot + "/UploadFiles/ESOP/" + fileName + "'  target='_blank' >" + fileName + "</a>";
                //}
                //else if (fileName.Contains("webm") || fileName.Contains("mp4"))
                //{
                //    e.Row.Cells[5].Text = "<a href='"+ WebHelper.WebRoot + "/ESOP/DownLoad.aspx?fileName='" + fileName + "'  onclick=showPic(" + fileName + ") >" + fileName + "</a>";
                //}
                //else
                //{

                //    e.Row.Cells[5].Text = "<a  class='media' href='"+ WebHelper.WebRoot + "/UploadFiles/ESOP/" + fileName + "'  target='_blank' >" + fileName + "</a>";

                //}
            }

        }
    }
}