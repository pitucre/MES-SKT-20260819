using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.NCCode
{
    public partial class NCCodeImport : System.Web.UI.Page
    {
        public string ncCodeXml = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxNCCode));

            this.GridView1.EmptyDataText = Resources.Messages.EmptyDataText;
            this.GridView1.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";

            this.GridView1.CssClass = "ListTable";
            this.GridView1.HeaderStyle.CssClass = "ListTableHeader";
            this.GridView1.RowStyle.CssClass = "ListTableOddRow";
            this.GridView1.AlternatingRowStyle.CssClass = "ListTableEvenRow";
            this.GridView1.SelectedRowStyle.CssClass = "ListTableSelectedRow";
            this.GridView1.PagerStyle.CssClass = "ListTablePager";
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                int id = e.Row.RowIndex + 1;
                e.Row.Cells[0].Text = id.ToString();
            }
        }

        protected void Upload_Click(object sender, EventArgs e)
        {
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

                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/NCode");

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
                    // filePath = @"D://不良代码导入模板.xlsx";
                    DataTable ncodeListTb = NPOIHelpers.Import(filePath);//SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.QueryExcel(filePath, WebHelper.ExcelConnString);
                    System.Text.StringBuilder strBuilder = new System.Text.StringBuilder();
                    List<string> userNames = new List<string>();
                    List<string> employeeNos = new List<string>();

                    if (ncodeListTb != null && ncodeListTb.Rows.Count > 0)
                    {
                        strBuilder.Append("<Root>");

                        for (int i = 0; i < ncodeListTb.Rows.Count; i++)
                        {
                            strBuilder.Append("<NCCode ");

                            for (int j = 0; j < ncodeListTb.Columns.Count; j++)
                            {
                                var attr = ncodeListTb.Rows[i][j].ToString();
                                if (attr.Trim() != "")
                                {
                                    strBuilder.Append(ncodeListTb.Columns[j].ColumnName);
                                    strBuilder.Append("=\"" + attr + "\" ");
                                }
                            }
                            strBuilder.Append(" ></NCCode>");
                        }
                        strBuilder.Append("</Root>");

                        GridView1.DataSource = ncodeListTb;
                        GridView1.DataBind();
                        ncCodeXml = strBuilder.ToString();
                    }

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
    }
}