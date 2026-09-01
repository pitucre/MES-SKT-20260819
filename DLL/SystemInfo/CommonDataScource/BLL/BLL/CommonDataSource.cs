using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonDataSource.Model;
using System.Web.Script.Serialization;

namespace SKT.LeanMES.CommonDataSource.BLL
{
    public class DataSource
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） DataSource 信息。
        /// </summary>
        /// <param name="entity">DataSource 实体对象。</param>
        public Int32 Edit(CommonDataSourceInfo entity)
        {
            int values = 0;
            if (entity.SQLType == "Procedure" && entity.UseType == "UIModel" && entity.DataSourceType == "Table")
            {
                string paramlist = "", tabCom = "";
                List<SqlParameter> parms = new List<SqlParameter>();
                GetParamterByProc(entity.SQLInfo, ref paramlist, ref parms);//获取存储过程参数

                GetColumnByProcResult(entity.SQLInfo, parms.ToArray(), ref tabCom);//获取存储过程返回Table的列

                SqlParameter[] parms2 = new SqlParameter[]{
                    new SqlParameter("@DataSourceID", SqlDbType.Int),
                    new SqlParameter("@DataSourceName", SqlDbType.NVarChar, 20),
                    new SqlParameter("@DataSourceDesc", SqlDbType.NVarChar, 200),
                    new SqlParameter("@DataSourceType", SqlDbType.VarChar, 20),
                    new SqlParameter("@SQLType", SqlDbType.NVarChar, 20),
                    new SqlParameter("@SQLInfo", SqlDbType.NVarChar, -1),
                    new SqlParameter("@UseType", SqlDbType.VarChar, 20),
                    new SqlParameter("@Paramters",SqlDbType.NVarChar,4000),
                    new SqlParameter("@TabColumn",SqlDbType.NVarChar,4000),
                    new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                    new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                };
                parms2[0].Value = entity.DataSourceID;
                //parms[0].Direction = ParameterDirection.InputOutput;
                parms2[1].Value = entity.DataSourceName;
                parms2[2].Value = entity.DataSourceDesc;
                parms2[3].Value = entity.DataSourceType;
                parms2[4].Value = entity.SQLType;
                parms2[5].Value = entity.SQLInfo;
                parms2[6].Value = entity.UseType;
                parms2[7].Value = paramlist.TrimEnd(new char[] { ',' });
                parms2[8].Value = tabCom.TrimEnd(new char[] { ',' }); ;
                parms2[9].Value = entity.CreateBy;
                parms2[10].Value = entity.ModifyBy;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "usp_Datasource_Edit", parms2);                
            }
            else
            {
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@DataSourceID", SqlDbType.Int),
                    new SqlParameter("@DataSourceName", SqlDbType.NVarChar, 20),
                    new SqlParameter("@DataSourceDesc", SqlDbType.NVarChar, 200),
                    new SqlParameter("@DataSourceType", SqlDbType.VarChar, 20),
                    new SqlParameter("@SQLType", SqlDbType.NVarChar, 20),
                    new SqlParameter("@SQLInfo", SqlDbType.NVarChar, -1),
                    new SqlParameter("@UseType", SqlDbType.VarChar, 20),
                    new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                    new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
                };

