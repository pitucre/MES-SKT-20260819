using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlTypes;
using System.IO;
using System.Linq;
using System.Xml;
using Dapper;
using LeanMES.FileMonitor.Model;
using LeanMES.FileMonitor.Utility;

namespace LeanMES.FileMonitor.Dao;

public class StationDao
{
	public static string ConnString => ConfigurationManager.AppSettings["MESConnString"];

	public IList<StationInfo> GetOperationTypeByUser(string userName)
	{
		using IDbConnection dbConnection = ConnectionFactory.CreateSqlConnection();
		List<StationInfo> result = dbConnection.Query<StationInfo>("dbo.uspGetStationsByUserRole", new
		{
			UserName = userName,
			ID = -1,
			IsGetOperationType = false
		}, null, buffered: true, null, CommandType.StoredProcedure).ToList();
		dbConnection.Close();
		return result;
	}

	public int GetDefResources(int stationId)
	{
		string sql = " SELECT TOP 1 ISNULL(StationDefaultResId,-1) AS StationDefaultResId FROM BASAL_STATION WHERE StationId = " + stationId;
		using IDbConnection dbConnection = ConnectionFactory.CreateSqlConnection();
		ResourceInfo resourceInfo = dbConnection.QueryFirstOrDefault<ResourceInfo>(sql);
		dbConnection.Close();
		return resourceInfo.StationDefaultResId;
	}

	public List<ResourceInfo> GetResourcesByOprId(int oprId, string username)
	{
		using IDbConnection dbConnection = ConnectionFactory.CreateSqlConnection();
		List<ResourceInfo> result = dbConnection.Query<ResourceInfo>("dbo.uspGetResourcesByOprId", new
		{
			UserName = username,
			OpeId = oprId
		}, null, buffered: true, null, CommandType.StoredProcedure).ToList();
		dbConnection.Close();
		return result;
	}

	internal DataTable GetTestConfig(string MachineType, string ConnectionString)
	{
		return new DataTable();
	}

	internal string SaveTestPanelComplate(string SerialNumber, int ResourceId, int StationId, string UserName, string NCCodeXML)
	{
		try
		{
			DynamicParameters dynamicParameters = new DynamicParameters();
			dynamicParameters.Add("@SerialNumber", SerialNumber.Trim());
			dynamicParameters.Add("@ResourceId", ResourceId);
			dynamicParameters.Add("@StationId", StationId);
			dynamicParameters.Add("@UserName", UserName.Trim());
			dynamicParameters.Add("@NCCodeXML", NCCodeXML);
			using IDbConnection cnn = ConnectionFactory.CreateSqlConnection();
			cnn.Execute("uspSaveTestPanelComplate", dynamicParameters, null, null, CommandType.StoredProcedure);
			return "";
		}
		catch (Exception ex)
		{
			Logger.Write("exec uspSaveTestData Error:" + ex.Message);
			return "exec uspSaveTestData Error:" + ex.Message;
		}
	}

	internal string SaveTestUnitComplate(string SerialNumber, int ResourceId, int StationId, int LineId, string UserName, int IsPass, int NCCodeId)
	{
		try
		{
			DynamicParameters dynamicParameters = new DynamicParameters();
			dynamicParameters.Add("@SerialNumber", SerialNumber.Trim());
			dynamicParameters.Add("@ResourceId", ResourceId);
			dynamicParameters.Add("@StationId", StationId);
			dynamicParameters.Add("@LineId", LineId);
			dynamicParameters.Add("@UserName", UserName.Trim());
			dynamicParameters.Add("@IsPass", IsPass);
			dynamicParameters.Add("@NCCodeId", NCCodeId);
			using IDbConnection cnn = ConnectionFactory.CreateSqlConnection();
			cnn.Execute("uspSaveTestUnitComplate", dynamicParameters, null, null, CommandType.StoredProcedure);
			return "";
		}
		catch (Exception ex)
		{
			Logger.Write("exec uspSaveTestData Error:" + ex.Message);
			return "exec uspSaveTestData Error:" + ex.Message;
		}
	}

