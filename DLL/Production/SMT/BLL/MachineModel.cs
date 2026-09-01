using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class MachineModel
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MODEL 信息。
        /// </summary>
        /// <param name="entity">MODEL 实体对象。</param>
        public Int32 Edit(MachineModelInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ModelID", SqlDbType.Int),
                new SqlParameter("@ModelName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Description", SqlDbType.NVarChar, 100),
                new SqlParameter("@MachineModelFamilyID", SqlDbType.Int),
                new SqlParameter("@MachineType", SqlDbType.NVarChar, 10),
                new SqlParameter("@Vendor", SqlDbType.NVarChar, 50),
                new SqlParameter("@Status", SqlDbType.NVarChar, 10),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
            };

            parms[0].Value = entity.ModelID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ModelName;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.MachineModelFamilyID;
            parms[4].Value = entity.MachineType;
            parms[5].Value = entity.Vendor;
            parms[6].Value = entity.Status;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModel_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MODELId 字符串删除 MODEL 信息。
        /// </summary>
        /// <param name="idString">MODELId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModel_Delete", parms);
        }

        /// <summary>
        /// 根据 MODELId 获取实体信息。
        /// </summary>
        /// <param name="mODELId">MODELId。</param>
        /// <returns>MODEL 实体对象。</returns>
        public MachineModelInfo GetInfo(Int32 mODELId)
        {
            MachineModelInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = mODELId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModel_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MachineModelInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6),rdr.GetString(7), rdr.GetDateTime(8),rdr.GetString(9), rdr.GetDateTime(10), rdr.GetString(11));

                    entity.ModelFamilyName = rdr.GetString(12);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MODEL 实体对象。</returns>
        public MachineModelInfo GetInfo(String fieldValue)
        {
            MachineModelInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MachineModel_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MODEL 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mODELCount">mODEL 总数。</param>
        /// <returns>MODEL 列表。</returns>
        public List<MachineModelInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MachineModelInfo> list = new List<MachineModelInfo>();
            MachineModelInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[Basal_MachineModel] A left join [Basal_MachineModelFamily] B ON B.ModelFamilyID=A.MachineModelFamilyID", "ModelID",
                "[ModelID], [ModelName], A.[Description], [MachineModelFamilyID], [MachineType], [Vendor], [Status],A.[CreateBy], A.[CreateDateTime],A.[ModifyBy],A.[ModifyDateTime],A.[Remark],isnull(B.[ModelFamilyName],'') ModelFamilyName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MachineModelInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetDateTime(10), rdr.GetString(11));
                    entity.ModelFamilyName = rdr.GetString(12);
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