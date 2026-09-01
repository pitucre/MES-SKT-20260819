/*================================================================
* Copyright (C) 2016 深圳市深科特信息技术有限公司
* 版权所有。
*
* 文件名：ExcelHelper.cs
* 文件功能描述：Excel操作类，两种方式操作Excel: 1 - 服务器上安装Office; 2 - 服务器上不需要安装Office; 
*
* 创建标识： 
*
* 修改标识： Alen Liu 20160420
* 修改描述： 增加服务器上不需要安装Office而直接操作Excel的方法
==================================================================*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    /// <summary>
    /// Excel操作类，两种方式操作Excel: 
    /// 1 - 服务器上安装Excel; 
    /// 2 - 服务器上不需要安装Excel; 
    /// </summary>
    public static class ExcelHelper
    {
        #region Excel导出，服务器上需安装Excel
        /// <summary>
        /// 导出Datatable到excel，服务器上需安装Excel
        /// </summary>
        /// <param name="dt">datatable数据</param>
        /// <param name="filename">导出要保存的文件名</param>
        /// <param name="encoding">编码：GB2312,UTF-8</param>
        public static void ExportToExcel(DataTable dt, string filename, string encoding)
        {
            Export(dt, filename, encoding);
        }

        /// <summary>
        /// 导出dataset到excel，服务器上需安装Excel
        /// </summary>
        /// <param name="ds">dataset 数据集</param>
        /// <param name="filename">导出要保存的文件名</param>
        /// <param name="encoding">编码：GB2312,UTF-8</param>
        public static void ExportToExcel(DataSet ds, string filename, string encoding)
        {
            Export(ds.Tables[0], filename, encoding);
        }

        /// <summary>
        /// 导出dataset到excel，服务器上需安装Excel
        /// </summary>
        /// <param name="dt">数据表</param>
        /// <param name="filename">导出要保存的文件名</param>
        public static void ExportToExcel(DataTable dt, string filename)
        {
            Export(dt, filename, "utf-8");
        }

        /// <summary>
        /// 导出dataset到excel，服务器上需安装Excel
        /// </summary>
        /// <param name="dt">数据表</param>
        public static void ExportToExcel(DataTable dt)
        {
            string filename = Guid.NewGuid().ToString();
            Export(dt, filename, "utf-8");
        }

        /// <summary>
        /// Excel导出，服务器上需安装Excel
        /// </summary>
        /// <param name="dt">DataTable数据表</param>
        /// <param name="filename">导出要保存的文件名</param>
        /// <param name="encoding">编码：GB2312,UTF-8</param>
        private static void Export(DataTable dt, string filename, string encoding)
        {
            HttpContext.Current.Response.Charset = encoding;
            System.Web.HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding(encoding);

            //设置输出文件类型为excel文件
            HttpContext.Current.Response.ContentType = "application/ms-excel";

            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + "" + HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8).ToString());

            //设置数字为文本格式
            string strStyle = "<style>td{mso-number-format:\"\\@\";}</style>";
            //定义StringWriter输出对象
            System.IO.StringWriter tw = new System.IO.StringWriter();
            //定义HtmlTextWriter对象
            HtmlTextWriter hw = new HtmlTextWriter(tw);

            hw.WriteLine(strStyle);
            GridView gv = new GridView();
            gv.DataSource = dt;
            gv.DataBind();
            gv.RenderControl(hw);
            //输出
            HttpContext.Current.Response.Write("<html><head><meta http-equiv=Content-Type content=\"text/html; charset=utf-8\">");
            HttpContext.Current.Response.Write(tw.ToString());
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
            HttpContext.Current.Response.Write("</body></html>");
        }
        #endregion

        #region Excel导入，服务器上需安装Excel
        /// <summary>
        /// 获取Excel的第一个Sheet的数据。注意，这里的第一个是按Sheet名排列后的第一个Sheet。
        /// <example>
        /// DataTable dt = Query(@"C:\My Documents\1.xls");
        /// </example>
        /// </summary>
        /// <param name="excelPath">Excel文件绝对路径。</param>
        /// <returns></returns>
        public static DataTable QueryExcel(string excelPath, string excelConnString)
        {
            DataTable dt = Common.DAL.Marshal.ExcelHelper.Query(excelPath, excelConnString);
            return dt;
        }

        /// <summary>
        /// 获取Excel指定Sheet名称的数据。
        /// <example>
        /// DataTable dt = Query(@"C:\My Documents\1.xls", "sheet1");
        /// </example>
        /// </summary>
        /// <param name="excelPath">Excel文件绝对路径。</param>
        /// <param name="sheetName">Sheet名，允许空格存在。如：sheet1</param>
        /// <returns></returns>
        public static DataTable QueryExcel(string excelPath, string sheetName, string excelConnString)
        {
            DataTable dt = Common.DAL.Marshal.ExcelHelper.Query(excelPath, sheetName, excelConnString);
            return dt;
        }

        /// <summary>
        /// 获取指定序号的Sheet的数据。序号从0开始。注意，是按Sheet名排列后的第Index个Sheet。
        /// <example>
        /// DataTable dt = Query(@"C:\My Documents\1.xls", 0);
        /// </example>
        /// </summary>
        /// <param name="excelPath">Excel文件绝对路径。</param>
        /// <param name="sheetIndex">Sheet的序号，从0开始。</param>
        /// <returns></returns>
        public static DataTable QueryExcel(string excelPath, int sheetIndex, string excelConnString)
        {
            DataTable dt = Common.DAL.Marshal.ExcelHelper.Query(excelPath, sheetIndex, excelConnString);
            return dt;
        }

        /// <summary>
        /// 获取指定序号的Sheet的数据。序号从0开始。注意，是按Sheet名排列后的第Index个Sheet。
        /// <example>
        /// DataTable dt = Query(@"C:\My Documents\1.xls", 0);
        /// </example>
        /// </summary>
        /// <param name="excelPath">Excel文件绝对路径。</param>
        /// <param name="sheetIndex">Sheet的序号，从0开始。如：sheet1$, 'My Sheet'$</param>
        /// <returns></returns>
        public static DataTable QueryExcelEx(string excelPath, string rawSheetName, string excelConnString)
        {
            DataTable dt = Common.DAL.Marshal.ExcelHelper.QueryEx(excelPath, rawSheetName, excelConnString);
            return dt;
        }
        #endregion

        #region Excel导出，服务器上不需要安装Excel
        /// <summary>
        /// 导出到Excel,服务器上不需要安装Excel
        /// </summary>
        /// <param name="dt">要导出的DataTable数据表</param>
        public static void HSSExportToExcel(DataTable dt)
        {
            SKT.Common.Utility.ExcelHelper.ExportDataToExcel(dt);
        }

        /// <summary>
        /// 导出到Excel,服务器上不需要安装Excel
        /// </summary>
        /// <param name="gridview">要导出的GridView</param>
        public static void HSSExportToExcel(GridView gridview)
        {
            SKT.Common.Utility.ExcelHelper.ExportDataToExcel(gridview);
        }

        /// <summary>
        /// 导出到Excel,服务器上不需要安装Excel
        /// </summary>
        /// <typeparam name="T">要导出的List泛型类型</typeparam>
        /// <param name="list">要导出的List<T></param>
        public static void HSSExportToExcel<T>(List<T> list)
        {
            SKT.Common.Utility.ExcelHelper.ExportDataToExcel<T>(list);
        }

        /// <summary>
        /// 导出到Excel,服务器上不需要安装Excel
        /// </summary>
        /// <param name="fileName">给导出的Excel文件设置一个名称，不设置给空字符</param>
        /// <param name="dt">要导出的数据表</param>
        public static void HSSExportToExcel(string fileName, DataTable dt)
        {
            SKT.Common.Utility.ExcelHelper.ExportDataToExcel(fileName, dt);
        }

        /// <summary>
        /// 导出到Excel,服务器上不需要安装Excel
        /// </summary>
        /// <param name="fileName">给导出的Excel文件设置一个名称，不设置给空字符</param>
        /// <param name="gridview">要导出的GridView</param>
        public static void HSSExportToExcel(string fileName, GridView gridview)
        {
            SKT.Common.Utility.ExcelHelper.ExportDataToExcel(fileName, gridview);
        }

        /// <summary>
        /// 导出到Excel,服务器上不需要安装Excel
        /// </summary>
        /// <typeparam name="T">要导出的List泛型类型</typeparam>
        /// <param name="fileName">给导出的Excel文件设置一个名称，不设置给空字符</param>
        /// <param name="list">要导出的List<T></param>
        public static void HSSExportToExcel<T>(string fileName, List<T> list)
        {
            SKT.Common.Utility.ExcelHelper.ExportDataToExcel<T>(fileName, list);
        }

        /// <summary>
        /// 导出到Excel,服务器上不需要安装Excel
        /// </summary>
        /// <param name="fileName">给导出的Excel文件设置一个名称，不设置给空字符</param>
        /// <param name="sheetName">给导出的Excel文件中的Sheet命名，没有给空字符，默认为"Sheet1"</param>
        /// <param name="dt">要导出的数据表</param>
        public static void HSSExportToExcel(string fileName, string sheetName, DataTable dt)
        {
            SKT.Common.Utility.ExcelHelper.ExportDataToExcel(fileName, sheetName, dt);
        }

        /// <summary>
        /// 导出到Excel,服务器上不需要安装Excel
        /// </summary>
        /// <param name="fileName">给导出的Excel文件设置一个名称，不设置给空字符</param>
        /// <param name="sheetName">给导出的Excel文件中的Sheet命名，没有给空字符，默认为"Sheet1"</param>
        /// <param name="sheetTitle">给导出的Sheet设置标题，如果设置了标题，则标题会占表格的第一行，不设置给空字符</param>
        /// <param name="dt">要导出的数据表</param>
        public static void HSSExportToExcel(string fileName, string sheetName, string sheetTitle, DataTable dt)
        {
            SKT.Common.Utility.ExcelHelper.ExportDataToExcel(fileName, sheetName, sheetTitle, dt);
        }

        /// <summary>
        /// 导出到Excel,服务器上不需要安装Excel
        /// </summary>
        /// <param name="fileName">给导出的Excel文件设置一个名称，不设置给空字符</param>
        /// <param name="company">给导出的Excel文件设置公司属性</param>
        /// <param name="subject">给导出的Excel文件设置标题属性</param>
        /// <param name="sheetName">给导出的Excel文件中的Sheet命名，没有给空字符，默认为"Sheet1"</param>
        /// <param name="sheetTitle">给导出的Sheet设置标题，如果设置了标题，则标题会占表格的第一行，不设置给空字符</param>
        /// <param name="dt">要导出的数据表</param>
        public static void HSSExportToExcel(string fileName, string company, string subject, string sheetName, string sheetTitle, DataTable dt)
        {
            SKT.Common.Utility.ExcelHelper.ExportDataToExcel(fileName, company, subject, sheetName, sheetTitle, dt);
        }

        /// <summary>
        /// 导出到Excel,服务器上不需要安装Excel
        /// </summary>
        /// <param name="fileName">给导出的Excel文件设置一个名称，不设置给空字符</param>
        /// <param name="company">给导出的Excel文件设置公司属性</param>
        /// <param name="subject">给导出的Excel文件设置标题属性</param>
        /// <param name="sheetName">给导出的Excel文件中的Sheet命名，没有给空字符，默认为"Sheet1"</param>
        /// <param name="sheetTitle">给导出的Sheet设置标题，如果设置了标题，则标题会占表格的第一行，不设置给空字符</param>
        /// <param name="gridview">要导出的Gridview</param>
        public static void HSSExportToExcel(string fileName, string company, string subject, string sheetName, string sheetTitle, GridView gridview)
        {
            SKT.Common.Utility.ExcelHelper.ExportDataToExcel(fileName, company, subject, sheetName, sheetTitle, gridview);
        }

        /// <summary>
        /// 导出到Excel,服务器上不需要安装Excel
        /// </summary>
        /// <typeparam name="T">要导出的List泛型类型</typeparam>
        /// <param name="fileName">给导出的Excel文件设置一个名称，不设置给空字符</param>
        /// <param name="company">给导出的Excel文件设置公司属性</param>
        /// <param name="subject">给导出的Excel文件设置标题属性</param>
        /// <param name="sheetName">给导出的Excel文件中的Sheet命名，没有给空字符，默认为"Sheet1"</param>
        /// <param name="sheetTitle">给导出的Sheet设置标题，如果设置了标题，则标题会占表格的第一行，不设置给空字符</param>
        /// <param name="list">要导出的List<T></param>
        public static void HSSExportToExcel<T>(string fileName, string company, string subject, string sheetName, string sheetTitle, List<T> list)
        {
            SKT.Common.Utility.ExcelHelper.ExportDataToExcel<T>(fileName, company, subject, sheetName, sheetTitle, list);
        }
        #endregion

        #region Excel导入，服务器上不需要安装Excel
        /// <summary>
        /// 导入Excel内容到DataTable，服务器上不需要安装Excel
        /// </summary>
        /// <param name="filePath">文件路径，指服务器上的待导入的Excel文件路径，请先上传文件到服务器</param>
        /// <returns>返回DataTable</returns>
        public static DataTable HSSExcelToDataTable(string filePath)
        {
            return SKT.Common.Utility.ExcelHelper.ExcelSheetImportToDataTable(filePath);
        }

        /// <summary>
        /// 导入Excel内容到DataTable，服务器上不需要安装Excel
        /// </summary>
        /// <param name="filePath">文件路径，指服务器上的待导入的Excel文件路径，请先上传文件到服务器</param>
        /// <param name="sheetName">指定要导入的Sheet名</param>
        /// <returns>返回DataTable</returns>
        public static DataTable HSSExcelToDataTable(string filePath, string sheetName)
        {
            return SKT.Common.Utility.ExcelHelper.ExcelSheetImportToDataTable(filePath, sheetName);
        }
        #endregion

        /// <summary>
        /// 获取Excel的所有的Sheet的名称。
        /// </summary>
        /// <param name="excelPath">Excel文件绝对路径。</param>
        /// <returns></returns>
        public static ArrayList GetSheetNames(string excelPath, string excelConnString)
        {
            ArrayList arrSheets = Common.DAL.Marshal.ExcelHelper.GetSheetNames(excelPath, excelConnString);
            return arrSheets;
        }
    }
}