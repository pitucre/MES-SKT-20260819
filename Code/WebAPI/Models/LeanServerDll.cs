using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;

namespace WebAPI
{
    public class LeanServerDll
    {

        private static System.Collections.Hashtable parmCache = System.Collections.Hashtable.Synchronized(new System.Collections.Hashtable());
        /// <summary>
        /// 调用存储过程 返回数据集合(查询)
        /// </summary>
        /// <returns></returns>
        public DataSet ExecProcedureTable(string procedureName,List<Dictionary<string, object>> parameters)
        {
            SqlParameter[] parms = GetSpcParams(procedureName);
            parms = SetParaValue(ToDataTable(parameters), parms);
            DataSet ds = new DataSet();

            using (SqlConnection sqlcon = new SqlConnection(SQLHelper.MESConnString))
            {
                if (sqlcon.State != ConnectionState.Open)
                    sqlcon.Open();

                SqlCommand sqlcom = new SqlCommand();
                sqlcom.Connection = sqlcon;
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = procedureName;
                for (int i = 0; i < parms.Length; i++)
                {
                    sqlcom.Parameters.Add(parms[i]);
                }
               
                using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                {
                    sda.Fill(ds);
                }

                sqlcon.Close();
                sqlcon.Dispose();
            }
            return ds;
        }


        /// <summary>
        /// 调用存储过程 (增删改)
        /// </summary>
        /// <returns></returns>
        public void ExecProcedure(string procedureName, List<Dictionary<string, object>> parameters)
        {
            SqlParameter[] parms = GetSpcParams(procedureName);
            parms = SetParaValue(ToDataTable(parameters),parms);
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, procedureName, parms);
        }

        public void UpdateAgvTaskStatus(string taskNo ,int status)
        {
            SqlParameter[] parms = new SqlParameter[]{
                        new SqlParameter("@TaskNo", SqlDbType.VarChar),
                        new SqlParameter("@Status", SqlDbType.VarChar,50)
                    };
            parms[0].Value = taskNo;
            parms[1].Value = status;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString,"uspUpdateAgvTask", parms);
        }

       /// <summary>
       /// 缓存key值名参数列表
       /// </summary>
       /// <param name="cacheKey"></param>
       /// <returns></returns>
        private static SqlParameter[] GetCachedParameters(string cacheKey)
        {
            SqlParameter[] array = (SqlParameter[])parmCache[cacheKey];
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

       /// <summary>
       /// 根据存储过程名获取参数列表
       /// </summary>
       /// <param name="procedureName"></param>
       /// <returns></returns>
        public static SqlParameter[] GetSpcParams(string procedureName)
        {
            if (System.DateTime.Now.Minute % 5 == 0)
            {
                parmCache.Clear();
            }
            SqlParameter[] array =GetCachedParameters(procedureName);
            SqlParameter[] result;
            if (array != null)
            {
                result = array;
            }
            else
            {
                System.Collections.Generic.List<SqlParameter> list = new System.Collections.Generic.List<SqlParameter>();
                string text = "select syscolumns.name, systypes.name, syscolumns.length,syscolumns.isoutparam from syscolumns,systypes\r\n                        where (syscolumns.id=object_id('" + procedureName + "') and syscolumns.xusertype=systypes.xusertype)\r\n                        order by syscolumns.colorder;";
                using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, text, new SqlParameter[0]))
                {
                    while (sqlDataReader.Read())
                    {
                        SqlParameter sqlParameter = new SqlParameter(sqlDataReader.GetString(0), RepalceType(sqlDataReader.GetString(1)), (int)sqlDataReader.GetInt16(2));
                        if (sqlDataReader.GetInt32(3) == 1)
                        {
                            sqlParameter.Direction = ParameterDirection.InputOutput;
                        }
                        list.Add(sqlParameter);
                    }
                }
                array = list.ToArray();
              
                result = array;
            }
            return result;
        }

        /// <summary>
        /// 返回参数类型
        /// </summary>
        /// <param name="sqlTypeString"></param>
        /// <returns></returns>
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

        /// <summary>
        /// 字典数组转DataTable
        /// </summary>
        /// <param name="arrayList"></param>
        /// <returns></returns>
        public static DataTable ToDataTable(List<Dictionary<string, object>> arrayList)
        {
            DataTable result;
            if (arrayList.Count == 0)
            {
                result = null;
            }
            else
            {
                DataTable dataTable = new DataTable();
                foreach (System.Collections.Generic.Dictionary<string, object> dictionary in arrayList)
                {
                    if (dataTable.Columns.Count == 0)
                    {
                        foreach (string current in dictionary.Keys)
                        {
                            dataTable.Columns.Add(current, (dictionary[current] == null) ? typeof(string) : dictionary[current].GetType());
                        }
                    }
                    DataRow dataRow = dataTable.NewRow();
                    foreach (string current in dictionary.Keys)
                    {
                        dataRow[current] = ((dictionary[current] == null) ? System.DBNull.Value : dictionary[current]);
                    }
                    dataTable.Rows.Add(dataRow);
                }
                result = dataTable;
            }
            return result;
        }


        private static DataTable GetParaTable(string strValue)
        {
            DataTable dataTable = JsonToDataTable(strValue);
            if (dataTable == null)
            {
                throw new System.Exception("数据结构参数列表数据为空");
            }
            return dataTable;
        }

        /// <summary>
        /// 返回DataTable对象
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        public static DataTable JsonToDataTable(string json)
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
                foreach (System.Collections.Generic.Dictionary<string, object> dictionary in arrayList)
                {
                    if (dataTable.Columns.Count == 0)
                    {
                        foreach (string current in dictionary.Keys)
                        {
                            dataTable.Columns.Add(current,
                                (dictionary[current] == null) ? typeof (string) : dictionary[current].GetType());
                        }
                    }
                    DataRow dataRow = dataTable.NewRow();
                    foreach (string current in dictionary.Keys)
                    {
                        dataRow[current] = ((dictionary[current] == null) ? System.DBNull.Value : dictionary[current]);
                    }
                    dataTable.Rows.Add(dataRow);
                }
                result = dataTable;
            }
            return result;
        }

        /// <summary>
        ///设置参数值
        /// </summary>
        /// <param name="dataTable"></param>
        /// <param name="arrParms"></param>
        /// <returns></returns>
        public static SqlParameter[] SetParaValue(DataTable dataTable, SqlParameter[] arrParms)
        {
     
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
                    arrParms[i].Value = ((arrParms[i].SqlDbType == SqlDbType.Structured) ? GetParaTable(obj.ToString()) : obj);
                }
                result = arrParms;
            }
            return result;
        }
        

    }
}
