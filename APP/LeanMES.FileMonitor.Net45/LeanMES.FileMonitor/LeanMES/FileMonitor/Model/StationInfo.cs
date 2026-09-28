using System;

namespace LeanMES.FileMonitor.Model
{
public class StationInfo
{
private int stationId;

private string station;

private string stationDesc;

private int stationTypeId;

private int stationStatus;

private int stationResTypeId;

private int stationDefaultResId;

private string stationRevision;

private bool stationIsCurrentRev;

private string remark;

private DateTime createDateTime;

private string createBy;

private DateTime modifyDateTime;

private string modifyBy;

private int tmplID;

private int moduleId;

private string opeType;

private string resTypeName;

private string resName;

private string statusStr;

private string tempName;

private string moduleName;

public string ShortLetter { get; set; }

public int IsCollectStation { get; set; }

public int StationId
{
	get
	{
		return stationId;
	}
	set
	{
		stationId = value;
	}
}

public string Station
{
	get
	{
		return station;
	}
	set
	{
		station = value;
	}
}

public string StationDesc
{
	get
	{
		return stationDesc;
	}
	set
	{
		stationDesc = value;
	}
}

public int StationTypeId
{
	get
	{
		return stationTypeId;
	}
	set
	{
		stationTypeId = value;
	}
}

public int StationStatus
{
	get
	{
		return stationStatus;
	}
	set
	{
		stationStatus = value;
	}
}

public int StationResTypeId
{
	get
	{
		return stationResTypeId;
	}
	set
	{
		stationResTypeId = value;
	}
}

public int StationDefaultResId
{
	get
	{
		return stationDefaultResId;
	}
	set
	{
		stationDefaultResId = value;
	}
}

public string StationRevision
{
	get
	{
		return stationRevision;
	}
	set
	{
		stationRevision = value;
	}
}

public bool StationIsCurrentRev
{
	get
	{
		return stationIsCurrentRev;
	}
	set
	{
		stationIsCurrentRev = value;
	}
}

public string Remark
{
	get
	{
		return remark;
	}
	set
	{
		remark = value;
	}
}

public DateTime CreateDateTime
{
	get
	{
		return createDateTime;
	}
	set
	{
		createDateTime = value;
	}
}

public string CreateBy
{
	get
	{
		return createBy;
	}
	set
	{
		createBy = value;
	}
}

public DateTime ModifyDateTime
{
	get
	{
		return modifyDateTime;
	}
	set
	{
		modifyDateTime = value;
	}
}

public string ModifyBy
{
	get
	{
		return modifyBy;
	}
	set
	{
		modifyBy = value;
	}
}

public int TmplID
{
	get
	{
		return tmplID;
	}
	set
	{
		tmplID = value;
	}
}

public string OpeType
{
	get
	{
		return opeType;
	}
	set
	{
		opeType = value;
	}
}

public string ResTypeName
{
	get
	{
		return resTypeName;
	}
	set
	{
		resTypeName = value;
	}
}

public string ResName
{
	get
	{
		return resName;
	}
	set
	{
		resName = value;
	}
}

public string StatusStr
{
	get
	{
		return statusStr;
	}
	set
	{
		statusStr = value;
	}
}

public string TempName
{
	get
	{
		return tempName;
	}
	set
	{
		tempName = value;
	}
}

public int ModuleId
{
	get
	{
		return moduleId;
	}
	set
	{
		moduleId = value;
	}
}

public string ModuleName
{
	get
	{
		return moduleName;
	}
	set
	{
		moduleName = value;
	}
}

public string StationType { get; set; }

public StationInfo()
{
}

public StationInfo(int stationId, string station, string stationDesc, int stationTypeId, int stationStatus, int stationResTypeId, int stationDefaultResId, string stationRevision, bool stationIsCurrentRev, string remark, DateTime createDateTime, string createBy, DateTime modifyDateTime, string modifyBy, int tmplID)
{
	this.stationId = stationId;
	this.station = station;
	this.stationDesc = stationDesc;
	this.stationTypeId = stationTypeId;
	this.stationStatus = stationStatus;
	this.stationResTypeId = stationResTypeId;
	this.stationDefaultResId = stationDefaultResId;
	this.stationRevision = stationRevision;
	this.stationIsCurrentRev = stationIsCurrentRev;
	this.remark = remark;
	this.createDateTime = createDateTime;
	this.createBy = createBy;
	this.modifyDateTime = modifyDateTime;
	this.modifyBy = modifyBy;
	this.tmplID = tmplID;
}
}
}
