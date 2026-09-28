using System;

namespace LeanMES.FileMonitor.Model;

[Serializable]
public class DeviceInterfaceTestPosition
{
	private int _devicetestposid;

	private int? _deviceinterfaceid;

	private string _analysisType;

	private string _ponitType;

	private string _testresult;

	private int? _sequencenumber;

	public int DeviceTestPosId
	{
		get
		{
			return _devicetestposid;
		}
		set
		{
			_devicetestposid = value;
		}
	}

	public int? DeviceInterfaceId
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

	public string AnalysisType
	{
		get
		{
			return _analysisType;
		}
		set
		{
			_analysisType = value;
		}
	}

	public string PonitType
	{
		get
		{
			return _ponitType;
		}
		set
		{
			_ponitType = value;
		}
	}

	public string TestResult
	{
		get
		{
			return _testresult;
		}
		set
		{
			_testresult = value;
		}
	}

	public string Position { get; set; }
}
