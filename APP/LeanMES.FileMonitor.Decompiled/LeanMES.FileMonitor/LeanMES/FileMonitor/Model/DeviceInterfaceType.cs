using System;

namespace LeanMES.FileMonitor.Model;

[Serializable]
public class DeviceInterfaceType
{
	private int _deviceInterfaceTypeId;

	private string _devicetype;

	private string _brand;

	private string _createby;

	private DateTime? _createtime = DateTime.Now;

	private string _modifyby;

	private DateTime? _modifydatetime = DateTime.Now;

	public int DeviceInterfaceTypeId
	{
		get
		{
			return _deviceInterfaceTypeId;
		}
		set
		{
			_deviceInterfaceTypeId = value;
		}
	}

	public string DeviceType
	{
		get
		{
			return _devicetype;
		}
		set
		{
			_devicetype = value;
		}
	}

	public string Brand
	{
		get
		{
			return _brand;
		}
		set
		{
			_brand = value;
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

	public DateTime? CreateTime
	{
		get
		{
			return _createtime;
		}
		set
		{
			_createtime = value;
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

	public DateTime? ModifyDateTime
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
}
