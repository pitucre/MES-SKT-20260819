using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Product.BLL
{
    public class ExpirationDateDtl
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ExpirationDateDtl 信息。
        /// </summary>
        /// <param name="entity">ExpirationDateDtl 实体对象。</param>
        public Int32 Edit(ExpirationDateDtlInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ExpirationDateDtlId", SqlDbType.Int),
                new SqlParameter("@Pid", SqlDbType.Int),
                new SqlParameter("@Number", SqlDbType.Int),
                new SqlParameter("@DayNumber", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.ExpirationDateDtlId;
            parms[1].Value = entity.Pid;
            parms[2].Value = entity.Number;
            parms[3].Value = entity.DayNumber;
            parms[4].Value = entity.Remark;
            parms[5].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ExpirationDateDtl_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ExpirationDateDtlId 字符串删除 ExpirationDateDtl 信息。
        /// </summary>
        /// <param name="idString">ExpirationDateDtlId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ExpirationDateDtl_Delete", parms);
        }

        /// <summary>
        /// 根据 ExpirationDateDtlId 获取实体信息。
        /// </summary>
        /// <param name="expirationDateDtlId">ExpirationDateDtlId。</param>
        /// <returns>ExpirationDateDtl 实体对象。</returns>
        public List<ExpirationDateDtlInfo> GetInfo(Int32 expirationDateDtlId)
        {
            ExpirationDateDtlInfo entity = null;
            List<ExpirationDateDtlInfo> list = new List<ExpirationDateDtlInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = expirationDateDtlId;
            parms[1].Value = true;

            list = ComMethod.GetList<ExpirationDateDtlInfo>("Basal_ExpirationDateDtl_GetInfo", parms);
            return list;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ExpirationDateDtl 实体对象。</returns>
        public List<ExpirationDateDtlInfo> GetInfo(String fieldValue)
        {
            ExpirationDateDtlInfo entity = null;
            List<ExpirationDateDtlInfo> list = new List<ExpirationDateDtlInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            list = ComMethod.GetList<ExpirationDateDtlInfo>("Basal_ExpirationDateDtl_GetInfo", parms);
            return list;
        }

        /// <summary>
        /// 分页获取 ExpirationDateDtl 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="expirationDateDtlCount">expirationDateDtl 总数。</param>
        /// <returns>ExpirationDateDtl 列表。</returns>
        public List<ExpirationDateDtlInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ExpirationDateDtlInfo> list = new List<ExpirationDateDtlInfo>();
            ExpirationDateDtlInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_ExpirationDateDtl", "ExpirationDateDtlId",
                "[ExpirationDateDtlId], [Pid], [Number], [DayNumber], [Remark], [CreateBy], [CreateDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ExpirationDateDtlInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4),
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