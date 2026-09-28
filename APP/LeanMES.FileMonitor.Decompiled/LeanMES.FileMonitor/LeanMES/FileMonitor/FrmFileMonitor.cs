using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using LeanMES.FileMonitor.Dao;
using LeanMES.FileMonitor.Enum;
using LeanMES.FileMonitor.Model;
using LeanMES.FileMonitor.SKTControls;
using LeanMES.FileMonitor.Utility;
using MetroFramework;
using MetroFramework.Controls;
using MetroFramework.Forms;
using Newtonsoft.Json;
using Quartz;
using Quartz.Impl;
using uPLibrary.Networking.M2Mqtt;
using uPLibrary.Networking.M2Mqtt.Messages;

namespace LeanMES.FileMonitor;

public class FrmFileMonitor : MetroForm
{
	private const string RUNNING = "运行";

	private const string SUSPEND = "暂停";

	private DeviceInterfaceTypeDao dtDao = new DeviceInterfaceTypeDao();

	private DeviceInterfaceDao diDao = new DeviceInterfaceDao();

	private List<OPCUAHelper> listHelper = null;

	private DeviceInterfaceTestPositionDao tpdao = new DeviceInterfaceTestPositionDao();

	private StationDao sdDao = new StationDao();

	private bool isBindBrand = false;

	private readonly string jsonFilePath = Path.GetPathRoot(Application.StartupPath) + "SKT\\FileMonitor\\LeanMESConfig.json";

	internal static Queue<string> QueueMsg = new Queue<string>();

	private readonly int logLength = 20;

	private IList<DeviceInterfaceType> deviceypeList = null;

	private new bool InvokeRequired = true;

	private static FileWatch fw = new FileWatch();

	public static bool isShowTop = false;

	public static string UserName;

	private IScheduler scheduler;

	private List<string> listLine = null;

	private OPCUAHelper opcClient;

	private MqttClient mqttClient = null;

	private ConcurrentQueue<MqttMsgPublishEventArgs> _queue = new ConcurrentQueue<MqttMsgPublishEventArgs>();

	private readonly SemaphoreSlim _batchLock = new SemaphoreSlim(10, 10);

	private IContainer components = null;

	private MetroTabControl tabFileMonitor;

	private MetroTabPage metroTabPage1;

	private MetroButton btnReset;

	private MetroButton btnRunning;

	private MetroButton btnPath;

	private ComboBoxTree ctStation;

	private Label label4;

	private NotifyIcon notifyIcon;

	private PictureBox pictureBox1;

	private Label label1;

	private MetroTextBox txtDir;

	private MetroPanel metroPanel1;

	private Label label17;

	private Label lblLineId;

	private Label lblNcCodeId;

	private MetroCheckBox chkShowTop;

	private RichTextBox rtxtLog;

	private Panel panel1;

	private Label label15;

	private System.Windows.Forms.Timer timer1;

	public FrmFileMonitor()
	{
		InitializeComponent();
	}

	private void FrmMetro_Load(object sender, EventArgs e)
	{
		tabFileMonitor.SelectedIndex = 0;
		InitLog();
		txtDir.Text = TXTHelper.GetAppSeting("MonitorDir");
	}

	private void InitLog()
	{
		ThreadPool.QueueUserWorkItem(delegate
		{
			while (true)
			{
				try
				{
					if (base.IsDisposed || !base.IsHandleCreated)
					{
						Logger.Write("未更新日志文本框信息", isOk: false);
						break;
					}
					Action method = delegate
					{
						RefreshRichBox();
					};
					Invoke(method);
				}
				catch (Exception ex)
				{
					Logger.Write("更新文本框数据失败：" + ex.Message, isOk: false);
				}
				if (QueueMsg.Count <= 0)
				{
					Thread.Sleep(10000);
				}
			}
		});
	}