	internal string SaveEquipmentCollection(string paramterStr, string paramterVal, int type, out string equiCode)
	{
		try
		{
			DynamicParameters dynamicParameters = new DynamicParameters();
			dynamicParameters.Add("@ParamterStr", paramterStr);
			dynamicParameters.Add("@ParamterVal", paramterVal);
			dynamicParameters.Add("@EquipmentType", type);
			dynamicParameters.Add("@EquiCode", "", DbType.String, ParameterDirection.InputOutput);
			using IDbConnection cnn = ConnectionFactory.CreateSqlConnection();
			cnn.Execute("uspEquimentCollection", dynamicParameters, null, null, CommandType.StoredProcedure);
			equiCode = dynamicParameters.Get<string>("@EquiCode");
			return "";
		}
		catch (Exception ex)
		{
			equiCode = "";
			Logger.Write("exec SaveEquipmentCollection Error:" + ex.Message);
			return "exec SaveEquipmentCollection Error:" + ex.Message;
		}
	}

	internal string HMGEquipmentCollection(string paramterStr)
	{
		string empty = string.Empty;
		try
		{
			DynamicParameters dynamicParameters = new DynamicParameters();
			dynamicParameters.Add("@ParamterjSONVal", paramterStr);
			dynamicParameters.Add("@EquiCode", "", DbType.String, ParameterDirection.InputOutput);
			using IDbConnection cnn = ConnectionFactory.CreateSqlConnection();
			cnn.Execute("uspEquimentCollectionHMG", dynamicParameters, null, null, CommandType.StoredProcedure);
			return dynamicParameters.Get<string>("@EquiCode");
		}
		catch (Exception ex)
		{
			Logger.Write("exec HMGEquipmentCollection Error:" + ex.Message);
			return "exec HMGEquipmentCollection Error:" + ex.Message;
		}
	}

	internal string HMGEquipmentCollectionTest(string paramterStr)
	{
		string empty = string.Empty;
		try
		{
			DynamicParameters dynamicParameters = new DynamicParameters();
			dynamicParameters.Add("@ParamterjSONVal", paramterStr);
			dynamicParameters.Add("@EquiCode", "", DbType.String, ParameterDirection.InputOutput);
			using IDbConnection cnn = ConnectionFactory.CreateSqlConnection();
			cnn.Execute("uspEquimentCollectionHMGTest", dynamicParameters, null, null, CommandType.StoredProcedure);
			return dynamicParameters.Get<string>("@EquiCode");
		}
		catch (Exception ex)
		{
			Logger.Write("exec HMGEquipmentCollection Error:" + ex.Message);
			return "exec HMGEquipmentCollection Error:" + ex.Message;
		}
	}

	internal bool SaveTestData(string Barcode, string StationName, string RscName, bool IsMultiPlate, bool TestResult, string DefectCode, string ExtParameter, string UserName, string ConnectionString, ref string OutMsg)
	{
		try
		{
			SqlXml value = new SqlXml();
			ExtParameter = (string.IsNullOrWhiteSpace(ExtParameter) ? "<xml></xml>" : ExtParameter);
			using (TextReader input = new StringReader(ExtParameter))
			{
				using XmlTextReader value2 = new XmlTextReader(input);
				value = new SqlXml(value2);
			}
			DynamicParameters dynamicParameters = new DynamicParameters();
			dynamicParameters.Add("@Barcode", Barcode);
			dynamicParameters.Add("@StationName", StationName);
			dynamicParameters.Add("@RscName", RscName);
			dynamicParameters.Add("@IsMultiPlate", IsMultiPlate);
			dynamicParameters.Add("@IsPass", TestResult);
			dynamicParameters.Add("@DefectCode", DefectCode);
			dynamicParameters.Add("@TestDataXml", value, DbType.Xml);
			dynamicParameters.Add("@UserName", UserName);
			dynamicParameters.Add("@Result", 0, DbType.Int32, ParameterDirection.InputOutput);
			dynamicParameters.Add("@ErrorMsg", "", DbType.String, ParameterDirection.InputOutput);
			using IDbConnection cnn = ConnectionFactory.CreateSqlConnection();
			cnn.Execute("uspSaveSMTTestData", dynamicParameters, null, null, CommandType.StoredProcedure);
			OutMsg = dynamicParameters.Get<string>("@ErrorMsg");
			return (dynamicParameters.Get<int>("@Result") != 0) ? true : false;
		}
		catch (Exception ex)
		{
			OutMsg = ex.Message;
			Logger.Write("exec uspSaveTestData Error:" + ex.Message);
			return false;
		}
	}

