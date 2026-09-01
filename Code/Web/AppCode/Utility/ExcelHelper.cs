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
using System.IO;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using NPOI.HSSF.UserModel;
using System.Text;
using NPOI.XSSF.Streaming;
using System.Reflection;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    /// <summary>
    /// Excel操作类，两种方式操作Excel: 1 - 服务器上安装Excel; 2 - 服务器上不需要安装Excel; 
    /// </summary>
    public static class ExcelHelper
    {
        #region Excel导出，服务器上需安装Excel
        /// <summary>
        /// 导出Datatable到excel
        /// </summary>
        /// <param name="dt">datatable数据</param>
        /// <param name="filename">导出要保存的文件名</param>
        /// <param name="encoding">编码：GB2312,UTF-8</param>
        public static void ExportToExcel(DataTable dt, string filename, string encoding)
        {
            Export(dt, filename, encoding);
        }

        /// <summary>
        /// 导出dataset到excel
        /// </summary>
        /// <param name="ds">dataset 数据集</param>
        /// <param name="filename">导出要保存的文件名</param>
        /// <param name="encoding">编码：GB2312,UTF-8</param>
        public static void ExportToExcel(DataSet ds, string filename, string encoding)
        {
            Export(ds.Tables[0], filename, encoding);
        }

        /// <summary>
        /// 导出dataset到excel
        /// </summary>
        /// <param name="dt">数据表</param>
        /// <param name="filename">导出要保存的文件名</param>
        public static void ExportToExcel(DataTable dt, string filename)
        {
            Export(dt, filename, "utf-8");
        }

        /// <summary>
        /// 导出dataset到excel
        /// </summary>
        /// <param name="dt">数据表</param>
        public static void ExportToExcel(DataTable dt)
        {
            string filename = Guid.NewGuid().ToString();
            Export(dt, filename, "utf-8");
        }

        /// <summary>
        /// Excel导出
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

        #region 导出xlsx文件

        /// <summary>
        /// 导出到Excel(支持xlsx文件)
        /// </summary>
        /// <param name="fileName">给导出的Excel文件设置一个名称，不设置给空字符</param>
        /// <param name="dt">要导出的数据表</param>
        public static void XSSExportToExcel(string fileName, DataTable dt)
        {
            SXSSFWorkbook workbook = new SXSSFWorkbook();
            ISheet sheet = workbook.CreateSheet();

            //列表和样式
            IRow headerRow = sheet.CreateRow(0);
            int headerIndex = 0;

            ICellStyle headerCellStyle = workbook.CreateCellStyle();
            IFont font = workbook.CreateFont();
            font.IsBold = true;
            headerCellStyle.SetFont(font);

            ICellStyle dateCellStyle = workbook.CreateCellStyle();
            IDataFormat dataFormat = workbook.CreateDataFormat();
            dateCellStyle.DataFormat = dataFormat.GetFormat("yyyy-MM-dd HH:mm:ss");

            foreach (DataColumn column in dt.Columns)
            {
                ICell cell = headerRow.CreateCell(headerIndex);
                cell.CellStyle = headerCellStyle;
                cell.SetCellValue(column.ColumnName);
                headerIndex = headerIndex + 1;
            }
            sheet.CreateFreezePane(0, 1, 0, 1);

            int rowCount = dt.Rows.Count;
            for (int i = 0; i < rowCount; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                int rowIndex = 0;
                foreach (DataColumn dc in dt.Columns)
                {
                    ICell newCell = row.CreateCell(rowIndex);
                    rowIndex = rowIndex + 1;
                    string drValue = dt.Rows[i][dc].ToString();
                    switch (dc.DataType.ToString())
                    {
                        case "System.String"://字符串类型
                            newCell.SetCellValue(drValue);
                            break;
                        case "System.DateTime"://日期类型
                            DateTime dateV;
                            DateTime.TryParse(drValue, out dateV);
                            newCell.SetCellValue(dateV);

                            newCell.CellStyle = dateCellStyle;
                            break;
                        case "System.Boolean"://布尔型
                            bool boolV = false;
                            bool.TryParse(drValue, out boolV);
                            newCell.SetCellValue(boolV);
                            break;
                        case "System.Int16"://整型
                        case "System.Int32":
                        case "System.Int64":
                        case "System.Byte":
                            int intV = 0;
                            int.TryParse(drValue, out intV);
                            newCell.SetCellValue(intV);
                            break;
                        case "System.Decimal"://浮点型
                        case "System.Double":
                        case "System.Single":
                            double doubV = 0;
                            double.TryParse(drValue, out doubV);
                            newCell.SetCellValue(doubV);
                            break;
                        case "System.DBNull"://空值处理
                            newCell.SetCellValue("");
                            break;
                        default:
                            newCell.SetCellValue("");
                            break;
                    }
                }
            }
            NPOIMemoryStream ms = new NPOIMemoryStream(false);
            workbook.Write(ms);
            byte[] bytes = ms.ToArray();
            ms.IsColse = true;
            ms.Close();

            #region Web导出

            HttpContext curContext = HttpContext.Current;
            // 设置编码和附件格式
            curContext.Response.ContentType = "application/vnd.ms-excel";
            curContext.Response.ContentEncoding = Encoding.UTF8;
            curContext.Response.Charset = "";
            curContext.Response.AppendHeader("Content-Length", bytes.Length.ToString());
            curContext.Response.AppendHeader("Content-Disposition",
                "attachment;filename=" + fileName);

            curContext.Response.BinaryWrite(bytes);
            curContext.Response.End();

            #endregion
        }

        #endregion

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

        /// <summary>
        /// 导入Excel内容到DataTable，服务器上不需要安装Excel
        /// </summary>
        /// <param name="filePath">文件路径，指服务器上的待导入的Excel文件路径，请先上传文件到服务器</param>
        /// <returns>返回DataTable</returns>
        public static DataTable ExcelToDataTable(string filePath, int startRow,bool isColumnName = true)
        {
            DataTable dataTable = null;
            FileStream fs = null;
            DataColumn column = null;
            DataRow dataRow = null;
            IWorkbook workbook = null;
            ISheet sheet = null;
            IRow row = null;
            ICell cell = null;
            try
            {
                using (fs = File.OpenRead(filePath))
                {
                    // 2007版本
                    if (filePath.IndexOf(".xlsx") > 0)
                        workbook = new XSSFWorkbook(fs);
                    // 2003版本
                    else if (filePath.IndexOf(".xls") > 0)
                        workbook = new HSSFWorkbook(fs);

                    if (workbook != null)
                    {
                        sheet = workbook.GetSheetAt(0);//读取第一个sheet，当然也可以循环读取每个sheet
                        dataTable = new DataTable();
                        if (sheet != null)
                        {
                            int rowCount = sheet.LastRowNum;//总行数
                            if (rowCount > 0)
                            {
                                IRow firstRow = sheet.GetRow(0);//第一行
                                int cellCount = firstRow.LastCellNum;//列数

                                //构建datatable的列
                                if (isColumnName)
                                {
                                    for (int i = firstRow.FirstCellNum; i < cellCount; ++i)
                                    {
                                        cell = firstRow.GetCell(i);
                                        if (cell != null)
                                        {
                                            if (cell.StringCellValue != null)
                                            {
                                                column = new DataColumn(cell.StringCellValue);
                                                dataTable.Columns.Add(column);
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    for (int i = firstRow.FirstCellNum; i < cellCount; ++i)
                                    {
                                        column = new DataColumn("column" + (i + 1));
                                        dataTable.Columns.Add(column);
                                    }
                                }

                                //填充行
                                for (int i = startRow; i <= rowCount; ++i)
                                {
                                    row = sheet.GetRow(i);
                                    if (row == null) continue;

                                    dataRow = dataTable.NewRow();
                                    for (int j = row.FirstCellNum; j < cellCount; ++j)
                                    {
                                        cell = row.GetCell(j);
                                        if (cell == null)
                                        {
                                            dataRow[j] = "";
                                        }
                                        else
                                        {
                                            //CellType(Unknown = -1,Numeric = 0,String = 1,Formula = 2,Blank = 3,Boolean = 4,Error = 5,)
                                            switch (cell.CellType)
                                            {
                                                case CellType.Blank:
                                                    dataRow[j] = "";
                                                    break;
                                                case CellType.Numeric:
                                                    short format = cell.CellStyle.DataFormat;
                                                    //对时间格式（2015.12.5、2015/12/5、2015-12-5等）的处理
                                                    if (format == 14 || format == 31 || format == 57 || format == 58)
                                                        dataRow[j] = cell.DateCellValue;
                                                    else
                                                        dataRow[j] = cell.NumericCellValue;
                                                    break;
                                                case CellType.String:
                                                    dataRow[j] = cell.StringCellValue;
                                                    break;
                                            }
                                        }
                                    }
                                    dataTable.Rows.Add(dataRow);
                                }
                            }
                        }
                    }
                }
                return dataTable;
            }
            catch (Exception)
            {
                if (fs != null)
                {
                    fs.Close();
                }
                return null;
            }
        }

        #endregion


        /// <summary>
        /// 导出到Excel 指定导出数据类型
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="fileName"></param>
        public static void ExportToExcelSetType(DataTable dt, string fileName)
        {

            HSSFWorkbook book = new HSSFWorkbook();// NPOI.HSSF.UserModel;

            string filePath = AppDomain.CurrentDomain.BaseDirectory + "Temp\\";
            if (!Directory.Exists(filePath))
            {
                try
                {
                    Directory.CreateDirectory(filePath);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }
            string path = filePath + fileName;
            try
            {
                List<string> ColumnName = new List<string>();
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    ColumnName.Add(dt.Columns[i].ColumnName);
                }
                string[] ColumnArray1 = ColumnName.ToArray();
                ISheet sheet = book.CreateSheet();//创建sheet NPOI.SS.UserModel;
                IRow row = sheet.CreateRow(0);
                for (int i = 0; i < ColumnArray1.Length; i++)
                {
                    row.CreateCell(i).SetCellValue(ColumnArray1[i]);
                }
                for (int i = 1; i <= dt.Rows.Count; i++)
                {
                    IRow dr = sheet.CreateRow(i);

                    for (int j = 0; j < ColumnArray1.Length; j++)
                    {
                        if (dt.Rows[i - 1][ColumnArray1[j]] != null)
                        {
                            if (dt.Columns[j].DataType.Name == "Decimal" || dt.Columns[j].DataType.Name == "Int32")
                            {
                                dr.CreateCell(j, CellType.Numeric).SetCellValue(Convert.ToDouble(dt.Rows[i - 1][ColumnArray1[j]]));
                            }
                            else
                            {
                                dr.CreateCell(j).SetCellValue(dt.Rows[i - 1][ColumnArray1[j]].ToString());
                            }
                        }

                        if (i == 1)
                            sheet.AutoSizeColumn(j);

                    }
                }

                FileStream fs = new FileStream(path, FileMode.Create);
                book.Write(fs);
                fs.Close();
                book = null;

                //导出文件
                CommonMethod.exportFile(fileName, filePath);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }

        }
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

        #region 解析CSV文件成数组
        /// <summary>
        /// 解析CSV文件成数组
        /// </summary>
        public static ArrayList ImportCsv(string filePath)
        {
            ArrayList Data = new ArrayList();
            String content = "";
            using (StreamReader sm = new StreamReader(filePath, System.Text.Encoding.Default))
            {
                content = sm.ReadToEnd().Replace("\r", "");
                sm.Close();
                sm.Dispose();
            }
            String[] contentArray = content.Split('\n');
            if (contentArray == null || contentArray.Length < 1)
            {
                return null;
            }

            for (int i = 0; i < contentArray.Length; i++)
            {
                String[] row = contentArray[i].Split(',');
                Data.Add(row);
            }
            return Data;
        }
        #endregion
    }

    public class NPOIHelper
    {

        /// <summary>
        /// 获取excel内容
        /// </summary>
        /// <param name="filePath">excel文件路径</param>
        /// <returns></returns>
        public static ArrayList ImportExcel(string filePath)
        {
            ArrayList Data = new ArrayList();
            using (FileStream fsRead = System.IO.File.OpenRead(filePath))
            {
                IWorkbook wk = null;
                //获取后缀名
                string extension = filePath.Substring(filePath.LastIndexOf(".")).ToString().ToLower();
                //判断是否是excel文件
                if (extension == ".xlsx" || extension == ".xls")
                {
                    //判断excel的版本
                    if (extension == ".xlsx")
                    {
                        wk = new XSSFWorkbook(fsRead);
                    }
                    else
                    {
                        wk = new HSSFWorkbook(fsRead);
                    }

                    //获取第一个sheet
                    ISheet sheet = wk.GetSheetAt(0);
                    
                    //读取每行,从第二行起
                    for (int r = 0; r <= sheet.LastRowNum; r++)
                    {
                        //获取当前行
                        IRow row = sheet.GetRow(r);
                        string[] RowData = new string[row.Cells.Count];
                        
                        //读取每列
                        for (int j = 0; j < row.Cells.Count; j++)
                        {
                            ICell cell = row.GetCell(j); //一个单元格
                            RowData[j] = GetCellValue(cell); //获取单元格的值
                        }
                        Data.Add(RowData); //把每行追加到DataTable
                    }
                }

            }
            return Data;
        }

        //对单元格进行判断取值
        public static string GetCellValue(ICell cell)
        {
            if (cell == null)
                return string.Empty;
            switch (cell.CellType)
            {
                case CellType.Blank: //空数据类型 这里类型注意一下，不同版本NPOI大小写可能不一样,有的版本是Blank（首字母大写)
                    return string.Empty;
                case CellType.Boolean: //bool类型
                    return cell.BooleanCellValue.ToString();
                case CellType.Error:
                    return cell.ErrorCellValue.ToString();
                case CellType.Numeric: //数字类型
                    if (HSSFDateUtil.IsCellDateFormatted(cell))//日期类型
                    {
                        return cell.DateCellValue.ToString();
                    }
                    else //其它数字
                    {
                        return cell.NumericCellValue.ToString();
                    }
                case CellType.Unknown: //无法识别类型
                default: //默认类型
                    return cell.ToString();//
                case CellType.String: //string 类型
                    return cell.StringCellValue;
                case CellType.Formula: //带公式类型
                    try
                    {
                        HSSFFormulaEvaluator e = new HSSFFormulaEvaluator(cell.Sheet.Workbook);
                        e.EvaluateInCell(cell);
                        return cell.ToString();
                    }
                    catch
                    {
                        return cell.NumericCellValue.ToString();
                    }
            }
        }
        /// <summary>
        /// 根据GridView列数据，导出到Excel
        /// </summary>
        /// <typeparam name="T">实体类</typeparam>
        /// <param name="list">需要导出的集合</param>
        /// <param name="gv">GridView</param>
        /// <param name="fileName">需要导出的文件名，包括文件类型（如：工单.xlsx）</param>
        public static void Export<T>(List<T> list, GridView gv, string fileName)
        {
            var dic = new Dictionary<string, string>();
            //遍历GridView
            BoundField boundField;
            foreach (DataControlField item in gv.Columns)
            {
                if (item is BoundField)
                {
                    boundField = item as BoundField;

                    //隐藏的字段，不导出；例如：<asp:BoundField DataField="DayReportId" HeaderText="DayReportId" ItemStyle-CssClass="DayReportId hide" HeaderStyle-CssClass="DayReportId" />
                    var css = boundField.ItemStyle.CssClass;
                    if (css.Length <= 0 || !css.Split(' ').Any(p => string.Equals(p, "hide", StringComparison.CurrentCultureIgnoreCase)))
                    {
                        dic.Add(boundField.DataField, item.HeaderText);
                    }
                }
            }
            Export<T>(list, dic, fileName);
        }
        /// <summary>
        /// 导出List集合到Excel
        /// </summary>
        /// <typeparam name="T">实体类</typeparam>
        /// <param name="list">需要导出的集合</param>
        /// <param name="fiedNames">需要导出的列名、中文名称 key为实体类字段名 value为实体类字段名中文描述</param>
        /// <param name="fileName">需要导出的文件名，包括文件类型（如：工单.xlsx）</param>
        public static void Export<T>(List<T> list, Dictionary<string, string> fiedNames, string fileName)
        {
            IWorkbook workbook;
            string fileExt = Path.GetExtension(fileName).ToLower();
            if (fileExt == ".xlsx")
            {
                workbook = new XSSFWorkbook();
            }
            else if (fileExt == ".xls")
            {
                workbook = new HSSFWorkbook();
            }
            else
            {
                return;
            }
            ISheet sheet = workbook.CreateSheet("Sheet1");
            ICell cell;
            IRow row;

            #region 生成列头

            int idxHead = 0;
            row = sheet.CreateRow(0);
            foreach (string val in fiedNames.Values)
            {
                cell = row.CreateCell(idxHead);
                cell.SetCellValue(val);
                idxHead++;
            }

            #endregion

            //获取实体类类型
            Type t = typeof(T);
            //获取实体类属性
            List<PropertyInfo> propertyList = t.GetProperties(BindingFlags.Instance | BindingFlags.Public).ToList();

            var dicProperty = new Dictionary<string, PropertyInfo>();
            //如果实体类字段能对应字典，则加入到dicProperty集合中
            propertyList.ForEach(p =>
            {
                if (fiedNames.Keys.Contains(p.Name))
                {
                    dicProperty.Add(p.Name, p);
                }
            });

            #region 生成数据

            //遍历列表数据
            PropertyInfo proInfo;
            string cellValue;
            for (int i = 0; i < list.Count; i++)
            {
                row = sheet.CreateRow(i + 1);
                int j = 0;
                //遍历字段名称
                foreach (string dataField in fiedNames.Keys)
                {
                    cell = row.CreateCell(j);
                    //取出属性对象
                    proInfo = dicProperty[dataField];
                    //获取对应属性的值
                    object value = proInfo.GetValue(list[i], null);
                    cellValue = value == null ? string.Empty : value.ToString();
                    cell.SetCellValue(cellValue);
                    j++;
                }
            }

            #endregion

            ////自动列宽度
            //if (list.Count <= 1000)
            //{
            //    for (int i = 0; i < fiedNames.Values.Count; i++)
            //    {
            //        sheet.AutoSizeColumn(i, true);
            //    }
            //}

            // 写入到客户端
            MemoryStream ms = new MemoryStream();
            workbook.Write(ms);
            ms.Flush();
            HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            if (HttpContext.Current.Request.ServerVariables["http_user_agent"].ToString().IndexOf("Firefox") != -1)
            {
                //火狐浏览器    
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", "=?UTF-8?B?" + Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(fileName)) + "?="));
            }
            else
            {
                //IE及其他浏览器 
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", HttpUtility.UrlEncode(fileName)));
            }
            HttpContext.Current.Response.BinaryWrite(ms.ToArray());
            HttpContext.Current.Response.End();
            ms.Close();
        }
    }
    public class NPOIMemoryStream : MemoryStream
    {
        /// <summary>
        /// 获取流是否关闭
        /// </summary>
        public bool IsColse { get; set; }

        public NPOIMemoryStream(bool colse = false)
        {
            IsColse = colse;
        }

        public override void Close()
        {
            if (IsColse)
            {
                base.Close();
            }

        }
    }
}