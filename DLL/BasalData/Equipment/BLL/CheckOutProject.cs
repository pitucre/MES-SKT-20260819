using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class CheckOutProject
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） CheckOutProject 信息。
        /// </summary>
        /// <param name="entity">CheckOutProject 实体对象。</param>
        public Int32 Edit(CheckOutProjectInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CheckOutProjectId", SqlDbType.Int),
                new SqlParameter("@CheckOutProjectName", SqlDbType.VarChar, 50),
                new SqlParameter("@IsEnable", SqlDbType.Bit),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.CheckOutProjectId;
            parms[1].Value = entity.CheckOutProjectName;
            parms[2].Value = entity.IsEnable;
            parms[3].Value = entity.Remark;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Equipment_CheckOutProject_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 CheckOutProjectId 字符串删除 CheckOutProject 信息。
        /// </summary>
        /// <param name="idString">CheckOutProjectId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Equipment_CheckOutProject_Delete", parms);
        }

        /// <summary>
        /// 根据 CheckOutProjectId 获取实体信息。
        /// </summary>
        /// <param name="checkOutProjectId">CheckOutProjectId。</param>
        /// <returns>CheckOutProject 实体对象。</returns>
        public CheckOutProjectInfo GetInfo(Int32 checkOutProjectId)
        {
            CheckOutProjectInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = checkOutProjectId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Equipment_CheckOutProject_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CheckOutProjectInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetBoolean(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>CheckOutProject 实体对象。</returns>
        public CheckOutProjectInfo GetInfo(String fieldValue)
        {
            CheckOutProjectInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Equipment_CheckOutProject_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CheckOutProjectInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetBoolean(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 CheckOutProject 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="checkOutProjectCount">checkOutProject 总数。</param>
        /// <returns>CheckOutProject 列表。</returns>
        public List<CheckOutProjectInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CheckOutProjectInfo> list = new List<CheckOutProjectInfo>();
            CheckOutProjectInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwEquipment_CheckOutProject", "CheckOutProjectId",
                "[CheckOutProjectId], [CheckOutProjectName], [IsEnable], [Remark], [CreateBy], [CreateDateTime],ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CheckOutProjectInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetBoolean(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5));
                    entity.IsEnableName = entity.IsEnable ? "启用" : "未启用";
                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime")))
                    {
                        entity.ModifyBy = rdr["ModifyBy"].ToString();
                        entity.ModifyTime = Convert.ToDateTime(rdr["ModifyTime"]);
                    }
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