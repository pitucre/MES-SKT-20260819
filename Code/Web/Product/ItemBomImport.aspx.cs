using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using Newtonsoft.Json;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemBomImport : BasePage
    {
        public string bomChildJson;
       
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));

            this.GridView1.EmptyDataText = Resources.Messages.EmptyDataText;
            this.GridView1.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";

            this.GridView1.CssClass = "ListTable";
            this.GridView1.HeaderStyle.CssClass = "ListTableHeader";
            this.GridView1.RowStyle.CssClass = "ListTableOddRow";
            this.GridView1.AlternatingRowStyle.CssClass = "ListTableEvenRow";
            this.GridView1.SelectedRowStyle.CssClass = "ListTableSelectedRow";
            this.GridView1.PagerStyle.CssClass = "ListTablePager";
        }

        protected void Upload_Click(object sender, EventArgs e)
        {
            this.txtItemCode.Text = this.hdnItemCode.Value;
            this.lblItemName.Text = this.hdnItemName.Value;
            
            if (!fileBomUrl.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                return;
            }
            else
            {
                string fileExtension = System.IO.Path.GetExtension(fileBomUrl.PostedFile.FileName).ToLower();
                string allowExtension = ".xls";
                string allowTwoExtension = ".xlsx";
                if (fileExtension != allowExtension && fileExtension != allowTwoExtension)
                {
                    WebHelper.ShowMessage(Resources.Messages.FileTypeError.ToString());
                    return;
                }

                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/BOM");

                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                string filePath = path + "/" + fileBomUrl.FileName;
                this.fileBomUrl.PostedFile.SaveAs(filePath);
                fileBomUrl.PostedFile.InputStream.Close();
                fileBomUrl.PostedFile.InputStream.Dispose();

                try
                {
                    DataTable list = NPOIHelpers.Import(filePath);/* SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.QueryExcel(filePath, WebHelper.ExcelConnString);*/
                   // ViewState["dt"] = list;
                    GridView1.DataSource = list;
                    GridView1.DataBind();
                    bomChildJson = JsonConvert.SerializeObject(list);                   
                }
                catch (Exception ex)
                {
                    WebHelper.ShowMessage(ex.Message);
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                }
                finally
                {
                    
                    File.Delete(filePath);
                }
            }
        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                int id = e.Row.RowIndex + 1;
                e.Row.Cells[0].Text = id.ToString();
            }
        }

        protected void btnView_Click(object sender, EventArgs e)
        {

            DataTable dt = (DataTable)ViewState["dt"];
            if (dt != null && dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
           
            
        }
    }
}