	internal bool SaveOMLTestData(string Barcode, string StationName, string RscName, bool IsMultiPlate, bool TestResult, string DefectCode, string ExtParameter, string UserName, string ConnectionString, ref string OutMsg)
	{
		try
		{
			SqlXml value = new SqlXml();
			ExtParameter = (string.IsNullOrWhiteSpace(ExtParameter) ? "<xml></xml>" : ExtParameter);
			using (TextReader input = new StringReader(ExtParameter))
			{
				using XmlTextReader value2 = new XmlTextReader(input);
				value = new SqlXml(value2);
			}
			DynamicParameters dynamicParameters = new DynamicParameters();
			dynamicParameters.Add("@Barcode", Barcode);
			dynamicParameters.Add("@StationName", StationName);
			dynamicParameters.Add("@RscName", RscName);
			dynamicParameters.Add("@IsMultiPlate", IsMultiPlate);
			dynamicParameters.Add("@IsPass", TestResult);
			dynamicParameters.Add("@DefectCode", DefectCode);
			dynamicParameters.Add("@TestDataXml", value, DbType.Xml);
			dynamicParameters.Add("@UserName", UserName);
			dynamicParameters.Add("@Result", 0, DbType.Int32, ParameterDirection.InputOutput);
			dynamicParameters.Add("@ErrorMsg", "", DbType.String, ParameterDirection.InputOutput);
			using IDbConnection cnn = ConnectionFactory.CreateSqlConnection();
			cnn.Execute("uspSaveOMLTestData", dynamicParameters, null, null, CommandType.StoredProcedure);
			OutMsg = dynamicParameters.Get<string>("@ErrorMsg");
			return (dynamicParameters.Get<int>("@Result") != 0) ? true : false;
		}
		catch (Exception ex)
		{
			OutMsg = ex.Message;
			Logger.Write("exec SaveOMLTestData Error:" + ex.Message);
			return false;
		}
	}

	internal bool SavePanelTestData(string Barcode, string StationName, string RscName, bool IsMultiPlate, bool TestResult, string DefectCode, string ExtParameter, string UserName, string ConnectionString, ref string OutMsg)
	{
		try
		{
			SqlXml value = null;
			ExtParameter = (string.IsNullOrWhiteSpace(ExtParameter) ? "<xml></xml>" : ExtParameter);
			using (TextReader input = new StringReader(ExtParameter))
			{
				using XmlTextReader value2 = new XmlTextReader(input);
				value = new SqlXml(value2);
			}
			DynamicParameters dynamicParameters = new DynamicParameters();
			dynamicParameters.Add("@Barcode", Barcode);
			dynamicParameters.Add("@StationName", StationName);
			dynamicParameters.Add("@RscName", RscName);
			dynamicParameters.Add("@IsMultiPlate", IsMultiPlate);
			dynamicParameters.Add("@IsPass", TestResult);
			dynamicParameters.Add("@DefectCode", DefectCode);
			dynamicParameters.Add("@TestDataXml", value, DbType.Xml);
			dynamicParameters.Add("@UserName", UserName);
			dynamicParameters.Add("@Result", 0, DbType.Int32, ParameterDirection.InputOutput);
			dynamicParameters.Add("@ErrorMsg", "", DbType.String, ParameterDirection.InputOutput);
			using IDbConnection cnn = ConnectionFactory.CreateSqlConnection();
			cnn.Execute("uspSaveSMTPanelTestData", dynamicParameters, null, null, CommandType.StoredProcedure);
			OutMsg = dynamicParameters.Get<string>("@ErrorMsg");
			return (dynamicParameters.Get<int>("@Result") != 0) ? true : false;
		}
		catch (Exception ex)
		{
			OutMsg = ex.Message;
			Logger.Write("exec uspSaveSMTTestData Error:" + ex.Message);
			return false;
		}
	}

	internal List<SerialNumberInfo> GetPanelSNInfo(string SerialNumber, string ConnectionString)
	{
		List<SerialNumberInfo> result = new List<SerialNumberInfo>();
		DynamicParameters dynamicParameters = new DynamicParameters();
		dynamicParameters.Add("@SerialNumber", SerialNumber);
		try
		{
			using IDbConnection cnn = ConnectionFactory.CreateSqlConnection();
			result = cnn.Query<SerialNumberInfo>("uspGetATEPanelInfoBySN", dynamicParameters, null, buffered: false, null, CommandType.StoredProcedure).ToList();
		}
		catch (Exception)
		{
		}
		return result;
	}

