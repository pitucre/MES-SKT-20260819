using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace LeanMES.FileMonitor.Dao
{
internal class ConnectionFactory
{
public static IDbConnection CreateConnection<T>() where T : IDbConnection, new()
{
	IDbConnection dbConnection = new T();
	dbConnection.ConnectionString = ConfigurationManager.AppSettings["MESConnString"];
	dbConnection.Open();
	return dbConnection;
}

public static IDbConnection CreateSqlConnection()
{
	return CreateConnection<SqlConnection>();
}
}
}
