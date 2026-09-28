using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Threading;
using System.Windows.Forms;
using LeanMES.FileMonitor.Utility;
using Microsoft.Win32;

namespace LeanMES.FileMonitor;

internal static class Program
{
	[STAThread]
	private static void Main()
	{
		Application.EnableVisualStyles();
		Application.SetCompatibleTextRenderingDefault(defaultValue: false);
		Application.ThreadException += Application_ThreadException;
		Logger.Write("程序启动...");
		int id = Process.GetCurrentProcess().Id;
		bool flag = false;
		Process[] processesByName = Process.GetProcessesByName("LeanMES.FileMonitor");
		foreach (Process process in processesByName)
		{
			if (Assembly.GetExecutingAssembly().Location.ToLower() == process.MainModule.FileName.ToLower() && id != process.Id)
			{
				flag = true;
				break;
			}
		}
		if (flag)
		{
			MessageBox.Show("另一个应用已启动，请勿重复开启");
			Application.Exit();
		}
		else
		{
			Application.Run(new FrmFileMonitor());
		}
	}

	private static void StartUp()
	{
		try
		{
			string executablePath = Application.ExecutablePath;
			SetAutoRun(executablePath, isAutoRun: true);
		}
		catch (Exception ex)
		{
			Logger.Write($"设置开机自启失败：{ex.Message}");
		}
	}

	private static void Application_ThreadException(object sender, ThreadExceptionEventArgs e)
	{
		Exception exception = e.Exception;
		Logger.Write(string.Format("捕获到未处理的异常：{0}，异常堆栈：{1}", exception.Message, exception.StackTrace.Replace("\r\n", " ")));
	}

	public static void SetAutoRun(string fileName, bool isAutoRun)
	{
		RegistryKey registryKey = null;
		try
		{
			string fileName2 = Path.GetFileName(fileName);
			registryKey = Registry.CurrentUser.OpenSubKey("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run", writable: true);
			if (registryKey == null)
			{
				registryKey = Registry.CurrentUser.CreateSubKey("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run");
			}
			if (isAutoRun)
			{
				registryKey.SetValue(fileName2, fileName);
			}
			else
			{
				registryKey.SetValue(fileName2, false);
			}
			Logger.Write($"设置开机自启成功！");
		}
		catch (Exception ex)
		{
			Logger.Write($"设置开机自启失败：{ex.Message}");
		}
		finally
		{
			registryKey?.Close();
		}
	}
}
