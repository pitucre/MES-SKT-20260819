using System;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using MetroFramework;
using MetroFramework.Forms;

namespace LeanMES.FileMonitor;

public class FrmDemo : MetroForm
{
	private IContainer components = null;

	public FrmDemo()
	{
		InitializeComponent();
	}

	private void FrmMetroDemo_Load(object sender, EventArgs e)
	{
		GetAccessControl("\\\\sktmes003\\临时文件夹", "skt\\wenshun.wang", "Admin@126");
		string text = "E:\\监控文件\\SMTTestSN - 副本.xlsx";
		string fileName = Path.GetFileName(text);
		string text2 = "\\\\sktmes003\\临时文件夹";
		if (!Directory.Exists(text2))
		{
			Directory.CreateDirectory(text2);
		}
		text2 = text2 + "\\" + fileName;
		if (File.Exists(text2))
		{
			File.Delete(text2);
		}
		File.Move(text, text2);
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

	public static bool connectState(string path)
	{
		return connectState(path, "", "");
	}

	public static bool connectState(string path, string userName, string passWord)
	{
		bool result = false;
		Process process = new Process();
		try
		{
			process.StartInfo.FileName = "cmd.exe";
			process.StartInfo.UseShellExecute = false;
			process.StartInfo.RedirectStandardInput = true;
			process.StartInfo.RedirectStandardOutput = true;
			process.StartInfo.RedirectStandardError = true;
			process.StartInfo.CreateNoWindow = true;
			process.Start();
			string value = "net use " + path + " " + passWord + " /user:" + userName;
			process.StandardInput.WriteLine(value);
			process.StandardInput.WriteLine("exit");
			while (!process.HasExited)
			{
				process.WaitForExit(1000);
			}
			string text = process.StandardError.ReadToEnd();
			process.StandardError.Close();
			if (!string.IsNullOrEmpty(text))
			{
				throw new Exception(text);
			}
			result = true;
		}
		catch (Exception ex)
		{
			MessageBox.Show(ex.Message);
		}
		finally
		{
			process.Close();
			process.Dispose();
		}
		return result;
	}

	public static void Transport(string src, string dst, string fileName)
	{
		FileStream fileStream = new FileStream(src, FileMode.Open);
		if (!Directory.Exists(dst))
		{
			Directory.CreateDirectory(dst);
		}
		dst += fileName;
		FileStream fileStream2 = new FileStream(dst, FileMode.OpenOrCreate);
		byte[] array = new byte[fileStream.Length];
		int count;
		while ((count = fileStream.Read(array, 0, array.Length)) > 0)
		{
			fileStream2.Write(array, 0, count);
		}
		fileStream.Flush();
		fileStream.Close();
		fileStream2.Flush();
		fileStream2.Close();
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing && components != null)
		{
			components.Dispose();
		}
		base.Dispose(disposing);
	}

	private void InitializeComponent()
	{
		base.SuspendLayout();
		base.ApplyImageInvert = true;
		base.AutoScaleDimensions = new System.Drawing.SizeF(6f, 12f);
		base.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
		base.BackMaxSize = 1000;
		base.BorderStyle = MetroFramework.Forms.MetroFormBorderStyle.FixedSingle;
		base.ClientSize = new System.Drawing.Size(739, 490);
		base.DisplayHeader = false;
		base.Name = "FrmMetroDemo";
		base.Padding = new System.Windows.Forms.Padding(20, 30, 20, 20);
		base.Resizable = false;
		base.ShadowType = MetroFramework.Forms.MetroFormShadowType.AeroShadow;
		base.Style = MetroFramework.MetroColorStyle.Silver;
		this.Text = "FrmMetroDemo";
		base.TopMost = true;
		base.Load += new System.EventHandler(FrmMetroDemo_Load);
		base.ResumeLayout(false);
	}
}
