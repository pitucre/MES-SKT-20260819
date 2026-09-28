using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using LeanMES.FileMonitor.Dao;

namespace LeanMES.FileMonitor.Utility;

public class ExtensionFun
{
	public static DataTable TransTxtToDataTable(string fullPath)
	{
		DataTable dataTable = new DataTable();
		using (StreamReader streamReader = new StreamReader(fullPath, Encoding.GetEncoding("GB2312")))
		{
			string text = streamReader.ReadToEnd().Replace("\r\n", "!^!");
			string[] array = text.Split(new string[1] { "!^!" }, StringSplitOptions.None);
			dataTable.Columns.Add("ID", typeof(string));
			string[] array2 = array;
			foreach (string value in array2)
			{
				if (!string.IsNullOrEmpty(value) && !string.IsNullOrWhiteSpace(value))
				{
					DataRow dataRow = dataTable.NewRow();
					dataRow["ID"] = value;
					dataTable.Rows.Add(dataRow);
				}
			}
		}
		return dataTable;
	}

	public static bool GetOMLPassType(string Barcode, List<string[]> rowArray, string ConnectionString, ref string NCData, ref bool FileActive)
	{
		bool result = true;
		int num = -1;
		int num2 = -1;
		int num3 = -1;
		int num4 = -1;
		string[] array = rowArray[0];
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].ToLower() == "partsname")
			{
				num = i;
			}
			if (array[i].ToLower() == "faultcode")
			{
				num2 = i;
			}
			if (array[i].ToLower() == "revisedfaultid")
			{
				num3 = i;
			}
			if (array[i].ToLower() == "componentblockname")
			{
				num4 = i;
			}
		}
		StationDao stationDao = new StationDao();
		List<SerialNumberInfo> panelSNInfo = stationDao.GetPanelSNInfo(Barcode, ConnectionString);
		string text = Barcode;
		for (int j = 1; j < rowArray.Count; j++)
		{
			if (rowArray[j].Length <= 2 || !(rowArray[j][0].ToString() != ""))
			{
				continue;
			}
			string[] array2 = rowArray[j];
			if (!(array2[num] != ""))
			{
				continue;
			}
			if (array2[num3] == "")
			{
				FileActive = false;
				break;
			}
			if (!(array2[num3] != "") || !(array2[num3] != "0"))
			{
				continue;
			}
			string location = array2[num4];
			if (!string.IsNullOrEmpty(location) && !string.IsNullOrWhiteSpace(location))
			{
				SerialNumberInfo serialNumberInfo = panelSNInfo.Where((SerialNumberInfo c) => c.Location.ToString() == location).SingleOrDefault();
				if (serialNumberInfo != null)
				{
					text = serialNumberInfo.SN;
				}
			}
			result = false;
			if (NCData.IndexOf("<NCCode SN =\"" + text + "\" CODE=\"" + array2[num3] + "\" Position=\"" + array2[num] + "\"></NCCode>") < 0)
			{
				NCData = NCData + "<NCCode SN =\"" + text + "\" CODE=\"" + array2[num3] + "\" Position=\"" + array2[num] + "\"></NCCode>";
			}
		}
		NCData = "<PanelSN>" + NCData + "</PanelSN>";
		return result;
	}
}
