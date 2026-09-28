using System;
using System.Collections.Generic;

namespace LeanMES.FileMonitor.Model;

[Serializable]
public class DeviceInterface
{
	private int _deviceinterfaceid;

	private int _deviceinterfacetypeid;

	private string _targetfiledir;

	private string _filetype;

	private string _username;

	private string _password;

	private string _defaultusername;

	private int _nccodeid;

	private int _lineid;

	private int _iscouplet;

	private string _snposition;

	private DateTime _createdatetime;

	private string _createby;

	private DateTime _modifydatetime;

	private string _modifyby;

	private int _reserved1;

	private string _reserved2;

	private string _reserved3;

	private string _reserved4;

	private string _reserved5;

	public int DeviceInterfaceId
	{
		get
		{
			return _deviceinterfaceid;
		}
		set
		{
			_deviceinterfaceid = value;
		}
	}

	public int DeviceInterfaceTypeId
	{
		get
		{
			return _deviceinterfacetypeid;
		}
		set
		{
			_deviceinterfacetypeid = value;
		}
	}

	public string TargetFileDir
	{
		get
		{
			return _targetfiledir;
		}
		set
		{
			_targetfiledir = value;
		}
	}

	public string FileType
	{
		get
		{
			return _filetype;
		}
		set
		{
			_filetype = value;
		}
	}

	public string UserName
	{
		get
		{
			return _username;
		}
		set
		{
			_username = value;
		}
	}

	public string Password
	{
		get
		{
			return _password;
		}
		set
		{
			_password = value;
		}
	}

	public string DefaultUserName
	{
		get
		{
			return _defaultusername;
		}
		set
		{
			_defaultusername = value;
		}
	}

	public int NCCodeId
	{
		get
		{
			return _nccodeid;
		}
		set
		{
			_nccodeid = value;
		}
	}

	public int LineId
	{
		get
		{
			return _lineid;
		}
		set
		{
			_lineid = value;
		}
	}

	public int IsCouplet
	{
		get
		{
			return _iscouplet;
		}
		set
		{
			_iscouplet = value;
		}
	}

	public string SnPosition
	{
		get
		{
			return _snposition;
		}
		set
		{
			_snposition = value;
		}
	}

	public DateTime CreateDateTime
	{
		get
		{
			return _createdatetime;
		}
		set
		{
			_createdatetime = value;
		}
	}

	public string CreateBy
	{
		get
		{
			return _createby;
		}
		set
		{
			_createby = value;
		}
	}

	public DateTime ModifyDateTime
	{
		get
		{
			return _modifydatetime;
		}
		set
		{
			_modifydatetime = value;
		}
	}

	public string ModifyBy
	{
		get
		{
			return _modifyby;
		}
		set
		{
			_modifyby = value;
		}
	}

	public int Reserved1
	{
		get
		{
			return _reserved1;
		}
		set
		{
			_reserved1 = value;
		}
	}

	public string Reserved2
	{
		get
		{
			return _reserved2;
		}
		set
		{
			_reserved2 = value;
		}
	}

	public string Reserved3
	{
		get
		{
			return _reserved3;
		}
		set
		{
			_reserved3 = value;
		}
	}

	public string Reserved4
	{
		get
		{
			return _reserved4;
		}
		set
		{
			_reserved4 = value;
		}
	}

	public string Reserved5
	{
		get
		{
			return _reserved5;
		}
		set
		{
			_reserved5 = value;
		}
	}

	public string TitleSplitChar { get; set; }

	public string TxtSplitChar { get; set; }

	public string IsCoupletName { get; set; }

	public string DeviceType { get; set; }

	public string Brand { get; set; }

	public string NCCode { get; set; }

	public string LineName { get; set; }

	public IList<DeviceInterfaceTestPosition> TestResultPosition { get; set; }
}
