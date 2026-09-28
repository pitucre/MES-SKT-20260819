using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Text;
using System.Xml;
using LeanMES.FileMonitor.Properties;

namespace LeanMES.FileMonitor.Utility
{
public class TXTHelper
{
public static ArrayList ImportTXT(string filePath, char[] SplitChar)
{
	ArrayList arrayList = new ArrayList();
	string text = "";
	using (StreamReader streamReader = new StreamReader(filePath, Encoding.UTF8))
	{
		text = streamReader.ReadToEnd().Replace("\r", "");
		streamReader.Close();
		streamReader.Dispose();
	}
	string[] array = text.Split(new char[1] { '\n' }, StringSplitOptions.RemoveEmptyEntries);
	if (array == null || array.Length < 1)
	{
		return null;
	}
	for (int i = 0; i < array.Length; i++)
	{
		string[] value = array[i].Split(SplitChar, StringSplitOptions.RemoveEmptyEntries);
		arrayList.Add(value);
	}
	return arrayList;
}

public static ArrayList ImportCsv(string filePath)
{
	ArrayList arrayList = new ArrayList();
	string text = "";
	using (StreamReader streamReader = new StreamReader(filePath, Encoding.UTF8))
	{
		text = streamReader.ReadToEnd().Replace("\r", "");
		streamReader.Close();
		streamReader.Dispose();
	}
	string[] array = text.Split('\n');
	if (array == null || array.Length < 1)
	{
		return null;
	}
	for (int i = 0; i < array.Length; i++)
	{
		string[] value = CSVstrToArry(array[i]);
		arrayList.Add(value);
	}
	return arrayList;
}

public static string[] CSVstrToArry(string splitStr)
{
	string text = string.Empty;
	List<string> list = new List<string>();
	bool flag = false;
	string[] array = splitStr.Split(',');
	string[] array2 = array;
	foreach (string text2 in array2)
	{
		if (!string.IsNullOrEmpty(text2) && text2.IndexOf('"') > -1)
		{
			string text3 = text2.Substring(0, 1);
			string text4 = string.Empty;
			if (text2.Length > 0)
			{
				text4 = text2.Substring(text2.Length - 1, 1);
			}
			if (text3.Equals("\"") && !text4.Equals("\""))
			{
				flag = true;
			}
			if (text4.Equals("\""))
			{
				text = (flag ? (text + "," + text2) : (text + text2));
				flag = false;
			}
		}
		else if (string.IsNullOrEmpty(text))
		{
			text += text2;
		}
		if (flag)
		{
			text = ((!string.IsNullOrEmpty(text)) ? (text + "," + text2) : (text + text2));
			continue;
		}
		list.Add(text.Replace("\"", "").Trim());
		text = string.Empty;
	}
	return list.ToArray();
}

public static void SaveConfig(string AppKey, string AppValue)
{
	try
	{
		XmlDocument xmlDocument = new XmlDocument();
		string baseDirectory = AppDomain.CurrentDomain.BaseDirectory;
		string filename = baseDirectory + "LeanMES.FileMonitor.exe.config";
		xmlDocument.Load(filename);
		Configuration configuration = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
		XmlNode xmlNode = xmlDocument.SelectSingleNode("//appSettings");
		XmlElement xmlElement = (XmlElement)xmlNode.SelectSingleNode("//add[@key='" + AppKey + "']");
		if (xmlElement != null)
		{
			xmlElement.SetAttribute("value", AppValue);
			configuration.AppSettings.Settings[AppKey].Value = AppValue;
		}
		else
		{
			XmlElement xmlElement2 = xmlDocument.CreateElement("add");
			xmlElement2.SetAttribute("key", AppKey);
			xmlElement2.SetAttribute("value", AppValue);
			xmlNode.AppendChild(xmlElement2);
			configuration.AppSettings.Settings.Add(AppKey, AppValue);
		}
		configuration.Save();
		ConfigurationManager.RefreshSection("appSettings");
		xmlDocument.Save(filename);
		Settings.Default.Reload();
	}
	catch (Exception ex)
	{
		string message = ex.Message;
	}
}

public static void SetAppSeting(string key, string value)
{
	try
	{
		Configuration configuration = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
		AppSettingsSection appSettings = configuration.AppSettings;
		appSettings.Settings[key].Value = value;
		configuration.Save(ConfigurationSaveMode.Modified);
		ConfigurationManager.RefreshSection("appSettings");
	}
	catch (Exception)
	{
	}
}

public static string GetAppSeting(string key)
{
	try
	{
		return ConfigurationSettings.AppSettings[key];
	}
	catch (Exception)
	{
		return string.Empty;
	}
}
}
}
