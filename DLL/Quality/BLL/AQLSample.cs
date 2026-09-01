using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
//using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class AQLSample
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AQLSample 信息。
        /// </summary>
        /// <param name="entity">AQLSample 实体对象。</param>
        public int Edit(AQLSampleInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AQLSampleId", SqlDbType.Int),
                new SqlParameter("@AQLSampleName", SqlDbType.NVarChar, 20),
                new SqlParameter("@AQLSampleValue", SqlDbType.Float),
                new SqlParameter("@AQLSampleDescription", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreaterBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateDate", SqlDbType.DateTime),
                new SqlParameter("@ModifyDate", SqlDbType.DateTime)
            };

            parms[0].Value = entity.AQLSampleId;
            parms[1].Value = entity.AQLSampleName;
            parms[2].Value = entity.AQLSampleValue;
            parms[3].Value = entity.AQLSampleDescription;
            parms[4].Value = entity.CreaterBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.CreateDate;
            parms[7].Value = entity.ModifyDate;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_AQLSampleEdit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AQLSampleId 字符串删除 AQLSample 信息。
        /// </summary>
        /// <param name="idString">AQLSampleId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_AQLSampleDelete", parms);
        }

        /// <summary>
        /// 根据 AQLSampleId 获取实体信息。
        /// </summary>
        /// <param name="aQLSampleId">AQLSampleId。</param>
        /// <returns>AQLSample 实体对象。</returns>
        public AQLSampleInfo GetInfo(Int32 aQLSampleId)
        {
            AQLSampleInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = aQLSampleId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_AQLSampleGetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AQLSampleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDouble(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AQLSample 实体对象。</returns>
        public AQLSampleInfo GetInfo(String fieldValue)
        {
            AQLSampleInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_AQLSampleGetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AQLSample 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="aQLSampleCount">aQLSample 总数。</param>
        /// <returns>AQLSample 列表。</returns>
        public List<AQLSampleInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AQLSampleInfo> list = new List<AQLSampleInfo>();
            AQLSampleInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwQuality_AQLSample", "AQLSampleID",////Quality_AQLSample
                "[AQLSampleId], [AQLSampleName], [AQLSampleValue], [AQLSampleDescription], [CreaterBy], [ModifyBy], [CreateDate], [ModifyDate]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AQLSampleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDouble(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetDateTime(7));

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


        /// <summary>
        /// 获取AQL值
        /// </summary>
        /// <returns>AQL值清单</returns>
        public List<string> GetAqlValueList()
        {
            SqlParameter[] parms = new SqlParameter[]{};
            List<string> list = new List<string>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetAqlValueList", parms))
            {
                while (rdr.Read())
                {
                    list.Add(rdr.GetString(0)); 
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AQLPlan 实体对象。</returns>
        public string AQLSampleSize(int lotsize)
        {
            string str = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LotSize",SqlDbType.Int)
            };
            parms[0].Value = lotsize;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetFnVi", parms))
            {
                while (dr.Read())
                {
                   var fn = dr.GetInt32(1);
                   var vi = dr.GetInt32(0);
                    str = fn + "," + vi;
                }
            }
            return str;
        }

    }
}