using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Anormal.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Anormal.BLL
{
    public class AnormalGroup
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Anormal_Type 信息。
        /// </summary>
        /// <param name="entity">Anormal_Type 实体对象。</param>
        public Int32 Edit(AnormalGroupInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AnormalGroupId", SqlDbType.Int),
                new SqlParameter("@AnormalGroupCode", SqlDbType.VarChar, 20),
                new SqlParameter("@AnormalGroupName", SqlDbType.VarChar, 20),
                new SqlParameter("@ControlShow", SqlDbType.NVarChar,50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.AnormalGroupId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.AnormalGroupCode;
            parms[2].Value = entity.AnormalGroupName;
            parms[3].Value = entity.ControlShow;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Group_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 Anormal_TypeId 字符串删除 Anormal_Type 信息。
        /// </summary>
        /// <param name="idString">Anormal_TypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Group_Delete", parms);
        }

        /// <summary>
        /// 根据 Anormal_TypeId 获取实体信息。
        /// </summary>
        /// <param name="anormal_GroupId">Anormal_GroupId。</param>
        /// <returns>Anormal_Group 实体对象。</returns>
        public AnormalGroupInfo GetInfo(Int32 anormal_GroupId)
        {
            AnormalGroupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = anormal_GroupId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Group_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Anormal_Group 实体对象。</returns>
        public AnormalGroupInfo GetInfo(String fieldValue)
        {
            AnormalGroupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Group_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Anormal_Type 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="anormal_TypeCount">anormal_Type 总数。</param>
        /// <returns>Anormal_Type 列表。</returns>
        public List<AnormalGroupInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AnormalGroupInfo> list = new List<AnormalGroupInfo>();
            AnormalGroupInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_Anormal_Group", "AnormalGroupId",////Basal_Anormal_Group
                "[AnormalGroupId], [AnormalGroupCode], [AnormalGroupName], [ControlShow], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AnormalGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));

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