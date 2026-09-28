using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading;
using System.Windows.Forms;
using System.Xml;
using LeanMES.FileMonitor.Dao;
using LeanMES.FileMonitor.Enum;
using LeanMES.FileMonitor.Model;
using LeanMES.FileMonitor.Utility;
using Quartz;

namespace LeanMES.FileMonitor;

[DisallowConcurrentExecution]
public class FileWatch : IJob
{
	public FileSystemWatcher _fileSystemWatcher;

	public static ExtensionSound es = new ExtensionSound();

	private StationDao dao = null;

	private int iCount = 1;

	public Queue<string> QList = new Queue<string>();

	private bool cancelTokenSource = true;

	private Thread tdWork = null;

	public static MonitorConfig Config { get; internal set; }

	public static bool StopRunning { get; set; }

	public static int ATEFileSleepTime { get; private set; }

	public static int MinFileSize { get; private set; }

	public static string ConnectionString => ConfigurationManager.AppSettings["MESConnString"];

	public static string TestMachineType { get; private set; }

	public static string SerialNumber { get; private set; }

	public static string HostName { get; private set; }

	public static string IPAdd { get; private set; }

	public void StartWork()
	{
		cancelTokenSource = true;
		if (tdWork != null)
		{
			tdWork.Abort();
			tdWork = null;
		}
		tdWork = new Thread(DoWork);
		tdWork.IsBackground = true;
		tdWork.Start();
	}

	public void DoWork()
	{
		while (cancelTokenSource)
		{
			if (QList.Count > 0)
			{
				try
				{
					ExecAnalysisFile();
				}
				catch (Exception ex)
				{
					Logger.Write(ex.ToString());
				}
			}
			else
			{
				Thread.Sleep(3000);
			}
		}
	}

	public void StopWork()
	{
		cancelTokenSource = false;
		if (_fileSystemWatcher != null)
		{
			_fileSystemWatcher.Dispose();
			_fileSystemWatcher = null;
		}
		if (tdWork != null)
		{
			tdWork.Abort();
			tdWork = null;
		}
	}

	public void ExecFileUnderDirectory()
	{
		string[] files = Directory.GetFiles(Config.MonitorDir, "*." + Config.DeviceInterface.FileType);
		for (int i = 0; i < files.Length; i++)
		{
			if (File.Exists(files[i]))
			{
				PostRaisingChageFile(files[i]);
			}
		}
	}

	public void StartMonitor()
	{
		try
		{
			if (!string.IsNullOrEmpty(Config.DeviceInterface.UserName) && !string.IsNullOrEmpty(Config.DeviceInterface.Password))
			{
				GetAccessControl(Config.DeviceInterface.TargetFileDir, Config.DeviceInterface.UserName, Config.DeviceInterface.Password);
				Thread.Sleep(1000);
			}
			if (_fileSystemWatcher != null)
			{
				_fileSystemWatcher.Dispose();
				_fileSystemWatcher = null;
			}
			_fileSystemWatcher = new FileSystemWatcher();
			_fileSystemWatcher.IncludeSubdirectories = true;
			_fileSystemWatcher.Filter = GetFileType(Config.DeviceInterface.FileType);
			_fileSystemWatcher.Path = Config.MonitorDir;
			string text = (string.Equals(Config.DeviceInterface.FileType, FileTypeEnum.Excel.ToString(), StringComparison.CurrentCultureIgnoreCase) ? "*.xls|*.xlsx" : _fileSystemWatcher.Filter);
			Logger.Write("监控文件类型为：" + text);
			Logger.Write("监控目录：" + _fileSystemWatcher.Path);
			_fileSystemWatcher.EnableRaisingEvents = true;
			StopRunning = false;
			Logger.Write("监控启动成功！");
		}
		catch (Exception ex)
		{
			Logger.Write("监控启动失败！" + ex.Message);
		}
	}

	private void _fileSystemWatcher_Changed(object sender, FileSystemEventArgs e)
	{
		if (!StopRunning && IsWatchFileTypeSameSetting(e.FullPath))
		{
			Logger.Write("文件改变");
			PostRaisingChageFile(e.FullPath);
		}
	}

	public void _fileSystemWatcher_Renamed(object sender, RenamedEventArgs e)
	{
		if (!StopRunning && IsWatchFileTypeSameSetting(e.FullPath))
		{
			Logger.Write("文件重命名");
			PostRaisingChageFile(e.FullPath);
		}
	}

