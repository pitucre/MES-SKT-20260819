using System;
using System.IO;
using System.Runtime.InteropServices;
using IWshRuntimeLibrary;

namespace LeanMES.FileMonitor.Utility
{
public class ShortcutCreator
{
public static void CreateShortcut(string directory, string shortcutName, string targetPath, string description = null, string iconLocation = null)
{
	if (!Directory.Exists(directory))
	{
		Directory.CreateDirectory(directory);
	}
	string pathLink = Path.Combine(directory, string.Format("{0}.lnk", shortcutName));
	WshShell wshShell = (WshShell)Activator.CreateInstance(Marshal.GetTypeFromCLSID(new Guid("72C24DD5-D70A-438B-8A42-98424B88AFB8")));
	IWshShortcut wshShortcut = (IWshShortcut)(dynamic)wshShell.CreateShortcut(pathLink);
	wshShortcut.TargetPath = targetPath;
	wshShortcut.WorkingDirectory = Path.GetDirectoryName(targetPath);
	wshShortcut.WindowStyle = 1;
	wshShortcut.Description = description;
	wshShortcut.IconLocation = (string.IsNullOrWhiteSpace(iconLocation) ? targetPath : iconLocation);
	wshShortcut.Save();
}

public static void CreateShortcutOnDesktop(string shortcutName, string targetPath, string description = null, string iconLocation = null)
{
	string folderPath = Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory);
	CreateShortcut(folderPath, shortcutName, targetPath, description, iconLocation);
}
}
}
