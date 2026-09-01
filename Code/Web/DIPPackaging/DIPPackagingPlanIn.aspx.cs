using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using AjaxPro;
using SKT.LeanMES.CommonLibrary.Common;

namespace SKT.LeanMES.Web.DIPPackaging
{
    public partial class DIPPackagingPlanIn : BasePage
    {
        public string dataXml = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(DIPPackagingPlanIn));
            if (!IsPostBack)
            {

                this.GridView1.EmptyDataText = Resources.Messages.EmptyDataText;
                this.GridView1.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";
                this.GridView1.CssClass = "ListTable";
                this.GridView1.HeaderStyle.CssClass = "ListTableHeader";
                this.GridView1.RowStyle.CssClass = "ListTableOddRow";
                this.GridView1.AlternatingRowStyle.CssClass = "ListTableEvenRow";
                this.GridView1.SelectedRowStyle.CssClass = "ListTableSelectedRow";
                this.GridView1.PagerStyle.CssClass = "ListTablePager";
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
        /// <summary>
        /// 数据导入
        /// </summary>
        /// <param name="dataXml1"></param>
        ///<param name="procName"></param>
        [AjaxMethod]
        public void DataImport(string dataXml1, string procName)
        {
            int userId = -1;
            SqlParameter[] parms = new SqlParameter[]{
                            new SqlParameter("@UserID", SqlDbType.VarChar,30),
                            new SqlParameter("@DataXml", SqlDbType.NVarChar)
                            };
            userId = AccountController.GetCurrentUser().UserId;
            try
            {
                parms[0].Value = userId;
                parms[1].Value = dataXml1;

                SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, procName, parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        public DataTable Distinct(DataTable dt, string[] filedNames)
        {
            DataView dv = dt.DefaultView;
            DataTable DistTable = dv.ToTable("Dist", true, filedNames);
            return DistTable;
        }

        public string[] GetColumnsByDataTable(DataTable dt)
        {
            string[] strColumns = null;
            if (dt.Columns.Count > 0)
            {
                int columnNum = 0;
                columnNum = dt.Columns.Count;
                strColumns = new string[columnNum];
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    strColumns[i] = dt.Columns[i].ColumnName;
                }
            }
            return strColumns;
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

                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/DIPPackagingPlan");

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
                    DataTable userNew = SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.QueryExcel(filePath, WebHelper.ExcelConnString);
                    System.Text.StringBuilder strBuilder = new System.Text.StringBuilder();
                    string[] strColumns = GetColumnsByDataTable(userNew);
                    //去掉DataTable中重复数据  add by weixia on 2018.4.25
                    DataTable userListTb = Distinct(userNew, strColumns);
                    if (userListTb != null && userListTb.Rows.Count > 0)
                    {
                        //
                        strBuilder.Append("<Root>");

                        for (int i = 0; i < userListTb.Rows.Count; i++)
                        {
                            if (String.IsNullOrEmpty(userListTb.Rows[i][0].ToString()))//Add By Alen 2018-01-25 增加空数据判断
                            {
                                continue;
                            }

                            strBuilder.Append("<DIPPackagingPlan ");

                            for (int j = 0; j < userListTb.Columns.Count; j++)
                            {
                                var attr = userListTb.Rows[i][j].ToString();
                                //特殊字符处理
                                attr = attr.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;");
                                if (attr.Trim() != "" || userListTb.Columns[j].ColumnName != "")
                                {
                                    strColumns[j] = userListTb.Columns[j].ColumnName;
                                    strBuilder.Append(userListTb.Columns[j].ColumnName);
                                    strBuilder.Append("=\"" + attr + "\" ");
                                }
                            }
                            strBuilder.Append(" ></DIPPackagingPlan>");
                        }
                        strBuilder.Append("</Root>");

                        GridView1.DataSource = userListTb;
                        GridView1.DataBind();
                        dataXml = strBuilder.ToString();
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
                    //File.Delete(filePath);
                }
            }
        }
    }
}