using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.ClientConfig.Model;

namespace SKT.LeanMES.ClientConfig.BLL
{
    public class UsersInStation
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） UsersInStation 信息。
        /// </summary>
        /// <param name="entity">UsersInStation 实体对象。</param>
        public Int32 Edit(UsersInStationInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UsersInStationId", SqlDbType.Int),
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@IsDefault", SqlDbType.TinyInt),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.UsersInStationId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.UserId;
            parms[2].Value = entity.StationId;
            parms[3].Value = entity.LineId;
            parms[4].Value = entity.ResId;
            parms[5].Value = entity.IsDefault;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_UsersInStation_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 UsersInStationId 字符串删除 UsersInStation 信息。
        /// </summary>
        /// <param name="idString">UsersInStationId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_UsersInStation_Delete", parms);
        }

        /// <summary>
        /// 根据 UsersInStationId 获取实体信息。
        /// </summary>
        /// <param name="usersInStationId">UsersInStationId。</param>
        /// <returns>UsersInStation 实体对象。</returns>
        public UsersInStationInfo GetInfo(Int32 usersInStationId)
        {
            UsersInStationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = usersInStationId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_UsersInStation_GetInfo", parms))
            {
                if (rdr.HasRows)
                {
                    entity = Helper.SqlDataReaderConverToList<UsersInStationInfo>(rdr)[0];
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>UsersInStation 实体对象。</returns>
        public UsersInStationInfo GetInfo(String fieldValue)
        {
            UsersInStationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_UsersInStation_GetInfo", parms))
            {
                if (rdr.HasRows)
                {
                    entity = Helper.SqlDataReaderConverToList<UsersInStationInfo>(rdr)[0];
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 UsersInStation 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="usersInStationCount">usersInStation 总数。</param>
        /// <returns>UsersInStation 列表。</returns>
        public List<UsersInStationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<UsersInStationInfo> list = new List<UsersInStationInfo>();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetUsersInStationInfo", "UsersInStationId",
                "UsersInStationId,UserId,UserName,StationId,Station,LineId,LineName,ResId,ResName,IsDefault,CreateDateTime,CreateBy", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                if (rdr.HasRows)
                {
                    list = Helper.SqlDataReaderConverToList<UsersInStationInfo>(rdr);
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