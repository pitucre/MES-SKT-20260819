using System;

namespace LeanMES.FileMonitor.Model
{
public class ResourceInfo
{
private int resourceId;

private int lineId;

private string resName;

private string resDescription;

private int resStatus;

private string defaultOpt;

private DateTime validStartTime;

private DateTime validEndTime;

private string createBy;

private DateTime createDateTime;

private string modifyBy;

private DateTime modifyDateTime;

private string remark;

private int itemId;

private string modify_Ver;

private string itemName;

private string lineName;

private string resTypeName;

private int resTypeId;

public int ResourceId
{
	get
	{
		return resourceId;
	}
	set
	{
		resourceId = value;
	}
}

public int LineId
{
	get
	{
		return lineId;
	}
	set
	{
		lineId = value;
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

public string ResDescription
{
	get
	{
		return resDescription;
	}
	set
	{
		resDescription = value;
	}
}

public int ResStatus
{
	get
	{
		return resStatus;
	}
	set
	{
		resStatus = value;
	}
}

public string DefaultOpt
{
	get
	{
		return defaultOpt;
	}
	set
	{
		defaultOpt = value;
	}
}

public DateTime ValidStartTime
{
	get
	{
		return validStartTime;
	}
	set
	{
		validStartTime = value;
	}
}

public DateTime ValidEndTime
{
	get
	{
		return validEndTime;
	}
	set
	{
		validEndTime = value;
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

public int ItemId
{
	get
	{
		return itemId;
	}
	set
	{
		itemId = value;
	}
}

public string Modify_Ver
{
	get
	{
		return modify_Ver;
	}
	set
	{
		modify_Ver = value;
	}
}

public string ItemName
{
	get
	{
		return itemName;
	}
	set
	{
		itemName = value;
	}
}

public string LineName
{
	get
	{
		return lineName;
	}
	set
	{
		lineName = value;
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

public int ResTypeId
{
	get
	{
		return resTypeId;
	}
	set
	{
		resTypeId = value;
	}
}

public string Face { get; set; }

public int StationDefaultResId { get; set; }

public string ResourceName { get; set; }

public ResourceInfo()
{
}

public ResourceInfo(int resourceId, int lineId, string resName, string resDescription, int resStatus, string defaultOpt, DateTime validStartTime, DateTime validEndTime, string createBy, DateTime createDateTime, string modifyBy, DateTime modifyDateTime, string remark)
{
	this.resourceId = resourceId;
	this.lineId = lineId;
	this.resName = resName;
	this.resDescription = resDescription;
	this.resStatus = resStatus;
	this.defaultOpt = defaultOpt;
	this.validStartTime = validStartTime;
	this.validEndTime = validEndTime;
	this.createBy = createBy;
	this.createDateTime = createDateTime;
	this.modifyBy = modifyBy;
	this.modifyDateTime = modifyDateTime;
	this.remark = remark;
}
}
}
