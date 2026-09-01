using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Product.BLL
{
    public class ExpirationDate
    {
        private Int32 recordCount = 0;


        /// <summary>
        /// 编辑（添加或更新） ExpirationDate 信息。
        /// </summary>
        /// <param name="entity">ExpirationDate 实体对象。</param>
        public Int32 Edit(ExpirationDateInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ExpirationDateId", SqlDbType.Int),
                new SqlParameter("@ExpirationDateName", SqlDbType.VarChar, 50),
                new SqlParameter("@CheckCount", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.ExpirationDateId;
            parms[1].Value = entity.ExpirationDateName;
            parms[2].Value = entity.CheckCount;
            parms[3].Value = entity.Remark;
            parms[4].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ExpirationDate_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ExpirationDateId 字符串删除 ExpirationDate 信息。
        /// </summary>
        /// <param name="idString">ExpirationDateId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ExpirationDate_Delete", parms);
        }

        /// <summary>
        /// 根据 ExpirationDateId 获取实体信息。
        /// </summary>
        /// <param name="expirationDateId">ExpirationDateId。</param>
        /// <returns>ExpirationDate 实体对象。</returns>
        public ExpirationDateInfo GetInfo(Int32 expirationDateId)
        {
            ExpirationDateInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = expirationDateId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ExpirationDate_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ExpirationDateInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ExpirationDate 实体对象。</returns>
        public ExpirationDateInfo GetInfo(String fieldValue)
        {
            ExpirationDateInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ExpirationDate_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ExpirationDateInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ExpirationDate 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="expirationDateCount">expirationDate 总数。</param>
        /// <returns>ExpirationDate 列表。</returns>
        public List<ExpirationDateInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {

            //表名或者视图
            string strTb = "vwBasal_ExpirationDate";
            //主键
            string strKey = "ExpirationDateId";
            //查询栏位字串
            string strColumns = "[ExpirationDateId], [ExpirationDateName], [CheckCount], [Remark], [CreateBy], [CreateDateTime],ModifyBy,ModifyTime";            

            return ComMethod.GetComList<ExpirationDateInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings); ;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


    }
}