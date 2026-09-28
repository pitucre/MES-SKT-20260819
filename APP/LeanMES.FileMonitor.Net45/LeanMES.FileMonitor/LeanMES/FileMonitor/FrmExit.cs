using System;
using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;
using MetroFramework;
using MetroFramework.Controls;
using MetroFramework.Forms;

namespace LeanMES.FileMonitor
{
public class FrmExit : MetroForm
{
private IContainer components = null;

private MetroLabel metroLabel1;

private MetroTextBox txtPassword;

private MetroButton btnExit;

public event Action ReturnValue;

public FrmExit()
{
	InitializeComponent();
}

private void FrmExit_Load(object sender, EventArgs e)
{
	base.FormClosed += FrmExit_FormClosed;
}

private void FrmExit_FormClosed(object sender, FormClosedEventArgs e)
{
	if (ReturnValue != null)
	{
		ReturnValue();
	}
}

private void btnExit_Click(object sender, EventArgs e)
{
	Exit();
}

private void txtPassword_KeyUp(object sender, KeyEventArgs e)
{
	if (e.KeyCode == Keys.Return)
	{
		Exit();
	}
}

private void Exit()
{
	string text = txtPassword.Text.Trim();
	if (string.IsNullOrEmpty(text))
	{
		MessageBox.Show("请输入密码！");
	}
	else if (!string.Equals(text, "mes123456"))
	{
		MessageBox.Show("密码不正确！");
	}
	else
	{
		Environment.Exit(0);
	}
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
	this.metroLabel1 = new MetroFramework.Controls.MetroLabel();
	this.txtPassword = new MetroFramework.Controls.MetroTextBox();
	this.btnExit = new MetroFramework.Controls.MetroButton();
	base.SuspendLayout();
	this.metroLabel1.AutoSize = true;
	this.metroLabel1.FontWeight = MetroFramework.MetroLabelWeight.Regular;
	this.metroLabel1.Location = new System.Drawing.Point(27, 90);
	this.metroLabel1.Name = "metroLabel1";
	this.metroLabel1.Size = new System.Drawing.Size(79, 19);
	this.metroLabel1.TabIndex = 0;
	this.metroLabel1.Text = "输入密码：";
	this.txtPassword.CustomButton.Image = null;
	this.txtPassword.CustomButton.Location = new System.Drawing.Point(149, 1);
	this.txtPassword.CustomButton.Name = "";
	this.txtPassword.CustomButton.Size = new System.Drawing.Size(21, 21);
	this.txtPassword.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
	this.txtPassword.CustomButton.TabIndex = 1;
	this.txtPassword.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
	this.txtPassword.CustomButton.UseSelectable = true;
	this.txtPassword.CustomButton.Visible = false;
	this.txtPassword.Lines = new string[0];
	this.txtPassword.Location = new System.Drawing.Point(110, 89);
	this.txtPassword.MaxLength = 32767;
	this.txtPassword.Name = "txtPassword";
	this.txtPassword.PasswordChar = '*';
	this.txtPassword.ScrollBars = System.Windows.Forms.ScrollBars.None;
	this.txtPassword.SelectedText = "";
	this.txtPassword.SelectionLength = 0;
	this.txtPassword.SelectionStart = 0;
	this.txtPassword.ShortcutsEnabled = true;
	this.txtPassword.Size = new System.Drawing.Size(171, 23);
	this.txtPassword.TabIndex = 1;
	this.txtPassword.UseSelectable = true;
	this.txtPassword.WaterMarkColor = System.Drawing.Color.FromArgb(109, 109, 109);
	this.txtPassword.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12f, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
	this.txtPassword.KeyUp += new System.Windows.Forms.KeyEventHandler(txtPassword_KeyUp);
	this.btnExit.Location = new System.Drawing.Point(110, 153);
	this.btnExit.Name = "btnExit";
	this.btnExit.Size = new System.Drawing.Size(75, 23);
	this.btnExit.TabIndex = 2;
	this.btnExit.Text = "确定";
	this.btnExit.UseSelectable = true;
	this.btnExit.Click += new System.EventHandler(btnExit_Click);
	base.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
	base.BorderStyle = MetroFramework.Forms.MetroFormBorderStyle.FixedSingle;
	base.ClientSize = new System.Drawing.Size(325, 259);
	base.Controls.Add(this.btnExit);
	base.Controls.Add(this.txtPassword);
	base.Controls.Add(this.metroLabel1);
	base.DisplayHeader = false;
	base.MaximizeBox = false;
	base.MinimizeBox = false;
	base.Name = "FrmExit";
	base.Padding = new System.Windows.Forms.Padding(20, 30, 20, 20);
	base.Resizable = false;
	base.Style = MetroFramework.MetroColorStyle.Red;
	this.Text = "FrmExit";
	base.Load += new System.EventHandler(FrmExit_Load);
	base.ResumeLayout(false);
	base.PerformLayout();
}
}
}
