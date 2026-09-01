using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Kanban.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Kanban.BLL
{
    public class Tag
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Tag 信息。
        /// </summary>
        /// <param name="entity">Tag 实体对象。</param>
        public Int32 Edit(TagInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@KanbanId", SqlDbType.Int),
                new SqlParameter("@KanbanName", SqlDbType.NVarChar, 100),
                new SqlParameter("@LinkUrl", SqlDbType.NVarChar, 200),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.KanbanId;
            parms[1].Value = entity.KanbanName;
            parms[2].Value = entity.LinkUrl;
            parms[3].Value = entity.Remark;
            parms[4].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_Tag_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 TagId 字符串删除 Tag 信息。
        /// </summary>
        /// <param name="idString">TagId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_Tag_Delete", parms);
        }

        /// <summary>
        /// 根据 TagId 获取实体信息。
        /// </summary>
        /// <param name="tagId">TagId。</param>
        /// <returns>Tag 实体对象。</returns>
        public TagInfo GetInfo(Int32 tagId)
        {
            TagInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.Int)
            };

            parms[0].Value = tagId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Kanban_Tag_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new TagInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        // 分页获取 Tag 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="tagCount">tag 总数。</param>
        /// <returns>Tag 列表。</returns>
        public List<TagInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TagInfo> list = new List<TagInfo>();
            TagInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwKanban_Tag", "KanbanId",
                "[KanbanId], [KanbanName], [LinkUrl], [Remark], [CreateBy], [CreateTime], [UpdateBy], [UpdateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TagInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
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