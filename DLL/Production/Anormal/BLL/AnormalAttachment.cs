using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.ProdAnormal.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.ProdAnormal.BLL
{
    public class AnormalAttachment
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AnormalAttachment 信息。
        /// </summary>
        /// <param name="entity">AnormalAttachment 实体对象。</param>
        public Int32 Edit(AnormalAttachmentInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AnormalAttachmentId", SqlDbType.Int),
                new SqlParameter("@AnormalId", SqlDbType.Int),
                new SqlParameter("@AttachmentName", SqlDbType.NVarChar, 100),
                new SqlParameter("@AttachmentPhysicalName", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20)
            };

            parms[0].Value = entity.AnormalAttachmentId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.AnormalId;
            parms[2].Value = entity.AttachmentName;
            parms[3].Value = entity.AttachmentPhysicalName;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalAttachment_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AnormalAttachmentId 字符串删除 AnormalAttachment 信息。
        /// </summary>
        /// <param name="idString">AnormalAttachmentId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalAttachment_Delete", parms);
        }

        /// <summary>
        /// 根据 AnormalAttachmentId 获取实体信息。
        /// </summary>
        /// <param name="anormalAttachmentId">AnormalAttachmentId。</param>
        /// <returns>AnormalAttachment 实体对象。</returns>
        public AnormalAttachmentInfo GetInfo(Int32 anormalAttachmentId)
        {
            AnormalAttachmentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = anormalAttachmentId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalAttachment_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalAttachmentInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AnormalAttachment 实体对象。</returns>
        public AnormalAttachmentInfo GetInfo(String fieldValue)
        {
            AnormalAttachmentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalAttachment_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalAttachmentInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AnormalAttachment 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="anormalAttachmentCount">anormalAttachment 总数。</param>
        /// <returns>AnormalAttachment 列表。</returns>
        public List<AnormalAttachmentInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AnormalAttachmentInfo> list = new List<AnormalAttachmentInfo>();
            AnormalAttachmentInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_AnormalAttachment", "AnormalAttachmentId",
                "[AnormalAttachmentId], [AnormalId], [AttachmentName], [AttachmentPhysicalName], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AnormalAttachmentInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
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

    }
}