	public void _fileSystemWatcher_Created(object sender, FileSystemEventArgs e)
	{
		if (!StopRunning && IsWatchFileTypeSameSetting(e.FullPath))
		{
			Logger.Write("文件创建");
			PostRaisingChageFile(e.FullPath);
		}
	}

	public bool IsWatchFileTypeSameSetting(string FilePath)
	{
		bool result = false;
		if (string.Equals(Config.DeviceInterface.FileType, FileTypeEnum.Excel.ToString(), StringComparison.CurrentCultureIgnoreCase) && FilePath.ToLower().IndexOf(".xls") > 0)
		{
			result = true;
		}
		else if (string.Equals(Config.DeviceInterface.FileType, FileTypeEnum.CSV.ToString(), StringComparison.CurrentCultureIgnoreCase) && FilePath.ToLower().IndexOf(".csv") > 0)
		{
			result = true;
		}
		else if (string.Equals(Config.DeviceInterface.FileType, FileTypeEnum.TXT.ToString(), StringComparison.CurrentCultureIgnoreCase) && FilePath.ToLower().IndexOf(".txt") > 0)
		{
			result = true;
		}
		else if (string.Equals(Config.DeviceInterface.FileType, FileTypeEnum.XML.ToString(), StringComparison.CurrentCultureIgnoreCase) && FilePath.ToLower().IndexOf(".xml") > 0)
		{
			result = true;
		}
		return result;
	}

	public void LoadUserConfig()
	{
		TestMachineType = string.Empty;
		ATEFileSleepTime = Convert.ToInt32(GetAppSetting("ATEFileSleepTime"));
		MinFileSize = Convert.ToInt32(GetAppSetting("MinFileSize"));
		HostName = Dns.GetHostName();
		IPAddress[] hostAddresses = Dns.GetHostAddresses(HostName);
		IPAdd = ((hostAddresses.Length != 0) ? hostAddresses[0].ToString() : "");
	}

	public void PostRaisingChageFile(string fullPath)
	{
		if (!QList.Contains(fullPath))
		{
			QList.Enqueue(fullPath);
		}
	}

	public void ExecAnalysisFile()
	{
		while (QList.Count > 0)
		{
			string text = QList.Dequeue();
			lock (text)
			{
				if (File.Exists(text))
				{
					TranscateFile(text);
				}
			}
		}
	}