	internal bool WriteErrorHistory(string TestCode, string SerialNumber, string StationName, string RscName, string FilePath, string IPAddress, string MachineName, string ExtParameter, string ErrorMsg, string UserName, string ConnectionString)
	{
		try
		{
			SqlXml value = null;
			ExtParameter = (string.IsNullOrWhiteSpace(ExtParameter) ? "<xml></xml>" : ExtParameter);
			using (TextReader input = new StringReader(ExtParameter))
			{
				using XmlTextReader value2 = new XmlTextReader(input);
				value = new SqlXml(value2);
			}
			DynamicParameters dynamicParameters = new DynamicParameters();
			dynamicParameters.Add("@TestCode", TestCode);
			dynamicParameters.Add("@SerialNumber", SerialNumber);
			dynamicParameters.Add("@StationName", StationName);
			dynamicParameters.Add("@RscName", RscName);
			dynamicParameters.Add("@FilePath", FilePath);
			dynamicParameters.Add("@IPAddress", IPAddress);
			dynamicParameters.Add("@MachineName", MachineName);
			dynamicParameters.Add("@TestDataXml", value, DbType.Xml);
			dynamicParameters.Add("@UserName", UserName);
			dynamicParameters.Add("@ErrorMsg", ErrorMsg);
			using IDbConnection cnn = ConnectionFactory.CreateSqlConnection();
			cnn.Execute("uspSaveTestErrorRecord", dynamicParameters, null, null, CommandType.StoredProcedure);
		}
		catch (Exception ex)
		{
			Logger.Write("Write Error Record fail:" + ex.Message);
			return false;
		}
		Logger.Write("Write Error Record successful");
		return true;
	}

	internal bool WritePassHistory(string TestCode, string SerialNumber, string StationName, string RscName, string FilePath, string IPAddress, string MachineName, string ExtParameter, string UserName, string ConnectionString)
	{
		try
		{
			SqlXml value = null;
			ExtParameter = (string.IsNullOrWhiteSpace(ExtParameter) ? "<xml></xml>" : ExtParameter);
			using (TextReader input = new StringReader(ExtParameter))
			{
				using XmlTextReader value2 = new XmlTextReader(input);
				value = new SqlXml(value2);
			}
			DynamicParameters dynamicParameters = new DynamicParameters();
			dynamicParameters.Add("@TestCode", TestCode);
			dynamicParameters.Add("@SerialNumber", SerialNumber);
			dynamicParameters.Add("@StationName", StationName);
			dynamicParameters.Add("@RscName", RscName);
			dynamicParameters.Add("@FilePath", FilePath);
			dynamicParameters.Add("@IPAddress", IPAddress);
			dynamicParameters.Add("@MachineName", MachineName);
			dynamicParameters.Add("@TestDataXml", value, DbType.Xml);
			dynamicParameters.Add("@UserName", UserName);
			using IDbConnection cnn = ConnectionFactory.CreateSqlConnection();
			cnn.Execute("uspSaveTestPassRecord", dynamicParameters, null, null, CommandType.StoredProcedure);
		}
		catch (Exception ex)
		{
			Logger.Write("write Pass record fail:" + ex.Message);
			return false;
		}
		Logger.Write("write Pass record successful");
		return true;
	}

	public string ValidateUser(string userName)
	{
		string empty = string.Empty;
		bool flag = false;
		try
		{
			DynamicParameters dynamicParameters = new DynamicParameters();
			dynamicParameters.Add("@UserId", -1);
			dynamicParameters.Add("@UserName", userName);
			dynamicParameters.Add("@Msg", empty, DbType.String, ParameterDirection.InputOutput);
			dynamicParameters.Add("@Result", flag, DbType.Boolean, ParameterDirection.InputOutput);
			using (IDbConnection cnn = ConnectionFactory.CreateSqlConnection())
			{
				cnn.Execute("uspCheckUser", dynamicParameters, null, null, CommandType.StoredProcedure);
				if (!dynamicParameters.Get<bool>("@Result"))
				{
					return dynamicParameters.Get<string>("@Msg");
				}
			}
			return string.Empty;
		}
		catch (Exception ex)
		{
			Logger.Write("验证用户异常:" + ex.Message);
			return ex.Message;
		}
	}

	public IList<EquipmentInfo> GetDeMaGeEquipmentList()
	{
		using IDbConnection dbConnection = ConnectionFactory.CreateSqlConnection();
		List<EquipmentInfo> result = dbConnection.Query<EquipmentInfo>("dbo.uspGetDeMaGeEquipmentList", null, null, buffered: true, null, CommandType.StoredProcedure).ToList();
		dbConnection.Close();
		return result;
	}
}
