using System.Collections.Generic;
using System.Data;
using System.Linq;
using Dapper;
using LeanMES.FileMonitor.Model;

namespace LeanMES.FileMonitor.Dao
{
public class DeviceInterfaceTestPositionDao
{
public IList<DeviceInterfaceTestPosition> GetAll(DeviceInterfaceTestPosition entity)
{
	string sql = "SELECT DeviceTestPosId,DeviceInterfaceId,AnalysisType,PonitType,TestResult FROM Prod_DeviceInterfaceTestPosition WHERE DeviceInterfaceId = @DeviceInterfaceId";
	using (IDbConnection dbConnection = ConnectionFactory.CreateSqlConnection())
	{
		List<DeviceInterfaceTestPosition> result = dbConnection.Query<DeviceInterfaceTestPosition>(sql, new { entity.DeviceInterfaceId }).ToList();
		dbConnection.Close();
		return result;
	}
}
}
}
