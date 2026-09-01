using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using NPOI.HPSF;
using NPOI.HSSF.UserModel;
using NPOI.SS.Formula.Eval;
using NPOI.SS.UserModel;
using NPOI.SS.Util;
using NPOI.XSSF.UserModel;
using System.IO;
using System.Reflection;
using System.Web.UI.WebControls;
using System.Text;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    /// <summary>
    /// NPOI帮助类
    /// </summary>
    public class NPOIHelpers
    {
        /// <summary>
        /// 读取Excel数据
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="sheetIndex"></param>
        /// <param name="headIndex">-1表示没有列头，只有内容</param>
        /// <param name="startRowIndex"></param>
        /// <returns></returns>
        public static DataTable Import(string fileName, int sheetIndex = 0, int headIndex = 0, int startRowIndex = 1, bool filterEmptyRow = true)
        {
            DataTable dt = null;
            try
            {
                IWorkbook wb;
                using (FileStream file = new FileStream(fileName, FileMode.Open, FileAccess.Read))
                {
                    wb = WorkbookFactory.Create(file);
                }
                ISheet sheet = wb.GetSheetAt(sheetIndex);

                dt = ImportDt(sheet, headIndex, startRowIndex, filterEmptyRow);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }


        /// <summary>
        /// 将指定sheet中的数据导出到datatable中
        /// </summary>
        /// <param name="sheet">需要导出的sheet</param>
        /// <param name="startRowIndex">列头所在行号，-1表示没有列头</param>
        /// <returns></returns>
        static DataTable ImportDt(ISheet sheet, int headIndex, int startRowIndex, bool filterEmptyRow = true)
        {
            DataTable dt = new DataTable();
            IRow headerRow;
            int cellCount;

            if (headIndex <= -1)
            {
                headerRow = sheet.GetRow(0);
                cellCount = headerRow.LastCellNum;
                for (int i = headerRow.FirstCellNum; i < cellCount; i++)
                {
                    DataColumn column = new DataColumn(i.ToString());
                    dt.Columns.Add(column);
                }
            }
            else
            {
                headerRow = sheet.GetRow(headIndex);
                cellCount = headerRow.LastCellNum;

                for (int i = headerRow.FirstCellNum; i < cellCount; i++)
                {
                    if (headerRow.GetCell(i) == null)
                    {
                        if (dt.Columns.IndexOf(Convert.ToString(i)) > 0)
                        {
                            DataColumn column = new DataColumn(Convert.ToString("重复列名" + i));
                            dt.Columns.Add(column);
                        }
                        else
                        {
                            DataColumn column = new DataColumn(Convert.ToString(i));
                            dt.Columns.Add(column);
                        }
                    }
                    else if (dt.Columns.IndexOf(headerRow.GetCell(i).ToString()) > 0)
                    {
                        DataColumn column = new DataColumn(Convert.ToString("重复列名" + i));
                        dt.Columns.Add(column);
                    }
                    else
                    {
                        DataColumn column = new DataColumn(headerRow.GetCell(i).ToString());
                        dt.Columns.Add(column);
                    }
                }
            }

            int rowCount = sheet.LastRowNum;
            for (int i = startRowIndex; i <= rowCount; i++)
            {
                IRow row;
                //if (sheet.GetRow(i) == null)
                //{
                //    row = sheet.CreateRow(i);
                //}
                //else
                //{
                row = sheet.GetRow(i);
                //}

                if (row == null)
                {
                    continue;
                }
                DataRow dataRow = dt.NewRow();
                bool emptyRow = true;

                for (int j = row.FirstCellNum; j < cellCount; j++)
                {
                    if (row.GetCell(j) == null)
                    {
                        continue;
                    }

                    switch (row.GetCell(j).CellType)
                    {
                        case CellType.String:
                            string str = row.GetCell(j).StringCellValue;
                            if (str != null && str.Length > 0)
                            {
                                dataRow[j] = str.ToString();
                            }
                            else
                            {
                                dataRow[j] = null;
                            }
                            break;
                        case CellType.Numeric:
                            if (DateUtil.IsCellDateFormatted(row.GetCell(j)))
                            {
                                dataRow[j] = DateTime.FromOADate(row.GetCell(j).NumericCellValue);
                            }
                            else
                            {
                                dataRow[j] = Convert.ToDouble(row.GetCell(j).NumericCellValue);
                            }
                            break;
                        case CellType.Boolean:
                            dataRow[j] = Convert.ToString(row.GetCell(j).BooleanCellValue);
                            break;
                        case CellType.Error:
                            dataRow[j] = ErrorEval.GetText(row.GetCell(j).ErrorCellValue);
                            break;
                        case CellType.Formula:
                            switch (row.GetCell(j).CachedFormulaResultType)
                            {
                                case CellType.String:
                                    string strFormula = row.GetCell(j).StringCellValue;
                                    if (strFormula != null && strFormula.Length > 0)
                                    {
                                        dataRow[j] = strFormula.ToString();
                                    }
                                    else
                                    {
                                        dataRow[j] = null;
                                    }
                                    break;
                                case CellType.Numeric:
                                    dataRow[j] = Convert.ToString(row.GetCell(j).NumericCellValue);
                                    break;
                                case CellType.Boolean:
                                    dataRow[j] = Convert.ToString(row.GetCell(j).BooleanCellValue);
                                    break;
                                case CellType.Error:
                                    dataRow[j] = ErrorEval.GetText(row.GetCell(j).ErrorCellValue);
                                    break;
                                default:
                                    dataRow[j] = "";
                                    break;
                            }
                            break;
                        default:
                            dataRow[j] = "";
                            break;
                    }

                    //不是空行
                    if (row.GetCell(j) != null && !string.IsNullOrWhiteSpace(Convert.ToString(row.GetCell(j))))
                    {
                        emptyRow = false;
                    }
                }

                //不过滤空行 或者 过滤空行，但当前行不是空行时，添加到dt中
                if (!filterEmptyRow || (filterEmptyRow && !emptyRow))
                {
                    dt.Rows.Add(dataRow);
                }
            }
            return dt;
        }


        /// <summary>
        /// Datable导出成Excel
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="file">导出路径(包括文件名与扩展名)</param>
        /// <param name="exportColumnName">是否导出DataTable列名</param>
        public static void Export(DataTable dt, string fileName, bool exportColumnName = true)
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
            ISheet sheet = string.IsNullOrEmpty(dt.TableName) ? workbook.CreateSheet("Sheet1") : workbook.CreateSheet(dt.TableName);

            //表头
            if (exportColumnName)
            {
                IRow row = sheet.CreateRow(0);
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    ICell cell = row.CreateCell(i);
                    cell.SetCellValue(dt.Columns[i].ColumnName);
                }
            }

            //数据  
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                //IRow row1 = sheet.CreateRow(i + 1);
                IRow row1 = sheet.CreateRow(exportColumnName ? (i + 1) : i);
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    ICell cell = row1.CreateCell(j);
                    cell.SetCellValue(dt.Rows[i][j].ToString());
                }
            }

            // 写入到客户端
            MemoryStream ms = new MemoryStream();
            workbook.Write(ms);
            ms.Flush();

            System.Web.HttpContext context = System.Web.HttpContext.Current;
            context.Response.ContentType = "application/vnd.ms-excel";

            string browser = context.Request.UserAgent.ToUpper();
            if ((browser.Contains("MS") && browser.Contains("IE")) || string.Equals(context.Request.Browser.Browser, "InternetExplorer", StringComparison.CurrentCultureIgnoreCase))
            {
                //IE浏览器 
                //fileName = System.Web.HttpUtility.UrlEncode(fileName);//空格时，文件名称会将空格变为+号
                fileName = ToHexString(fileName);
                context.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", fileName));
            }
            else if (browser.Contains("FIREFOX"))
            {
                //火狐浏览器    
                context.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", "=?UTF-8?B?" + Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(fileName)) + "?="));
            }
            else
            {
                //其他浏览器 
                context.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", fileName));
            }
            context.Response.BinaryWrite(ms.ToArray());
            context.Response.End();
            ms.Close();
        }


        /// <summary>
        /// Datable导出成Excel
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="file">导出路径(包括文件名与扩展名)</param>
        public static void Export(DataSet ds, string fileName)
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

            foreach (DataTable dt in ds.Tables)
            {
                ISheet sheet = string.IsNullOrEmpty(dt.TableName) ? workbook.CreateSheet("Sheet1") : workbook.CreateSheet(dt.TableName);

                //表头  
                IRow row = sheet.CreateRow(0);
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    ICell cell = row.CreateCell(i);
                    cell.SetCellValue(dt.Columns[i].ColumnName);
                }

                //数据  
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    IRow row1 = sheet.CreateRow(i + 1);
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        ICell cell = row1.CreateCell(j);
                        cell.SetCellValue(dt.Rows[i][j].ToString());
                    }
                }
            }

            //MemoryStream stream = new MemoryStream();
            //workbook.Write(stream);
            //HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            //HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.Default;
            //HttpContext.Current.Response.HeaderEncoding = System.Text.Encoding.Default;
            //HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
            ////HttpContext.Current.Response.BinaryWrite(System.Text.Encoding.GetEncoding("gb2312").GetPreamble());
            //HttpContext.Current.Response.BinaryWrite(stream.ToArray());

            using (var exportData = new MemoryStream())
            {
                workbook.Write(exportData);
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ClearHeaders();
                HttpContext.Current.Response.ClearContent();
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats - officedocument.spreadsheetml.sheet";
                HttpContext.Current.Response.AppendHeader("Content-Type", "text/html; charset=GB2312");
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename={0}", fileName));
                HttpContext.Current.Response.Charset = "GB2312";
                HttpContext.Current.Response.ContentEncoding = Encoding.GetEncoding("GB2312");
                HttpContext.Current.Response.BinaryWrite(exportData.ToArray());// ms.ToArray()   GetBuffer
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.Close();
            }

        }


        /// <summary>
        /// 获取单元格类型
        /// </summary>
        /// <param name="cell"></param>
        /// <returns></returns>
        private static object GetValueType(ICell cell)
        {
            if (cell == null)
                return null;
            switch (cell.CellType)
            {
                case CellType.Blank: //BLANK:  
                    return null;
                case CellType.Boolean: //BOOLEAN:  
                    return cell.BooleanCellValue;
                case CellType.Numeric: //NUMERIC:  
                    return cell.NumericCellValue;
                case CellType.String: //STRING:  
                    return cell.StringCellValue;
                case CellType.Error: //ERROR:  
                    return cell.ErrorCellValue;
                case CellType.Formula: //FORMULA:  
                default:
                    return "=" + cell.CellFormula;
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






        /// <summary>
        /// 根据数据源按固定模板数据填充
        /// </summary>
        /// <param name="dataSource">数据源</param>
        /// <param name="hssfworkbook">工作簿</param>
        /// <param name="strFileName">下载名称.xls</param>
        /// <param name="rowOffset">偏移行数</param>
        /// <param name="colOffset">偏移列数</param>
        /// <param name="sheetIndex">工作薄索引</param>
        public static void ExportWorkBook(DataSet database, HSSFWorkbook hssfworkbook, string strFileName, int rowOffset = 0, int colOffset = 0, int sheetIndex = 0)
        {
            ISheet sheet = hssfworkbook.GetSheetAt(sheetIndex);
            ICellStyle cellStyle = hssfworkbook.CreateCellStyle();
            //设置单元格上下左右边框线  
            cellStyle.BorderTop = NPOI.SS.UserModel.BorderStyle.Thin;
            cellStyle.BorderBottom = NPOI.SS.UserModel.BorderStyle.Thin;
            cellStyle.BorderLeft = NPOI.SS.UserModel.BorderStyle.Thin;
            cellStyle.BorderRight = NPOI.SS.UserModel.BorderStyle.Thin;
            cellStyle.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Center;
            DataTable dataSource = new DataTable();
            DataTable dataSource2 = new DataTable();


            if (database.Tables.Count == 0)
                return;


            dataSource = database.Tables[0];
            dataSource2 = database.Tables[1];


            for (int i = 0; i < dataSource.Rows.Count; i++)
            {
                for (int j = 0; j < dataSource.Columns.Count; j++)
                {
                    IRow row = sheet.GetRow(i + rowOffset);

                    if (row == null)
                        row = sheet.CreateRow(i + rowOffset);
                    NPOI.SS.UserModel.ICell newCell = row.GetCell(j + colOffset);

                    if (newCell == null)
                    {
                        newCell = row.CreateCell(j + colOffset);
                        newCell.CellStyle = cellStyle;
                    }
                    string drValue = dataSource.Rows[i][j].ToString();
                    string drType = dataSource.Columns[j].DataType.ToString();
                    #region 数据类型

                    switch (drType)
                    {
                        case "System.String"://字符串类型
                            newCell.SetCellValue(drValue);
                            break;
                        case "System.DateTime"://日期类型
                            DateTime dateV;
                            DateTime.TryParse(drValue, out dateV);
                            newCell.SetCellValue(dateV);

                            //newCell.CellStyle = dateStyle;//格式化显示
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

                    #endregion
                }
            }

            for (int i = 0; i < dataSource2.Rows.Count; i++)
            {
                for (int j = 0; j < dataSource2.Columns.Count; j++)
                {
                    IRow row = sheet.GetRow(i + rowOffset);

                    if (row == null)
                        row = sheet.CreateRow(i + rowOffset);
                    NPOI.SS.UserModel.ICell newCell = row.GetCell(j + colOffset);

                    if (newCell == null)
                    {
                        newCell = row.CreateCell(j + colOffset);
                        newCell.CellStyle = cellStyle;
                    }
                    string drValue = dataSource.Rows[i][j].ToString();
                    string drType = dataSource.Columns[j].DataType.ToString();
                    #region 数据类型

                    switch (drType)
                    {
                        case "System.String"://字符串类型
                            newCell.SetCellValue(drValue);
                            break;
                        case "System.DateTime"://日期类型
                            DateTime dateV;
                            DateTime.TryParse(drValue, out dateV);
                            newCell.SetCellValue(dateV);

                            //newCell.CellStyle = dateStyle;//格式化显示
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

                    #endregion
                }
            }





            //提供下载程序
            ExportHSSFWorkbookByWeb(hssfworkbook, null, strFileName);

        }


        /// <summary>
        /// 将指定的HSSFWorkbook输出到流
        /// </summary>
        /// <param name="workbook"></param>
        /// <param name="strFileName">文件名</param>
        public static void ExportHSSFWorkbookByWeb(HSSFWorkbook hssWorkbook = null, XSSFWorkbook xssWorkbook = null, string strFileName = null)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                if (hssWorkbook == null)
                    xssWorkbook.Write(ms);
                else
                    hssWorkbook.Write(ms);
                ms.Flush();
                ms.Position = 0;

                HttpContext curContext = HttpContext.Current;

                // 设置编码和附件格式
                curContext.Response.ContentType = "application/vnd.ms-excel";
                curContext.Response.ContentEncoding = Encoding.Default;
                curContext.Response.Charset = "";
                curContext.Response.AppendHeader("Content-Disposition", "attachment;filename=" + strFileName);
                curContext.Response.BinaryWrite(ms.GetBuffer());
                curContext.Response.End();
            }
        }



        #region 文件名称编码

        /// <summary>
        /// 对字符串中的非 ASCII 字符进行编码
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static string ToHexString(string s)
        {
            char[] chars = s.ToCharArray();
            StringBuilder builder = new StringBuilder();
            for (int index = 0; index < chars.Length; index++)
            {
                bool needToEncode = NeedToEncode(chars[index]);
                if (needToEncode)
                {
                    string encodedString = ToHexString(chars[index]);
                    builder.Append(encodedString);
                }
                else
                {
                    builder.Append(chars[index]);
                }
            }
            return builder.ToString();
        }

        /// <summary>
        /// 判断字符是否需要使用特殊的 ToHexString 的编码方式
        /// </summary>
        /// <param name="chr"></param>
        /// <returns></returns>
        private static bool NeedToEncode(char chr)
        {
            string reservedChars = "$-_.+!*'(),@=&";
            if (chr > 127)
                return true;
            if (char.IsLetterOrDigit(chr) || reservedChars.IndexOf(chr) >= 0)
                return false;
            return true;
        }

        /// <summary>
        /// 为非 ASCII 字符编码
        /// </summary>
        /// <param name="chr"></param>
        /// <returns></returns>
        private static string ToHexString(char chr)
        {
            UTF8Encoding utf8 = new UTF8Encoding();
            byte[] encodedBytes = utf8.GetBytes(chr.ToString());
            StringBuilder builder = new StringBuilder();
            for (int index = 0; index < encodedBytes.Length; index++)
            {
                builder.AppendFormat("%{0}", Convert.ToString(encodedBytes[index], 16));
            }
            return builder.ToString();
        }

        #endregion

    }
}