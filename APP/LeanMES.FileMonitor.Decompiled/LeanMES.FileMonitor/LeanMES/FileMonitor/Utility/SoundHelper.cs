using System;
using System.IO;
using System.Media;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace LeanMES.FileMonitor.Utility;

public class SoundHelper
{
	[Flags]
	public enum PlaySoundFlags
	{
		SND_SYNC = 0,
		SND_ASYNC = 1,
		SND_NODEFAULT = 2,
		SND_LOOP = 8,
		SND_NOSTOP = 0x10,
		SND_NOWAIT = 0x2000,
		SND_FILENAME = 0x20000,
		SND_RESOURCE = 0x40004
	}

	public static SoundPlayer player;

	[DllImport("winmm.DLL", CharSet = CharSet.Unicode, SetLastError = true, ThrowOnUnmappableChar = true)]
	private static extern bool PlaySound(string szSound, IntPtr hMod, PlaySoundFlags flags);

	public static void PlaySound()
	{
		string path = $"{Application.StartupPath}\\Resources";
		DirectoryInfo directoryInfo = new DirectoryInfo(path);
		FileInfo[] files = directoryInfo.GetFiles("*.wav");
		if (files != null && files.Length != 0)
		{
			string fullName = files[0].FullName;
			if (File.Exists(fullName))
			{
				player = new SoundPlayer();
				player.SoundLocation = fullName;
				player.Load();
				player.PlayLooping();
			}
		}
	}

	public static void StopPlaySound()
	{
		if (player != null)
		{
			player.Stop();
			player.Dispose();
			player = null;
		}
	}
}
