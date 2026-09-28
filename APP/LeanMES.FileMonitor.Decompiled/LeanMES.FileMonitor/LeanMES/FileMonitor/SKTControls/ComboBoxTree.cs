using System;
using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;
using LeanMES.FileMonitor.Model;
using LeanMES.FileMonitor.Properties;
using MetroFramework.Controls;

namespace LeanMES.FileMonitor.SKTControls;

public class ComboBoxTree : UserControl
{
	public delegate void GetResourceHandler(StationInfo entity, string userName);

	private MetroTextBox m_TextBox;

	private TreeView m_TreeView;

	private Button m_DropdownButton;

	private int m_MaxDropDownItems = 15;

	private bool b_Dropdown = false;

	private bool b_Enabled = true;

	private IContainer components = null;

	public TreeNodeCollection Nodes => m_TreeView.Nodes;

	public ImageList ImageList
	{
		get
		{
			return m_TreeView.ImageList;
		}
		set
		{
			m_TreeView.ImageList = value;
		}
	}

	public new bool Enabled
	{
		get
		{
			return b_Enabled;
		}
		set
		{
			if (b_Enabled != value)
			{
				b_Enabled = value;
				m_DropdownButton.Enabled = value;
				b_Enabled = value;
				if (!b_Enabled && b_Dropdown)
				{
					HideDropDown();
				}
				if (EnableChanged != null)
				{
					EnableChanged(this, EventArgs.Empty);
				}
			}
		}
	}

	public override Font Font
	{
		get
		{
			return base.Font;
		}
		set
		{
			base.Font = value;
			m_TextBox.Font = value;
			m_TreeView.Font = value;
			LayoutControls();
		}
	}

	public override string Text
	{
		get
		{
			return m_TextBox.Text;
		}
		set
		{
			if (Text != value)
			{
				m_TextBox.Text = value;
			}
		}
	}

	public bool ShowLines
	{
		get
		{
			return m_TreeView.ShowLines;
		}
		set
		{
			m_TreeView.ShowLines = value;
		}
	}

	public bool ShowPlusMinus
	{
		get
		{
			return m_TreeView.ShowPlusMinus;
		}
		set
		{
			m_TreeView.ShowPlusMinus = value;
		}
	}

	public bool ShowRootLines
	{
		get
		{
			return m_TreeView.ShowRootLines;
		}
		set
		{
			m_TreeView.ShowRootLines = value;
		}
	}

	public bool ShowNodeToolTips
	{
		get
		{
			return m_TreeView.ShowNodeToolTips;
		}
		set
		{
			m_TreeView.ShowNodeToolTips = value;
		}
	}

	public TreeNode SelectedNode
	{
		get
		{
			return m_TreeView.SelectedNode;
		}
		set
		{
			m_TreeView.SelectedNode = value;
			if (value != null)
			{
				Text = value.Text;
			}
		}
	}

	public int MaxDropDownItems
	{
		get
		{
			return m_MaxDropDownItems;
		}
		set
		{
			if (m_MaxDropDownItems != value)
			{
				m_MaxDropDownItems = value;
				m_TreeView.Height = m_TextBox.Height * value;
			}
		}
	}

	public object TextBoxTag
	{
		get
		{
			return m_TextBox.Tag;
		}
		set
		{
			m_TextBox.Tag = value;
		}
	}

	public event EventHandler DropDown;

	public event EventHandler DropDownClosed;

	public event EventHandler EnableChanged;

	public event TreeViewCancelEventHandler BeforeExpand;

	public event TreeViewCancelEventHandler BeforeCollapse;

	public event TreeViewEventHandler AfterExpand;

	public event TreeViewEventHandler AfterCollapse;

	public event GetResourceHandler GetResourceEvent;

	public ComboBoxTree()
	{
		InitControls();
		LayoutControls();
	}

	private void InitControls()
	{
		m_TextBox = new MetroTextBox();
		m_TextBox.Size = new Size(267, 25);
		m_TextBox.KeyDown += m_TextBox_KeyDown;
		m_TextBox.Parent = this;
		m_TextBox.ReadOnly = true;
		m_DropdownButton = new Button();
		m_DropdownButton.Image = LeanMES.FileMonitor.Properties.Resources.down;
		m_DropdownButton.Width = 20;
		m_DropdownButton.Height = m_TextBox.Height - 2;
		m_DropdownButton.Location = new Point(m_TextBox.Right - 22, 1);
		m_DropdownButton.Click += m_DropdownButton_Click;
		m_DropdownButton.FlatStyle = FlatStyle.Flat;
		m_DropdownButton.FlatAppearance.BorderSize = 0;
		m_DropdownButton.Parent = this;
		m_DropdownButton.BringToFront();
		m_TreeView = new TreeView();
		m_TreeView.Visible = false;
		m_TreeView.DoubleClick += m_TreeView_DoubleClick;
		m_TreeView.KeyDown += m_TreeView_KeyDown;
		m_TreeView.LostFocus += m_TreeView_LostFocus;
		m_TreeView.BeforeExpand += m_TreeView_BeforeExpand;
		m_TreeView.BeforeCollapse += TreeComboBox_BeforeCollapse;
		m_TreeView.AfterExpand += m_TreeView_AfterExpand;
		m_TreeView.AfterCollapse += TreeComboBox_AfterCollapse;
		m_TreeView.Location = new Point(0, 0);
		m_TreeView.Parent = null;
		base.LostFocus += TreeComboBox_LostFocus;
	}

