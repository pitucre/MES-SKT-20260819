using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Kanban.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Kanban.BLL
{
    public class Send
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Send 信息。
        /// </summary>
        /// <param name="entity">Send 实体对象。</param>
        public Int32 Edit(SendInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@KanbanSendId", SqlDbType.Int),
                new SqlParameter("@KanbanId", SqlDbType.Int),
                new SqlParameter("@Location", SqlDbType.NVarChar, 100),
                new SqlParameter("@MAC", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@SendName", SqlDbType.NVarChar, 100)
            };

            parms[0].Value = entity.KanbanSendId;
            parms[1].Value = entity.KanbanId;
            parms[2].Value = entity.Location;
            parms[3].Value = entity.MAC;
            parms[4].Value = entity.Remark;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.SendName;


            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_Send_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SendId 字符串删除 Send 信息。
        /// </summary>
        /// <param name="idString">SendId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_Send_Delete", parms);
        }

        /// <summary>
        /// 根据 SendId 获取实体信息。
        /// </summary>
        /// <param name="sendId">SendId。</param>
        /// <returns>Send 实体对象。</returns>
        public SendInfo GetInfo(string  fieldValue,Int32 typeId)
        {
            SendInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@SearchType", SqlDbType.Int)
                
            };

            parms[0].Value = fieldValue;
            parms[1].Value = typeId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Kanban_Send_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SendInfo();
                    entity.KanbanSendId = Convert.ToInt32(rdr["KanbanSendId"].ToString());
                    entity.KanbanId = Convert.ToInt32(rdr["KanbanId"].ToString());
                    entity.Location = rdr["Location"].ToString();
                    entity.MAC = rdr["MAC"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.KanbanName = rdr["KanbanName"].ToString();
                    entity.SendName = rdr["SendName"].ToString();
                    entity.LinkUrl = rdr["LinkUrl"].ToString();
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Send 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="sendCount">send 总数。</param>
        /// <returns>Send 列表。</returns>
        public List<SendInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SendInfo> list = new List<SendInfo>();
            SendInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwKanBanSend", "KanbanSendId",
                "[KanbanSendId], [KanbanId], [Location], [MAC], [Remark], [KanbanName], [UpdateBy], [UpdateTime],[RowId],[SendName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SendInfo();
                    entity.KanbanSendId = Convert.ToInt32(rdr["KanbanSendId"]); 
                    entity.KanbanId = Convert.ToInt32(rdr["KanbanId"]);
                    entity.Location = rdr["Location"].ToString();
                    entity.MAC = rdr["MAC"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.KanbanName = rdr["KanbanName"].ToString();
                    entity.UpdateBy = rdr["UpdateBy"].ToString();
                    entity.UpdateTime = rdr["UpdateTime"].ToString()!=""?Convert.ToDateTime(rdr["UpdateTime"]).ToString("yyyy-MM-dd HH:mm:ss"):"";
                    entity.RowId = Convert.ToInt32(rdr["RowId"]);
                    entity.SendName = rdr["SendName"].ToString();

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// Send 列表
        /// </summary>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public DataTable GetAll(String sortExpression, SearchSettings searchSettings)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("SELECT [KanbanSendId], [KanbanId], [Location], [MAC], [Remark], [KanbanName], [UpdateBy], [UpdateTime],[RowId],[SendName] FROM vwKanBanSend WHERE 1 = 1 ");
            if (!string.IsNullOrWhiteSpace(searchSettings.ExtensionCondition))
            {
                sb.Append(searchSettings.ExtensionCondition);
            }
            if (!string.IsNullOrWhiteSpace(sortExpression))
            {
                sb.AppendFormat(" ORDER BY {0}", sortExpression);
            }
            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sb.ToString(), null);
        }

        public  List<SendInfo>  GetKanbanMACById(int kanbanId)
        {
            List<SendInfo> list = new List<SendInfo>();
            SendInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@KanbanId", SqlDbType.Int)

            };

            parms[0].Value = kanbanId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "uspKanbanMACById", parms))
            {
                while (rdr.Read())
                {
                    entity = new SendInfo();
                    entity.MAC = rdr["MAC"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}