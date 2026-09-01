using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.DataType.Model;

namespace SKT.LeanMES.DataType.BLL
{
    public class DataField
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） FIELD 信息。
        /// </summary>
        /// <param name="entity">FIELD 实体对象。</param>
        public Int32 Edit(DataFieldInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DataFieldId", SqlDbType.Int),
                new SqlParameter("@DataTypeId", SqlDbType.Int),
                new SqlParameter("@DataField", SqlDbType.VarChar, 50),
                new SqlParameter("@DataTag", SqlDbType.VarChar, 30),
                new SqlParameter("@MaskGroup", SqlDbType.Int),
                new SqlParameter("@DataType", SqlDbType.VarChar, 10),
                new SqlParameter("@Required", SqlDbType.Bit),
                new SqlParameter("@Sequence", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),                
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),               
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.DataFieldId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.DataTypeId;
            parms[2].Value = entity.DataField;
            parms[3].Value = entity.DataTag;
            parms[4].Value = entity.MaskGroup;
            parms[5].Value = entity.DataType;
            parms[6].Value = entity.Required;
            parms[7].Value = entity.Sequence;
            parms[8].Value = entity.Remark;
            parms[9].Value = entity.ModifyBy;
            parms[10].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_DataField_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 FIELDId 字符串删除 FIELD 信息。
        /// </summary>
        /// <param name="idString">FIELDId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_DataField_Delete", parms);
        }

        /// <summary>
        /// 根据 FIELDId 获取实体信息。
        /// </summary>
        /// <param name="fIELDId">FIELDId。</param>
        /// <returns>FIELD 实体对象。</returns>
        public DataFieldInfo GetInfo(Int32 fIELDId)
        {
            DataFieldInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fIELDId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_DataField_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DataFieldInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetBoolean(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FIELD 实体对象。</returns>
        public DataFieldInfo GetInfo(String fieldValue)
        {
            DataFieldInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_DataField_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DataFieldInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetBoolean(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 FIELD 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="fIELDCount">fIELD 总数。</param>
        /// <returns>FIELD 列表。</returns>
        public List<DataFieldInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DataFieldInfo> list = new List<DataFieldInfo>();
            DataFieldInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "BasalDataField", "DataFieldId",
                "[DataFieldId], [DataTypeId], [DataField], [DataTag], [MaskGroup], [DataType], [Required], [Sequence], [Remark], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new DataFieldInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetBoolean(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
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
        /// data field is system datafield or not
        /// </summary>
        /// <param name="strField"></param>
        /// <returns></returns>
        public Int32 IsSystemDataField(string strField, int intSystemDataField)
        {
            SqlParameter[] parms = new SqlParameter[]{  
                new SqlParameter("@DataField", SqlDbType.VarChar, 50), 
                new SqlParameter("@SysDataField", SqlDbType.Int)
            };
            parms[0].Value = strField;
            parms[1].Value = intSystemDataField;
            parms[1].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspIsSystemDataField", parms);
            return (Int32)parms[1].Value;
        }

        /// <summary>
        /// get data field by data type ID
        /// </summary>
        /// <param name="fieldValue"></param>
        /// <returns></returns>
        public List<DataFieldInfo> GetAllByTID(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DataFieldInfo> list = new List<DataFieldInfo>();
            DataFieldInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwDataField", "DataFieldId",
                "[DataFieldId], [DataTypeId], [DataField], [DataTag], [MaskGroup], [DataType], [Required], [Sequence], [Remark], [ModifyTime], [ModifyPeople], [CreateDateTime], [CreateBy],[MaskGroupData]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new DataFieldInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetBoolean(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetString(13));
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取工站上对应的无物料数据类型
        /// </summary>
        /// <param name="sn">产品序列号</param>
        /// <param name="opeID">工序id</param>
        /// <returns>数据类型列表</returns>
        public List<DataFieldInfo> uspGetDataFieldBySNAndOpeID(string sn, int opeID)
        {
            List<DataFieldInfo> list = new List<DataFieldInfo>();
            DataFieldInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN", SqlDbType.NVarChar, 500), 
                new SqlParameter("@StationID", SqlDbType.Int)
            };

            parms[0].Value = sn;
            parms[1].Value = opeID;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetDataFieldBySNAndOpeID", parms))
            {
                while (rdr.Read())
                {
                    entity = new DataFieldInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetBoolean(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }
    }
}