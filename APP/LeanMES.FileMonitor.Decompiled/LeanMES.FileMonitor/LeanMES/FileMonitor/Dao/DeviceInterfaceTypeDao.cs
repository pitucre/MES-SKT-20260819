using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using Dapper;
using LeanMES.FileMonitor.Model;

namespace LeanMES.FileMonitor.Dao;

public class DeviceInterfaceTypeDao
{
	private static readonly string conn = ConfigurationManager.AppSettings["MESConnString"];

	public IList<DeviceInterfaceType> GetDeviceType()
	{
		string sql = $"SELECT MAX(DeviceInterfaceTypeId) AS DeviceInterfaceTypeId, DeviceType FROM dbo.Prod_DeviceInterfaceType GROUP BY DeviceType";
		using IDbConnection dbConnection = ConnectionFactory.CreateSqlConnection();
		List<DeviceInterfaceType> result = dbConnection.Query<DeviceInterfaceType>(sql).ToList();
		dbConnection.Close();
		return result;
	}

	public DeviceInterfaceType GetDeviceTypeInfo(DeviceInterfaceType entity)
	{
		string sql = $"SELECT DeviceInterfaceTypeId, DeviceType FROM dbo.Prod_DeviceInterfaceType WHERE DeviceInterfaceTypeId = @DeviceInterfaceTypeId";
		using IDbConnection dbConnection = ConnectionFactory.CreateSqlConnection();
		DeviceInterfaceType result = dbConnection.Query<DeviceInterfaceType>(sql, new { entity.DeviceInterfaceTypeId }).FirstOrDefault();
		dbConnection.Close();
		return result;
	}

	public IList<DeviceInterfaceType> GetBrandType(DeviceInterfaceType entity)
	{
		using IDbConnection dbConnection = ConnectionFactory.CreateSqlConnection();
		string sql = "SELECT DeviceInterfaceTypeId,DeviceType,Brand,CreateBy,CreateTime,ModifyBy,ModifyDateTime FROM Prod_DeviceInterfaceType WHERE DeviceType = @DeviceType";
		List<DeviceInterfaceType> result = dbConnection.Query<DeviceInterfaceType>(sql, new { entity.DeviceType }).ToList();
		dbConnection.Close();
		return result;
	}
}
