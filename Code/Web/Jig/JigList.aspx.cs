using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SKT.LeanMES.Web.AjaxServices;
using System.IO;

namespace SKT.LeanMES.Web.Jig
{
    public partial class JigList : BasePage
    {
        private int columnIndex_JigStatus = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_JigStatus = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "JigStatus")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxJig));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "JigId";
            this.Master.DefaultSortExpression = "JigId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            //删除
            if (IsPostBack)
            {
                searchSettings.AddCondition("JigName", Server.HtmlEncode(this.txtJigName.Text));
                searchSettings.AddCondition("JigNickName", Server.HtmlEncode(this.txtJigNickName.Text));
                if (ddlJigStatus.SelectedValue != "0")
                {
                    searchSettings.AddCondition("JigStatus", ddlJigStatus.SelectedValue);
                }
                searchSettings.AddCondition("JigCode", this.txtJigCode.Text);
                searchSettings.AddCondition("Position", this.txtPosition.Text);

                if (!String.IsNullOrEmpty(this.txtDateFrom.Value) && !String.IsNullOrEmpty(this.txtDateTo.Value))
                {
                    searchSettings.ExtensionCondition = " CreateDateTime between '" + txtDateFrom.Value + "' and '" + txtDateTo.Value + "'";
                }

                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Jig.BLL.Jig bll = new SKT.LeanMES.Jig.BLL.Jig();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }
                else
                {
                    if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                    {
                        DataTable tb = new DataTable();
                        String JigName = txtJigName.Text;
                        String JigNickName = txtJigNickName.Text;
                        tb = BindData(JigName, JigNickName);
                        if (tb != null)
                        {
                            ExportToSpreadsheet(tb, DateTime.Now.ToShortDateString());
                        }
                    }
                    else
                    {
                        if (Request.Form["hdnOperate"].ToLower() == "scrap")
                        {
                            SKT.LeanMES.Jig.BLL.Jig bll = new SKT.LeanMES.Jig.BLL.Jig();
                            bll.Scrap(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                            WebHelper.ShowMessage(Resources.Messages.ScrapSuccess);
                        }
                    }
                }
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(String JigName, String JigNickName)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            SKT.LeanMES.Jig.BLL.Jig bll = new SKT.LeanMES.Jig.BLL.Jig();
            tb = bll.ImportToExcel(JigName, JigNickName);
            if (tb != null)
            {
                return tb;
            }
            else
            {
                return null;
            }
        }

        #region  DataTable导出到Excel
        public static void ExportToSpreadsheet(DataTable table, string name)
        {
            Random r = new Random();
            string rf = "";
            for (int j = 0; j < 10; j++)
            {
                rf = r.Next(int.MaxValue).ToString();
            }

            HttpContext context = HttpContext.Current;
            context.Response.Clear();

            context.Response.ContentType = "text/csv";
            context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" +  HttpUtility.UrlEncode( "夹具-" + name, System.Text.Encoding.UTF8) + ".xls");
            context.Response.BinaryWrite(System.Text.Encoding.UTF8.GetPreamble());

            foreach (DataColumn column in table.Columns)
            {
                context.Response.Write(column.ColumnName + ",");
                //context.Response.Write(column.ColumnName + "(" + column.DataType + "),");   
            }

            context.Response.Write(Environment.NewLine);
            double test;

            foreach (DataRow row in table.Rows)
            {
                for (int i = 0; i < table.Columns.Count; i++)
                {
                    switch (table.Columns[i].DataType.ToString())
                    {
                        case "System.String":
                            if (double.TryParse(row[i].ToString(), out test)) context.Response.Write("=");
                            context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                            break;
                        case "System.DateTime":
                            if (row[i].ToString() != "")
                                context.Response.Write("\"" + ((DateTime)row[i]).ToString("yyyy-MM-dd hh:mm:ss") + "\",");
                            else
                                context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                            break;
                        default:
                            context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                            break;
                    }
                }
                context.Response.Write(Environment.NewLine);
            }

            context.Response.End();

        }

        #endregion

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取。
                //14 改为columnIndex_JigStatus

                string s = e.Row.Cells[columnIndex_JigStatus].Text;
                switch (s)
                {
                    case "1": e.Row.Cells[columnIndex_JigStatus].Text = "正常";
                        break;
                    case "2": e.Row.Cells[columnIndex_JigStatus].Text = "报废";
                        break;
                    default: e.Row.Cells[columnIndex_JigStatus].Text = "";
                        break;
                }
            }
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            this.GridView1.AllowPaging = false;
            this.GridView1.AllowSorting = false;
            toExcel(this.GridView1);

            this.GridView1.AllowPaging = true;
            this.GridView1.AllowSorting = false;
        }

        private void Fun(GridView grd)
        {
            grd.AllowPaging = false;
        }

        /// <summary>
        /// 导出到Excel
        /// </summary>
        /// <param name="gv"></param>
        public void toExcel(GridView gv)
        {
            Response.Charset = "GB2312";
            Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");

            string fileName = "export.xls";
            string style = @"<style> .text { mso-number-format:\@; } </script> ";
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName);
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            //  this.gv.RenderControl(htw);
            gv.RenderControl(htw);
            Response.Write(style);
            Response.Write(sw.ToString());
            Response.End();
        }
        /// <summary>
        /// </summary>
        /// <param name="control"></param>
        public override void VerifyRenderingInServerForm(Control control) { }
    }
}