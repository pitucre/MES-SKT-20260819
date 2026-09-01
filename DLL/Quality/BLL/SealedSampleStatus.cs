using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Quality.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class SealedSampleStatus
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SealedSampleStatus 信息。
        /// </summary>
        /// <param name="entity">SealedSampleStatus 实体对象。</param>
        public Int32 Edit(SealedSampleStatusInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SampleStatusId", SqlDbType.Int),
                new SqlParameter("@Status", SqlDbType.VarChar, 50),
                new SqlParameter("@StatusDesc", SqlDbType.VarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.SampleStatusId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Status;
            parms[2].Value = entity.StatusDesc;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_SealedSampleStatus_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SealedSampleStatusId 字符串删除 SealedSampleStatus 信息。
        /// </summary>
        /// <param name="idString">SealedSampleStatusId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_SealedSampleStatus_Delete", parms);
        }

        /// <summary>
        /// 根据 SealedSampleStatusId 获取实体信息。
        /// </summary>
        /// <param name="sealedSampleStatusId">SealedSampleStatusId。</param>
        /// <returns>SealedSampleStatus 实体对象。</returns>
        public SealedSampleStatusInfo GetInfo(Int32 sealedSampleStatusId)
        {
            SealedSampleStatusInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = sealedSampleStatusId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_SealedSampleStatus_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SealedSampleStatusInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SealedSampleStatus 实体对象。</returns>
        public SealedSampleStatusInfo GetInfo(String fieldValue)
        {
            SealedSampleStatusInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_SealedSampleStatus_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SealedSampleStatusInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SealedSampleStatus 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="sealedSampleStatusCount">sealedSampleStatus 总数。</param>
        /// <returns>SealedSampleStatus 列表。</returns>
        public List<SealedSampleStatusInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SealedSampleStatusInfo> list = new List<SealedSampleStatusInfo>();
            SealedSampleStatusInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Quality_SealedSampleStatus", "SampleStatusId",
                "[SampleStatusId], [Status], [StatusDesc], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SealedSampleStatusInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6));

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