	private void LayoutControls()
	{
		m_TextBox.Width = base.Width;
		base.Height = m_TextBox.Height;
		m_DropdownButton.Left = m_TextBox.Right - 22;
		m_DropdownButton.Height = m_TextBox.Height - 2;
		m_TreeView.Width = base.Width;
		m_TreeView.Height = (Font.Height + 3) * m_MaxDropDownItems;
	}

	private void ShowDropDown()
	{
		if (base.Parent == null)
		{
			return;
		}
		Point location = new Point(base.Left, base.Bottom - 1);
		Point point = base.Parent.PointToScreen(base.Parent.Location);
		Point point2 = base.TopLevelControl.PointToScreen(base.Parent.Location);
		location.Offset(point.X - point2.X, point.Y - point2.Y);
		if (location.Y + m_TreeView.Height > base.TopLevelControl.ClientRectangle.Height)
		{
			location.Y -= base.Height + m_TreeView.Height;
			if (location.Y < 0)
			{
				location.Y = base.TopLevelControl.ClientRectangle.Height - m_TreeView.Height;
			}
		}
		if (location.X + m_TreeView.Width > base.TopLevelControl.ClientRectangle.Width)
		{
			location.X = base.TopLevelControl.ClientRectangle.Width - m_TreeView.Width;
		}
		m_TreeView.Location = location;
		m_TreeView.Visible = true;
		m_TreeView.Parent = base.TopLevelControl;
		m_TreeView.BringToFront();
		b_Dropdown = true;
		if (DropDown != null)
		{
			DropDown(this, EventArgs.Empty);
		}
		m_TreeView.Focus();
	}

	private void HideDropDown()
	{
		if (DropDownClosed != null)
		{
			DropDownClosed(this, EventArgs.Empty);
		}
		m_TreeView.Parent = null;
		m_TreeView.Visible = false;
		b_Dropdown = false;
	}

	private void m_TextBox_KeyDown(object sender, KeyEventArgs e)
	{
		if (e.KeyCode == Keys.Return)
		{
			if (b_Dropdown)
			{
				HideDropDown();
			}
			else
			{
				ShowDropDown();
			}
		}
		else if (e.KeyCode == Keys.Down)
		{
			ShowDropDown();
			m_TreeView.Focus();
		}
	}

	private void m_TreeView_KeyDown(object sender, KeyEventArgs e)
	{
		if (e.KeyCode == Keys.Return)
		{
			m_TreeView_DoubleClick(sender, EventArgs.Empty);
		}
	}

	private void m_TreeView_LostFocus(object sender, EventArgs e)
	{
		if (!m_DropdownButton.Focused)
		{
			HideDropDown();
		}
	}

	private void m_TreeView_DoubleClick(object sender, EventArgs e)
	{
		TreeNode selectedNode = m_TreeView.SelectedNode;
		if (selectedNode != null)
		{
			if (selectedNode.ForeColor == Color.Gray)
			{
				return;
			}
			m_TextBox.Text = selectedNode.Text;
			m_TextBox.Tag = selectedNode.Tag;
			if (GetResourceEvent != null)
			{
				GetResourceEvent(selectedNode.Tag as StationInfo, FrmFileMonitor.UserName);
			}
		}
		if (b_Dropdown)
		{
			HideDropDown();
		}
	}

	private void TreeComboBox_AfterCollapse(object sender, TreeViewEventArgs e)
	{
		if (AfterCollapse != null)
		{
			AfterCollapse(this, e);
		}
	}

	private void TreeComboBox_BeforeCollapse(object sender, TreeViewCancelEventArgs e)
	{
		if (BeforeCollapse != null)
		{
			BeforeCollapse(this, e);
		}
	}

	private void m_TreeView_AfterExpand(object sender, TreeViewEventArgs e)
	{
		if (AfterExpand != null)
		{
			AfterExpand(this, e);
		}
	}

	private void m_TreeView_BeforeExpand(object sender, TreeViewCancelEventArgs e)
	{
		if (BeforeExpand != null)
		{
			BeforeExpand(this, e);
		}
	}

	private void m_DropdownButton_Click(object sender, EventArgs e)
	{
		if (b_Dropdown)
		{
			HideDropDown();
		}
		else
		{
			ShowDropDown();
		}
	}

	private void TreeComboBox_LostFocus(object sender, EventArgs e)
	{
		if (b_Dropdown)
		{
			HideDropDown();
		}
	}

	protected override void OnResize(EventArgs e)
	{
		base.OnResize(e);
		LayoutControls();
	}

	protected override void OnSizeChanged(EventArgs e)
	{
		base.OnSizeChanged(e);
		LayoutControls();
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
		base.AutoScaleDimensions = new System.Drawing.SizeF(6f, 12f);
		base.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
		base.Name = "ComboBoxTree";
		base.Size = new System.Drawing.Size(232, 434);
		base.ResumeLayout(false);
	}
}
