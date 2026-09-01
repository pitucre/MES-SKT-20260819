using Microsoft.Office.Interop.Excel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Hold
{
    public partial class QHoldImport : BasePage
    {
        public string feederXml = string.Empty;

        public string IsEmpty = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
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

                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/Qhold");

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

                    System.Data.DataTable userListTb = NPOIHelpers.Import(filePath); //SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.QueryExcel(filePath, WebHelper.ExcelConnString);
                    System.Text.StringBuilder strBuilder = new System.Text.StringBuilder();
                    List<string> lis = new List<string>();
                    System.Data.DataTable userTab = userListTb.Clone();
                    IsEmpty = "";
                    if (userListTb != null && userListTb.Rows.Count > 0)
                    {
                        strBuilder.Append("<Root>");

                        for (int i = 0; i < userListTb.Rows.Count; i++)
                        {
                            string sQhold = " ";
                            bool bNotEmpty = false;

                            for (int j = 0; j < userListTb.Columns.Count; j++)
                            {


                                //if (!lis.Contains(userListTb.Rows[i][0].ToString()))
                                // {
                                // lis.Add(userListTb.Rows[i][0].ToString());

                                var attr = userListTb.Rows[i][j].ToString();
                                if (attr.Trim() != "" || userListTb.Columns[j].ColumnName != "")
                                {
                                    sQhold = sQhold + userListTb.Columns[j].ColumnName;
                                    sQhold = sQhold + "=\"" + attr + "\" ";
                                }

                                if (attr.Trim() != "")
                                {
                                    bNotEmpty = true;
                                }
                                else
                                {
                                    IsEmpty = userListTb.Columns[j].ColumnName + "列，不能为空";
                                         WebHelper.ShowMessage(userListTb.Columns[j].ColumnName+"列，不能为空");
                                }
                                //}
                            }

                            if (bNotEmpty)
                            {
                                userTab.Rows.Add(userListTb.Rows[i].ItemArray);
                                strBuilder.Append(string.Format("<Qhold {0}></Qhold>", sQhold));
                            }
                        }
                        strBuilder.Append("</Root>");
                    }

                    if (userListTb.Columns.Count == 2)
                    {
                        feederXml = strBuilder.ToString();
                        GridView1.DataSource = userTab;
                        GridView1.DataBind();
                    }
                    else
                    {
                        WebHelper.ShowMessage("Excel导入列不匹配");
                        GridView1.DataSource = null;
                        GridView1.DataBind();
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