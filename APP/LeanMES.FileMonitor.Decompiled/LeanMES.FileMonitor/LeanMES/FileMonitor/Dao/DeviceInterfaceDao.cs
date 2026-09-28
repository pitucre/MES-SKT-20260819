using System.Data;
using System.Linq;
using System.Text;
using Dapper;
using LeanMES.FileMonitor.Model;

namespace LeanMES.FileMonitor.Dao;

public class DeviceInterfaceDao
{
	public DeviceInterface Get(DeviceInterface entity)
	{
		using IDbConnection dbConnection = ConnectionFactory.CreateSqlConnection();
		string sql = "SELECT di.DeviceInterfaceId,di.DeviceInterfaceTypeId,di.TargetFileDir,di.FileType,di.DefaultUserName,di.NCCodeId,di.LineId,di.IsCouplet\r\n                                ,di.CreateDateTime,di.CreateBy,di.ModifyDateTime,di.ModifyBy,di.Reserved1,di.Reserved2,di.Reserved3,di.Reserved4,di.Reserved5, li.LineName, nc.NCCode\r\n                                FROM Prod_DeviceInterface di\r\n                                INNER JOIN Basal_NCCode nc ON di.NCCodeId = nc.NCCodeId\r\n                                INNER JOIN Basal_Line li ON di.LineId = li.LineId\r\n                                WHERE DeviceInterfaceTypeId = @DeviceInterfaceTypeId";
		DeviceInterface result = dbConnection.Query<DeviceInterface>(sql, new { entity.DeviceInterfaceTypeId }).FirstOrDefault();
		dbConnection.Close();
		return result;
	}

	public DeviceInterface GetDeviceInterface(DeviceInterface entity)
	{
		using IDbConnection dbConnection = ConnectionFactory.CreateSqlConnection();
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("SELECT");
		stringBuilder.Append(" di.DeviceInterfaceId,di.DeviceInterfaceTypeId,di.TargetFileDir,di.FileType,di.DefaultUserName,di.NCCodeId,di.LineId,di.IsCouplet");
		stringBuilder.Append(" ,di.CreateDateTime,di.CreateBy,di.ModifyDateTime,di.ModifyBy,di.Reserved1,di.Reserved2,di.Reserved3,di.Reserved4,di.Reserved5,TitleSplitChar,TxtSplitChar");
		stringBuilder.Append(" ,dt.DeviceType,dt.Brand");
		stringBuilder.Append(" ,nc.NCCode,li.LineName");
		stringBuilder.Append(" FROM Prod_DeviceInterface di");
		stringBuilder.Append(" INNER JOIN Prod_DeviceInterfaceType dt ON di.DeviceInterfaceTypeId = dt.DeviceInterfaceTypeId");
		stringBuilder.Append(" INNER JOIN Basal_NCCode nc ON di.NCCodeId = nc.NCCodeId");
		stringBuilder.Append(" INNER JOIN Basal_Line li ON di.LineId = li.LineId");
		stringBuilder.Append(" WHERE di.DeviceInterfaceTypeId = @DeviceInterfaceTypeId");
		DeviceInterface result = dbConnection.Query<DeviceInterface>(stringBuilder.ToString(), new { entity.DeviceInterfaceTypeId }).FirstOrDefault();
		dbConnection.Close();
		return result;
	}
}
