using System;
using System.Runtime.InteropServices;
using System.Text;
using System.Windows.Forms;

namespace LeanMES.FileMonitor.Utility;

public class ExtensionSound
{
	private static readonly string WaveSoundPath = Application.StartupPath.TrimEnd('\\') + "\\Resources\\warn.mp3";

	private int syncMciResult = -1;

	public static Form formulario;

	[DllImport("winmm.dll")]
	private static extern int mciSendString(string lpszCommand, StringBuilder returnString, int bufferSize, IntPtr hwndCallback);

	[DllImport("winmm.dll")]
	private static extern bool mciGetErrorString(int errorCode, StringBuilder errorText, int errorTextSize);

	public void mciReplacement()
	{
		if (formulario.InvokeRequired)
		{
			formulario.Invoke((Action)delegate
			{
				mciSendString("stop myDivece", null, 0, new IntPtr(0));
				mciSendString("close myDivece", null, 0, new IntPtr(0));
				int num2 = mciSendString($"open {WaveSoundPath} alias myDivece", null, 0, new IntPtr(0));
				StringBuilder errorText2 = new StringBuilder();
				if (num2 == 0)
				{
					StringBuilder stringBuilder2 = new StringBuilder();
					mciSendString("play myDivece", null, 0, new IntPtr(0));
					mciSendString("status myDivece mode", stringBuilder2, stringBuilder2.Length, new IntPtr(0));
				}
				else
				{
					mciGetErrorString(num2, errorText2, 50);
				}
			});
		}
		else
		{
			mciSendString("stop myDivece", null, 0, new IntPtr(0));
			mciSendString("close myDivece", null, 0, new IntPtr(0));
			int num = mciSendString($"open {WaveSoundPath} alias myDivece", null, 0, new IntPtr(0));
			StringBuilder errorText = new StringBuilder();
			if (num == 0)
			{
				StringBuilder stringBuilder = new StringBuilder();
				mciSendString("play myDivece", null, 0, new IntPtr(0));
				mciSendString("status myDivece mode", stringBuilder, stringBuilder.Length, new IntPtr(0));
			}
			else
			{
				mciGetErrorString(num, errorText, 50);
			}
		}
	}
}