	private bool TranscateFile(string fullPath)
	{
		bool result = false;
		if (IsFileInUse(fullPath))
		{
			Logger.Write("文件被占用，文件路径：" + fullPath);
			//MessageBox.Show("文件被占用", "", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
			Thread.Sleep(ATEFileSleepTime * 1000);
			QList.Enqueue(fullPath);
			return false;
		}
		try
		{
			if (Config.DeviceInterface.FileType.ToLower() == "txt")
			{
				result = TranscateTxtFile(fullPath);
			}
			else if (Config.DeviceInterface.FileType.ToLower() == "csv")
			{
				result = TranscateCsvFile(fullPath);
			}
			else if (Config.DeviceInterface.FileType.ToLower() == "xml")
			{
				result = TranscateXmlFile(fullPath);
			}
			else if (string.Equals(Config.DeviceInterface.FileType, "excel", StringComparison.CurrentCultureIgnoreCase))
			{
				result = TranscateExcelFile(fullPath);
			}
		}
		catch (Exception ex)
		{
			SoundHelper.PlaySound();
			string msg = string.Format("文件({0})解析失败,解析时间：{2},失败原因：{1}", fullPath, ex.Message, DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss"));
			//MessageBox.Show("文件解析失败", "", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
			Logger.Write(msg);
		}
		return result;
	}

	private bool TranscateTxtFile(string fullPath)
	{
		string text = fullPath.Substring(fullPath.LastIndexOf('\\') + 1);
		string bMsg = "";
		bool result = true;
		try
		{
			if (dao == null)
			{
				dao = new StationDao();
			}
			ArrayList dt = TXTHelper.ImportTXT(fullPath, Config.DeviceInterface.TxtSplitChar.ToCharArray());
			StandTransfor(dt, dao, bMsg, fullPath, text);
		}
		catch (Exception ex)
		{
			result = false;
			string msg = $"解析文件{text}失败：{ex.Message}";
			SoundHelper.PlaySound();
			MoveToTargetDir(fullPath, FileDirEnum.ERROR);
			Logger.Write(msg, isOk: false);
		}
		return result;
	}

	private bool TranscateDatFile(string fullPath)
	{
		string text = fullPath.Substring(fullPath.LastIndexOf('\\') + 1);
		text = text.Split('.')[0];
		if (text.ToUpper() != "MESDATA")
		{
			return false;
		}
		string text2 = "";
		bool result = true;
		try
		{
			if (dao == null)
			{
				dao = new StationDao();
			}
			ArrayList arrayList = new ArrayList();
			string text3 = "";
			using (StreamReader streamReader = new StreamReader(fullPath, Encoding.UTF8))
			{
				text3 = streamReader.ReadToEnd().Replace("\r", "");
				streamReader.Close();
				streamReader.Dispose();
			}
			string[] array = text3.Split(new char[1] { '\n' }, StringSplitOptions.RemoveEmptyEntries);
			if (array == null || array.Length < 1)
			{
			}
			string equiCode = string.Empty;
			text2 = dao.SaveEquipmentCollection(array[0].ToString(), array[1].ToString(), 1, out equiCode);
			if (text2 == "")
			{
				MoveToTargetDir(fullPath, FileDirEnum.OK);
				Logger.Write($"采集恩格尔设备数据：文件名称【{text}】 设备号【{equiCode}】");
			}
			else
			{
				MoveToTargetDir(fullPath, FileDirEnum.NG);
				Logger.Write($"采集恩格尔设备数据失败; 文件名称【{text}】 设备号【{equiCode}】 错误消息【{text2}】");
			}
		}
		catch (Exception ex)
		{
			result = false;
			string msg = $"解析文件{text}失败：{ex.Message}";
			SoundHelper.PlaySound();
			MoveToTargetDir(fullPath, FileDirEnum.ERROR);
			Logger.Write(msg, isOk: false);
		}
		return result;
	}

	private bool TranscateCsvFile(string fullPath)
	{
		string text = fullPath.Substring(fullPath.LastIndexOf('\\') + 1);
		bool result = true;
		string bMsg = "";
		try
		{
			if (dao == null)
			{
				dao = new StationDao();
			}
			ArrayList dt = TXTHelper.ImportCsv(fullPath);
			StandTransfor(dt, dao, bMsg, fullPath, text);
		}
		catch (Exception ex)
		{
			result = false;
			string msg = $"解析文件{text}失败：{ex.Message}";
			SoundHelper.PlaySound();
			MoveToTargetDir(fullPath, FileDirEnum.ERROR);
			Logger.Write(msg, isOk: false);
		}
		return result;
	}

	private bool TranscateExcelFile(string fullPath)
	{
		string text = fullPath.Substring(fullPath.LastIndexOf('\\') + 1);
		bool result = true;
		string bMsg = "";
		try
		{
			if (dao == null)
			{
				dao = new StationDao();
			}
			ArrayList dt = NPOIHelper.ImportExcelNew(fullPath);
			StandTransfor(dt, dao, bMsg, fullPath, text);
		}
		catch (Exception ex)
		{
			result = false;
			string msg = $"解析文件{text}失败：{ex.Message}";
			SoundHelper.PlaySound();
			MoveToTargetDir(fullPath, FileDirEnum.ERROR);
			Logger.Write(msg, isOk: false);
		}
		return result;
	}

	private void StandTransfor(ArrayList dt, StationDao dao, string bMsg, string fullPath, string FileName)
	{
		string[] array = FileName.Split(Config.DeviceInterface.TitleSplitChar.ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
		string text = "";
		string text2 = "";
		string text3 = "";
		string text4 = "";
		string text5 = "";
		string text6 = "";
		string text7 = "";
		string text8 = "";
		string text9 = "";
		string text10 = "";
		string text11 = "";
		string text12 = "";
		int stationId = Config.StationId;
		int resourceId = Config.ResourceId;
		int isCouplet = Config.DeviceInterface.IsCouplet;
		string userName = Config.DeviceInterface.DefaultUserName.Trim();
		text10 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SN")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SN")).AnalysisType.Trim());
		text2 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SN")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SN")).TestResult.Trim());
		text11 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResult")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResult")).AnalysisType.Trim());
		text3 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResult")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResult")).TestResult.Trim());
		text12 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("ReTestResult")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("ReTestResult")).AnalysisType.Trim());
		text4 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("ReTestResult")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("ReTestResult")).TestResult.Trim());
		text5 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResultFail")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResultFail")).TestResult.Trim());
		text6 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResultGood")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResultGood")).TestResult.Trim());
		text7 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SubSN")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SubSN")).TestResult.Trim());
		text8 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("PanelSetting")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("PanelSetting")).TestResult.Trim());
		text9 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("FailCode")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("FailCode")).TestResult.Trim());
		string text13 = "";
		text13 = ((!(text10 == "TITLE")) ? (dt[Convert.ToInt32(text2.Split(',')[0]) - 1] as string[])[Convert.ToInt32(text2.Split(',')[1]) - 1].Trim() : array[Convert.ToInt32(text2) - 1].Trim());
		if (text8 != "")
		{
			int num = Convert.ToInt32(text8.Split(',')[0]) - 1;
			int num2 = Convert.ToInt32(text8.Split(',')[1]) - 1;
			int num3 = Convert.ToInt32(text7.Split(',')[1]) - 1;
			int num4 = Convert.ToInt32(text9.Split(',')[1]) - 1;
			for (; num < dt.Count; num++)
			{
				if ((dt[num] as string[]).Length < num2 || (dt[num] as string[]).Length < num3 || (dt[num] as string[]).Length < num4)
				{
					continue;
				}
				string text14 = (dt[num] as string[])[num2].Trim();
				if (text14 != "")
				{
					string text15 = (dt[num] as string[])[num3].Trim();
					string text16 = (dt[num] as string[])[num4].Trim();
					if ((!(text6 != "") || !string.Equals(text16, text6, StringComparison.CurrentCultureIgnoreCase)) && (!(text6 == "") || !(text5 != "") || string.Equals(text16, text5, StringComparison.CurrentCultureIgnoreCase)) && text.IndexOf($"<NCCode SN=\"{text14.Trim()}\" CODE=\"{text16.Trim()}\" Position=\"{text15.Trim()}\"></NCCode>") < 0)
					{
						text += $"<NCCode SN=\"{text14.Trim()}\" CODE=\"{text16.Trim()}\" Position=\"{text15.Trim()}\"></NCCode>";
					}
				}
			}
			text = $"<PanelSN>{text}</PanelSN>";
			bMsg = dao.SaveTestPanelComplate(text13, resourceId, stationId, userName, text);
			if (bMsg == "")
			{
				MoveToTargetDir(fullPath, FileDirEnum.OK);
				Logger.Write(string.Format("解析文件{0}成功; SN：{1}过站成功！SN检验结果：{2}", FileName, text13, GetResult(text == "<PanelSN></PanelSN>")));
			}
			else
			{
				MoveToTargetDir(fullPath, FileDirEnum.NG);
				Logger.Write($"解析文件{FileName}成功; SN：{text13}过站失败！消息:{bMsg}");
			}
		}
		else
		{
			string text17 = "";
			text17 = ((!(text11 == "TITLE")) ? (dt[Convert.ToInt32(text3.Split(',')[0]) - 1] as string[])[Convert.ToInt32(text3.Split(',')[1]) - 1].Trim() : array[Convert.ToInt32(text3) - 1].Trim());
			string text18 = "";
			text18 = ((!(text12 == "TITLE")) ? (dt[Convert.ToInt32(text4.Split(',')[0]) - 1] as string[])[Convert.ToInt32(text4.Split(',')[1]) - 1].Trim() : array[Convert.ToInt32(text4) - 1].Trim());
			int num5 = 0;
			if (text6 != "" && string.Equals(text17, text6, StringComparison.CurrentCultureIgnoreCase))
			{
				num5 = 1;
			}
			else if (text6 != "" && string.Equals(text18, text6, StringComparison.CurrentCultureIgnoreCase))
			{
				num5 = 1;
			}
			else if (text6 == "" && text5 != "" && !string.Equals(text17, text5, StringComparison.CurrentCultureIgnoreCase) && !string.Equals(text18, text5, StringComparison.CurrentCultureIgnoreCase))
			{
				num5 = 1;
			}
			bMsg = dao.SaveTestUnitComplate(text13, resourceId, stationId, Config.DeviceInterface.LineId, userName, num5, Config.DeviceInterface.NCCodeId);
			if (bMsg == "")
			{
				MoveToTargetDir(fullPath, FileDirEnum.OK);
				Logger.Write($"解析文件{FileName}成功; SN：{text13}过站成功！SN检验结果：{GetResult(num5 == 1)}");
			}
			else
			{
				MoveToTargetDir(fullPath, FileDirEnum.NG);
				Logger.Write($"解析文件{FileName}成功; SN：{text13}过站失败！消息:{bMsg}");
			}
		}
	}

	private bool TranscateXmlFile(string fullPath)
	{
		string text = fullPath.Substring(fullPath.LastIndexOf('\\') + 1);
		string[] array = text.Split(Config.DeviceInterface.TitleSplitChar.ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
		bool result = true;
		string text2 = "";
		try
		{
			if (dao == null)
			{
				dao = new StationDao();
			}
			XmlDocument xmlDocument = XMLHelper.ImportXMLToReader(fullPath);
			string text3 = "";
			string text4 = "";
			string text5 = "";
			string text6 = "";
			string text7 = "";
			string text8 = "";
			string text9 = "";
			string text10 = "";
			string text11 = "";
			string text12 = "";
			string text13 = "";
			string text14 = "";
			int stationId = Config.StationId;
			int resourceId = Config.ResourceId;
			int isCouplet = Config.DeviceInterface.IsCouplet;
			string defaultUserName = Config.DeviceInterface.DefaultUserName;
			text12 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SN")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SN")).AnalysisType.Trim());
			text4 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SN")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SN")).TestResult);
			text13 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResult")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResult")).AnalysisType.Trim());
			text5 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResult")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResult")).TestResult);
			text14 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("ReTestResult")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("ReTestResult")).AnalysisType.Trim());
			text6 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("ReTestResult")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("ReTestResult")).TestResult);
			text7 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResultFail")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResultFail")).TestResult);
			text8 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResultGood")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("TestResultGood")).TestResult);
			text9 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SubSN")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("SubSN")).TestResult);
			text10 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("PanelSetting")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("PanelSetting")).TestResult);
			text11 = ((Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("FailCode")) == null) ? "" : Config.DeviceInterface.TestResultPosition.First((DeviceInterfaceTestPosition f) => f.PonitType.Equals("FailCode")).TestResult);
			string text15 = "";
			text15 = ((!(text12 == "TITLE")) ? GetAttributeInfo(text4, xmlDocument) : array[Convert.ToInt32(text4) - 1].Trim());
			if (text10 != "")
			{
				string[] array2 = text10.Split('@');
				XmlNodeList elementsByTagName = xmlDocument.GetElementsByTagName(array2[0]);
				for (int num = 0; num < elementsByTagName.Count; num++)
				{
					string text16 = "";
					if (array2.Length > 1)
					{
						if (elementsByTagName.Item(num).Attributes[text10[1]] == null)
						{
							break;
						}
						text16 = elementsByTagName[num].Attributes[text10[1]].InnerText.Trim();
					}
					else
					{
						text16 = elementsByTagName[num].InnerText.Trim();
					}
					if (text16 != "")
					{
						string[] array3 = text9.Split('@');
						string text17 = "";
						text17 = ((array3.Length <= 1) ? xmlDocument.GetElementsByTagName(array3[0]).Item(num).InnerText.Trim() : xmlDocument.GetElementsByTagName(array3[0]).Item(num).Attributes[text9[1]].InnerText.Trim());
						string[] array4 = text11.Split('@');
						string text18 = "";
						text18 = ((array4.Length <= 1) ? xmlDocument.GetElementsByTagName(array4[0]).Item(num).InnerText.Trim() : xmlDocument.GetElementsByTagName(array4[0]).Item(num).Attributes[array4[1]].InnerText.Trim());
						if ((!(text8 != "") || !string.Equals(text18, text8, StringComparison.CurrentCultureIgnoreCase)) && (!(text8 == "") || !(text7 != "") || string.Equals(text18, text7, StringComparison.CurrentCultureIgnoreCase)) && text3.IndexOf($"<NCCode SN=\"{text16.Trim()}\" CODE=\"{text17.Trim()}\" Position=\"{text18.Trim()}\"></NCCode>") < 0)
						{
							text3 += $"<NCCode SN=\"{text16.Trim()}\" CODE=\"{text17.Trim()}\" Position=\"{text18.Trim()}\"></NCCode>";
						}
					}
				}
				text3 = $"<PanelSN>{text3}</PanelSN>";
				text2 = dao.SaveTestPanelComplate(text15, resourceId, stationId, defaultUserName, text3);
				if (text2 == "")
				{
					MoveToTargetDir(fullPath, FileDirEnum.OK);
					Logger.Write(string.Format("解析文件{0}成功; SN：{1}过站成功！SN检验结果：{2}", text, text15, GetResult(text3 == "<PanelSN></PanelSN>")));
				}
				else
				{
					MoveToTargetDir(fullPath, FileDirEnum.NG);
					Logger.Write($"解析文件{text}成功; SN：{text15}过站失败！消息:{text2}");
				}
			}
			else
			{
				string text19 = "";
				text19 = ((!(text13 == "TITLE")) ? GetAttributeInfo(text5, xmlDocument) : array[Convert.ToInt32(text5) - 1].Trim());
				string text20 = "";
				text20 = ((!(text14 == "TITLE")) ? GetAttributeInfo(text6, xmlDocument) : array[Convert.ToInt32(text6) - 1].Trim());
				int num2 = 0;
				if (text8 != "" && string.Equals(text19, text8, StringComparison.CurrentCultureIgnoreCase))
				{
					num2 = 1;
				}
				else if (text8 != "" && string.Equals(text20, text8, StringComparison.CurrentCultureIgnoreCase))
				{
					num2 = 1;
				}
				else if (text8 == "" && text7 != "" && !string.Equals(text19, text7, StringComparison.CurrentCultureIgnoreCase) && !string.Equals(text20, text7, StringComparison.CurrentCultureIgnoreCase))
				{
					num2 = 1;
				}
				text2 = dao.SaveTestUnitComplate(text15, resourceId, stationId, Config.DeviceInterface.LineId, defaultUserName, num2, Config.DeviceInterface.NCCodeId);
				if (text2 == "")
				{
					MoveToTargetDir(fullPath, FileDirEnum.OK);
					Logger.Write($"解析文件{text}成功; SN：{text15}过站成功！SN检验结果：{GetResult(num2 == 1)}");
				}
				else
				{
					MoveToTargetDir(fullPath, FileDirEnum.NG);
					Logger.Write($"解析文件{text}成功; SN：{text15}过站失败！消息:{text2}");
				}
			}
		}
		catch (Exception ex)
		{
			result = false;
			string msg = $"解析文件{text}失败：{ex.Message}";
			SoundHelper.PlaySound();
			MoveToTargetDir(fullPath, FileDirEnum.ERROR);
			Logger.Write(msg, isOk: false);
		}
		return result;
	}

	public bool IsFileInUse(string sFilePath)
	{
		bool result = true;
		FileStream fileStream = null;
		try
		{
			FileInfo fileInfo = new FileInfo(sFilePath);
			if (Math.Ceiling((double)fileInfo.Length / 1024.0) > (double)MinFileSize)
			{
				fileStream = new FileStream(sFilePath, FileMode.Open, FileAccess.Read, FileShare.Read);
				result = false;
			}
		}
		catch
		{
		}
		finally
		{
			if (fileStream != null)
			{
				fileStream.Close();
				fileStream.Dispose();
			}
		}
		return result;
	}

	private string GetNewFileName(int i, string TargetPath, string FileName, string OldFileName)
	{
		FileName = OldFileName.Substring(0, OldFileName.IndexOf('.')) + "_" + (i + 1) + OldFileName.Substring(OldFileName.IndexOf('.'), OldFileName.Length - OldFileName.IndexOf('.'));
		if (File.Exists(TargetPath + "\\" + FileName))
		{
			i++;
			FileName = GetNewFileName(i, TargetPath, FileName, OldFileName);
		}
		return FileName;
	}

	private string GetLastRevFileName(int i, string TargetPath, string FileName, string OldFileName)
	{
		string text = OldFileName.Substring(0, OldFileName.IndexOf('.')) + "_" + (i + 1) + OldFileName.Substring(OldFileName.IndexOf('.'), OldFileName.Length - OldFileName.IndexOf('.'));
		if (File.Exists(TargetPath + "\\" + text))
		{
			i++;
			FileName = GetLastRevFileName(i, TargetPath, text, OldFileName);
		}
		return FileName;
	}

	private string GetAttributeInfo(string xpath, XmlDocument xmlDoc)
	{
		string[] array = xpath.Split('@');
		string result = "";
		if (array.Length > 1)
		{
			XmlNodeList elementsByTagName = xmlDoc.GetElementsByTagName(array[0]);
			for (int i = 0; i < elementsByTagName.Count; i++)
			{
				if (elementsByTagName.Item(i).Attributes[array[1]] != null)
				{
					result = elementsByTagName.Item(i).Attributes[array[1]].InnerText.Trim();
					break;
				}
			}
		}
		else
		{
			result = xmlDoc.GetElementsByTagName(array[0])[0].InnerText.Trim();
		}
		return result;
	}

	private void WriteLog(string Msg, string StackTrace)
	{
		if (!Directory.Exists(GetAppSetting("FileLog")))
		{
			Directory.CreateDirectory(GetAppSetting("FileLog"));
		}
		string path = Path.Combine(GetAppSetting("FileLog"), string.Format("{0}.txt", DateTime.Now.ToString("yyyy-MM-dd")));
		if (!File.Exists(path))
		{
			File.Create(path).Close();
		}
		File.AppendAllText(path, Msg + "\r\n", Encoding.GetEncoding("GB2312"));
		File.AppendAllText(path, StackTrace + "\r\n\r\n", Encoding.GetEncoding("GB2312"));
	}

	public static string GetAppSetting(string key)
	{
		return ConfigurationManager.AppSettings[key];
	}

	private bool GetXMLResult(XmlDocument xmlDoc)
	{
		bool result = false;
		IList<DeviceInterfaceTestPosition> testResultPosition = Config.DeviceInterface.TestResultPosition;
		if (testResultPosition != null && testResultPosition.Count > 0)
		{
			string empty = string.Empty;
			foreach (DeviceInterfaceTestPosition item in testResultPosition)
			{
				empty = GetAttributeInfo(item.Position, xmlDoc);
				if (!string.IsNullOrEmpty(empty) && empty.ToLower().IndexOf(item.TestResult.ToLower()) > -1)
				{
					result = true;
					break;
				}
			}
		}
		return result;
	}

	private bool GetCSVResult(IList<string[]> rowArray)
	{
		bool result = false;
		IList<DeviceInterfaceTestPosition> testResultPosition = Config.DeviceInterface.TestResultPosition;
		if (testResultPosition != null && testResultPosition.Count > 0)
		{
			string empty = string.Empty;
			foreach (DeviceInterfaceTestPosition item in testResultPosition)
			{
				string[] array = item.Position.Split(',');
				empty = rowArray[Convert.ToInt32(array[0]) - 1][Convert.ToInt32(array[1]) - 1].Trim();
				if (!string.IsNullOrEmpty(empty) && empty.ToLower().IndexOf(item.TestResult.ToLower()) > -1)
				{
					result = true;
					break;
				}
			}
		}
		return result;
	}

	private bool GetExcelResult(DataTable dt)
	{
		bool result = false;
		IList<DeviceInterfaceTestPosition> testResultPosition = Config.DeviceInterface.TestResultPosition;
		if (testResultPosition != null && testResultPosition.Count > 0)
		{
			string empty = string.Empty;
			foreach (DeviceInterfaceTestPosition item in testResultPosition)
			{
				string[] array = item.Position.Split(',');
				empty = dt.Rows[Convert.ToInt32(array[0]) - 1][Convert.ToInt32(array[1]) - 1].ToString().Trim();
				if (!string.IsNullOrEmpty(empty) && empty.ToLower().IndexOf(item.TestResult.ToLower()) > -1)
				{
					result = true;
					break;
				}
			}
		}
		return result;
	}

	private string GetFileType(string format)
	{
		if (string.Equals(format, FileTypeEnum.Excel.ToString(), StringComparison.CurrentCultureIgnoreCase))
		{
			return "*.*";
		}
		return "*." + format;
	}

	private void MoveToTargetDir(string sourcePath, FileDirEnum fileDir)
	{
		string fileName = Path.GetFileName(sourcePath);
		string text = GetTargetDir(fileDir);
		if (!Directory.Exists(text))
		{
			try
			{
				Directory.CreateDirectory(text);
				Logger.Write($"创建文件夹，文件夹路径：{text}");
			}
			catch (Exception)
			{
				text = "d:\\mes";
			}
		}
		text = text + "\\" + fileName;
		if (File.Exists(text))
		{
			File.Delete(text);
		}
		File.Move(sourcePath, text);
	}

	private string GetTargetDir(FileDirEnum fileDir)
	{
		return $"{Config.DeviceInterface.TargetFileDir}\\{fileDir.ToString()}\\{Config.DeviceInterface.DeviceType}\\{Config.DeviceInterface.Brand}\\{DateTime.Now.GetDateTimeStr(1)}";
	}

	private string GetTargetPath(string sourcePath, FileDirEnum fileDir)
	{
		string fileName = Path.GetFileName(sourcePath);
		string targetDir = GetTargetDir(fileDir);
		return targetDir + "\\" + fileName;
	}

	private string GetResult(bool isPass)
	{
		return isPass ? "OK" : "NG";
	}

	public static void GetAccessControl(string path, string user, string pwd)
	{
		Process process = new Process();
		process.StartInfo.FileName = Environment.GetEnvironmentVariable("ComSpec");
		process.StartInfo.UseShellExecute = false;
		process.StartInfo.RedirectStandardInput = true;
		process.StartInfo.RedirectStandardOutput = true;
		process.StartInfo.CreateNoWindow = true;
		process.Start();
		process.StandardInput.WriteLine("Net Use {0} /del", path);
		process.StandardInput.WriteLine("Net Use {0} \"{1}\" /user:{2}", path, pwd, user);
		process.StandardInput.WriteLine("exit");
		process.WaitForExit();
		process.Close();
	}

	public void Execute(IJobExecutionContext context)
	{
		try
		{
			List<string> list = null;
			list = ((!string.Equals(Config.DeviceInterface.FileType, "excel", StringComparison.CurrentCultureIgnoreCase)) ? (from s in Directory.GetFiles(Config.MonitorDir, "*.*", SearchOption.AllDirectories)
				where s.ToLower().EndsWith(Config.DeviceInterface.FileType.ToLower())
				select s).ToList() : (from s in Directory.GetFiles(Config.MonitorDir, "*.*")
				where s.ToLower().EndsWith("xls") || s.ToLower().EndsWith("xlsx")
				select s).ToList());
			string empty = string.Empty;
			for (int num = 0; num < list.Count; num++)
			{
				if (StopRunning)
				{
					SoundHelper.StopPlaySound();
					break;
				}
				empty = list[num];
				if (File.Exists(empty))
				{
					SoundHelper.StopPlaySound();
					ProcessFile(empty);
				}
			}
		}
		catch (Exception ex)
		{
			string msg = $"定时执行任务失败：{ex.Message}";
			Logger.Write(msg, isOk: false);
		}
	}

	private bool ProcessFile(string fullPath)
	{
		bool result = false;
		if (IsFileInUse(fullPath))
		{
			Logger.Write("文件被占用，文件路径：" + fullPath, isOk: false);
			return false;
		}
		try
		{
			if (Config.DeviceInterface.FileType.ToLower() == "txt")
			{
				result = TranscateTxtFile(fullPath);
			}
			else if (Config.DeviceInterface.FileType.ToLower() == "dat")
			{
				result = TranscateDatFile(fullPath);
			}
			else if (Config.DeviceInterface.FileType.ToLower() == "csv")
			{
				result = TranscateCsvFile(fullPath);
			}
			else if (Config.DeviceInterface.FileType.ToLower() == "xml")
			{
				result = TranscateXmlFile(fullPath);
			}
			else if (string.Equals(Config.DeviceInterface.FileType, "excel", StringComparison.CurrentCultureIgnoreCase))
			{
				result = TranscateExcelFile(fullPath);
			}
		}
		catch (Exception ex)
		{
			SoundHelper.PlaySound();
			string msg = string.Format("文件({0})解析失败,解析时间：{2},失败原因：{1}", fullPath, ex.Message, DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss"));
			//MessageBox.Show("文件解析失败", "", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
			Logger.Write(msg, isOk: false);
		}
		return result;
	}
}
