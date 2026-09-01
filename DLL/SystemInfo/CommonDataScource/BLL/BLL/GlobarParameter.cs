using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonDataSource.Model;

namespace SKT.LeanMES.CommonDataSource.BLL
{
    public class GlobarParameter
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） GlobarParameter 信息。
        /// </summary>
        /// <param name="entity">GlobarParameter 实体对象。</param>
        public int Edit(GlobarParametersInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@ParaType", SqlDbType.Int),
                new SqlParameter("@ParaName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ParaValue", SqlDbType.NVarChar, 1000),
                new SqlParameter("@ParaDescription", SqlDbType.NVarChar, 100),
                new SqlParameter ("@CreateBy", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.ParaType;
            parms[2].Value = entity.ParaName;
            parms[3].Value = entity.ParaValue;
            parms[4].Value = entity.Paraription;
            parms[5].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_GlobarParameterEdit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 GlobarParameterId 字符串删除 GlobarParameter 信息。
        /// </summary>
        /// <param name="idString">GlobarParameterId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_GlobarParameterDelete", parms);
        }

        /// <summary>
        /// 根据 GlobarParameterId 获取实体信息。
        /// </summary>
        /// <param name="globarParameterId">GlobarParameterId。</param>
        /// <returns>GlobarParameter 实体对象。</returns>
        public GlobarParametersInfo GetInfo(Int32 globarParameterId)
        {
            GlobarParametersInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = globarParameterId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_GlobarParameterGetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new GlobarParametersInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5), rdr.GetDateTime(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>GlobarParameter 实体对象。</returns>
        public GlobarParametersInfo GetInfo(String fieldValue)
        {
            GlobarParametersInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_GlobarParameterGetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new GlobarParametersInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),rdr.GetString(5), rdr.GetDateTime(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 GlobarParameter 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="globarParameterCount">globarParameter 总数。</param>
        /// <returns>GlobarParameter 列表。</returns>
        public List<GlobarParametersInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<GlobarParametersInfo> list = new List<GlobarParametersInfo>();
            GlobarParametersInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYS_GlobarParameter", "ID",////SYS_GlobarParameter
                "[ID], [ParaType], [ParaName], [ParaValue], [Paraription], [CreateBy], [CreateDateTime],ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new GlobarParametersInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),rdr.GetString(5),rdr.GetDateTime(6));
                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime"))) {
                        entity.ModifyBy = rdr["ModifyBy"].ToString();
                        entity.ModifyTime =Convert.ToDateTime(rdr["ModifyTime"]) ;
                    }

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
        /// 页面加载时，获取编号
        /// </summary>
        /// <returns></returns>
        public string GetParaType(Int32 id)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ParaType",SqlDbType.Int),
                new SqlParameter("@ID",SqlDbType.Int)
            };
            parms[0].Direction = ParameterDirection.Output;
            parms[1].Value = id;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_GlobarParameteGetParaType", parms);
            return parms[0].Value.ToString();
        }

    }
}