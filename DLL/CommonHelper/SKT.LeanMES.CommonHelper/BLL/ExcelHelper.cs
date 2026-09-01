using OfficeOpenXml;
using System;
using System.Data;
using System.IO;

namespace SKT.LeanMES.CommonHelper.BLL
{
	public static class ExcelHelper
	{
		public static DataSet importExcelFile(string strFile_Path, bool boolHeader, SheetTable[] arr_stTable_Info)
		{
			DataSet dataSet = new DataSet();
			System.IO.FileStream fileStream = new System.IO.FileStream(strFile_Path, System.IO.FileMode.Open, System.IO.FileAccess.ReadWrite, System.IO.FileShare.ReadWrite);
			using (ExcelPackage excelPackage = new ExcelPackage(fileStream))
			{
				for (int i = 1; i <= arr_stTable_Info.Length; i++)
				{
					SheetTable sheetTable = arr_stTable_Info[i - 1];
					DataTable dataTable = dataSet.Tables.Add(sheetTable.TableName);
					ExcelWorksheet excelWorksheet = excelPackage.Workbook.Worksheets[i];
					int column = excelWorksheet.Dimension.End.Column;
					int row = excelWorksheet.Dimension.End.Row;
					ushort num = 1;
					while ((int)num <= sheetTable.ColumnsName.Length)
					{
						dataTable.Columns.Add(new DataColumn(sheetTable.ColumnsName[(int)(num - 1)]));
						num += 1;
					}
					int num2 = boolHeader ? 2 : 1;
					for (int j = num2; j <= row; j++)
					{
						DataRow dataRow = dataTable.NewRow();
						num = 1;
						while ((int)num <= sheetTable.ColumnsName.Length)
						{
							dataRow[(int)(num - 1)] = excelWorksheet.Cells[j, (int)num].Value;
							num += 1;
						}
						dataTable.Rows.Add(dataRow);
					}
				}
			}
			return dataSet;
		}

		public static DataSet importExcelFile(string strFile_Path, oneSheetMuti[] arr_TbInfo)
		{
			DataSet dataSet = new DataSet();
			System.IO.FileStream fileStream = new System.IO.FileStream(strFile_Path, System.IO.FileMode.Open, System.IO.FileAccess.ReadWrite, System.IO.FileShare.ReadWrite);
			using (ExcelPackage excelPackage = new ExcelPackage(fileStream))
			{
				ExcelWorksheet excelWorksheet = excelPackage.Workbook.Worksheets[1];
				for (int i = 0; i < arr_TbInfo.Length; i++)
				{
					oneSheetMuti oneSheetMuti = arr_TbInfo[i];
					DataTable dataTable = dataSet.Tables.Add(oneSheetMuti.TableName);
					ushort num = 0;
					while ((int)num < oneSheetMuti.ColumnsName.Length)
					{
						dataTable.Columns.Add(new DataColumn(oneSheetMuti.ColumnsName[(int)num]));
						num += 1;
					}
					int num2 = (oneSheetMuti.StartEnd[1] == -1) ? excelWorksheet.Dimension.End.Row : oneSheetMuti.StartEnd[1];
					for (int j = oneSheetMuti.StartEnd[0]; j <= num2; j++)
					{
						DataRow dataRow = dataTable.NewRow();
						num = 1;
						while ((int)num <= oneSheetMuti.ColumnsName.Length)
						{
							dataRow[(int)(num - 1)] = excelWorksheet.Cells[j, (int)num].Value;
							num += 1;
						}
						dataTable.Rows.Add(dataRow);
					}
				}
			}
			return dataSet;
		}

		public static DataSet ImportData(string strFile_Path, bool boolHeader, SheetTable stTable_Info)
		{
			SheetTable[] arr_stTable_Info = new SheetTable[]
			{
				stTable_Info
			};
			return ExcelHelper.importExcelFile(strFile_Path, boolHeader, arr_stTable_Info);
		}

		public static DataSet ImportData(string strFile_Path, oneSheetMuti stTable_Info)
		{
			oneSheetMuti[] arr_TbInfo = new oneSheetMuti[]
			{
				stTable_Info
			};
			return ExcelHelper.importExcelFile(strFile_Path, arr_TbInfo);
		}
	}
}
