using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.MaskGroup.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;


namespace SKT.LeanMES.MaskGroup.BLL
{
    public class MaskGroup
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） GROUP 信息。
        /// </summary>
        /// <param name="entity">GROUP 实体对象。</param>
        public Int32 Edit(MaskGroupInfo entity, string action, Int32 oldRecordId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaskID", SqlDbType.Int),
                new SqlParameter("@MaskGroup", SqlDbType.NVarChar, 20),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),                
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),                
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Action",SqlDbType.VarChar,20),
                new SqlParameter("@OldRecordId",SqlDbType.Int)
            };

            parms[0].Value = entity.MaskID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MaskGroup;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.Remark;            
            parms[4].Value = entity.ModifyBy;            
            parms[5].Value = entity.CreateBy;
            parms[6].Value = action;
            parms[7].Value = oldRecordId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Mask_Group_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 GROUPId 字符串删除 GROUP 信息。
        /// </summary>
        /// <param name="idString">GROUPId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Mask_Group_Delete", parms);
        }

        /// <summary>
        /// 根据 GROUPId 获取实体信息。
        /// </summary>
        /// <param name="gROUPId">GROUPId。</param>
        /// <returns>GROUP 实体对象。</returns>
        public MaskGroupInfo GetInfo(Int32 gROUPId)
        {
            MaskGroupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = gROUPId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Mask_Group_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaskGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>GROUP 实体对象。</returns>
        public MaskGroupInfo GetInfo(String fieldValue)
        {
            MaskGroupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Mask_Group_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaskGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 GROUP 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="gROUPCount">gROUP 总数。</param>
        /// <returns>GROUP 列表。</returns>
        public List<MaskGroupInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaskGroupInfo> list = new List<MaskGroupInfo>();
            MaskGroupInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_Mask_Group", "MaskID",////Basal_Mask_Group
                "[MaskID], [MaskGroup], [Description], [Remark], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaskGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));

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