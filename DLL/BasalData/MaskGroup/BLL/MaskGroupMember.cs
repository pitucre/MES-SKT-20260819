using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.MaskGroup.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.MaskGroup.BLL
{
    public class MaskGroupMember
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） GROUP_MEMBER 信息。
        /// </summary>
        /// <param name="entity">GROUP_MEMBER 实体对象。</param>
        public Int32 Edit(MaskGroupMemberInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@MaskId", SqlDbType.Int),
                new SqlParameter("@Sequence", SqlDbType.Int),
                new SqlParameter("@MaskType", SqlDbType.Char, 1),
                new SqlParameter("@DisplayMask", SqlDbType.VarChar, 300),
                new SqlParameter("@RegularExpression", SqlDbType.VarChar, 300),
                new SqlParameter("@MinLength", SqlDbType.Int),
                new SqlParameter("@MaxLength", SqlDbType.Int),
                new SqlParameter("@ValidFrom", SqlDbType.DateTime),
                new SqlParameter("@ValidTo", SqlDbType.DateTime)
            };

            parms[0].Value = entity.ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MaskID;
            parms[2].Value = entity.Sequence;
            parms[3].Value = entity.MaskType;
            parms[4].Value = entity.DisplayMask;
            parms[5].Value = entity.RegularExpression;
            parms[6].Value = entity.MinLength;
            parms[7].Value = entity.MaxLength;
            parms[8].Value = entity.ValidFrom;
            parms[9].Value = entity.ValidTo;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Mask_GroupMember_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 GROUP_MEMBERId 字符串删除 GROUP_MEMBER 信息。
        /// </summary>
        /// <param name="idString">GROUP_MEMBERId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Mask_GroupMember_Delete", parms);
        }

        /// <summary>
        /// 根据 GROUP_MEMBERId 获取实体信息。
        /// </summary>
        /// <param name="gROUP_MEMBERId">GROUP_MEMBERId。</param>
        /// <returns>GROUP_MEMBER 实体对象。</returns>
        public MaskGroupMemberInfo GetInfo(Int32 gROUP_MEMBERId)
        {
            MaskGroupMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = gROUP_MEMBERId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Mask_GroupMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaskGroupMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetDateTime(8), rdr.GetDateTime(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>GROUP_MEMBER 实体对象。</returns>
        public MaskGroupMemberInfo GetInfo(String fieldValue)
        {
            MaskGroupMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Mask_GroupMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaskGroupMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4),
                       rdr.GetString(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetDateTime(8), rdr.GetDateTime(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 GROUP_MEMBER 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="gROUP_MEMBERCount">gROUP_MEMBER 总数。</param>
        /// <returns>GROUP_MEMBER 列表。</returns>
        public List<MaskGroupMemberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaskGroupMemberInfo> list = new List<MaskGroupMemberInfo>();
            MaskGroupMemberInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Mask_GroupMember", "Id",
                "[Id], [MaskId], [Sequence], [MaskType], [DisplayMask], [RegularExpression], [MinLength], [MaxLength], [ValidFrom], [ValidTo]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaskGroupMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetInt32(7),rdr.GetDateTime(8), rdr.GetDateTime(9));

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