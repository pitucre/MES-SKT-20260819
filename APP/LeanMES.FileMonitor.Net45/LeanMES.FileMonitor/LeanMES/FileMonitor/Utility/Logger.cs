using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading;

namespace LeanMES.FileMonitor.Utility
{
public class Logger
{
private static Queue<string> QueueMsg;

public static string LogFilePath { get; set; }

static Logger()
{
	QueueMsg = null;
	QueueMsg = new Queue<string>();
	RunThread();
}

private static string GetLogPath()
{
	string logFilePath = LogFilePath;
	if (!Directory.Exists(logFilePath))
	{
		Directory.CreateDirectory(logFilePath);
	}
	logFilePath = logFilePath + "\\" + DateTime.Now.ToString("yyyy-MM-dd") + ".log";
	if (!File.Exists(logFilePath))
	{
		FileStream fileStream = File.Create(logFilePath);
		fileStream.Close();
		fileStream.Dispose();
	}
	return logFilePath;
}

private static void RunThread()
{
	ThreadPool.QueueUserWorkItem(delegate
	{
		while (true)
		{
			if (string.IsNullOrEmpty(LogFilePath))
			{
				Thread.Sleep(5000);
			}
			else
			{
				string text = string.Empty;
				lock (QueueMsg)
				{
					if (QueueMsg.Count > 0)
					{
						text = QueueMsg.Dequeue();
					}
				}
				if (!string.IsNullOrEmpty(text))
				{
					WriteLog(text);
				}
				if (QueueMsg.Count <= 0)
				{
					Thread.Sleep(5000);
				}
			}
		}
	});
}

public static void WriteLog(string strLog)
{
	if (string.IsNullOrEmpty(strLog))
	{
		return;
	}
	FileStream fileStream = null;
	try
	{
		string logPath = GetLogPath();
		fileStream = File.Open(logPath, FileMode.OpenOrCreate);
		byte[] bytes = Encoding.UTF8.GetBytes(strLog);
		fileStream.Position = fileStream.Length;
		fileStream.Write(bytes, 0, bytes.Length);
	}
	finally
	{
		if (fileStream != null)
		{
			fileStream.Close();
			fileStream.Dispose();
		}
	}
}

public static void Write(string msg, bool isOk = true)
{
	if (string.IsNullOrWhiteSpace(msg))
	{
		return;
	}
	msg = string.Format("{0} {1} {2}\r\n", DateTime.Now.GetDateTimeStr(2), isOk ? "OK" : "NG", msg.Trim());
	lock (QueueMsg)
	{
		QueueMsg.Enqueue(msg);
	}
	lock (FrmFileMonitor.QueueMsg)
	{
		FrmFileMonitor.QueueMsg.Enqueue(msg);
	}
}
}
}