	public void RefreshRichBox()
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
			int num = rtxtLog.Lines.Count();
			if (num > logLength)
			{
				listLine = rtxtLog.Lines.ToList();
				if (listLine.Count <= 0)
				{
					return;
				}
				listLine.RemoveAt(num - 1);
				listLine.Add(text.TrimEnd());
				rtxtLog.Clear();
				for (int i = 1; i < listLine.Count; i++)
				{
					if (listLine[i].Length >= 22 && listLine[i].Substring(20, 2) == "NG")
					{
						rtxtLog.SelectionColor = Color.Red;
					}
					rtxtLog.AppendText(listLine[i] + Environment.NewLine);
				}
				listLine.Clear();
				listLine = null;
			}
			else
			{
				if (text.Length >= 22 && text.Substring(20, 2) == "NG")
				{
					rtxtLog.SelectionColor = Color.Red;
				}
				rtxtLog.AppendText(text);
			}
		}
		if (QueueMsg.Count <= 0 && !string.IsNullOrEmpty(text))
		{
			rtxtLog.Focus();
			rtxtLog.Select(rtxtLog.TextLength, 0);
			rtxtLog.ScrollToCaret();
			Application.DoEvents();
		}
	}

	private void btnPath_Click(object sender, EventArgs e)
	{
		FolderBrowserDialog folderBrowserDialog = new FolderBrowserDialog();
		folderBrowserDialog.ShowDialog();
		txtDir.Text = folderBrowserDialog.SelectedPath;
	}

	private void btnRunning_Click(object sender, EventArgs e)
	{
		btnRunning.Enabled = false;
		try
		{
			SoundHelper.StopPlaySound();
			ExtensionSound.formulario = this;
			if (!(btnRunning.Text == "运行") && 0 == 0)
			{
				if (scheduler != null && !scheduler.IsShutdown)
				{
					scheduler.Shutdown(waitForJobsToComplete: false);
				}
				FileWatch.StopRunning = true;
				MessageBox.Show("已暂停解析");
				btnRunning.Text = "运行";
				Logger.Write("暂停监控");
				btnRunning.Enabled = true;
				timer1.Enabled = false;
				if (mqttClient == null)
				{
					return;
				}
				try
				{
					if (mqttClient.IsConnected)
					{
						mqttClient.MqttMsgPublishReceived -= client_MqttMsgPublishReceived;
						mqttClient.Disconnect();
					}
				}
				catch (Exception ex)
				{
					Logger.Write("断开连接异常: " + ex.Message);
				}
				finally
				{
					Logger.Write("释放MQTT客户端资源...");
					try
					{
						mqttClient.Disconnect();
					}
					catch (Exception ex2)
					{
						Logger.Write("资源释放异常: " + ex2.Message);
					}
					mqttClient = null;
					Logger.Write("✓ 客户端资源已释放");
				}
				Logger.Write("暂停MQTT监控");
			}
			else
			{
				timer1.Enabled = true;
				string text = txtDir.Text.Trim();
				if (string.IsNullOrEmpty(text))
				{
					MessageBox.Show("请选择监控文件目录");
					btnPath.Focus();
					return;
				}
				TXTHelper.SaveConfig("MonitorDir", text);
				FileWatch.Config = new MonitorConfig
				{
					MonitorDir = text,
					DeviceInterface = new DeviceInterface
					{
						FileType = "dat",
						TxtSplitChar = ","
					}
				};
				StartProcessFile();
				btnRunning.Text = "暂停";
				FileWatch.StopRunning = false;
			}
		}
		catch (Exception ex3)
		{
			Logger.Write(ex3.Message);
		}
		finally
		{
			btnRunning.Enabled = true;
		}
	}

	private void btnReset_Click(object sender, EventArgs e)
	{
		try
		{
			SoundHelper.StopPlaySound();
			string a = btnRunning.Text.Trim();
			if (string.Equals(a, "暂停"))
			{
				MessageBox.Show("请先暂停解析");
				return;
			}
			Logger.Write("暂停监控");
			btnRunning.Text = "运行";
			FileWatch.StopRunning = true;
			txtDir.Text = string.Empty;
			lock (QueueMsg)
			{
				QueueMsg.Clear();
			}
			rtxtLog.Text = string.Empty;
			fw.StopWork();
		}
		catch (Exception ex)
		{
			Logger.Write(ex.Message);
			MessageBox.Show(ex.Message);
		}
	}

	private void notifyIcon_DoubleClick(object sender, EventArgs e)
	{
		if (base.WindowState == FormWindowState.Minimized)
		{
			Show();
			base.WindowState = FormWindowState.Normal;
		}
	}

	private void FrmMetro_FormClosing(object sender, FormClosingEventArgs e)
	{
		e.Cancel = true;
		FrmExit frmExit = new FrmExit();
		frmExit.ReturnValue += Frm_ReturnValue;
		frmExit.ShowDialog();
	}

	private void Frm_ReturnValue()
	{
		chkShowTop.Checked = isShowTop;
		base.TopMost = isShowTop;
	}

	private void chkShowTop_CheckedChanged(object sender, EventArgs e)
	{
		base.TopMost = (chkShowTop.Checked ? true : false);
		isShowTop = chkShowTop.Checked;
	}

	private void StartProcessFile()
	{
		string empty = string.Empty;
		int seconds = Convert.ToInt32(ConfigurationManager.AppSettings["JobExecIntervalInSecond"]);
		DateTimeOffset dateTimeOffset = DateBuilder.EvenMinuteDate(DateTimeOffset.UtcNow.AddSeconds(5.0));
		try
		{
			string text = (string.Equals(FileWatch.Config.DeviceInterface.FileType, FileTypeEnum.Excel.ToString(), StringComparison.CurrentCultureIgnoreCase) ? "*.xls|*.xlsx" : "dat");
			Logger.Write("任务监控文件类型为：" + text);
			Logger.Write("任务监控目录：" + txtDir.Text);
			ISchedulerFactory schedulerFactory = new StdSchedulerFactory();
			scheduler = schedulerFactory.GetScheduler();
			IJobDetail jobDetail = JobBuilder.Create<FileWatch>().WithIdentity("jobFile", "group").Build();
			ITrigger trigger = TriggerBuilder.Create().WithIdentity("trgFile", "group").StartNow()
				.WithSimpleSchedule(delegate(SimpleScheduleBuilder x)
				{
					x.WithIntervalInSeconds(seconds).RepeatForever();
				})
				.Build();
			scheduler.ScheduleJob(jobDetail, trigger);
			string text2 = "";
			IList<EquipmentInfo> deMaGeEquipmentList = new StationDao().GetDeMaGeEquipmentList();
			listHelper = new List<OPCUAHelper>();
			foreach (EquipmentInfo item in deMaGeEquipmentList)
			{
				if (!string.IsNullOrWhiteSpace(item.EquipmentIP) && !string.IsNullOrWhiteSpace(item.EquipmentPort) && Tool.PingIp(item.EquipmentIP))
				{
					try
					{
						text2 = "opc.tcp://" + item.EquipmentIP + ":" + item.EquipmentPort;
						OPCUAHelper oPCUAHelper = new OPCUAHelper();
						oPCUAHelper.OpenConnectOfAnonymous(text2);
						listHelper.Add(oPCUAHelper);
						Logger.Write($"德马格设备：{item.EquipmentCode}");
					}
					catch (Exception ex)
					{
						Logger.Write($"处理失败1：{ex.Message}", isOk: false);
					}
				}
			}
			HMGExecute();
			scheduler.Start();
			Logger.Write("任务启动完成,文件解析将在：" + seconds + "秒后循环执行.");
		}
		catch (Exception ex2)
		{
			Logger.Write($"处理失败：{ex2.Message}", isOk: false);
		}
	}

	private void cboBrandType_SelectedIndexChanged(object sender, EventArgs e)
	{
	}

	private void timer1_Tick(object sender, EventArgs e)
	{
		try
		{
			string PartSts = string.Empty;
			string MachineID = string.Empty;
			string ActCntPrt = string.Empty;
			string ActTimCyc = string.Empty;
			string ActFrcClp = string.Empty;
			string paramterStr = string.Empty;
			string paramterVal = string.Empty;
			Task.Run(async delegate
			{
				foreach (OPCUAHelper opcClient in listHelper)
				{
					try
					{
						if (opcClient.ConnectStatus)
						{
							PartSts = opcClient.GetCurrentNodeValue("ns=2;s=PartSts").ToString();
							MachineID = opcClient.GetCurrentNodeValue("ns=2;s=MachineID").ToString();
							ActCntPrt = opcClient.GetCurrentNodeValue("ns=2;s=ActCntPrt").ToString();
							ActTimCyc = opcClient.GetCurrentNodeValue("ns=2;s=ActTimCyc").ToString();
							ActFrcClp = opcClient.GetCurrentNodeValue("ns=2;s=ActFrcClp").ToString();
							paramterStr = "@PartSts,@MachineID,@ActCntPrt,@ActTimCyc,@ActFrcClp";
							Logger.Write("采集德马格设备数据：" + MachineID);
							paramterVal = PartSts + "," + MachineID + "," + ActCntPrt + "," + ActTimCyc + "," + ActFrcClp;
							new StationDao().SaveEquipmentCollection(paramterStr, paramterVal, 2, out MachineID);
						}
						else
						{
							Logger.Write("采集德马格注塑设备连接失败..");
						}
					}
					catch (Exception ex2)
					{
						Logger.Write("德马格注塑设备采集数据发生异常：" + ex2.Message, isOk: false);
					}
				}
			}).Wait();
		}
		catch (Exception ex)
		{
			Logger.Write("发生异常：" + ex.Message, isOk: false);
		}
	}

	public void HMGExecute()
	{
		try
		{
			if (mqttClient == null)
			{
				Logger.Write("开始采集海天设备数据.....");
				IPAddress brokerIpAddress = IPAddress.Parse("172.16.5.150");
				int brokerPort = 1883;
				string clientId = "CsharpClient";
				string username = "mqttadmin";
				string password = "Mqttadmin@123";
				mqttClient = new MqttClient(brokerIpAddress, brokerPort, secure: false, null, null, MqttSslProtocols.None);
				mqttClient.Connect(clientId, username, password, cleanSession: true, 60);
				mqttClient.MqttMsgPublishReceived += client_MqttMsgPublishReceived;
				mqttClient.Subscribe(new string[1] { "+/all" }, new byte[1]);
			}
		}
		catch (Exception ex)
		{
			Logger.Write("采集海天设备数据发生异常：" + ex.Message, isOk: false);
		}
	}

	private async void client_MqttMsgPublishReceived(object sender, MqttMsgPublishEventArgs e)
	{
		_queue.Enqueue(e);
		if (_queue.Count > 100)
		{
			ProcessBatchAsync();
		}
	}

	private async Task ProcessBatchAsync()
	{
		await _batchLock.WaitAsync();
		try
		{
			List<MqttMsgPublishEventArgs> batch = new List<MqttMsgPublishEventArgs>();
			MqttMsgPublishEventArgs msg;
			while (_queue.TryDequeue(out msg))
			{
				batch.Add(msg);
			}
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.Append("<Root>");
			foreach (MqttMsgPublishEventArgs msg2 in batch)
			{
				string json = Encoding.UTF8.GetString(msg2.Message);
				DeviceData data = JsonConvert.DeserializeObject<DeviceData>(json);
				stringBuilder.AppendFormat("<Data DevId='{0}'  sendTime='{1}'  STS='{2}'  CYCN='{3}'   ECYCT='{4}'  EPLSPM='{5}'/>", data.DevId, data.SendTime, data.Data.STS, data.Data.CYCN, data.Data.ECYCT, data.Data.ECYCT);
			}
			stringBuilder.Append("</Root>");
			try
			{
				string equiCode = new StationDao().HMGEquipmentCollectionTest(stringBuilder.ToString());
				Logger.Write("采集海天设备数据：" + equiCode + " ");
			}
			catch (Exception ex)
			{
				Logger.Write("处理消息失败：" + ex.Message);
			}
		}
		finally
		{
			_batchLock.Release();
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
		this.components = new System.ComponentModel.Container();
		System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LeanMES.FileMonitor.FrmFileMonitor));
		this.tabFileMonitor = new MetroFramework.Controls.MetroTabControl();
		this.metroTabPage1 = new MetroFramework.Controls.MetroTabPage();
		this.panel1 = new System.Windows.Forms.Panel();
		this.label15 = new System.Windows.Forms.Label();
		this.rtxtLog = new System.Windows.Forms.RichTextBox();
		this.lblNcCodeId = new System.Windows.Forms.Label();
		this.lblLineId = new System.Windows.Forms.Label();
		this.chkShowTop = new MetroFramework.Controls.MetroCheckBox();
		this.txtDir = new MetroFramework.Controls.MetroTextBox();
		this.btnReset = new MetroFramework.Controls.MetroButton();
		this.btnRunning = new MetroFramework.Controls.MetroButton();
		this.btnPath = new MetroFramework.Controls.MetroButton();
		this.label4 = new System.Windows.Forms.Label();
		this.notifyIcon = new System.Windows.Forms.NotifyIcon(this.components);
		this.label1 = new System.Windows.Forms.Label();
		this.pictureBox1 = new System.Windows.Forms.PictureBox();
		this.metroPanel1 = new MetroFramework.Controls.MetroPanel();
		this.label17 = new System.Windows.Forms.Label();
		this.timer1 = new System.Windows.Forms.Timer(this.components);
		this.tabFileMonitor.SuspendLayout();
		this.metroTabPage1.SuspendLayout();
		this.panel1.SuspendLayout();
		((System.ComponentModel.ISupportInitialize)this.pictureBox1).BeginInit();
		this.metroPanel1.SuspendLayout();
		base.SuspendLayout();
		this.tabFileMonitor.Controls.Add(this.metroTabPage1);
		this.tabFileMonitor.Dock = System.Windows.Forms.DockStyle.Bottom;
		this.tabFileMonitor.FontWeight = MetroFramework.MetroTabControlWeight.Regular;
		this.tabFileMonitor.Location = new System.Drawing.Point(1, 56);
		this.tabFileMonitor.Name = "tabFileMonitor";
		this.tabFileMonitor.SelectedIndex = 0;
		this.tabFileMonitor.Size = new System.Drawing.Size(762, 466);
		this.tabFileMonitor.Style = MetroFramework.MetroColorStyle.Silver;
		this.tabFileMonitor.TabIndex = 3;
		this.tabFileMonitor.UseSelectable = true;
		this.metroTabPage1.Controls.Add(this.panel1);
		this.metroTabPage1.Controls.Add(this.rtxtLog);
		this.metroTabPage1.Controls.Add(this.lblNcCodeId);
		this.metroTabPage1.Controls.Add(this.lblLineId);
		this.metroTabPage1.Controls.Add(this.chkShowTop);
		this.metroTabPage1.Controls.Add(this.txtDir);
		this.metroTabPage1.Controls.Add(this.btnReset);
		this.metroTabPage1.Controls.Add(this.btnRunning);
		this.metroTabPage1.Controls.Add(this.btnPath);
		this.metroTabPage1.Controls.Add(this.label4);
		this.metroTabPage1.Font = new System.Drawing.Font("微软雅黑", 9f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 134);
		this.metroTabPage1.HorizontalScrollbarBarColor = true;
		this.metroTabPage1.HorizontalScrollbarHighlightOnWheel = false;
		this.metroTabPage1.HorizontalScrollbarSize = 10;
		this.metroTabPage1.Location = new System.Drawing.Point(4, 38);
		this.metroTabPage1.Margin = new System.Windows.Forms.Padding(0);
		this.metroTabPage1.Name = "metroTabPage1";
		this.metroTabPage1.Size = new System.Drawing.Size(754, 424);
		this.metroTabPage1.Style = MetroFramework.MetroColorStyle.Silver;
		this.metroTabPage1.TabIndex = 0;
		this.metroTabPage1.Text = "  参数设置  ";
		this.metroTabPage1.VerticalScrollbarBarColor = true;
		this.metroTabPage1.VerticalScrollbarHighlightOnWheel = false;
		this.metroTabPage1.VerticalScrollbarSize = 10;
		this.panel1.BackColor = System.Drawing.Color.Transparent;
		this.panel1.Controls.Add(this.label15);
		this.panel1.Location = new System.Drawing.Point(4, 84);
		this.panel1.Name = "panel1";
		this.panel1.Size = new System.Drawing.Size(683, 22);
		this.panel1.TabIndex = 49;
		this.label15.AutoSize = true;
		this.label15.BackColor = System.Drawing.Color.White;
		this.label15.Font = new System.Drawing.Font("微软雅黑", 9f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 134);
		this.label15.Location = new System.Drawing.Point(3, 2);
		this.label15.Name = "label15";
		this.label15.Size = new System.Drawing.Size(84, 20);
		this.label15.TabIndex = 22;
		this.label15.Text = "运行日志：";
		this.rtxtLog.BackColor = System.Drawing.Color.White;
		this.rtxtLog.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
		this.rtxtLog.Font = new System.Drawing.Font("微软雅黑", 9f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 134);
		this.rtxtLog.Location = new System.Drawing.Point(3, 112);
		this.rtxtLog.Name = "rtxtLog";
		this.rtxtLog.ReadOnly = true;
		this.rtxtLog.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical;
		this.rtxtLog.Size = new System.Drawing.Size(748, 311);
		this.rtxtLog.TabIndex = 48;
		this.rtxtLog.Text = "";
		this.lblNcCodeId.AutoSize = true;
		this.lblNcCodeId.Location = new System.Drawing.Point(495, 390);
		this.lblNcCodeId.Name = "lblNcCodeId";
		this.lblNcCodeId.Size = new System.Drawing.Size(0, 20);
		this.lblNcCodeId.TabIndex = 47;
		this.lblNcCodeId.Visible = false;
		this.lblLineId.AutoSize = true;
		this.lblLineId.Location = new System.Drawing.Point(442, 390);
		this.lblLineId.Name = "lblLineId";
		this.lblLineId.Size = new System.Drawing.Size(0, 20);
		this.lblLineId.TabIndex = 46;
		this.lblLineId.Visible = false;
		this.chkShowTop.AutoSize = true;
		this.chkShowTop.Location = new System.Drawing.Point(105, 59);
		this.chkShowTop.Name = "chkShowTop";
		this.chkShowTop.Size = new System.Drawing.Size(184, 17);
		this.chkShowTop.TabIndex = 41;
		this.chkShowTop.Text = "始终显示在屏幕最前端";
		this.chkShowTop.UseSelectable = true;
		this.chkShowTop.CheckedChanged += new System.EventHandler(chkShowTop_CheckedChanged);
		this.txtDir.CustomButton.Image = null;
		this.txtDir.CustomButton.Location = new System.Drawing.Point(286, 1);
		this.txtDir.CustomButton.Name = "";
		this.txtDir.CustomButton.Size = new System.Drawing.Size(23, 23);
		this.txtDir.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
		this.txtDir.CustomButton.TabIndex = 1;
		this.txtDir.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
		this.txtDir.CustomButton.UseSelectable = true;
		this.txtDir.CustomButton.Visible = false;
		this.txtDir.Lines = new string[0];
		this.txtDir.Location = new System.Drawing.Point(105, 13);
		this.txtDir.MaxLength = 32767;
		this.txtDir.Name = "txtDir";
		this.txtDir.PasswordChar = '\0';
		this.txtDir.ReadOnly = true;
		this.txtDir.ScrollBars = System.Windows.Forms.ScrollBars.None;
		this.txtDir.SelectedText = "";
		this.txtDir.SelectionLength = 0;
		this.txtDir.SelectionStart = 0;
		this.txtDir.ShortcutsEnabled = true;
		this.txtDir.Size = new System.Drawing.Size(310, 25);
		this.txtDir.TabIndex = 38;
		this.txtDir.UseSelectable = true;
		this.txtDir.WaterMarkColor = System.Drawing.Color.FromArgb(109, 109, 109);
		this.txtDir.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12f, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
		this.btnReset.Cursor = System.Windows.Forms.Cursors.Hand;
		this.btnReset.Location = new System.Drawing.Point(587, 53);
		this.btnReset.Name = "btnReset";
		this.btnReset.Size = new System.Drawing.Size(100, 25);
		this.btnReset.TabIndex = 37;
		this.btnReset.Text = "重置";
		this.btnReset.UseSelectable = true;
		this.btnReset.Click += new System.EventHandler(btnReset_Click);
		this.btnRunning.BackColor = System.Drawing.Color.Brown;
		this.btnRunning.Cursor = System.Windows.Forms.Cursors.Hand;
		this.btnRunning.ForeColor = System.Drawing.Color.CornflowerBlue;
		this.btnRunning.Location = new System.Drawing.Point(413, 53);
		this.btnRunning.Name = "btnRunning";
		this.btnRunning.Size = new System.Drawing.Size(100, 25);
		this.btnRunning.TabIndex = 36;
		this.btnRunning.Text = "运行";
		this.btnRunning.UseSelectable = true;
		this.btnRunning.Click += new System.EventHandler(btnRunning_Click);
		this.btnPath.BackColor = System.Drawing.Color.DeepSkyBlue;
		this.btnPath.Cursor = System.Windows.Forms.Cursors.Hand;
		this.btnPath.Location = new System.Drawing.Point(413, 13);
		this.btnPath.Name = "btnPath";
		this.btnPath.Size = new System.Drawing.Size(100, 25);
		this.btnPath.TabIndex = 35;
		this.btnPath.Text = "浏览";
		this.btnPath.UseSelectable = true;
		this.btnPath.Click += new System.EventHandler(btnPath_Click);
		this.label4.AutoSize = true;
		this.label4.BackColor = System.Drawing.Color.White;
		this.label4.Location = new System.Drawing.Point(17, 16);
		this.label4.Name = "label4";
		this.label4.Size = new System.Drawing.Size(84, 20);
		this.label4.TabIndex = 25;
		this.label4.Text = "监控目录：";
		this.notifyIcon.Icon = (System.Drawing.Icon)resources.GetObject("notifyIcon.Icon");
		this.notifyIcon.Text = "深科特文件监控系统";
		this.notifyIcon.Visible = true;
		this.notifyIcon.DoubleClick += new System.EventHandler(notifyIcon_DoubleClick);
		this.label1.Anchor = System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right;
		this.label1.AutoSize = true;
		this.label1.BackColor = System.Drawing.Color.Transparent;
		this.label1.Font = new System.Drawing.Font("微软雅黑", 21.75f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 134);
		this.label1.Location = new System.Drawing.Point(162, 14);
		this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
		this.label1.Name = "label1";
		this.label1.Size = new System.Drawing.Size(516, 48);
		this.label1.TabIndex = 4;
		this.label1.Text = "深科特设备数据采集系统 V4.0";
		this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
		this.pictureBox1.Anchor = System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left;
		this.pictureBox1.BackColor = System.Drawing.Color.Transparent;
		this.pictureBox1.Image = (System.Drawing.Image)resources.GetObject("pictureBox1.Image");
		this.pictureBox1.Location = new System.Drawing.Point(1, 14);
		this.pictureBox1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
		this.pictureBox1.Name = "pictureBox1";
		this.pictureBox1.Size = new System.Drawing.Size(130, 48);
		this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
		this.pictureBox1.TabIndex = 5;
		this.pictureBox1.TabStop = false;
		this.metroPanel1.Controls.Add(this.label17);
		this.metroPanel1.Dock = System.Windows.Forms.DockStyle.Bottom;
		this.metroPanel1.HorizontalScrollbarBarColor = true;
		this.metroPanel1.HorizontalScrollbarHighlightOnWheel = false;
		this.metroPanel1.HorizontalScrollbarSize = 10;
		this.metroPanel1.Location = new System.Drawing.Point(1, 522);
		this.metroPanel1.Name = "metroPanel1";
		this.metroPanel1.Size = new System.Drawing.Size(762, 26);
		this.metroPanel1.TabIndex = 6;
		this.metroPanel1.VerticalScrollbarBarColor = true;
		this.metroPanel1.VerticalScrollbarHighlightOnWheel = false;
		this.metroPanel1.VerticalScrollbarSize = 10;
		this.label17.Anchor = System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right;
		this.label17.AutoSize = true;
		this.label17.Font = new System.Drawing.Font("微软雅黑", 9f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, 134);
		this.label17.Location = new System.Drawing.Point(238, 3);
		this.label17.Name = "label17";
		this.label17.Size = new System.Drawing.Size(234, 20);
		this.label17.TabIndex = 2;
		this.label17.Text = "深科特信息技术有限公司版权所有";
		this.label17.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
		this.timer1.Enabled = true;
		this.timer1.Interval = 30000;
		this.timer1.Tick += new System.EventHandler(timer1_Tick);
		base.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
		base.BorderStyle = MetroFramework.Forms.MetroFormBorderStyle.FixedSingle;
		base.ClientSize = new System.Drawing.Size(764, 549);
		base.Controls.Add(this.pictureBox1);
		base.Controls.Add(this.label1);
		base.Controls.Add(this.tabFileMonitor);
		base.Controls.Add(this.metroPanel1);
		base.DisplayHeader = false;
		base.Icon = (System.Drawing.Icon)resources.GetObject("$this.Icon");
		base.MaximizeBox = false;
		base.Name = "FrmFileMonitor";
		base.Padding = new System.Windows.Forms.Padding(1, 30, 1, 1);
		base.ShadowType = MetroFramework.Forms.MetroFormShadowType.DropShadow;
		base.Style = MetroFramework.MetroColorStyle.Silver;
		base.FormClosing += new System.Windows.Forms.FormClosingEventHandler(FrmMetro_FormClosing);
		base.Load += new System.EventHandler(FrmMetro_Load);
		this.tabFileMonitor.ResumeLayout(false);
		this.metroTabPage1.ResumeLayout(false);
		this.metroTabPage1.PerformLayout();
		this.panel1.ResumeLayout(false);
		this.panel1.PerformLayout();
		((System.ComponentModel.ISupportInitialize)this.pictureBox1).EndInit();
		this.metroPanel1.ResumeLayout(false);
		this.metroPanel1.PerformLayout();
		base.ResumeLayout(false);
		base.PerformLayout();
	}
}
