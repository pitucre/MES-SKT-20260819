using System;
using System.IO;

namespace LeanMES.FileMonitor
{
internal class Log
{
private static readonly object signal = new object();

internal static void info(string message)
{
	DateTime now = DateTime.Now;
	string text = "[" + now.Year + "-" + now.Month + "-" + now.Day + " " + now.Hour + ":" + now.Minute + ":" + now.Second + "]   ";
	message = text + message;
	string text2 = "log\\" + now.Year + "-" + now.Month + "\\";
	if (!Directory.Exists(text2))
	{
		try
		{
			Directory.CreateDirectory(text2);
		}
		catch (Exception ex)
		{
			Console.WriteLine(ex.Message);
		}
	}
	lock (signal)
	{
		using (StreamWriter streamWriter = new StreamWriter(text2 + now.Year + "-" + now.Month + "-" + now.Day + ".log", append: true))
		{
			streamWriter.WriteLine(message);
			streamWriter.Close();
		}
	}
	Console.WriteLine(message);
}
}
}
