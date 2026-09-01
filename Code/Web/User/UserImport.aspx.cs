using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.User
{
    public partial class UserImport : BasePage
    {
        public string userXml = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));

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

                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/User");

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
                   // filePath = @"D://用户导入模板.xlsx";
                    DataTable userListTb = NPOIHelpers.Import(filePath); //SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.QueryExcel(filePath, WebHelper.ExcelConnString);
                    System.Text.StringBuilder strBuilder = new System.Text.StringBuilder();
                    List<string> userNames = new List<string>();
                    List<string> employeeNos = new List<string>();

                    //数据校验
                 
                    foreach (DataRow dr in userListTb.Rows)
                    {



                        #region 验证

                        var employeeNo = dr["工号"].ToString();
                        var depart = dr["部门"].ToString();
                        if(string.IsNullOrEmpty(employeeNo)||string.IsNullOrEmpty(depart))
                        {
                            WebHelper.ShowMessage(string.Format("部门或工号不能为空！"));
                            return;
                        }
                      


                        #endregion


                    }
                    
                    if (userListTb != null && userListTb.Rows.Count > 0)
                    {
                        strBuilder.Append("<Root>");

                        for (int i = 0; i < userListTb.Rows.Count; i++)
                        {
                            strBuilder.Append("<User ");

                            for (int j = 0; j < userListTb.Columns.Count; j++)
                            {
                                var attr = userListTb.Rows[i][j].ToString();
                                if (attr.Trim() != "")
                                {
                                    strBuilder.Append(userListTb.Columns[j].ColumnName);
                                    strBuilder.Append("=\"" + attr + "\" ");                                    
                                }
                            }
                            strBuilder.Append(" ></User>");
                        }
                        strBuilder.Append("</Root>"); 

                        GridView1.DataSource = userListTb;
                        GridView1.DataBind(); 
                        userXml = strBuilder.ToString();
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