using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Station.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Station.BLL
{
    public class StationCert
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） StationCert 信息。
        /// </summary>
        /// <param name="entity">StationCert 实体对象。</param>
        public Int32 Edit(StationCertInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationCertId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@CertificationId", SqlDbType.Int)
            };

            parms[0].Value = entity.StationCertId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.StationId;
            parms[2].Value = entity.CertificationId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationCert_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 StationCertId 字符串删除 StationCert 信息。
        /// </summary>
        /// <param name="idString">StationCertId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationCert_Delete", parms);
        }

        /// <summary>
        /// 根据 StationCertId 获取实体信息。
        /// </summary>
        /// <param name="stationCertId">StationCertId。</param>
        /// <returns>StationCert 实体对象。</returns>
        public StationCertInfo GetInfo(Int32 stationCertId)
        {
            StationCertInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = stationCertId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StationCert_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StationCertInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>StationCert 实体对象。</returns>
        public StationCertInfo GetInfo(String fieldValue)
        {
            StationCertInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StationCert_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StationCertInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 StationCert 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="stationCertCount">stationCert 总数。</param>
        /// <returns>StationCert 列表。</returns>
        public List<StationCertInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<StationCertInfo> list = new List<StationCertInfo>();
            StationCertInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_StationCert", "StationCertId",
                "[StationCertId], [StationId], [CertificationId]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationCertInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2));

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