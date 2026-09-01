using Aspose.Cells;
using SKT.LeanMES.Warehouse.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.CommonDataSource;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    public partial class EquipmentInspectionItemListTreeImport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQualityInspection));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(ImportData));
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
        #region 上传文件 解析Excel
        /// <summary>
        /// 上传文件 解析Excel
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
            //check the loading list file
            if (!fuPickList.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                return;
            }
            else
            {
                string fileExtension = System.IO.Path.GetExtension(fuPickList.PostedFile.FileName).ToLower();
                string allowExtension = ".xls";
                string allowTwoExtension = ".xlsx";
                if (fileExtension != allowExtension && fileExtension != allowTwoExtension)
                {
                    WebHelper.ShowMessage(Resources.Messages.FileTypeError.ToString());
                    return;
                }
                

                //this.txtPickListName.Text = System.IO.Path.GetFileName(fuPickList.PostedFile.FileName).ToString().Substring(0, System.IO.Path.GetFileName(fuPickList.PostedFile.FileName).ToString().LastIndexOf("."));

            }

            try
            {
                if (fuPickList.HasFile)
                {
                    /*   string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + System.IO.Path.GetFileName(fuPickList.PostedFile.FileName).ToString();
                       string filePath = Server.MapPath("..\\TempFile");
                       if (!Directory.Exists(filePath))
                       {
                           try
                           {
                               Directory.CreateDirectory(filePath);
                           }
                           catch (Exception)
                           {
                               throw new ApplicationException("Create folder failed.");
                           }
                       }
                       //--end
                       fuPickList.PostedFile.SaveAs(filePath + "\\" + filename); //
                       filename = filePath + "\\" + filename;//

                       //  string strExtension = System.IO.Path.GetExtension(filename);
                       string strCom = "";
                       string strExtension = System.IO.Path.GetExtension(fuPickList.PostedFile.FileName).ToLower();
                       *//*  if (strExtension == ".xls")
                         {
                             strCom = GetSheetName(filename);
                         }*//*
                       string strCon = "";
                       switch (strExtension)
                       {
                           case ".xls":
                               strCon = " Provider = Microsoft.Jet.OLEDB.4.0 ; Data Source =" + filename + ";Extended Properties='Excel 8.0; HDR=NO; IMEX=1'";
                               break;
                           case ".xlsx":
                               strCon = " Provider = Microsoft.ACE.OLEDB.12.0 ; Data Source =" + filename + ";Extended Properties='Excel 12.0; HDR=NO; IMEX=1'";
                               break;
                           default:
                               strCon = "";
                               break;
                       }


                       OleDbConnection myConn = new OleDbConnection(strCon);
                       myConn.Open();

                       DataTable dtds = myConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                       strCom = dtds.Rows[0][2].ToString().Trim();
                       *//**//*



                       string StrSql = @"SELECT  F1 as  父节点,F2 as 名称,F3 as  录入方式 ,F4 as 排序 
                                       from  [" + strCom + "]  where not( F1='' or  F2='' or  F3=''  or  F4='' ) ";

                       //string StrSql = "SELECT * from  [" + strCom + "]";

                       OleDbDataAdapter myadapter = new OleDbDataAdapter(StrSql, myConn);
                       DataSet ds = new DataSet();
                       try
                       {
                           myadapter.Fill(ds, "[" + strCom + "]");
                       }
                       catch (Exception ex)
                       {
                           WebHelper.ShowMessage(ex.Message.ToString());
                           return;
                       }


                       DataTable dt = ds.Tables[0];*/
                    Aspose.Cells.Workbook workbook = new Aspose.Cells.Workbook(fuPickList.PostedFile.InputStream);
                    DataTable dt = workbook.Worksheets[0].Cells.ExportDataTable(0, 0, workbook.Worksheets[0].Cells.MaxDataRow + 1, workbook.Worksheets[0].Cells.MaxDataColumn + 1, new ExportTableOptions { ExportColumnName = true, SkipErrorValue = true });
                    int row = dt.Rows.Count;
                    if (row == 1)
                    {
                        WebHelper.ShowMessage("上传没有数据，请录入！");
                    }
                    //去除标题行
                    if (row > 1)
                    {
                        dt.Rows.Remove(dt.Rows[0]);
                    }
                    //VerifyOfflineGRN(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    System.Text.StringBuilder strBuilder = new System.Text.StringBuilder();
                    string[] strColumns = GetColumnsByDataTable(dt);
                    strBuilder.Append("<Root>");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (String.IsNullOrEmpty(dt.Rows[i][0].ToString()))//Add By Alen 2018-01-25 增加空数据判断
                        {
                            continue;
                        }

                        strBuilder.Append("<Feeder ");

                        for (int j = 0; j < dt.Columns.Count; j++)
                        {
                            var attr = dt.Rows[i][j].ToString();
                            //特殊字符处理
                            attr = attr.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;");
                            if (attr.Trim() != "" || dt.Columns[j].ColumnName != "")
                            {
                                strColumns[j] = dt.Columns[j].ColumnName;
                                strBuilder.Append(dt.Columns[j].ColumnName);
                                strBuilder.Append("=\"" + attr + "\" ");
                            }
                        }
                        strBuilder.Append(" ></Feeder>");
                    }
                    strBuilder.Append("</Root>");

                   // myConn.Close();
                }
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message.ToString());
                GridView1.DataSource = null;
                GridView1.DataBind();
                //this.txtPickListName.Text = ex.Message.ToString();

            }
        }
        #endregion

        #region 保存数据到数据库
        /// <summary>
        /// 保存数据到数据库
        /// </summary>
        /// <param name="dt"></param>
        public void VerifyOfflineGRN(DataTable dt)
        {
            List<WarehouseLocationInfo> list = null;
            try
            {
                SKT.LeanMES.Warehouse.BLL.Warehouse bllUnit = new LeanMES.Warehouse.BLL.Warehouse();
                list = bllUnit.checkExoportWareLocation(dt);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion


    }
}