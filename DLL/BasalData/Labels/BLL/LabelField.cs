using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Labels.Model;

namespace SKT.LeanMES.Labels.BLL
{
    public class LabelField
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） DF 信息。
        /// </summary>
        /// <param name="entity">DF 实体对象。</param>
        public void Edit(LabelFieldInfo entity, string s)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldDfID", SqlDbType.Int),
                new SqlParameter("@FieldDfName", SqlDbType.NVarChar, 20),
                new SqlParameter("@FieldDfDesc", SqlDbType.NVarChar, 50),
                new SqlParameter("@Definition", SqlDbType.VarChar, 2000),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateDateTime", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyDateTime", SqlDbType.DateTime),
                new SqlParameter("@DefDetail",SqlDbType.NVarChar,4000),
                new SqlParameter("@Font", SqlDbType.NVarChar, 10),
                new SqlParameter("@IsBold", SqlDbType.Bit)
            };

            parms[0].Value = entity.FieldDfID;
            parms[1].Value = entity.FieldDfName;
            parms[2].Value = entity.FieldDfDesc;
            parms[3].Value = entity.Definition;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = DateTime.Now;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = DateTime.Now;
            parms[8].Value = s;
            parms[9].Value = entity.Font;
            parms[10].Value = entity.IsBold;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_LabelFieldDF_Edit", parms);

        }

        /// <summary>
        /// 根据 DFId 字符串删除 DF 信息。
        /// </summary>
        /// <param name="idString">DFId 字符串。</param>
        /// <returns>日志内容。</returns>
        public string Delete(String idString, String userName)
        {
            string rs = "";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;


            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_LabelFieldDF_Delete", parms))
            {
                if (rdr.Read())
                {
                    rs = rdr.GetString(0);
                }
                rdr.Close();
            }
            return rs;
        }

        /// <summary>
        /// 根据 DFId 获取实体信息。
        /// </summary>
        /// <param name="dFId">DFId。</param>
        /// <returns>DF 实体对象。</returns>
        public DataTable GetInfo(Int32 LabelFieldDefId)
        {
            DataTable dt = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LabelFieldDefId", SqlDbType.Int)
            };

            parms[0].Value = LabelFieldDefId;

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Basal_LabelFieldDF_GetInfo", parms);

            return dt;
        }

        /// <summary>
        /// 分页获取 DF 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="dFCount">dF 总数。</param>
        /// <returns>DF 列表。</returns>
        public List<LabelFieldInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LabelFieldInfo> list = new List<LabelFieldInfo>();
            LabelFieldInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_LabelFieldDF", "FieldDfID",////Basal_LabelFieldDF
                "[FieldDfID], [FieldDfName], [FieldDfDesc], [Definition], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelFieldInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        ///根据表名找映射数据库名
        /// </summary>
        /// <param name="tbName"></param>
        /// <returns></returns>
        public DataTable GetDBField(string tbName)
        {
            DataTable dt = null;
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@TbName",SqlDbType.NVarChar,50)
            };
            parameters[0].Value = tbName;
            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Basal_LabelFieldDF_GetDBFields", parameters);
            return dt;
        }


        /// <summary>
        /// 根据ID找Basal_LabelField表数据
        /// </summary>
        /// <param name="labelId"></param>
        /// <returns></returns>
        public DataTable GetLabelFormatInfo(int labelId)
        {
            DataTable dt = null;
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@LabelId",SqlDbType.Int)
            };
            parameters[0].Value = labelId;
            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Basal_LabelFieldDF_GetLabelFormatInfo", parameters);
            return dt;
        }

        /// <summary>
        /// 根据ID找Basal_LabelField表数据
        /// </summary>
        /// <param name="labelId"></param>
        /// <returns></returns>
        public Dictionary<int, string> LabelSet(int labelId)
        {
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@LabelId",SqlDbType.Int)
            };
            parameters[0].Value = labelId;
            Dictionary<int, string> dic = new Dictionary<int, string>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, @"select t1.FieldDfID id,t2.FieldDfName name from Basal_LabelField t1 
inner join Basal_LabelFieldDF t2 on t1.fielddfid = t2.fielddfid
where t1.LabelFieldID =@LabelId", parameters))
            {
                while (rdr.Read())
                {
                    dic.Add(rdr.GetInt32(0), rdr.GetString(1));
                }
                rdr.Close();
            }
            return dic;
        }


        /// <summary>
        /// 添加标签格式
        /// </summary>
        /// <param name="labelId"></param>
        /// <param name="labelFieldId"></param>
        /// <param name="labelFieldName"></param>
        /// <param name="createBy"></param>
        public void AddLabelFormat(int labelId, int labelFieldId, string labelFieldName, string createBy)
        {
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@LabelId",SqlDbType.Int),
                new SqlParameter("@LabelFieldId",SqlDbType.Int),
                new SqlParameter("@LabelFieldName",SqlDbType.NVarChar,50),
                new SqlParameter("@CreateBy",SqlDbType.VarChar,20)
            };
            parameters[0].Value = labelId;
            parameters[1].Value = labelFieldId;
            parameters[2].Value = labelFieldName;
            parameters[3].Value = createBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_LabelFieldDF_AddLabelFormat", parameters);
        }

        /// <summary>
        /// 删除Label标签格式
        /// </summary>
        /// <param name="labelFieldId"></param>
        /// <param name="labelId"></param>
        /// <returns></returns>
        public string DeleteLabelFormat(int labelFieldId, int labelId, string userName)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@LabelId",SqlDbType.Int),
                new SqlParameter("@LabelFieldId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
            };
            parameters[0].Value = labelId;
            parameters[1].Value = labelFieldId;
            parameters[2].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_LabelFieldDF_DeleteLabelFormat", parameters))
            {
                if (rdr.Read())
                {
                    s = rdr.GetString(0);
                }
                rdr.Close();
            }
            return s;
        }

        /// <summary>
        /// 获取数据库表名
        /// </summary>
        /// <returns></returns>
        public DataTable GetDBTables()
        {
            DataTable dt = new DataTable();

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Basal_LabelFieldDF_GetDBTables", null);
            return dt;
        }

        /// <summary>
        /// 获取标签字段函数，函数以“UdfGetLBL_”开头，参数有：@UID INT,@StationID INT,@ResID INT,@LineID INT
        /// </summary>
        /// <returns></returns>
        public DataTable GetCustomFun()
        {
            DataTable dt = new DataTable();

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Basal_LabelFieldDF_GetCustomFun", null);
            return dt;
        }
    }
}