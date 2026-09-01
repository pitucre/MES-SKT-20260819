using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.Model;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;

namespace SKT.LeanMES.CommonHelper.BLL
{
	public class ComMethod
	{
		private static string strComConnect = SQLHelper.MESConnString;
        //by liwen 20201019 SQLHelper.MESConnString全部修正为SQLHelper.MESConnString 以解决静态变量字符串不变的BUG

        private static System.Collections.Hashtable parmCache = System.Collections.Hashtable.Synchronized(new System.Collections.Hashtable());

		public static string GetPrintJson(string strSPC, SqlParameter[] parms, string strConn = null)
		{
			System.Collections.Generic.List<PrintJson> list = new System.Collections.Generic.List<PrintJson>();
			PrintJson printJson = new PrintJson();
			System.Collections.Generic.List<OneLebal> list2 = new System.Collections.Generic.List<OneLebal>();
			OneLebal oneLebal = new OneLebal();
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, parms))
			{
				while (sqlDataReader.Read())
				{
					printJson = new PrintJson();
					list2 = new System.Collections.Generic.List<OneLebal>();
					for (int i = 0; i < sqlDataReader.FieldCount; i++)
					{
						list2.Add(new OneLebal
						{
							name = sqlDataReader.GetName(i),
							value = System.Convert.IsDBNull(sqlDataReader.GetValue(i)) ? "" : sqlDataReader.GetValue(i).ToString()
						});
					}
					printJson.LabelContent = list2;
					list.Add(printJson);
				}
				sqlDataReader.Close();
			}
			return JsonConvert.SerializeObject(list);
		}

		public static string GetPrintJsonMuti<T>(string strSPC, string strJsonParaValue, int intPageSize = 1, string strConn = null) where T : class
		{
			SqlParameter[] array = ComMethod.GetSpcParams(strSPC, strConn);
			array = ComMethod.setParaValue(strJsonParaValue, array);
			return ComMethod.GetPrintJsonMuti(strSPC, array, intPageSize, strConn);
		}

		public static string GetPrintJsonMuti(string strSPC, SqlParameter[] parms, int intPageSize = 1, string strConn = null)
		{
			System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
			int num = intPageSize;
			int num2 = 0;
			int num3 = 0;
			System.Collections.Generic.List<string> list = new System.Collections.Generic.List<string>();
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, parms))
			{
				stringBuilder.Append("[");
				while (sqlDataReader.Read())
				{
					list.Clear();
					num = ((num == 0) ? intPageSize : num);
					if (num == intPageSize)
					{
						stringBuilder.Append("{\"LabelContent\":[");
					}
					for (int i = 0; i < sqlDataReader.FieldCount; i++)
					{
						list.Add(sqlDataReader.GetName(i));
						string str = sqlDataReader[i].ToString();
						stringBuilder.Append("{\"name\":" + sqlDataReader.GetName(i) + ((num2 == 0) ? "" : num2.ToString()) + ",");
						stringBuilder.Append("\"value\":");
						str = ComMethod.StringFormat(sqlDataReader[i].ToString(), sqlDataReader.GetFieldType(i));
						stringBuilder.Append(str + " },");
					}
					num--;
					if (num == 0)
					{
						stringBuilder.Remove(stringBuilder.Length - 1, 1);
						stringBuilder.Append("]},");
					}
					num3++;
					num2++;
					num2 = ((num2 == intPageSize) ? 0 : num2);
				}
				if (num3 % intPageSize == 0)
				{
					stringBuilder.Remove(stringBuilder.Length - 1, 1);
					stringBuilder.Append("]");
				}
				else
				{
					for (int j = num3 % intPageSize; j < intPageSize; j++)
					{
						for (int i = 0; i < list.Count; i++)
						{
							stringBuilder.Append("{\"name\":" + list[i] + j.ToString() + ",");
							stringBuilder.Append("\"value\":\"\"},");
						}
					}
					stringBuilder.Remove(stringBuilder.Length - 1, 1);
					stringBuilder.Append("]}]");
				}
				if (!sqlDataReader.IsClosed)
				{
					sqlDataReader.Close();
				}
			}
			return (stringBuilder.Length == 1) ? "[]" : stringBuilder.ToString();
		}

        public static DataSet ExcuteSpcByTempBackDs(string strSpc, string strJson, DataSet ds, string strConn = null)
        {
            SqlConnection sqlConnection = new SqlConnection(strConn ?? ComMethod.strComConnect);
            sqlConnection.Open();
            SqlTransaction sqlTransaction = sqlConnection.BeginTransaction(IsolationLevel.ReadCommitted);
            DataSet result;
            try
            {
                DataSet dataSet = ComMethod.ReaderToDataSet(ComMethod.ExecSpc(strSpc, strJson, ds, strConn, sqlConnection, sqlTransaction), "table");
                sqlTransaction.Commit();
                result = dataSet;
            }
            catch (System.Exception ex)
            {
                sqlTransaction.Rollback();
                throw ex;
            }
            finally
            {
                sqlTransaction.Dispose();
                sqlConnection.Close();
                sqlConnection.Dispose();
            }
            return result;
        }

        public static string ExcuteSpcByTemp(string strSpc, string strJson, DataSet ds, string strConn = null)
		{
			SqlConnection sqlConnection = new SqlConnection(strConn ?? ComMethod.strComConnect);
			sqlConnection.Open();
			SqlTransaction sqlTransaction = sqlConnection.BeginTransaction(IsolationLevel.ReadCommitted);
			string result;
			try
			{
				string text = ComMethod.ReaderToJson(ComMethod.ExecSpc(strSpc, strJson, ds, strConn, sqlConnection, sqlTransaction));
				sqlTransaction.Commit();
				result = text;
			}
			catch (System.Exception ex)
			{
				sqlTransaction.Rollback();
				throw ex;
			}
			finally
			{
				sqlTransaction.Dispose();
				sqlConnection.Close();
				sqlConnection.Dispose();
			}
			return result;
		}
		
        private static IDataReader ExecSpc(string strSpc, string strJson, DataSet ds, string strConn, SqlConnection conn, SqlTransaction trans)
        {
            int num = 0;
            SqlParameter[] spcParams = ComMethod.GetSpcParams(strSpc, strConn);
            DataTable dataTable = ComMethod.EntityToDataTable(strJson);
            if (dataTable == null)
            {
                throw new System.Exception("存储过程Json参数字段未设定或为空");
            }
            if (dataTable.Rows.Count > 0)
            {
                for (int i = 0; i < spcParams.Length; i++)
                {
                    object obj = dataTable.Rows[0][spcParams[i].ParameterName.Replace("@", "")];
                    obj = ((obj == null || obj.ToString() == string.Empty) ? System.DBNull.Value : obj);
                    spcParams[i].Value = ((spcParams[i].SqlDbType == SqlDbType.Structured) ? ComMethod.GetParaTable(obj.ToString()) : obj);
                    if (spcParams[i].SqlDbType == SqlDbType.Structured)
                    {
                        spcParams[i].SourceColumnNullMapping = true;
                    }
                }
            }
            if (dataTable.Columns.Contains("TempColumns"))
            {
                string[] array = dataTable.Rows[0]["TempColumns"].ToString().Split(new char[]
                {
                    ','
                });
                string[] array2 = array;
                for (int j = 0; j < array2.Length; j++)
                {
                    string text = array2[j];
                    if (!dataTable.Columns.Contains(text))
                    {
                        throw new System.Exception("未设定存入临时表的列表属性字段");
                    }
                    DataTable dataTable2 = ComMethod.ToDataTable(dataTable.Rows[0][text].ToString());
                    if (dataTable2 != null)
                    {
                        ComMethod.DataIntoTempTb(trans, conn, dataTable2, "TempTable" + ((num == 0) ? "" : num.ToString()));
                        num++;
                    }
                }
            }
            if (ds != null)
            {
                for (int i = 0; i < ds.Tables.Count; i++)
                {
                    ComMethod.DataIntoTempTb(trans, conn, ds.Tables[i], "TempTable" + ((num == 0) ? "" : num.ToString()));
                    num++;
                }
            }
            SqlCommand sqlCommand = new SqlCommand();
            ComMethod.initCommand(trans.Connection, trans, sqlCommand, CommandType.StoredProcedure, strSpc, spcParams);
            return sqlCommand.ExecuteReader();
        }

        private static void DataIntoTempTb(SqlTransaction trans, SqlConnection conn, DataTable dt, string strTempName)
		{
			System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
			System.Text.StringBuilder stringBuilder2 = new System.Text.StringBuilder();
			System.Text.StringBuilder stringBuilder3 = new System.Text.StringBuilder();
			System.Collections.Generic.List<SqlParameter> list = new System.Collections.Generic.List<SqlParameter>();
			for (int i = 0; i < dt.Columns.Count; i++)
			{
				stringBuilder.Append("[" + dt.Columns[i].ColumnName + "]  " + ComMethod.RepalceTbType(dt.Columns[i].DataType.Name) + " NULL, ");
				stringBuilder2.Append("[" + dt.Columns[i].ColumnName + "],");
				stringBuilder3.Append("@" + dt.Columns[i].ColumnName + ",");
				list.Add(ComMethod.RepalceTbParams(dt.Columns[i].DataType.Name, dt.Columns[i].ColumnName));
			}
			if (stringBuilder.ToString() == "")
			{
				throw new System.Exception("表数据没有栏位, 数据存入临时表失败");
			}
			string cmdText = string.Concat(new string[]
			{
				"CREATE TABLE #",
				strTempName,
				" ( ",
				stringBuilder.ToString(),
				")"
			});
			ComMethod.ExecuteNonQuery(trans, CommandType.Text, cmdText, null);
			cmdText = string.Concat(new string[]
			{
				"INSERT INTO #",
				strTempName,
				" ( ",
				stringBuilder2.ToString().TrimEnd(new char[]
				{
					','
				}),
				" ) VALUES ( ",
				stringBuilder3.ToString().TrimEnd(new char[]
				{
					','
				}),
				" )"
			});
			foreach (DataRow dataRow in dt.Rows)
			{
				foreach (SqlParameter current in list)
				{
					current.Value = dataRow[current.ParameterName.TrimStart(new char[]
					{
						'@'
					})];
				}
				ComMethod.ExecuteNonQuery(trans, CommandType.Text, cmdText, list.ToArray());
			}
		}

		public static T Get<T>(string strSPC, SqlParameter[] parms, string strConn = null) where T : class
		{
			T result = (T)((object)System.Activator.CreateInstance(typeof(T)));
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, parms))
			{
				result = ComMethod.ToEntity<T>(sqlDataReader);
			}
			return result;
		}

		public static T Get<T>(string strSPC, string strJsonParaValue, string strConn = null) where T : class
		{
			SqlParameter[] array = ComMethod.GetSpcParams(strSPC, strConn);
			array = ComMethod.setParaValue(strJsonParaValue, array);
			T result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, array))
			{
				result = ComMethod.ToEntity<T>(sqlDataReader);
			}
			return result;
		}

		public static string Get(string strSPC, SqlParameter[] parms, string strConn = null)
		{
			string ownJson;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, parms))
			{
				ownJson = ComMethod.GetOwnJson(sqlDataReader);
			}
			return ownJson;
		}

		public static DataSet Get(string strSPC, string strJsonParaValue, string strConn = null)
		{
			return ComMethod.ReaderToDataSet(ComMethod.getSpcReader(strSPC, strJsonParaValue, strConn), "table");
		}

		public static string GetJson(string strSPC, string strJsonParaValue, string strConn = null)
		{
			return ComMethod.GetOwnJson(ComMethod.getSpcReader(strSPC, strJsonParaValue, strConn));
		}

		public static T GetBySql<T>(string strSql, SqlParameter[] parms, string strConn = null) where T : class
		{
			T result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderSqlText(strConn ?? SQLHelper.MESConnString, strSql, parms))
			{
				result = ComMethod.ToEntity<T>(sqlDataReader);
			}
			return result;
		}

		public static string GetBySql(string strSql, SqlParameter[] parms, string strConn = null)
		{
			string ownJson;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderSqlText(strConn ?? SQLHelper.MESConnString, strSql, parms))
			{
				ownJson = ComMethod.GetOwnJson(sqlDataReader);
			}
			return ownJson;
		}

		public static T GetInfo<T>(long intId, string strSPC, string strConn = null) where T : class
		{
			SqlParameter[] spcParams = ComMethod.GetSpcParams(strSPC, strConn);
			spcParams[0].Value = intId;
			spcParams[1].Value = true;
			T result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, spcParams))
			{
				result = ComMethod.ToEntity<T>(sqlDataReader);
			}
			return result;
		}

		public static T GetInfo<T>(string strName, string strSPC, string strConn = null) where T : class
		{
			SqlParameter[] spcParams = ComMethod.GetSpcParams(strSPC, strConn);
			spcParams[0].Value = strName;
			spcParams[1].Value = false;
			T result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, spcParams))
			{
				result = ComMethod.ToEntity<T>(sqlDataReader);
			}
			return result;
		}

		public static System.Collections.Generic.List<T> GetList<T>(SqlParameter[] parms, ref int rowCount, string strConn = null) where T : class
		{
			System.Collections.Generic.List<T> result = new System.Collections.Generic.List<T>();
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, "Common_GetPageRecords", parms))
			{
				result = ComMethod.ToListEntity<T>(sqlDataReader);
			}
			rowCount = System.Convert.ToInt32(parms[parms.Length - 1].Value);
			return result;
		}

		public static System.Collections.Generic.List<T> GetList<T>(string strSPC, string strJsonParaValue, string strConn = null) where T : class
		{
			SqlParameter[] array = ComMethod.GetSpcParams(strSPC, strConn);
			array = ComMethod.setParaValue(strJsonParaValue, array);
			System.Collections.Generic.List<T> result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, array))
			{
				result = ComMethod.ToListEntity<T>(sqlDataReader);
			}
			return result;
		}

		public static System.Collections.Generic.List<T> GetList<T>(string strSPC, SqlParameter[] parms, string strConn = null) where T : class
		{
			System.Collections.Generic.List<T> result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, parms))
			{
				result = ComMethod.ToListEntity<T>(sqlDataReader);
			}
			return result;
		}

		public static string GetList(string strSPC, SqlParameter[] parms, string strConn = null)
		{
			string result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, parms))
			{
				result = ComMethod.ReaderToJson(sqlDataReader);
			}
			return result;
		}

		public static System.Collections.Generic.List<T> GetListBySql<T>(string strSql, SqlParameter[] parms, string strConn = null) where T : class
		{
			System.Collections.Generic.List<T> result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderSqlText(strConn ?? SQLHelper.MESConnString, strSql, parms))
			{
				result = ComMethod.ToListEntity<T>(sqlDataReader);
			}
			return result;
		}

		public static string GetListJson<T>(string strSPC, string strJsonParaValue, string strConn = null) where T : class
		{
			SqlParameter[] array = ComMethod.GetSpcParams(strSPC, strConn);
			array = ComMethod.setParaValue(strJsonParaValue, array);
			string result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, array))
			{
				result = ComMethod.ReaderToJson(sqlDataReader);
			}
			return result;
		}

		public static string GetListJson(string strSPC, string strJsonParaValue, string strConn = null)
		{
			SqlParameter[] array = ComMethod.GetSpcParams(strSPC, strConn);
			array = ComMethod.setParaValue(strJsonParaValue, array);
			string result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, array))
			{
				result = ComMethod.ReaderToJson(sqlDataReader);
			}
			return result;
		}

		public static string GetListBySql(string strSql, SqlParameter[] parms, string strConn = null)
		{
			string result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderSqlText(strConn ?? SQLHelper.MESConnString, strSql, parms))
			{
				result = ComMethod.ReaderToJson(sqlDataReader);
			}
			return result;
		}

		public static DataSet GetListDataSet(string strSPC, SqlParameter[] parms, string strTbName = "table", string strConn = null)
		{
			DataSet result;
			using (SqlDataReader spcReader = ComMethod.getSpcReader(strSPC, parms, null))
			{
				result = ComMethod.ReaderToDataSet(spcReader, strTbName);
			}
			return result;
		}

		public static DataSet GetListDataSet(string strSPC, string strJsonParaValue, string strTbName = "table", string strConn = null)
		{
			SqlParameter[] array = ComMethod.GetSpcParams(strSPC, strConn);
			array = ComMethod.setParaValue(strJsonParaValue, array);
			DataSet result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, array))
			{
				result = ComMethod.ReaderToDataSet(sqlDataReader, strTbName);
			}
			return result;
		}

		public static DataSet GetListDataSetBySql(string strSql, SqlParameter[] parms, string strTbName = "table", string strConn = null)
		{
			DataSet result;
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderSqlText(strConn ?? SQLHelper.MESConnString, strSql, parms))
			{
				result = ComMethod.ReaderToDataSet(sqlDataReader, strTbName);
			}
			return result;
		}

		public static System.Collections.Generic.List<T> GetListByTbName<T>(string TbName, string strClName, SqlParameter[] parms, string strConn = null) where T : class
		{
			string basalSqlContition = ComMethod.getBasalSqlContition(TbName, strClName, parms);
			System.Collections.Generic.List<T> result = new System.Collections.Generic.List<T>();
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderSqlText(strConn ?? SQLHelper.MESConnString, basalSqlContition, parms))
			{
				result = ComMethod.ToListEntity<T>(sqlDataReader);
			}
			return result;
		}

		public static System.Collections.Generic.List<T> GetPageList<T>(string strSpc, string strJsonParaValue, int startRow, int maxRows, ref int rowCount, string strConn = null) where T : class
		{
			SqlParameter[] array = ComMethod.GetSpcParams(strSpc, strConn);
			array = ComMethod.setParaValue(strJsonParaValue, array);
			System.Collections.Generic.List<T> result = new System.Collections.Generic.List<T>();
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSpc, array))
			{
				result = ComMethod.ToListEntity<T>(sqlDataReader, startRow, maxRows, ref rowCount);
			}
			return result;
		}

		public static System.Collections.Generic.List<T> GetPageList<T>(string strSpc, SqlParameter[] parms, int startRow, int maxRows, ref int rowCount, string strConn = null) where T : class
		{
			System.Collections.Generic.List<T> result = new System.Collections.Generic.List<T>();
			using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(strConn ?? SQLHelper.MESConnString, strSpc, parms))
			{
				result = ComMethod.ToListEntity<T>(sqlDataReader, startRow, maxRows, ref rowCount);
			}
			return result;
		}

		public static DataTable GetListByTbName(string TbName, string strClName, SqlParameter[] parms, string strConn = null)
		{
			string basalSqlContition = ComMethod.getBasalSqlContition(TbName, strClName, parms);
			return SQLHelper.ExcuteDataTableSqlText(strConn ?? SQLHelper.MESConnString, basalSqlContition, parms);
		}

		public static System.Collections.Generic.List<T> GetComList<T>(ref int rowCount, int startRow, int maxRows, string strTb, string strKey, string strColumns, string sortExpression, SearchSettings searchSettings) where T : class
		{
			SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, strTb, strKey, strColumns, searchSettings, sortExpression);
			return ComMethod.GetList<T>(parms, ref rowCount, null);
		}

		public static DataSet GetComList(ref int rowCount, int startRow, int maxRows, string strTb, string strKey, string sortExpression, SearchSettings searchSettings)
		{
			string tbOrViewColumns = ComMethod.GetTbOrViewColumns(strTb, null);
			SqlParameter[] array = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, strTb, strKey, tbOrViewColumns, searchSettings, sortExpression);
			DataSet listDataSet = ComMethod.GetListDataSet("Common_GetPageRecords", array, "table", null);
			rowCount = System.Convert.ToInt32(array[array.Length - 1].Value);
			return listDataSet;
		}

		public static DataSet GetComList(ref int rowCount, int startRow, int maxRows, string TbView, string sortExpression, SearchSettings searchSettings, string strConn = null)
		{
			SqlConnection sqlConnection = new SqlConnection(strConn ?? SQLHelper.MESConnString);
			sqlConnection.Open();
			SqlTransaction sqlTransaction = sqlConnection.BeginTransaction(IsolationLevel.ReadCommitted);
			DataSet result;
			try
			{
				using (SqlDataReader tbViewReaderPage = ComMethod.getTbViewReaderPage(sqlTransaction, sqlConnection, ref rowCount, startRow, maxRows, TbView, searchSettings, sortExpression, strConn))
				{
					DataSet dataSet = ComMethod.ReaderToDataSet(tbViewReaderPage, "table");
					sqlTransaction.Commit();
					result = dataSet;
				}
			}
			catch (System.Exception ex)
			{
				throw ex;
			}
			finally
			{
				sqlTransaction.Dispose();
				sqlConnection.Close();
				sqlConnection.Dispose();
			}
			return result;
		}

		public static DataSet GetComList(ref int rowCount, int startRow, int maxRows, string TbView, string sortExpression, string strJson, string strConn = null)
		{
			SqlConnection sqlConnection = new SqlConnection(strConn ?? SQLHelper.MESConnString);
			sqlConnection.Open();
			SqlTransaction sqlTransaction = sqlConnection.BeginTransaction(IsolationLevel.ReadCommitted);
			DataSet result;
			try
			{
				using (SqlDataReader tbViewReaderPage = ComMethod.getTbViewReaderPage(sqlTransaction, sqlConnection, ref rowCount, startRow, maxRows, TbView, strJson, sortExpression, strConn))
				{
					DataSet dataSet = ComMethod.ReaderToDataSet(tbViewReaderPage, "table");
					sqlTransaction.Commit();
					result = dataSet;
				}
			}
			catch (System.Exception ex)
			{
				throw ex;
			}
			finally
			{
				sqlTransaction.Dispose();
				sqlConnection.Close();
				sqlConnection.Dispose();
			}
			return result;
		}

		public static string GetComListJson(int startRow, int maxRows, string TbView, string sortExpression, string strJson, string strConn = null)
		{
			SqlConnection sqlConnection = new SqlConnection(strConn ?? SQLHelper.MESConnString);
			sqlConnection.Open();
			SqlTransaction sqlTransaction = sqlConnection.BeginTransaction(IsolationLevel.ReadCommitted);
			string result;
			try
			{
				int num = 0;
				using (SqlDataReader tbViewReaderPage = ComMethod.getTbViewReaderPage(sqlTransaction, sqlConnection, ref num, startRow, maxRows, TbView, strJson, sortExpression, strConn))
				{
					string text = ComMethod.ReaderToJson(tbViewReaderPage);
					sqlTransaction.Commit();
					text = text.TrimEnd(new char[]
					{
						'}'
					}) + ", \"TotalCount\":" + num.ToString() + " }";
					result = text;
				}
			}
			catch (System.Exception ex)
			{
				throw ex;
			}
			finally
			{
				sqlTransaction.Dispose();
				sqlConnection.Close();
				sqlConnection.Dispose();
			}
			return result;
		}

		public static string GetTbViewList(string strTb, SearchSettings searchSettings, string sortExpression = "", string strConn = null)
		{
			string tbOrViewColumns = ComMethod.GetTbOrViewColumns(strTb, null);
			string result;
			using (SqlDataReader tbViewReader = ComMethod.getTbViewReader(strTb, searchSettings, sortExpression, strConn))
			{
				result = ComMethod.ReaderToJson(tbViewReader);
			}
			return result;
		}

		public static string GetTbViewList(string strTb, string strJson, string sortExpression = "", string strConn = null)
		{
			string tbOrViewColumns = ComMethod.GetTbOrViewColumns(strTb, null);
			string result;
			using (SqlDataReader tbViewReader = ComMethod.getTbViewReader(strTb, strJson, sortExpression, strConn))
			{
				result = ComMethod.ReaderToJson(tbViewReader);
			}
			return result;
		}

		public static DataSet GetTbViewListDs(string strTb, string strJson, string sortExpression = "", string strConn = null)
		{
			string tbOrViewColumns = ComMethod.GetTbOrViewColumns(strTb, null);
			DataSet result;
			using (SqlDataReader tbViewReader = ComMethod.getTbViewReader(strTb, strJson, sortExpression, null))
			{
				result = ComMethod.ReaderToDataSet(tbViewReader, "table");
			}
			return result;
		}

		public static DataSet GetTbViewListDs(string strTb, SearchSettings searchSettings, string sortExpression = "", string strConn = null)
		{
			string tbOrViewColumns = ComMethod.GetTbOrViewColumns(strTb, null);
			DataSet result;
			using (SqlDataReader tbViewReader = ComMethod.getTbViewReader(strTb, searchSettings, sortExpression, null))
			{
				result = ComMethod.ReaderToDataSet(tbViewReader, "table");
			}
			return result;
		}

		public static void Edit(string strSPC, SqlParameter[] arrParms, string strConn = null)
		{
			SQLHelper.ExecuteNonQueryStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, arrParms);
		}

		public static void EditBySql(string strSql, SqlParameter[] arrParms, string strConn = null)
		{
			SQLHelper.ExecuteNonQueryText(strConn ?? SQLHelper.MESConnString, strSql, arrParms);
		}

		public static void Edit<T>(string strJson, string strSPC, SqlParameter[] arrParms = null, string strConn = null) where T : class
		{
			arrParms = (arrParms ?? ComMethod.GetSpcParams(strSPC, strConn));
			arrParms = ComMethod.setParaValue(strJson, arrParms);
			SQLHelper.ExecuteNonQueryStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, arrParms);
		}

		public static void Edit(string strJson, string strSPC, SqlParameter[] arrParms = null, string strConn = null)
		{
			arrParms = (arrParms ?? ComMethod.GetSpcParams(strSPC, strConn));
			arrParms = ComMethod.setParaValue(strJson, arrParms);
			SQLHelper.ExecuteNonQueryStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, arrParms);
		}

		public static string EditBack<T>(string strJson, string strSPC, SqlParameter[] arrParms = null, string strConn = null) where T : class
		{
			arrParms = (arrParms ?? ComMethod.GetSpcParams(strSPC, strConn));
			arrParms = ComMethod.setParaValue(strJson, arrParms);
			return ComMethod.GetList(strSPC, arrParms, strConn);
		}

		public static string EditBack(string strJson, string strSPC, string strConn = null)
		{
			SqlParameter[] array = ComMethod.GetSpcParams(strSPC, strConn);
			array = ComMethod.setParaValue(strJson, array);
			return ComMethod.GetList(strSPC, array, strConn);
		}

		public static SqlParameter[] setParaValue<T>(string strJson, SqlParameter[] arrParms) where T : class
		{
			T t = ComMethod.JsonToEntity<T>(strJson);
			for (int i = 0; i < arrParms.Length; i++)
			{
				if (arrParms[i].Value != null)
				{
					break;
				}
				object obj = t.GetType().GetProperty(arrParms[i].ParameterName.Replace("@", "")).GetValue(t, null);
				obj = ((obj == null || obj.ToString() == string.Empty) ? System.DBNull.Value : obj);
				arrParms[i].Value = ((arrParms[i].SqlDbType == SqlDbType.Structured) ? ComMethod.GetParaTable(obj.ToString()) : obj);
                if (arrParms[i].SqlDbType == SqlDbType.Structured) {
                    arrParms[i].SourceColumnNullMapping = true;
                }
			}
			return arrParms;
		}

		public static SqlParameter[] setParaValue(string strJson, SqlParameter[] arrParms)
		{
			DataTable dataTable = ComMethod.EntityToDataTable(strJson);
			if (dataTable == null)
			{
				throw new System.Exception("存储过程Json参数字段未设定或为空");
			}
			SqlParameter[] result;
			if (dataTable.Rows.Count == 0)
			{
				result = arrParms;
			}
			else
			{
				for (int i = 0; i < arrParms.Length; i++)
				{
					object obj = dataTable.Rows[0][arrParms[i].ParameterName.Replace("@", "")];
					obj = ((obj == null || obj.ToString() == string.Empty) ? System.DBNull.Value : obj);
					arrParms[i].Value = ((arrParms[i].SqlDbType == SqlDbType.Structured) ? ComMethod.GetParaTable(obj.ToString()) : obj);
                    if (arrParms[i].SqlDbType == SqlDbType.Structured)
                    {
                        arrParms[i].SourceColumnNullMapping = true;
                    }
                }
				result = arrParms;
			}
			return result;
		}

		public static void Delete(string idString, string userName, string strSpc, string strConn = null)
		{
			SqlParameter[] spcParams = ComMethod.GetSpcParams(strSpc, null);
			spcParams[0].Value = idString;
			spcParams[1].Value = userName;
			SQLHelper.ExecuteNonQueryStoredProcedure(strConn ?? SQLHelper.MESConnString, strSpc, spcParams);
		}

		public static DataTable GetDataTableList(string strSPC, SqlParameter[] parms, string strConn = null)
		{
			return SQLHelper.ExecuteDataTableStoredProcedure(strConn ?? SQLHelper.MESConnString, strSPC, parms);
		}

		private static string getBasalSqlContition(string TbName, string strClName, SqlParameter[] parms)
		{
			string str = string.Format("SELECT {0} FROM {1}", strClName, TbName);
			string text = "";
			for (int i = 0; i < parms.Length; i++)
			{
				text = parms[i].ParameterName.Replace("@", "") + " = " + parms[i].ParameterName + " AND ";
			}
			return str + ((text == "") ? "" : (" WHERE " + text.Substring(0, text.Length - 4)));
		}

		public static SqlParameter[] GetSpcParams(string strSpc, string strConn = null)
		{
			if (System.DateTime.Now.Minute % 5 == 0)
			{
				ComMethod.parmCache.Clear();
			}
			SqlParameter[] array = ComMethod.GetCachedParameters(strSpc);
			SqlParameter[] result;
			if (array != null)
			{
				result = array;
			}
			else
			{
				System.Collections.Generic.List<SqlParameter> list = new System.Collections.Generic.List<SqlParameter>();
				string text = "select syscolumns.name, systypes.name, syscolumns.length,syscolumns.isoutparam from syscolumns,systypes\r\n                        where (syscolumns.id=object_id('" + strSpc + "') and syscolumns.xusertype=systypes.xusertype)\r\n                        order by syscolumns.colorder;";
				using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderSqlText(strConn ?? SQLHelper.MESConnString, text, new SqlParameter[0]))
				{
					while (sqlDataReader.Read())
					{
						SqlParameter sqlParameter = new SqlParameter(sqlDataReader.GetString(0), ComMethod.RepalceType(sqlDataReader.GetString(1)), (int)sqlDataReader.GetInt16(2));
						if (sqlDataReader.GetInt32(3) == 1)
						{
							sqlParameter.Direction = ParameterDirection.InputOutput;
						}
						list.Add(sqlParameter);
					}
				}
				array = list.ToArray();
				ComMethod.CacheParameters(strSpc, array);
				result = array;
			}
			return result;
		}

		public static string GetTbOrViewColumns(string strTbOrView, string strConn = null)
		{
			if (System.DateTime.Now.Minute % 5 == 0)
			{
				ComMethod.parmCache.Clear();
			}
			string text = ComMethod.GetCachedColumns(strTbOrView);
			string result;
			if (text != null)
			{
				result = text;
			}
			else
			{
				string text2 = "SELECT ISNULL(STUFF((Select ', ' + Name  FROM SysColumns Where id=Object_Id('" + strTbOrView + "') ORDER BY colid FOR XML PATH('')), 1, 1, ''), '') AS columsName";
				using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderSqlText(strConn ?? SQLHelper.MESConnString, text2, new SqlParameter[0]))
				{
					while (sqlDataReader.Read())
					{
						text = sqlDataReader.GetString(0);
					}
				}
				ComMethod.CacheColumns(strTbOrView, text);
				result = text;
			}
			return result;
		}

        public static string GetSpcTbViewColumns(string strName, string strType = "view", string strConn = null)
        {
            string result = "";
            if (strType.ToLower() == "view")
            {
                string strSql = "select b.name colName, ISNULL(e.value,'') as colDesc, c.name DataType ,b.length colLength, 0 as ColType\r\n                            from syscolumns b \r\n\t                            inner join systypes c on b.xtype=c.xusertype\r\n\t                            LEFT JOIN SYS.extended_properties AS e ON b.colid = e.minor_id AND b.id=e.major_id\r\n                            where id=OBJECT_ID('" + strName + "') and colid > 1";
                result = ComMethod.ReaderToJson(ComMethod.getReader(strConn ?? ComMethod.strComConnect, CommandType.Text, strSql, null));
            }
            else
            {
                if (strType.ToLower() == "sp")
                {
                    System.Collections.Generic.List<DataColumns> list = new System.Collections.Generic.List<DataColumns>();
                    SqlParameter[] spcParams = ComMethod.GetSpcParams(strName, strConn);
                    for (int i = 0; i < spcParams.Length; i++)
                    {
                        spcParams[i].Value = System.DBNull.Value;
                        list.Add(new DataColumns
                        {
                            colName = spcParams[i].ParameterName,
                            colDesc = "",
                            ColType = 1,
                            DataType = spcParams[i].DbType.ToString(),
                            colLength = spcParams[i].Size
                        });
                    }
                    SqlDataReader reader = ComMethod.getReader(strConn ?? ComMethod.strComConnect, CommandType.StoredProcedure, strName, spcParams);
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        list.Add(new DataColumns
                        {
                            colName = reader.GetName(i),
                            colDesc = "",
                            ColType = 0,
                            DataType = "varchar",
                            colLength = 0
                        });
                    }
                    result = "{\"data\": " + JsonConvert.SerializeObject(list) + " }";
                }
            }
            return result;
        }
        
        public static T JsonToEntity<T>(string strJson) where T : class
		{
			return JsonConvert.DeserializeObject<T>(strJson);
		}

		public static System.Collections.Generic.List<T> JsonToEntities<T>(string strJson) where T : class
		{
			return JsonConvert.DeserializeObject<System.Collections.Generic.List<T>>(strJson);
		}

		public static DataTable EntityToDataTable(string onejson)
		{
			string json = "[" + onejson + "]";
			return ComMethod.ToDataTable(json);
		}

		public static DataTable ToDataTable(string json)
		{
			System.Collections.ArrayList arrayList = new JavaScriptSerializer
			{
				MaxJsonLength = 2147483647
			}.Deserialize<System.Collections.ArrayList>(json);
			DataTable result;
			if (arrayList.Count == 0)
			{
				result = null;
			}
			else
			{
				DataTable dataTable = new DataTable();
                List<string> listColumnName = new List<string>();
                foreach (System.Collections.Generic.Dictionary<string, object> dictionary in arrayList)
				{
                    //添加列（默认第一个数据行）
                    if (dataTable.Columns.Count == 0)
					{
						foreach (string current in dictionary.Keys)
						{
							dataTable.Columns.Add(current, (dictionary[current] == null) ? typeof(string) : dictionary[current].GetType());
                            listColumnName.Add(current);
                        }
					}
                    //添加行
                    DataRow dataRow = dataTable.NewRow();
					foreach (string current in dictionary.Keys)
					{
                        //只处理已存在的列
                        if (listColumnName.Contains(current))
                        {
                            dataRow[current] = ((dictionary[current] == null) ? System.DBNull.Value : dictionary[current]);
                        }
					}
					dataTable.Rows.Add(dataRow);
				}
				result = dataTable;
			}
			return result;
		}

		public static DataTable JsonToDataTable(string strJson)
		{
            return ToDataTable(strJson);
        }

		public static string GetOwnJson(IDataReader reader)
		{
			string text = ComMethod.getOwnReaderJson(reader).ToString();
			return (text.Length == 0) ? "{}" : text;
		}

		public static string ReaderToJson(IDataReader reader)
		{
			return ComMethod.ReaderToJson(reader, "data");
		}

		public static string ReaderToJson(IDataReader reader, string strJsonName)
		{
			System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
			int num = 0;
			stringBuilder.Append("{");
			do
			{
				string str = strJsonName + ((num > 0) ? num.ToString() : "");
				stringBuilder.Append("\"" + str + "\":");
				stringBuilder.Append(ComMethod.OneReaderToJson(reader) + ",");
				num++;
			}
			while (reader.NextResult());
			if (!reader.IsClosed)
			{
				reader.Close();
			}
			stringBuilder.Remove(stringBuilder.Length - 1, 1);
			stringBuilder.Append("}");
			return (stringBuilder.Length == 1) ? "{}" : stringBuilder.ToString();
		}

		private static string OneReaderToJson(IDataReader dataReader)
		{
			System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
			stringBuilder.Append("[");
			while (dataReader.Read())
			{
				stringBuilder.Append("{");
				for (int i = 0; i < dataReader.FieldCount; i++)
				{
					string text = dataReader[i].ToString();
					stringBuilder.Append("\"" + dataReader.GetName(i) + "\":");
					text = ComMethod.StringFormat(dataReader[i].ToString(), dataReader.GetFieldType(i));
					text = ((i < dataReader.FieldCount - 1) ? (text + ",") : text);
					stringBuilder.Append(text);
				}
				stringBuilder.Append("},");
			}
			stringBuilder.Remove(stringBuilder.Length - 1, 1);
			stringBuilder.Append("]");
			return (stringBuilder.Length == 1) ? "[]" : stringBuilder.ToString();
		}

		private static System.Text.StringBuilder getOwnReaderJson(IDataReader dataReader)
		{
			System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
			while (dataReader.Read())
			{
				stringBuilder.Clear();
				stringBuilder.Append("{");
				for (int i = 0; i < dataReader.FieldCount; i++)
				{
					string text = dataReader[i].ToString();
					stringBuilder.Append("\"" + dataReader.GetName(i) + "\":");
					text = ComMethod.StringFormat(dataReader[i].ToString(), dataReader.GetFieldType(i));
					text = ((i < dataReader.FieldCount - 1) ? (text + ",") : text);
					stringBuilder.Append(text);
				}
				stringBuilder.Append("}");
			}
			return stringBuilder;
		}

		public static string String2Json(string s)
		{
			System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
			int i = 0;
			while (i < s.Length)
			{
				char c = s.ToCharArray()[i];
				char c2 = c;
				if (c2 <= '\r')
				{
					if (c2 != '\0')
					{
						switch (c2)
						{
						case '\b':
							stringBuilder.Append("\\b");
							break;
						case '\t':
							stringBuilder.Append("\\t");
							break;
						case '\n':
							stringBuilder.Append("\\n");
							break;
						case '\v':
							stringBuilder.Append("\\v");
							break;
						case '\f':
							stringBuilder.Append("\\f");
							break;
						case '\r':
							stringBuilder.Append("\\r");
							break;
						default:
							goto IL_F5;
						}
					}
					else
					{
						stringBuilder.Append("\\0");
					}
				}
				else if (c2 != '"')
				{
					if (c2 != '/')
					{
						if (c2 != '\\')
						{
							goto IL_F5;
						}
						stringBuilder.Append("\\\\");
					}
					else
					{
						stringBuilder.Append("\\/");
					}
				}
				else
				{
					stringBuilder.Append("\\\"");
				}
				IL_FF:
				i++;
				continue;
				IL_F5:
				stringBuilder.Append(c);
				goto IL_FF;
			}
			return stringBuilder.ToString();
		}

		private static string StringFormat(string str, System.Type type)
		{
			if (type != typeof(string) && string.IsNullOrEmpty(str))
			{
				str = "\"" + str + "\"";
			}
			else if (type == typeof(string))
			{
				str = ComMethod.String2Json(str);
				str = "\"" + str + "\"";
			}
			else if (type == typeof(System.DateTime))
			{
				str = "\"" + str + "\"";
			}
			else if (type == typeof(bool))
			{
				str = str.ToLower();
			}
			else if (type == typeof(byte[]))
			{
				str = "\"" + str + "\"";
			}
			else if (type == typeof(System.Guid))
			{
				str = "\"" + str + "\"";
			}
			return str;
		}

		public static SqlDataReader getSpcReader(string strSPC, string strJsonParaValue, string strConn = null)
		{
			SqlParameter[] array = ComMethod.GetSpcParams(strSPC, strConn);
			array = ComMethod.setParaValue(strJsonParaValue, array);
			return ComMethod.getReader(strConn ?? SQLHelper.MESConnString, CommandType.StoredProcedure, strSPC, array);
		}

		public static SqlDataReader getSpcReader(string strSPC, SqlParameter[] parms, string strConn = null)
		{
			return ComMethod.getReader(strConn ?? SQLHelper.MESConnString, CommandType.StoredProcedure, strSPC, parms);
		}

		public static SqlDataReader getTbViewReader(string TbView, string strJson, string strSort = "", string strConn = null)
		{
			System.Collections.Generic.List<SqlParameter> listPara = new System.Collections.Generic.List<SqlParameter>();
			System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
			ComMethod.getTbViewConditionAndParams(TbView, strJson, null, strConn, listPara, stringBuilder, null);
			string strSql = string.Format("SELECT {0} FROM {1} {2} {3}", new object[]
			{
				ComMethod.GetTbOrViewColumns(TbView, null),
				TbView,
				stringBuilder.ToString(),
				strSort
			});
			return ComMethod.getReader(strConn ?? SQLHelper.MESConnString, CommandType.Text, strSql, ComMethod.getTableParams(listPara));
		}

        public static SqlDataReader getTbViewReaderRowNum(string TbView, string strJson, string strSort = "", string strConn = null)
        {
            System.Collections.Generic.List<SqlParameter> listPara = new System.Collections.Generic.List<SqlParameter>();
            System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
            string tbViewConditionAndParams = ComMethod.getTbViewConditionAndParams(TbView, strJson, null, strConn, listPara, stringBuilder, null);
            strSort = ((strSort == "") ? tbViewConditionAndParams : strSort);
            string strSql = string.Format("SELECT {0}, ROW_NUMBER()OVER({3}) AS ROWNUM FROM {1} {2}", new object[]
            {
                ComMethod.GetTbOrViewColumns(TbView, null),
                TbView,
                stringBuilder.ToString(),
                strSort
            });
            return ComMethod.getReader(strConn ?? ComMethod.strComConnect, CommandType.Text, strSql, ComMethod.getTableParams(listPara));
        }

        public static SqlDataReader getTbViewReader(string TbView, SearchSettings searchSettings, string strSort = "", string strConn = null)
		{
			System.Collections.Generic.List<SqlParameter> listPara = new System.Collections.Generic.List<SqlParameter>();
			System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
			ComMethod.getTbViewConditionAndParams(TbView, null, searchSettings, strConn, listPara, stringBuilder, null);
			string strSql = string.Format("SELECT {0} FROM {1} {2} {3}", new object[]
			{
				ComMethod.GetTbOrViewColumns(TbView, null),
				TbView,
				stringBuilder.ToString(),
				strSort
			});
			return ComMethod.getReader(strConn ?? SQLHelper.MESConnString, CommandType.Text, strSql, ComMethod.getTableParams(listPara));
		}

		public static SqlDataReader getTbViewReaderPage(SqlTransaction trans, SqlConnection conn, ref int rowCount, int startRow, int maxRows, string TbView, SearchSettings searchSettings, string strSort = "", string strConn = null)
		{
			System.Collections.Generic.List<SqlParameter> listPara = new System.Collections.Generic.List<SqlParameter>();
			System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
			string tbViewConditionAndParams = ComMethod.getTbViewConditionAndParams(TbView, null, searchSettings, strConn, listPara, stringBuilder, null);
			strSort = ((strSort == "") ? tbViewConditionAndParams : strSort);
            //by liwen 2020.10.22 处理字符串中带了ORDER BY 
            if (strSort.ToUpper().IndexOf("ORDER BY") > -1) {
                strSort = strSort.Replace("ORDER BY","");
            }
			string text = string.Format("SELECT COUNT(1) FROM {0} {1} ", TbView, stringBuilder);
			rowCount = System.Convert.ToInt32(ComMethod.ExecuteScalar(conn, trans, CommandType.Text, text, ComMethod.getTableParams(listPara)));
			text = string.Format(" SELECT {0}, ROWNUM FROM ( SELECT {0}, ROW_NUMBER()OVER(ORDER BY {2}) AS ROWNUM FROM {1} {3} ) AS A WHERE ROWNUM BETWEEN {4} AND {5}", new object[]
			{
				ComMethod.GetTbOrViewColumns(TbView, null),
				TbView,
				strSort,
				stringBuilder,
				startRow.ToString(),
				maxRows.ToString()
			});
			return ComMethod.ExecuteReader(conn, trans, CommandType.Text, text, ComMethod.getTableParams(listPara));
		}

		public static SqlDataReader getTbViewReaderPage(SqlTransaction trans, SqlConnection conn, ref int rowCount, int startRow, int maxRows, string TbView, string strJson, string strSort = "", string strConn = null)
		{
			System.Collections.Generic.List<SqlParameter> listPara = new System.Collections.Generic.List<SqlParameter>();
			System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
			string tbViewConditionAndParams = ComMethod.getTbViewConditionAndParams(TbView, strJson, null, strConn, listPara, stringBuilder, null);
			strSort = ((strSort == "") ? tbViewConditionAndParams : strSort);
			string text = string.Format("SELECT COUNT(1) FROM {0} {1} ", TbView, stringBuilder);
			rowCount = System.Convert.ToInt32(ComMethod.ExecuteScalar(conn, trans, CommandType.Text, text, ComMethod.getTableParams(listPara)));
			text = string.Format(" SELECT {0}, ROWNUM FROM ( SELECT {0}, ROW_NUMBER()OVER( ORDER BY {2}) AS ROWNUM FROM {1} {3} ) AS A WHERE ROWNUM BETWEEN {4} AND {5}", new object[]
			{
				ComMethod.GetTbOrViewColumns(TbView, null),
				TbView,
				strSort,
				stringBuilder,
				startRow.ToString(),
				maxRows.ToString()
			});
			return ComMethod.ExecuteReader(conn, trans, CommandType.Text, text, ComMethod.getTableParams(listPara));
		}

		public static SqlDataReader getReader(string strConnection, CommandType cmdType, string strSql, params SqlParameter[] arr_parms)
		{
			SqlConnection conn = new SqlConnection(strConnection);
			return ComMethod.ExecuteReader(conn, null, cmdType, strSql, arr_parms);
		}

		private static SqlDataReader ExecuteReader(SqlConnection conn, SqlTransaction trans, CommandType cmdType, string cmdText, params SqlParameter[] arr_parms)
		{
			SqlCommand sqlCommand = new SqlCommand();
			SqlDataReader result;
			try
			{
				ComMethod.initCommand(conn, trans, sqlCommand, cmdType, cmdText, arr_parms);
				result = sqlCommand.ExecuteReader();
			}
			catch (System.Exception ex)
			{
				sqlCommand.Dispose();
				conn.Close();
				throw ex;
			}
			return result;
		}

		private static object ExecuteScalar(SqlConnection conn, SqlTransaction trans, CommandType cmdType, string strSql, params SqlParameter[] arr_parms)
		{
			SqlCommand sqlCommand = new SqlCommand();
			object result;
			try
			{
				ComMethod.initCommand(conn, trans, sqlCommand, cmdType, strSql, arr_parms);
				result = sqlCommand.ExecuteScalar();
			}
			catch (System.Exception ex)
			{
				sqlCommand.Dispose();
				conn.Close();
				throw ex;
			}
			return result;
		}

		public static int ExecuteNonQuery(SqlTransaction trans, CommandType cmdType, string cmdText, params SqlParameter[] cmdParms)
		{
			SqlCommand sqlCommand = new SqlCommand();
			ComMethod.initCommand(trans.Connection, trans, sqlCommand, cmdType, cmdText, cmdParms);
			int result = sqlCommand.ExecuteNonQuery();
			sqlCommand.Parameters.Clear();
			return result;
		}

        public static int ExeNonQuerySpcSql(string strSql, SqlParameter[] arr_parms, CommandType cmdType = CommandType.Text, string strConn = null)
        {
            SqlConnection sqlConnection = new SqlConnection(strConn ?? ComMethod.strComConnect);
            SqlCommand sqlCommand = new SqlCommand();
            int result;
            try
            {
                ComMethod.initCommand(sqlConnection, null, sqlCommand, cmdType, strSql, arr_parms);
                result = sqlCommand.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                sqlCommand.Dispose();
                sqlConnection.Close();
                throw ex;
            }
            return result;
        }

        private static void initCommand(SqlConnection conn, SqlTransaction trans, SqlCommand cmd, CommandType cmdType, string cmdText, SqlParameter[] arr_parms)
		{
			cmd.Parameters.Clear();
			if (conn.State != ConnectionState.Open)
			{
				conn.Open();
			}
			if (trans != null)
			{
				cmd.Transaction = trans;
			}
			cmd.Connection = conn;
			cmd.CommandText = cmdText;
			cmd.CommandType = cmdType;
			if (arr_parms != null)
			{
				for (int i = 0; i < arr_parms.Length; i++)
				{
					SqlParameter value = arr_parms[i];
					cmd.Parameters.Add(value);
				}
			}
		}

		private static void getSqlContion(System.Collections.Generic.List<SqlParameter> list, System.Collections.Generic.List<SqlParameter> listPara, System.Text.StringBuilder strContiton, Contition con)
		{
			bool flag = con.value.TrimStart(new char[]
			{
				'%'
			}).TrimEnd(new char[]
			{
				'%'
			}).Length != con.value.ToString().Length;
			System.Collections.Generic.List<SqlParameter> list2 = (from p in list
			where p.ParameterName == "@" + con.name
			select p).ToList<SqlParameter>();
			if (list2.Count == 0)
			{
				throw new System.Exception("资料参数[" + con.name + "]不存在");
			}
			string text = (con.type != null) ? con.type : ((!flag) ? " = " : " LIKE ");
			string text2 = (con.action != null) ? (" " + con.action.ToString() + " ") : ((strContiton.ToString() != "") ? " AND " : " ");
			SqlParameter sqlParameter = list2[0];
			sqlParameter.SqlDbType = (flag ? SqlDbType.NVarChar : sqlParameter.SqlDbType);
			sqlParameter.Size = (flag ? sqlParameter.Size : 500);
			ComMethod.RepalceType(sqlParameter, con.value);
			listPara.Add(sqlParameter);
			string text3 = (sqlParameter.SqlDbType == SqlDbType.DateTime || sqlParameter.SqlDbType == SqlDbType.Date || sqlParameter.SqlDbType == SqlDbType.DateTime2) ? (" CONVERT( DATETIME, @" + con.name + " ) ") : (" @" + con.name);
			strContiton.Append((strContiton.ToString() == "") ? " WHERE " : "");
			strContiton.Append(string.Concat(new string[]
			{
				text2,
				con.name,
				" ",
				text,
				text3
			}));
		}

		private static string getTbViewConditionAndParams(string TbView, string strJson, SearchSettings searchSettings, string strConn, System.Collections.Generic.List<SqlParameter> listPara, System.Text.StringBuilder strContiton, System.Text.StringBuilder strSort = null)
		{
			System.Collections.Generic.List<SqlParameter> listParameters = ComMethod.GetListParameters(TbView, strConn);
			if (listParameters == null)
			{
				throw new System.Exception("表参数获取失败");
			}
			if (strJson == null)
			{
				foreach (string current in searchSettings.Conditions.Keys)
				{
					string text = searchSettings.Conditions[current];
					if (text != "")
					{
						ComMethod.getSqlContion(listParameters, listPara, strContiton, new Contition
						{
							value = text,
							name = current
						});
					}
				}
				if (searchSettings.ExtensionCondition != null && searchSettings.ExtensionCondition != "")
				{
					strContiton.Append((strContiton.ToString() == "") ? (" WHERE " + searchSettings.ExtensionCondition) : (" AND " + searchSettings.ExtensionCondition));
				}
			}
			else
			{
				System.Collections.Generic.List<Contition> list = ComMethod.JsonToEntities<Contition>(strJson);
				foreach (Contition current2 in list)
				{
					if (current2.value != null)
					{
						ComMethod.getSqlContion(listParameters, listPara, strContiton, current2);
					}
				}
			}
			return listParameters[0].ParameterName.TrimStart(new char[]
			{
				'@'
			}) + " DESC ";
		}

		private static DataTable GetParaTable(string strValue)
		{
            return ComMethod.ToDataTable(strValue);
		}

		private static void RepalceType(SqlParameter param, string strValue)
		{
			switch (param.SqlDbType)
			{
			case SqlDbType.Bit:
				param.Value = (strValue == "1");
				return;
			case SqlDbType.DateTime:
				param.Value = System.Convert.ToDateTime(strValue);
				return;
			}
			param.Value = strValue;
		}

		private static void CacheParameters(string cacheKey, params SqlParameter[] cmdParms)
		{
			ComMethod.parmCache[cacheKey] = cmdParms;
		}

		private static void CacheParameters(string cacheKey, System.Collections.Generic.List<SqlParameter> cmdParms)
		{
			ComMethod.parmCache[cacheKey] = cmdParms;
		}

		private static void CacheColumns(string cacheKey, string strColumns)
		{
			ComMethod.parmCache[cacheKey] = strColumns;
		}

		private static SqlParameter[] GetCachedParameters(string cacheKey)
		{
			SqlParameter[] array = (SqlParameter[])ComMethod.parmCache[cacheKey];
			SqlParameter[] result;
			if (array == null)
			{
				result = null;
			}
			else
			{
				SqlParameter[] array2 = new SqlParameter[array.Length];
				int i = 0;
				int num = array.Length;
				while (i < num)
				{
					array2[i] = (SqlParameter)((System.ICloneable)array[i]).Clone();
					i++;
				}
				result = array2;
			}
			return result;
		}

		private static SqlParameter[] getTableParams(System.Collections.Generic.List<SqlParameter> listPara)
		{
			SqlParameter[] array = new SqlParameter[listPara.Count];
			int i = 0;
			int count = listPara.Count;
			while (i < count)
			{
				array[i] = (SqlParameter)((System.ICloneable)listPara[i]).Clone();
				i++;
			}
			return array;
		}

		private static System.Collections.Generic.List<SqlParameter> GetListParameters(string TbView, string strConn)
		{
			System.Collections.Generic.List<SqlParameter> list = (System.Collections.Generic.List<SqlParameter>)ComMethod.parmCache["Tb_" + TbView];
			if (System.DateTime.Now.Minute % 5 == 0)
			{
				ComMethod.parmCache.Clear();
			}
			System.Collections.Generic.List<SqlParameter> result;
			if (list != null)
			{
				result = list;
			}
			else
			{
				list = new System.Collections.Generic.List<SqlParameter>();
				string text = "SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH \r\n                        FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" + TbView + "';";
				using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderSqlText(strConn ?? SQLHelper.MESConnString, text, new SqlParameter[0]))
				{
					while (sqlDataReader.Read())
					{
						int size = sqlDataReader.IsDBNull(2) ? 0 : sqlDataReader.GetInt32(2);
						SqlParameter item = sqlDataReader.IsDBNull(2) ? new SqlParameter("@" + sqlDataReader.GetString(0), ComMethod.RepalceType(sqlDataReader.GetString(1))) : new SqlParameter("@" + sqlDataReader.GetString(0), ComMethod.RepalceType(sqlDataReader.GetString(1)), size);
						list.Add(item);
					}
				}
				ComMethod.CacheParameters("Tb_" + TbView, list);
				result = list;
			}
			return result;
		}

		private static string GetCachedColumns(string cacheKey)
		{
			return (ComMethod.parmCache[cacheKey] == null) ? null : ComMethod.parmCache[cacheKey].ToString();
		}

		private static SqlDbType RepalceType(string sqlTypeString)
		{
			SqlDbType result;
			switch (sqlTypeString)
			{
			case "int":
				result = SqlDbType.Int;
				return result;
			case "varchar":
				result = SqlDbType.VarChar;
				return result;
			case "bit":
				result = SqlDbType.Bit;
				return result;
			case "datetime":
				result = SqlDbType.DateTime;
				return result;
			case "decimal":
				result = SqlDbType.Decimal;
				return result;
			case "float":
				result = SqlDbType.Float;
				return result;
			case "image":
				result = SqlDbType.Image;
				return result;
			case "money":
				result = SqlDbType.Money;
				return result;
			case "ntext":
				result = SqlDbType.NText;
				return result;
			case "nvarchar":
				result = SqlDbType.NVarChar;
				return result;
			case "smalldatetime":
				result = SqlDbType.SmallDateTime;
				return result;
			case "smallint":
				result = SqlDbType.SmallInt;
				return result;
			case "text":
				result = SqlDbType.Text;
				return result;
			case "bigint":
				result = SqlDbType.BigInt;
				return result;
			case "binary":
				result = SqlDbType.Binary;
				return result;
			case "char":
				result = SqlDbType.Char;
				return result;
			case "nchar":
				result = SqlDbType.NChar;
				return result;
			case "numeric":
				result = SqlDbType.Decimal;
				return result;
			case "real":
				result = SqlDbType.Real;
				return result;
			case "smallmoney":
				result = SqlDbType.SmallMoney;
				return result;
			case "sql_variant":
				result = SqlDbType.Variant;
				return result;
			case "timestamp":
				result = SqlDbType.Timestamp;
				return result;
			case "tinyint":
				result = SqlDbType.TinyInt;
				return result;
			case "uniqueidentifier":
				result = SqlDbType.VarChar;
				return result;
			case "varbinary":
				result = SqlDbType.VarBinary;
				return result;
			case "xml":
				result = SqlDbType.Xml;
				return result;
			}
			result = SqlDbType.Structured;
			return result;
		}

        private static SqlParameter getNewSpcPama(SqlDataReader rdr)
        {
            SqlParameter result = new SqlParameter(rdr.GetString(0), ComMethod.RepalceType(rdr.GetString(1)), (int)rdr.GetInt16(2));
            string text = rdr.GetString(1).ToLower();
            switch (text)
            {
                case "int":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Int);
                    return result;
                case "varchar":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.VarChar, (int)rdr.GetInt16(2));
                    return result;
                case "bit":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Bit);
                    return result;
                case "datetime":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.DateTime);
                    return result;
                case "decimal":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Decimal);
                    return result;
                case "float":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Float);
                    return result;
                case "image":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Image);
                    return result;
                case "money":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Money);
                    return result;
                case "ntext":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.NText);
                    return result;
                case "nvarchar":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.NVarChar, (int)rdr.GetInt16(2));
                    return result;
                case "smalldatetime":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.SmallDateTime);
                    return result;
                case "smallint":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.SmallInt);
                    return result;
                case "text":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Text);
                    return result;
                case "bigint":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.BigInt);
                    return result;
                case "binary":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Binary);
                    return result;
                case "char":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Char, (int)rdr.GetInt16(2));
                    return result;
                case "nchar":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.NChar, (int)rdr.GetInt16(2));
                    return result;
                case "numeric":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Decimal);
                    return result;
                case "real":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Real);
                    return result;
                case "smallmoney":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.SmallMoney);
                    return result;
                case "sql_variant":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Variant);
                    return result;
                case "timestamp":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Timestamp);
                    return result;
                case "tinyint":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.TinyInt);
                    return result;
                case "uniqueidentifier":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.VarChar, (int)rdr.GetInt16(2));
                    return result;
                case "varbinary":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.VarBinary, (int)rdr.GetInt16(2));
                    return result;
                case "xml":
                    result = new SqlParameter(rdr.GetString(0), SqlDbType.Xml);
                    return result;
            }
            result = new SqlParameter(rdr.GetString(0), SqlDbType.Structured);
            return result;
        }

        private static SqlParameter RepalceTbParams(string type, string strName)
		{
			SqlParameter result = new SqlParameter("@" + strName, SqlDbType.NVarChar, 8000);
			if (type != null)
			{
				if (!(type == "Int32"))
				{
					if (!(type == "Boolean"))
					{
						if (!(type == "DateTime"))
						{
							if (!(type == "Int64"))
							{
								if (!(type == "Decimal"))
								{
									if (type == "Double")
									{
										result = new SqlParameter("@" + strName, SqlDbType.Float);
									}
								}
								else
								{
									result = new SqlParameter("@" + strName, SqlDbType.Decimal);
								}
							}
							else
							{
								result = new SqlParameter("@" + strName, SqlDbType.BigInt);
							}
						}
						else
						{
							result = new SqlParameter("@" + strName, SqlDbType.DateTime);
						}
					}
					else
					{
						result = new SqlParameter("@" + strName, SqlDbType.Bit);
					}
				}
				else
				{
					result = new SqlParameter("@" + strName, SqlDbType.Int);
				}
			}
			return result;
		}

		private static string RepalceTbType(string type)
		{
			string result = "NVARCHAR(MAX)";
			if (type != null)
			{
				if (!(type == "Int32"))
				{
					if (!(type == "Boolean"))
					{
						if (!(type == "DateTime"))
						{
							if (!(type == "Int64"))
							{
								if (!(type == "Decimal"))
								{
									if (type == "Double")
									{
										result = "FLOAT";
									}
								}
								else
								{
									result = "DECIMAL(30,8)";
								}
							}
							else
							{
								result = "BIGINT";
							}
						}
						else
						{
							result = "DATETIME";
						}
					}
					else
					{
						result = "BIT";
					}
				}
				else
				{
					result = "INT";
				}
			}
			return result;
		}

		public static System.Collections.Generic.List<T> ToListEntity<T>(SqlDataReader reader) where T : class
		{
			System.Collections.Generic.List<T> list = new System.Collections.Generic.List<T>();
			T t = (T)((object)System.Activator.CreateInstance(typeof(T)));
			System.Reflection.PropertyInfo[] entityPara = ComMethod.getEntityPara<T>(reader, t);
			while (reader.Read())
			{
				t = (T)((object)System.Activator.CreateInstance(typeof(T)));
				ComMethod.setParaVelues<T>(reader, t, entityPara);
				list.Add(t);
			}
			if (!reader.IsClosed)
			{
				reader.Close();
			}
			return list;
		}

		public static System.Collections.Generic.List<T> ToListEntity<T>(SqlDataReader reader, int startRow, int maxRows, ref int rowCount) where T : class
		{
			System.Collections.Generic.List<T> list = new System.Collections.Generic.List<T>();
			T t = (T)((object)System.Activator.CreateInstance(typeof(T)));
			System.Reflection.PropertyInfo[] entityPara = ComMethod.getEntityPara<T>(reader, t);
			int num = 0;
			while (reader.Read())
			{
				if (num >= startRow && num < startRow + maxRows)
				{
					t = (T)((object)System.Activator.CreateInstance(typeof(T)));
					ComMethod.setParaVelues<T>(reader, t, entityPara);
					list.Add(t);
				}
				num++;
			}
			rowCount = num;
			if (!reader.IsClosed)
			{
				reader.Close();
			}
			return list;
		}

		private static System.Reflection.PropertyInfo[] getEntityPara<T>(SqlDataReader reader, T entity) where T : class
		{
			System.Reflection.PropertyInfo[] array = new System.Reflection.PropertyInfo[reader.FieldCount];
			for (int i = 0; i < reader.FieldCount; i++)
			{
				array[i] = entity.GetType().GetProperty(reader.GetName(i), System.Reflection.BindingFlags.IgnoreCase | System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public);
			}
			return array;
		}

		private static void setParaVelues<T>(SqlDataReader reader, T entity, System.Reflection.PropertyInfo[] listP) where T : class
		{
			for (int i = 0; i < reader.FieldCount; i++)
			{
				if (listP[i] != null)
				{
                    listP[i].SetValue(entity, System.Convert.IsDBNull(reader.GetValue(i)) ? null : listP[i].GetGetMethod().ReturnParameter.ParameterType.Name == "Int32" ? Convert.ToInt32(ComMethod.FormatValue(reader.GetValue(i), listP[i])) : ComMethod.FormatValue(reader.GetValue(i), listP[i]), null);
				}
			}
		}

		private static object FormatValue(object obj, System.Reflection.PropertyInfo p)
		{
			return obj;
		}

		public static T ToEntity<T>(SqlDataReader reader) where T : class
		{
			T t = (T)((object)System.Activator.CreateInstance(typeof(T)));
			while (reader.Read())
			{
				for (int i = 0; i < reader.FieldCount; i++)
				{
					System.Reflection.PropertyInfo property = t.GetType().GetProperty(reader.GetName(i), System.Reflection.BindingFlags.IgnoreCase | System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public);
					if (property != null)
					{
						FomatValue[] array = property.GetCustomAttributes(typeof(FomatValue), false) as FomatValue[];
						property.SetValue(t, System.Convert.IsDBNull(reader.GetValue(i)) ? null : ComMethod.FormatValue(reader.GetValue(i), property), null);
					}
				}
			}
			if (!reader.IsClosed)
			{
				reader.Close();
			}
			return t;
		}

		public static object DbNull(object objValue)
		{
			if (objValue == null || objValue.ToString() == string.Empty)
			{
				objValue = System.DBNull.Value;
			}
			return objValue;
		}

		public static DataTable ConvertToDataTable<T>(System.Collections.Generic.List<T> data)
		{
			PropertyDescriptorCollection properties = TypeDescriptor.GetProperties(typeof(T));
			DataTable dataTableSchema = ComMethod.GetDataTableSchema<T>();
			object[] array = new object[properties.Count];
			foreach (T current in data)
			{
				for (int i = 0; i < array.Length; i++)
				{
					array[i] = properties[i].GetValue(current);
				}
				dataTableSchema.Rows.Add(array);
			}
			dataTableSchema.AcceptChanges();
			return dataTableSchema;
		}

		private static DataTable GetDataTableSchema<T>()
		{
			PropertyDescriptorCollection properties = TypeDescriptor.GetProperties(typeof(T));
			DataTable dataTable = new DataTable();
			for (int i = 0; i < properties.Count; i++)
			{
				PropertyDescriptor propertyDescriptor = properties[i];
				System.Type type = propertyDescriptor.PropertyType;
				if (type.IsGenericType && type.GetGenericTypeDefinition() == typeof(System.Nullable<>))
				{
					type = System.Nullable.GetUnderlyingType(type);
				}
				dataTable.Columns.Add(propertyDescriptor.Name, type);
			}
			return dataTable;
		}

		public static DataSet ReaderToDataSet(IDataReader reader, string strTbName = "table")
		{
			DataSet dataSet = new DataSet();
			int num = 0;
			do
			{
				string strName = strTbName + ((num > 0) ? num.ToString() : "");
				dataSet.Tables.Add(ComMethod.OneReaderToDataTable(reader, strName));
				num++;
			}
			while (reader.NextResult());
			if (!reader.IsClosed)
			{
				reader.Close();
			}
			return dataSet;
		}

		private static DataTable OneReaderToDataTable(IDataReader reader, string strName)
		{
			DataTable dataTable = new DataTable();
			dataTable.TableName = strName;
			for (int i = 0; i < reader.FieldCount; i++)
			{
				dataTable.Columns.Add(reader.GetName(i), reader.GetFieldType(i));
			}
			while (reader.Read())
			{
				object[] values = new object[reader.FieldCount];
				reader.GetValues(values);
				dataTable.Rows.Add(values);
			}
			return dataTable;
        }

        private static DataTable OneReaderToDataTable(IDataReader reader, int startRow, int maxRows, ref int rowCount, string strName)
        {
            DataTable dataTable = new DataTable();
            dataTable.TableName = strName;
            for (int i = 0; i < reader.FieldCount; i++)
            {
                dataTable.Columns.Add(reader.GetName(i), reader.GetFieldType(i));
            }
            int num = 0;
            while (reader.Read())
            {
                if (num >= startRow && num < startRow + maxRows)
                {
                    object[] values = new object[reader.FieldCount];
                    reader.GetValues(values);
                    dataTable.Rows.Add(values);
                }
                num++;
            }
            return dataTable;
        }

        public static string ToPageListJson(IDataReader reader, int startRow, int maxRows)
        {
            string result;
            try
            {
                System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
                stringBuilder.Append("{\"data\": [");
                int num = 0;
                int num2 = 0;
                while (reader.Read())
                {
                    num++;
                    if (num >= startRow && num < maxRows)
                    {
                        stringBuilder.Append("{");
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            string text = reader[i].ToString();
                            stringBuilder.Append("\"" + reader.GetName(i) + "\":");
                            text = ComMethod.StringFormat(reader[i].ToString(), reader.GetFieldType(i));
                            text = ((i < reader.FieldCount - 1) ? (text + ",") : text);
                            stringBuilder.Append(text);
                            num2++;
                        }
                        stringBuilder.Append("},");
                    }
                }
                stringBuilder.Remove(stringBuilder.Length - 1, 1);
                stringBuilder.Append("],\"TotalCount\": " + num + "}");
                result = ((num2 == 0) ? "{}" : stringBuilder.ToString());
            }
            catch (System.Exception ex)
            {
                reader.Close();
                throw ex;
            }
            finally
            {
                reader.Close();
            }
            return result;
        }

        public static string GetPageList(string strSpc, string strJsonParaValue, int startRow, int maxRows, string strConn = null)
        {
            string result;
            using (SqlDataReader spcReader = ComMethod.getSpcReader(strSpc, strJsonParaValue, strConn))
            {
                result = ComMethod.ToPageListJson(spcReader, startRow, maxRows);
            }
            return result;
        }

        /// <summary>
        /// 数据库类型转换
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="value"></param>
        /// <returns></returns>
        public static T FromDatabase<T>(Object value)
        {
            //处理空和DBNull
            if (value == null || Convert.IsDBNull(value) == true)
            {
                return default(T);
            }
            //可空类型转为基础类型
            Type convertType = typeof(T);
            if (convertType.IsGenericType && convertType.GetGenericTypeDefinition().Equals(typeof(Nullable<>)))
            {
                NullableConverter convert = new NullableConverter(convertType);
                convertType = convert.UnderlyingType;
            }
            //区分枚举和其他基础类型
            if (convertType.IsEnum == false)
            {
                if (value == null || Convert.IsDBNull(value) == true)
                {
                    return default(T);
                }
                else
                {
                    return (T)Convert.ChangeType(value, convertType);
                }
            }
            else
            {
                if (Enum.IsDefined(convertType, value) == false)
                {
                    throw new ArgumentOutOfRangeException();
                }

                return (T)Enum.ToObject(convertType, value);
            }
        }


        public static List<T> ConvertDataTableToList<T>(DataTable table) where T : class, new()
        {
            List<T> list = new List<T>();
            foreach (DataRow row in table.Rows)
            {
                T local = Activator.CreateInstance<T>();
                foreach (PropertyInfo info in local.GetType().GetProperties())
                {
                    if (table.Columns.Contains(info.Name) && (row[info.Name] != DBNull.Value))
                    {
                        info.SetValue(local, row[info.Name], null);
                    }
                }
                list.Add(local);
            }
            return list;
        }
    }
}
