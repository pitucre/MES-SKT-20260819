using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class MachineModelAttribute
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MODEL_ATTRIBUTE 信息。
        /// </summary>
        /// <param name="entity">MODEL_ATTRIBUTE 实体对象。</param>
        public Int32 Edit(MachineModelAttributeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ModelAttrID", SqlDbType.Int),
                new SqlParameter("@MachineModelID", SqlDbType.Int),
                new SqlParameter("@TablePosition", SqlDbType.TinyInt),
                new SqlParameter("@MachineTableType", SqlDbType.TinyInt),
                new SqlParameter("@StartSlotPosition", SqlDbType.SmallInt),
                new SqlParameter("@EndSlotPosition", SqlDbType.SmallInt),
                new SqlParameter("@Status", SqlDbType.NVarChar, 10),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
            };

            parms[0].Value = entity.ModelAttrID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MachineModelID;
            parms[2].Value = entity.TablePosition;
            parms[3].Value = entity.MachineTableType;
            parms[4].Value = entity.StartSlotPosition;
            parms[5].Value = entity.EndSlotPosition;
            parms[6].Value = entity.Status;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModelAttribute_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MODEL_ATTRIBUTEId 字符串删除 MODEL_ATTRIBUTE 信息。
        /// </summary>
        /// <param name="idString">MODEL_ATTRIBUTEId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModelAttribute_Delete", parms);
        }

        /// <summary>
        /// 根据 MODEL_ATTRIBUTEId 获取实体信息。
        /// </summary>
        /// <param name="mODEL_ATTRIBUTEId">MODEL_ATTRIBUTEId。</param>
        /// <returns>MODEL_ATTRIBUTE 实体对象。</returns>
        public MachineModelAttributeInfo GetInfo(Int32 mODEL_ATTRIBUTEId)
        {
            MachineModelAttributeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = mODEL_ATTRIBUTEId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModelAttribute_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MachineModelAttributeInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetByte(2), rdr.GetByte(3), rdr.GetInt16(4),
                        rdr.GetInt16(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetDateTime(10), rdr.GetString(11));
                    entity.MachineModelName = rdr.GetString(12);
                    entity.MachineTableTypeName = rdr.GetString(13);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MODEL_ATTRIBUTE 实体对象。</returns>
        public MachineModelAttributeInfo GetInfo(String fieldValue)
        {
            MachineModelAttributeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModelAttribute_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MODEL_ATTRIBUTE 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mODEL_ATTRIBUTECount">mODEL_ATTRIBUTE 总数。</param>
        /// <returns>MODEL_ATTRIBUTE 列表。</returns>
        public List<MachineModelAttributeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MachineModelAttributeInfo> list = new List<MachineModelAttributeInfo>();
            MachineModelAttributeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMachineModelAttr", "ModelAttrID",
                "[ModelAttrID], [MachineModelID], [TablePosition], [MachineTableType], [StartSlotPosition], [EndSlotPosition], [Status], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [ModelName], [MachineTableTypeName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MachineModelAttributeInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetByte(2), rdr.GetByte(3), rdr.GetInt16(4),
                        rdr.GetInt16(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetDateTime(10), rdr.GetString(11));
                    entity.MachineModelName = rdr.GetString(12);
                    entity.MachineTableTypeName = rdr.GetString(13);
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

    }
}