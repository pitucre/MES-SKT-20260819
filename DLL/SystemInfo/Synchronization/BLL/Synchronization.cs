using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Synchronization.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Synchronization.BLL
{
    public class Synchronization
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Synch 信息。
        /// </summary>
        /// <param name="entity">Synch 实体对象。</param>
        public Int32 Edit(SynchronizationInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SynchID", SqlDbType.Int),
                new SqlParameter("@StoredProcedureName", SqlDbType.NVarChar, 100),
                new SqlParameter("@BusinessName", SqlDbType.NVarChar, 30),
                new SqlParameter("@timeout", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateTime", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyTime", SqlDbType.DateTime)
            };

            parms[0].Value = entity.SynchID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.StoredProcedureName;
            parms[2].Value = entity.BusinessName;
            parms[3].Value = entity.Timeout;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.CreateTime;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = entity.ModifyTime;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Synchronization_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SynchId 字符串删除 Synch 信息。
        /// </summary>
        /// <param name="idString">SynchId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Synchronization_Delete", parms);
        }

        /// <summary>
        /// 根据 SynchId 获取实体信息。
        /// </summary>
        /// <param name="synchId">SynchId。</param>
        /// <returns>Synch 实体对象。</returns>
        public SynchronizationInfo GetInfo(Int32 synchId)
        {
            SynchronizationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = synchId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Synchronization_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SynchronizationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
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
        /// <returns>Synch 实体对象。</returns>
        public SynchronizationInfo GetInfo(String fieldValue)
        {
            SynchronizationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Synchronization_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SynchronizationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Synch 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="synchCount">synch 总数。</param>
        /// <returns>Synch 列表。</returns>
        public List<SynchronizationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SynchronizationInfo> list = new List<SynchronizationInfo>();
            SynchronizationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYS_Synchronization", "SynchId",/////SYS_Synchronization
                "[SynchID], [StoredProcedureName], [BusinessName], [timeout], [CreateBy], [CreateTime], [ModifyBy], [ModifyTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SynchronizationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
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

        #region 获取手动同步列表信息
        /// <summary>
        /// 获取手动同步列表信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SynchronizationInfo> GetManualSyncAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SynchronizationInfo> list = new List<SynchronizationInfo>();
            //表名或者视图
            string strTb = "vwProd_ManualSync";////Prod_ManualSync
            //主键
            string strKey = "SyncID";
            //查询栏位字串
            string strColumns = @" SyncID, SyncType, SyncContent, CreateBy, CreateDateTime, DisposeDateTime, DisposeState,ModifyBy,ModifyDateTime";

            return ComMethod.GetComList<SynchronizationInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        #endregion

        #region 获取单手动同步信息
        /// <summary>
        /// 获取单手动同步信息
        /// </summary>
        /// <param name="ScopeId"></param>
        /// <returns></returns>
        public SynchronizationInfo GetManualSyncInfo(Int32 ScopeId)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<SynchronizationInfo>(ScopeId, "uspGetManualSyncInfo");
        }
        #endregion

        #region 保存手动同步信息
        /// <summary>
        /// 保存手动同步信息
        /// </summary>
        /// <param name="entity"></param>
        public void SaveManualSync(int SyncID, string SyncType, string SyncContent, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SyncID", SqlDbType.Int),
                new SqlParameter("@SyncType", SqlDbType.VarChar, 50),
                new SqlParameter("@SyncContent", SqlDbType.VarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = SyncID;
            parms[1].Value = SyncType;
            parms[2].Value = SyncContent;
            parms[3].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveManualSync", parms);

        }
        #endregion

        #region 删除手动同步信息
        /// <summary>
        /// 删除手动同步信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void DeleteManualSync(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteManualSync", parms);
        }
        #endregion

        #region 获取同步类型
        /// <summary>
        /// 获取号码类型
        /// </summary>
        /// <returns></returns>
        public List<SynchronizationInfo> GeSyncTypeALL()
        {
            List<SynchronizationInfo> entity = new List<SynchronizationInfo>();
            try
            {
                string cmdTxt = string.Format("SELECT SyncType FROM dbo.Basal_SyncType GROUP BY SyncType");
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    SynchronizationInfo t = new SynchronizationInfo();
                    t.SyncType = dt.Rows[i][0].ToString();
                    entity.Add(t);
                }
            }
            catch (Exception ex)
            {
            }
            return entity;

        }
        #endregion
    }
}