                parms[0].Value = entity.DataSourceID;
                //parms[0].Direction = ParameterDirection.InputOutput;
                parms[1].Value = entity.DataSourceName;
                parms[2].Value = entity.DataSourceDesc;
                parms[3].Value = entity.DataSourceType;
                parms[4].Value = entity.SQLType;
                parms[5].Value = entity.SQLInfo;
                parms[6].Value = entity.UseType;
                parms[7].Value = entity.CreateBy;
                parms[8].Value = entity.ModifyBy;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.ReportConnString, "SDP_DataSource_Edit", parms);
                
            }
            return values;
        }

        /// <summary>
        /// 获取存储过程的结果列表的列
        /// </summary>
        /// <param name="ProcName"></param>
        /// <param name="tabCom"></param>
        private void GetColumnByProcResult(string ProcName, SqlParameter[] paras, ref string tabCom)
        {
            DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, ProcName, paras);
            if (dt.Rows.Count == 0)
            {
                throw new Exception("存储过程不能返回列表！");
            }

            for (int i = 0; i < dt.Columns.Count; i++)
            {
                tabCom = tabCom + dt.Columns[i].ColumnName + ",";
            }
        }

        /// <summary>
        /// 获取存储过程的参数列表
        /// </summary>
        /// <param name="ProcName"></param>
        /// <param name="paramlist"></param>
        /// <param name="parmlist"></param>
        /// <returns></returns>
        private void GetParamterByProc(string ProcName, ref string paramlist, ref List<SqlParameter> parmlist)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProcName", SqlDbType.VarChar,100)
            };
            parms[0].Value = ProcName;

            DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspAutoGetProcParam", parms);
            if (dt.Rows.Count == 0)
            {
                throw new Exception("存储过程不存在或者没有参数");
            }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                paramlist = paramlist + dt.Rows[i]["ParamterName"].ToString() + ",";


                SqlDbType dbtype = SqlDbType.VarChar;
                dynamic paramvalue;
                switch (dt.Rows[i]["TypeName"].ToString().ToLower())
                {
                    case "char":
                        dbtype = SqlDbType.Char;
                        paramvalue = "";
                        break;
                    case "nchar":
                        dbtype = SqlDbType.NChar;
                        paramvalue = "";
                        break;
                    case "varchar":
                        dbtype = SqlDbType.VarChar;
                        paramvalue = "";
                        break;
                    case "nvarchar":
                        dbtype = SqlDbType.NVarChar;
                        paramvalue = "";
                        break;
                    case "decimal":
                        dbtype = SqlDbType.Decimal;
                        paramvalue = 0;
                        break;
                    case "bit":
                        dbtype = SqlDbType.Bit;
                        paramvalue = 0;
                        break;
                    case "float":
                        dbtype = SqlDbType.Float;
                        paramvalue = 0;
                        break;
                    case "int":
                        dbtype = SqlDbType.Int;
                        paramvalue = 0;
                        break;
                    case "bigint":
                        dbtype = SqlDbType.BigInt;
                        paramvalue = 0;
                        break;
                    case "numeric":
                        dbtype = SqlDbType.Decimal;
                        paramvalue = 0;
                        break;
                    case "date":
                        dbtype = SqlDbType.Date;
                        paramvalue = Convert.ToDateTime("1900-01-01");
                        break;
                    case "datetime":
                        dbtype = SqlDbType.DateTime;
                        paramvalue = Convert.ToDateTime("1900-01-01");
                        break;
                    default:
                        paramvalue = "";
                        break;
                }
                SqlParameter param = new SqlParameter(dt.Rows[i]["ParamterName"].ToString(), dbtype, Convert.ToInt32(dt.Rows[i]["max_length"]));
                param.Value = paramvalue;
                parmlist.Add(param);
            }
        }

        /// <summary>
        /// 根据 DataSourceId 字符串删除 DataSource 信息。
        /// </summary>
        /// <param name="idString">DataSourceId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.ReportConnString, "SDP_DataSource_Delete", parms);
        }

        /// <summary>
        /// 根据 DataSourceId 获取实体信息。
        /// </summary>
        /// <param name="dataSourceId">DataSourceId。</param>
        /// <returns>DataSource 实体对象。</returns>
        public CommonDataSourceInfo GetInfo(Int32 dataSourceId)
        {
            CommonDataSourceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = dataSourceId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "SDP_DataSource_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CommonDataSourceInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>DataSource 实体对象。</returns>
        public CommonDataSourceInfo GetInfo(String fieldValue)
        {
            CommonDataSourceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "SDP_DataSource_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CommonDataSourceInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取JSON信息。
        /// </summary>
        /// <param name="dataID">数据源ID。</param>
        /// <returns>DataSource JSON。</returns>
        public string GetJsonInfo(string procName)
        {
            CommonDataSourceInfo entity = null;
            List<CommonDataSourceInfo> list = new List<CommonDataSourceInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };
            parms[0].Value = procName;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "SDP_DataSource_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CommonDataSourceInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12));
                    list.Add(entity);
                }
                rdr.Close();
            }

            return new JavaScriptSerializer().Serialize(list);
        }

        /// <summary>
        /// 分页获取 DataSource 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="dataSourceCount">dataSource 总数。</param>
        /// <returns>DataSource 列表。</returns>
        public List<CommonDataSourceInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CommonDataSourceInfo> list = new List<CommonDataSourceInfo>();
            CommonDataSourceInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwSDP_DataSource"
                , "DataSourceId"
                , "[DataSourceID], [DataSourceName], [DataSourceDesc], [DataSourceType], [SQLType], [SQLInfo], [Paramters], [TabColumn], [UseType], [CreateBy], [CreateTime], [ModifyBy], [ModifyTime]"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CommonDataSourceInfo();
                    entity.DataSourceID = (int)rdr["DataSourceID"];
                    entity.DataSourceName = rdr["DataSourceName"].ToString();
                    entity.DataSourceDesc = rdr["DataSourceDesc"].ToString();
                    entity.DataSourceType = rdr["DataSourceType"].ToString();
                    entity.SQLType = rdr["SQLType"].ToString();
                    entity.SQLInfo = rdr["SQLInfo"].ToString();
                    entity.Paramters = rdr["Paramters"].ToString();
                    entity.TabColumn = rdr["TabColumn"].ToString();
                    entity.UseType = rdr["UseType"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateTime = rdr["CreateTime"].ToString();
                    entity.ModifyBy = rdr["ModifyBy"].ToString();
                    entity.ModifyTime = rdr["ModifyTime"].ToString();

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 检查用户输入。
        /// </summary>
        /// <param name="dbType">执行类型</param>
        /// <param name="sqlText">语句或者存储过程名称</param>
        public int CheckSql(string dbType, string sqlText)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@dbType", SqlDbType.NVarChar, 50),
                new SqlParameter("@sqlText", SqlDbType.NVarChar,Int32.MaxValue)
            };

            parms[0].Value = dbType;
            parms[1].Value = sqlText;

            return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.ReportConnString, "uspCheckSqlText", parms);

        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 通过存储过程，获取所有的存储过程参数
        /// </summary>
        /// <param name="ProcNames">存储过程名称集合</param>
        /// <returns></returns>
        public List<ProcParameterInfo> GetParameterInfoByProcNames(string[] ProcNames)
        {
            List<ProcParameterInfo> entitylst = new List<ProcParameterInfo>();

            string sProcName = "'" + string.Join("','", ProcNames) + "'";

            string sql = @"
                    SELECT a.name AS procName,ISNULL(c.name,'') AS typeName, ISNULL(b.name,'') AS parameter,ISNULL(b.max_length,-1) AS max_length,d.BusinessName
                    FROM sys.procedures a LEFT JOIN sys.parameters b
                    ON a.object_id=b.object_id 
                    LEFT JOIN sys.types c ON b.system_type_id=c.system_type_id AND b.user_type_id=c.user_type_id
                    INNER JOIN dbo.SYS_Synchronization d WITH(NOLOCK) ON a.name=d.StoredProcedureName
                    WHERE a.name in (" + sProcName + ")";

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql))
            {
                while (rdr.Read())
                {
                    ProcParameterInfo entity = new ProcParameterInfo(rdr["procName"].ToString(), rdr["parameter"].ToString(), rdr["typeName"].ToString(),
                        Convert.ToInt32(rdr["max_length"]), rdr["BusinessName"].ToString(), "");
                    entitylst.Add(entity);
                }
                rdr.Close();
            }
            return entitylst;
        }

        /// <summary>
        /// 动态执行存储过程
        /// </summary>
        /// <param name="Params"></param>
        /// <returns></returns>
        public bool ExecuteProc(List<ProcParameterInfo> Params)
        {
            bool bResult = true;
            SqlParameter[] parms = null;
            if (Params.Count > 1)
            {
                parms = new SqlParameter[Params.Count];
                for (int i = 0; i < Params.Count; i++)
                {
                    parms[i] = new SqlParameter(Params[i].ParameterName, GetSqlDbType(Params[i].ParameterType));
                    parms[i].Value = Params[i].ParameterValue;
                }
            }
            else if (Params.Count == 1 && Params[0].ParameterName != "")
            {
                parms = new SqlParameter[] { new SqlParameter(Params[0].ParameterName, GetSqlDbType(Params[0].ParameterType)) };
                parms[0].Value = Params[0].ParameterValue;
            }

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, Params[0].ProcName, parms);

            return bResult;
        }

        /// <summary>
        /// 转换成数据类型
        /// </summary>
        /// <param name="dbType"></param>
        /// <returns></returns>
        private SqlDbType GetSqlDbType(string dbType)
        {
            SqlDbType sqldbType = SqlDbType.VarChar;
            switch (dbType.ToLower())
            {
                case "nvarchar":
                    sqldbType = SqlDbType.NVarChar;
                    break;
                case "bit":
                    sqldbType = SqlDbType.Bit;
                    break;
                case "int":
                    sqldbType = SqlDbType.Int;
                    break;
                case "decimal":
                    sqldbType = SqlDbType.Decimal;
                    break;
                case "datetime":
                    sqldbType = SqlDbType.DateTime;
                    break;
                case "char":
                    sqldbType = SqlDbType.Char;
                    break;
                default:
                    break;
            }
            return sqldbType;
        }

        /// <summary>
        /// 分页获取 DataSource 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="dataSourceCount">dataSource 总数。</param>
        /// <returns>DataSource 列表。</returns>
        public List<CommonDataSourceInfo> GetSysobjectsAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CommonDataSourceInfo> list = new List<CommonDataSourceInfo>();
            CommonDataSourceInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwSysobjects"
                , "TableId"
                , "TableId,[TableName], [TableType]"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CommonDataSourceInfo();
                    entity.DataSourceID = Int32.Parse(rdr["TableId"].ToString());
                    entity.DataSourceName = rdr["TableName"].ToString();
                    entity.DataSourceType = rdr["TableType"].ToString();

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
    }
}