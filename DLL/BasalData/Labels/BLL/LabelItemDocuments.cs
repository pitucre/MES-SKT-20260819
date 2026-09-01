using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Labels.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Labels.BLL
{
    public class LabelItemDocuments
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新） LabelItemDocuments 信息。
        /// </summary>
        /// <param name="entity">LabelItemDocuments 实体对象。</param>
        public Int32 Edit(LabelItemDocumentsInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemDocId", SqlDbType.Int),
                new SqlParameter("@ItemID", SqlDbType.Int),
                new SqlParameter("@DocID", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@TypeId", SqlDbType.Int),
                new SqlParameter("@Sequence", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@PrintSort", SqlDbType.Int)
            };

            parms[0].Value = entity.ItemDocId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ItemID;
            parms[2].Value = entity.DocID;
            parms[3].Value = entity.StationId;
            parms[4].Value = entity.TypeId;
            parms[5].Value = entity.Sequence;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.PrintSort;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemDocuments_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ItemDocumentsId 字符串删除 LabelItemDocuments 信息。
        /// </summary>
        /// <param name="idString">ItemDocumentsId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemDocuments_Delete", parms);
        }

        /// <summary>
        /// 根据 ItemDocumentsId 获取实体信息。
        /// </summary>
        /// <param name="itemDocumentsId">ItemDocumentsId。</param>
        /// <returns>LabelItemDocuments 实体对象。</returns>
        public LabelItemDocumentsInfo GetInfo(Int32 itemDocumentsId)
        {
            LabelItemDocumentsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = itemDocumentsId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ItemDocuments_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LabelItemDocumentsInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(3), rdr.GetInt32(5), 
                        rdr.GetInt32(7), rdr.GetInt32(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), 
                        rdr.GetDateTime(13));
                    entity.ItemName = rdr.IsDBNull(2) ? "" : rdr.GetString(2);
                    entity.DocumentName = rdr.IsDBNull(4) ? "" : rdr.GetString(4);
                    entity.Station = rdr.IsDBNull(6) ? "" : rdr.GetString(6);
                    entity.TypeName = rdr.IsDBNull(8) ? "" : rdr.GetString(8);
                    entity.PrintSort = rdr.IsDBNull(14) ? 0 : rdr.GetInt32(14);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LabelItemDocuments 实体对象。</returns>
        public LabelItemDocumentsInfo GetInfo(String fieldValue)
        {
            LabelItemDocumentsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ItemDocuments_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LabelItemDocumentsInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(3), rdr.GetInt32(5), 
                        rdr.GetInt32(7), rdr.GetInt32(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), 
                        rdr.GetDateTime(13));
                    entity.ItemName = rdr.IsDBNull(2) ? "" : rdr.GetString(2);
                    entity.DocumentName = rdr.IsDBNull(4) ? "" : rdr.GetString(4);
                    entity.Station = rdr.IsDBNull(6) ? "" : rdr.GetString(6);
                    entity.TypeName = rdr.IsDBNull(8) ? "" : rdr.GetString(8);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 LabelItemDocuments 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemDocumentsCount">LabelItemDocuments 总数。</param>
        /// <returns>LabelItemDocuments 列表。</returns>
        public List<LabelItemDocumentsInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LabelItemDocumentsInfo> list = new List<LabelItemDocumentsInfo>();
            LabelItemDocumentsInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwLabelDocuments", "ItemDocId",
                "[ItemDocId], [ItemID], [ItemName], [DocID], [DocumentName], [StationId], [Station], [TypeId], [TypeName], [Sequence], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelItemDocumentsInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(3), rdr.GetInt32(5),
                        rdr.GetInt32(7), rdr.GetInt32(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),
                        rdr.GetDateTime(13));
                    entity.ItemName = rdr.IsDBNull(2) ? "" : rdr.GetString(2);
                    entity.DocumentName = rdr.IsDBNull(4) ? "" : rdr.GetString(4);
                    entity.Station = rdr.IsDBNull(6) ? "" : rdr.GetString(6);
                    entity.TypeName = rdr.IsDBNull(8) ? "" : rdr.GetString(8);

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
