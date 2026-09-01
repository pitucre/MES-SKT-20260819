using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class MachineModelFamily
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MODEL_FAMILY 信息。
        /// </summary>
        /// <param name="entity">MODEL_FAMILY 实体对象。</param>
        public Int32 Edit(MachineModelFamilyInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ModelFamilyID", SqlDbType.Int),
                new SqlParameter("@ModelFamilyName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Description", SqlDbType.NVarChar, 100),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
            };

            parms[0].Value = entity.ModelFamilyID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ModelFamilyName;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.ModifyBy;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModelFamily_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MODEL_FAMILYId 字符串删除 MODEL_FAMILY 信息。
        /// </summary>
        /// <param name="idString">MODEL_FAMILYId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModelFamily_Delete", parms);
        }

        /// <summary>
        /// 根据 MODEL_FAMILYId 获取实体信息。
        /// </summary>
        /// <param name="mODEL_FAMILYId">MODEL_FAMILYId。</param>
        /// <returns>MODEL_FAMILY 实体对象。</returns>
        public MachineModelFamilyInfo GetInfo(Int32 mODEL_FAMILYId)
        {
            MachineModelFamilyInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = mODEL_FAMILYId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModelFamily_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MachineModelFamilyInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MODEL_FAMILY 实体对象。</returns>
        public MachineModelFamilyInfo GetInfo(String fieldValue)
        {
            MachineModelFamilyInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModelFamily_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MODEL_FAMILY 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mODEL_FAMILYCount">mODEL_FAMILY 总数。</param>
        /// <returns>MODEL_FAMILY 列表。</returns>
        public List<MachineModelFamilyInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MachineModelFamilyInfo> list = new List<MachineModelFamilyInfo>();
            MachineModelFamilyInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_MachineModelFamily", "ModelFamilyID",
                "[ModelFamilyID], [ModelFamilyName], [Description],[CreateBy],[CreateDateTime],[ModifyBy],[ModifyDateTime],[Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MachineModelFamilyInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));

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