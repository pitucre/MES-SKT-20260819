using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SDP.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.Script.Serialization;
using System.Collections;
using System.Text;

namespace SKT.LeanMES.SDP.BLL
{
    public class UIModel
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） UIModel 信息。
        /// </summary>
        /// <param name="entity">UIModel 实体对象。</param>
        public Int32 Edit(UIModelInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ModelId", SqlDbType.Int),
                new SqlParameter("@ModelName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Content", SqlDbType.VarChar, -1),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ModelId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ModelName;
            parms[2].Value = entity.Content;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_UIModel_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 UIModelId 字符串删除 UIModel 信息。
        /// </summary>
        /// <param name="idString">UIModelId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_UIModel_Delete", parms);
        }

        /// <summary>
        /// 根据 UIModelId 获取实体信息。
        /// </summary>
        /// <param name="uIModelId">UIModelId。</param>
        /// <returns>UIModel 实体对象。</returns>
        public UIModelInfo GetInfo(Int32 uIModelId)
        {
            UIModelInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = uIModelId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_UIModel_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new UIModelInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6));
                    entity.StationId = rdr.GetInt32(7);
                    entity.Station = rdr.GetString(8);
                    entity.ModelType = rdr.GetInt32(9);
                    entity.ModelClass = rdr.GetString(10);
                    entity.PopedomId = rdr.GetInt32(11);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>UIModel 实体对象。</returns>
        public UIModelInfo GetInfo(String fieldValue)
        {
            UIModelInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_UIModel_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new UIModelInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6));
                    entity.StationId = rdr.GetInt32(7);
                    entity.Station = rdr.GetString(8);
                    entity.ModelType = rdr.GetInt32(9);
                    entity.ModelClass = rdr.GetString(10);
                    entity.PopedomId = rdr.GetInt32(11);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 UIModel 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="uIModelCount">uIModel 总数。</param>
        /// <returns>UIModel 列表。</returns>
        public List<UIModelInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<UIModelInfo> list = new List<UIModelInfo>();
            UIModelInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSDP_UIModel", "ModelId",
                @"[ModelId], [ModelName], [Content], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], 
                    CASE WHEN ModelType=2 THEN 'UI' ELSE 'PDA' END AS ModelTypeName, ModelClass ", 
                searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new UIModelInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6));
                    entity.ModelTypeName = rdr.GetString(7);
                    entity.ModelClass = rdr.GetString(8);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public UIModelInfo GetModelTempInfo(int TempId)
        {            
            UIModelInfo entity = null;
            string sqlText = "SELECT ModelTempId,  ModelType AS ModelClass, ModelName, Url, CreateBy, CreateDateTime, ModifyBy, ModifyDateTime,Content FROM SDP_PDAUIModelTemp where ModelTempId=" + TempId.ToString();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlText))
            {
                if (rdr.Read())
                {
                    entity = new UIModelInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetDateTime(5),
                        rdr.GetString(6), rdr.GetDateTime(7));
                    entity.Content = rdr.GetString(8);                    
                }
                rdr.Close();
            }
            return entity;
        }

        public Int64 SavePDAPreview(string Content)
        {
            Int64 ID = -1;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Content", SqlDbType.NVarChar, -1)
            };
            parms[0].Value = Content;
            
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PDAFunctionTempInDB_Add", parms))
            {
                if (rdr.Read())
                {
                    ID = rdr.GetInt64(0);
                }
                rdr.Close();
            }
            return ID;
        }

        public string GetPDAPreview(Int64 ID)
        {
            string Content = "";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.BigInt)
            };
            parms[0].Value = ID;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PDAFunctionTempInDB_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    Content = rdr.GetString(0);
                }
                rdr.Close();
            }
            return Content;
        }

        public string GetPDAModelContent(Int32 ID)
        {
            string Content = "";
            string sqlText = string.Format("SELECT Content FROM SDP_UIModel WITH(NOLOCK) WHERE ModelId = {0}", ID);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlText))
            {
                if (rdr.Read())
                {
                    Content = rdr.GetString(0);
                }
                rdr.Close();
            }
            return Content;
        }

        public List<UIModelInfo> GetPDAFunction(string ModelName)
        {
            List<UIModelInfo> list = new List<UIModelInfo>();
            UIModelInfo entity = null;
            string sqlText = string.Format("Select [ModelId], [ModelName], ModelClass from SDP_UIModel where ModelType = 4 AND ModelClass='{0}' ", ModelName);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlText))
            {
                while (rdr.Read())
                {
                    entity = new UIModelInfo()
                    {
                        ModelId = rdr.GetInt32(0),
                        ModelName = rdr.GetString(1),
                        ModelClass = rdr.GetString(2)
                    };
                    
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public List<UIModelInfo> GetAll()
        {
            List<UIModelInfo> list = new List<UIModelInfo>();
            UIModelInfo entity = null;
            string sqlText = "select [ModelId], [ModelName], [Content], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime] from SDP_UIModel where ModelType = 2 ";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlText))
            {
                while (rdr.Read())
                {
                    entity = new UIModelInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6));

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        public int Save(string model, string uiName, int id, int stationid)
        {
            if (string.IsNullOrEmpty(model) || string.IsNullOrEmpty(uiName))
            {
                return -1;
            }
            UIModelSave m = JsonConvert.DeserializeObject<UIModelSave>(model);
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@id", SqlDbType.Int),
                new SqlParameter("@fields", SqlDbType.VarChar),
                new SqlParameter("@name", SqlDbType.NVarChar),
                new SqlParameter("@template", SqlDbType.NVarChar),
                new SqlParameter("@parse", SqlDbType.NVarChar),
                new SqlParameter("@data", SqlDbType.NVarChar),
                new SqlParameter("@add_fields", SqlDbType.NVarChar),
                new SqlParameter("@stationid", SqlDbType.Int)
            };
            parms[0].Value = id;
            parms[1].Value = m.fields;
            parms[2].Value = uiName;
            parms[3].Value = m.template.ToString();
            parms[4].Value = m.parse.ToString();
            parms[5].Value = JsonConvert.SerializeObject(m.data);
            parms[6].Value = m.add_fields.ToString();
            parms[7].Value = stationid;
            int result = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_UIModel_Save", parms);

            return result;

        }

        #region 用户自定义HTML二次开发

        #region UI查询

        /// <summary>
        /// UI调用查询并返回JSON字符串结果
        /// </summary>
        /// <param name="procName">表/视图/存储过程的名称</param>
        /// <param name="fieldStr">对表/视图有效</param>
        /// <param name="conditionStr">对表/视图有效</param>
        /// <param name="jsonParams">对存储过程有效</param>
        /// <returns></returns>
        public string Search(string procName, string fieldStr, string conditionStr, string jsonParams)
        {
            string json = "";
            string sqlStr = "";
            string typeStr = GetFuncType(procName).ToLower().Trim();

            DataSet dataSet = new DataSet();
            try
            {
                if (typeStr == "p")
                {
                    SqlParameter[] paras = GetSqlParameterInfo(procName, jsonParams);
                    dataSet = CommonHelper.BLL.ComMethod.GetListDataSet(procName, paras);
                }
                else
                {
                    sqlStr = "select " + fieldStr + " from " + procName + " where " + conditionStr;
                    dataSet = CommonHelper.BLL.ComMethod.GetListDataSetBySql(sqlStr, null);
                }

                if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                {
                    json = ToJson(dataSet);
                }
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    throw ex.InnerException;
                }
                else
                {
                    throw ex;
                }
            }
            return json;
        }

        /// 检测函数属于方法函数还是存储过程
        /// </summary>
        /// <param name="funcName"></param>
        /// <returns></returns>
        private string GetFuncType(string funcName)
        {
            string result = "";
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@name",SqlDbType.NVarChar,50)
            };
            parms[0].Value = funcName;

            string sql = "SELECT type FROM sys.sysobjects WHERE name=@name";

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                if (rdr.Read())
                {
                    result = rdr.GetString(0);
                }
            }
            return result;
        }
        #endregion

        #region UI自定义存储过程执行

        /// <summary>
        /// 执行存储过程，返回值
        /// </summary>
        /// <param name="procName"></param>
        /// <param name="jsonParams"></param>
        /// <returns></returns>
        public List<string> ExecProc(string procName, string jsonParams)
        {
            List<string> list = new List<string>();
            SqlParameter param;
            try
            {
                SqlParameter[] paras = GetSqlParameterInfo(procName, jsonParams);

                //调用存储过程
                //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, procName, paras);
                DataSet dataSet = CommonHelper.BLL.ComMethod.GetListDataSet(procName, paras);

                for (int j = 0; j < paras.Length; j++)
                {
                    param = paras[j];
                    if (param.Direction == ParameterDirection.InputOutput)
                    {
                        list.Add(paras[j].Value.ToString());
                    }
                }
                if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                {
                    list.Add(ToJson(dataSet));
                }
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    throw ex.InnerException;
                }
                else
                {
                    throw ex;
                }                
            }
            //有返回参数的返回数值
            return list;
        }

        /// <summary>
        /// 验证程序传递参数与存储过程参数
        /// </summary>
        /// <param name="procName"></param>
        /// <param name="jsonParams"></param>
        /// <returns></returns>
        public SqlParameter[] GetSqlParameterInfo(string procName, string jsonParams)
        {
            string errorMsg = "";
            //获取参数的名称和值
            //var paramsList = CommonHelper.BLL.ComMethod.JsonToEntities<ParamsInfo>(jsonParams);
            var paramsList = GetJsonParam(jsonParams);

            //验证参数名称是否与存储过程所需一致
            var procParamsList = GetProcParams(procName);
            if (paramsList.Count != procParamsList.Count)
            {
                errorMsg = "当前传递的参数和存储过程[" + procName + "]所需参数个数不一致！";
                throw new Exception(errorMsg);
            }

            ProcParamsInfo entity;
            SqlParameter[] paras = new SqlParameter[procParamsList.Count];
            SqlParameter param;

            for (int i = 0; i < procParamsList.Count; i++)
            {
                entity = procParamsList[i];

                if (entity.ParamName.ToLower() != paramsList[i].name.ToLower())
                {
                    errorMsg = "当前传递的第" + (i + 1) + "个参数[" + paramsList[i].name + "]和存储过程[" + procName + "]所需参数[" + entity.ParamName + "]不一致！";
                    throw new Exception(errorMsg);
                }
                else
                {
                    //创建存储过程参数数组
                    param = new SqlParameter();
                    param.ParameterName = entity.ParamName;
                    try
                    {
                        param.SqlDbType = (SqlDbType)Enum.Parse(typeof(SqlDbType), entity.DataType, true);
                        param.Value = paramsList[i].value;
                    }
                    catch (Exception)
                    {
                        param.SqlDbType = SqlDbType.Structured;
                        param.Value = JsonToTable("[" + paramsList[i].value + "]");
                    }

                    if (entity.Length > 0)
                    {
                        param.Size = entity.Length;
                        param.Precision = Convert.ToByte(entity.Length > 255 ? 255 : entity.Length);
                        param.Scale = Convert.ToByte(entity.Scale);
                    }
                    param.Direction = entity.IsOutput == true ? ParameterDirection.InputOutput : ParameterDirection.Input;


                    paras[i] = param;
                }
            }

            return paras;
        }

        /// <summary>
        /// 获取JSON参数和值
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        private List<ParamsInfo> GetJsonParam(string json)
        {
            dynamic d = new System.Dynamic.ExpandoObject();

            JavaScriptSerializer jss = new JavaScriptSerializer();
            object obj = jss.DeserializeObject(json);
            IDictionary<string, object> dic = (IDictionary<string, object>)obj;
            List<ParamsInfo> list = new List<ParamsInfo>();
            ParamsInfo entity = null;
            foreach (var item in dic)
            {
                entity = new ParamsInfo();
                entity.name = "@" + item.Key;
                entity.value = item.Value.ToString();
                if (item.Value.GetType().Name.Contains("Dictionary"))
                {
                    entity.value = JsonConvert.SerializeObject(item.Value);
                }
                list.Add(entity);
            }
            return list;
        }

        #endregion

        #region DataSet/DataTable转Json 

        /// <summary>
        /// Json 字符串 转换为 DataTable数据集合
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        public static DataTable JsonToTable(string json)
        {
            DataTable dataTable = new DataTable();  //实例化
            DataTable result;
            try
            {
                JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
                javaScriptSerializer.MaxJsonLength = Int32.MaxValue; //取得最大数值
                ArrayList arrayList = javaScriptSerializer.Deserialize<ArrayList>(json);
                if (arrayList.Count > 0)
                {
                    foreach (Dictionary<string, object> dictionary in arrayList)
                    {
                        if (dictionary.Keys.Count == 0)
                        {
                            result = dataTable;
                            return result;
                        }
                        if (dataTable.Columns.Count == 0)
                        {
                            foreach (string current in dictionary.Keys)
                            {
                                dataTable.Columns.Add(current, dictionary[current].GetType());
                            }
                        }
                        DataRow dataRow = dataTable.NewRow();
                        foreach (string current in dictionary.Keys)
                        {
                            dataRow[current] = dictionary[current];
                        }

                        dataTable.Rows.Add(dataRow); //循环添加行到DataTable中
                    }
                }
            }
            catch
            {
            }
            result = dataTable;
            return result;
        }

        /// <summary>
        /// 获取存储过程的参数
        /// </summary>
        /// <param name="procName"></param>
        /// <returns></returns>
        public List<ProcParamsInfo> GetProcParams(string procName)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@ProcName",SqlDbType.NVarChar)
            };

            parms[0].Value = procName;

            var list = CommonHelper.BLL.ComMethod.GetList<ProcParamsInfo>("uspGetProcParams", parms);

            return list;
        }

        /// <summary>    
        /// DataSet转换为Json   
        /// </summary>    
        /// <param name="dataSet">DataSet对象</param>   
        /// <returns>Json字符串</returns>    
        public static string ToJson(DataSet dataSet)
        {
            string jsonString = "";
            if (dataSet.Tables.Count > 1)
            {
                jsonString = "[";
                foreach (DataTable table in dataSet.Tables)
                {
                    //jsonString += "\"" + table.TableName + "\":" + ToJson(table) + ",";
                    jsonString += ToJson(table) + ",";
                }
                jsonString = jsonString.TrimEnd(',');
                jsonString = jsonString + "]";
            }
            else
            {
                jsonString = ToJson(dataSet.Tables[0]);
            }
            return jsonString;
        }

        /// <summary>     
        /// Datatable转换为Json     
        /// </summary>    
        /// <param name="table">Datatable对象</param>     
        /// <returns>Json字符串</returns>     
        public static string ToJson(DataTable dt)
        {
            StringBuilder jsonString = new StringBuilder();
            jsonString.Append("[");
            DataRowCollection drc = dt.Rows;
            for (int i = 0; i < drc.Count; i++)
            {
                jsonString.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string strKey = dt.Columns[j].ColumnName;
                    string strValue = drc[i][j].ToString();
                    Type type = dt.Columns[j].DataType;
                    jsonString.Append("\"" + strKey + "\":");
                    strValue = StringFormat(strValue, type);
                    if (j < dt.Columns.Count - 1)
                    {
                        jsonString.Append(strValue + ",");
                    }
                    else
                    {
                        jsonString.Append(strValue);
                    }
                }
                jsonString.Append("},");
            }
            jsonString.Remove(jsonString.Length - 1, 1);
            jsonString.Append("]");
            return jsonString.ToString();
        }

        /// <summary>
        /// 格式化字符型、日期型、布尔型
        /// </summary>
        /// <param name="str"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        private static string StringFormat(string str, Type type)
        {
            if (type == typeof(string))
            {
                str = String2Json(str);
                str = "\"" + str + "\"";
            }
            else if (type == typeof(DateTime))
            {
                str = "\"" + str + "\"";
            }
            else if (type == typeof(bool))
            {
                str = str.ToLower();
            }
            else if (type != typeof(string) && string.IsNullOrEmpty(str))
            {
                str = "\"" + str + "\"";
            }
            else if (type == typeof(Guid))//by liwen 20200723 修正GUID类型序列化问题
            {
                str = "\"" + str + "\"";
            }
            return str;
        }

        /// <summary>
        /// 过滤特殊字符
        /// </summary>
        /// <param name="s">字符串</param>
        /// <returns>json字符串</returns>
        private static string String2Json(String s)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < s.Length; i++)
            {
                char c = s.ToCharArray()[i];
                switch (c)
                {
                    case '\"':
                        sb.Append("\\\""); break;
                    case '\\':
                        sb.Append("\\\\"); break;
                    case '/':
                        sb.Append("\\/"); break;
                    case '\b':
                        sb.Append("\\b"); break;
                    case '\f':
                        sb.Append("\\f"); break;
                    case '\n':
                        sb.Append("\\n"); break;
                    case '\r':
                        sb.Append("\\r"); break;
                    case '\t':
                        sb.Append("\\t"); break;
                    default:
                        sb.Append(c); break;
                }
            }
            return sb.ToString();
        }

        #endregion

        #region 后台高级UI模板设计执行

        /// <summary>
        /// 保存用户自定义HTML代码
        /// </summary>
        /// <param name="id"></param>
        /// <param name="uiName"></param>
        /// <param name="template"></param>
        /// <param name="stationId"></param>
        /// <param name="popedomId">内置模板ID</param>
        public void UDFSave(int id, string uiName, string template, string className, int stationId,string createBy,int popedomId=-1)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@Name", SqlDbType.NVarChar),
                new SqlParameter("@Template", SqlDbType.NVarChar),
                new SqlParameter("@ClassName", SqlDbType.NVarChar),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar),
                new SqlParameter("@PopedomId", SqlDbType.Int)

            };
            parms[0].Value = id;
            parms[1].Value = uiName;
            parms[2].Value = template;
            parms[3].Value = className;
            parms[4].Value = stationId;
            parms[5].Value = createBy;
            parms[6].Value = popedomId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_UIModel_UDFSave", parms);
        }


        /// <summary>
        /// 获取内置UI的地址
        /// </summary>
        /// <param name="popedom"></param>
        /// <returns></returns>
        public string GetTemplateUrl(string popedom)
        {
            string url = "";

            string sqlText = "SELECT url FROM dbo.Framework_Pages WHERE Popedom='" + popedom + "'";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlText))
            {
                if (rdr.Read())
                {
                    url = rdr.GetString(0);
                }
                rdr.Close();
            }
            return url;
        }

        public List<UIModelInfo> GetAllTempModel()
        {
            List<UIModelInfo> list = new List<UIModelInfo>();
            UIModelInfo entity = null;
            string sqlText = "select ModelTempId, ModelType as ModelClass, ModelName, Url, CreateBy, CreateDateTime, ModifyBy, ModifyDateTime from SDP_PDAUIModelTemp";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlText))
            {
                while (rdr.Read())
                {
                    entity = new UIModelInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetDateTime(5),
                        rdr.GetString(6), rdr.GetDateTime(7));

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        #endregion

        #endregion

        public DataTable GetTable(string proc, string xml)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@xml", SqlDbType.Xml)
            };
            parms[0].Value = xml;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, proc, parms);
        }
        public string Edit(string proc, string setXml, string whereXml)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@setXml", SqlDbType.Xml),
                new SqlParameter("@whereXml", SqlDbType.Xml),
                new SqlParameter("@text",  SqlDbType.NVarChar,200)
            };
            parms[0].Value = setXml;
            parms[1].Value = whereXml;
            parms[2].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, proc, parms);
            return parms[2].Value.ToString();
        }
    }
}