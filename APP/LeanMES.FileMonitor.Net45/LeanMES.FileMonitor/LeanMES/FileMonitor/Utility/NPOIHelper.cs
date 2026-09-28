using System.Collections;
using System.Data;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;

namespace LeanMES.FileMonitor.Utility
{
public class NPOIHelper
{
public static DataTable ImportExcel(string filePath)
{
	DataTable dataTable = new DataTable();
	using (FileStream fileStream = File.OpenRead(filePath))
	{
		IWorkbook workbook = null;
		string text = filePath.Substring(filePath.LastIndexOf(".")).ToString().ToLower();
		if (text == ".xlsx" || text == ".xls")
		{
			workbook = ((!(text == ".xlsx")) ? ((IWorkbook)new HSSFWorkbook(fileStream)) : ((IWorkbook)new XSSFWorkbook((Stream)fileStream)));
			ISheet sheetAt = workbook.GetSheetAt(0);
			IRow row = sheetAt.GetRow(0);
			for (int i = row.FirstCellNum; i < row.Cells.Count; i++)
			{
				DataColumn column = new DataColumn("Column" + (i + 1));
				dataTable.Columns.Add(column);
			}
			for (int j = 0; j <= sheetAt.LastRowNum; j++)
			{
				DataRow dataRow = dataTable.NewRow();
				IRow row2 = sheetAt.GetRow(j);
				for (int k = 0; k < row2.Cells.Count; k++)
				{
					ICell cell = row2.GetCell(k);
					dataRow[k] = GetCellValue(cell);
				}
				dataTable.Rows.Add(dataRow);
			}
		}
	}
	return dataTable;
}

public static ArrayList ImportExcelNew(string filePath)
{
	ArrayList arrayList = new ArrayList();
	using (FileStream fileStream = File.OpenRead(filePath))
	{
		IWorkbook workbook = null;
		string text = filePath.Substring(filePath.LastIndexOf(".")).ToString().ToLower();
		if (text == ".xlsx" || text == ".xls")
		{
			workbook = ((!(text == ".xlsx")) ? ((IWorkbook)new HSSFWorkbook(fileStream)) : ((IWorkbook)new XSSFWorkbook((Stream)fileStream)));
			ISheet sheetAt = workbook.GetSheetAt(0);
			for (int i = 0; i <= sheetAt.LastRowNum; i++)
			{
				IRow row = sheetAt.GetRow(i);
				string[] array = new string[row.Cells.Count];
				for (int j = 0; j < row.Cells.Count; j++)
				{
					ICell cell = row.GetCell(j);
					array[j] = GetCellValue(cell);
				}
				arrayList.Add(array);
			}
		}
	}
	return arrayList;
}

private static string GetCellValue(ICell cell)
{
	if (cell == null)
	{
		return string.Empty;
	}
	switch (cell.CellType)
	{
	case CellType.Blank:
		return string.Empty;
	case CellType.Boolean:
		return cell.BooleanCellValue.ToString();
	case CellType.Error:
		return cell.ErrorCellValue.ToString();
	case CellType.Numeric:
		if (DateUtil.IsCellDateFormatted(cell))
		{
			return cell.DateCellValue.ToString();
		}
		return cell.NumericCellValue.ToString();
	default:
		return cell.ToString();
	case CellType.String:
		return cell.StringCellValue;
	case CellType.Formula:
		try
		{
			HSSFFormulaEvaluator hSSFFormulaEvaluator = new HSSFFormulaEvaluator(cell.Sheet.Workbook);
			hSSFFormulaEvaluator.EvaluateInCell(cell);
			return cell.ToString();
		}
		catch
		{
			return cell.NumericCellValue.ToString();
		}
	}
}
}
}
