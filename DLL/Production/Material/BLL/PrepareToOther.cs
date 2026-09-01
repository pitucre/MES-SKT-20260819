using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Material.BLL
{
   public class PrepareToOther
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） PrepareToOther 信息。
        /// </summary>
        /// <param name="entity">PrepareToOther 实体对象。</param>
        public Int32 Edit(PrepareToOtherInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RID", SqlDbType.Int),
                new SqlParameter("@PrepareDesc", SqlDbType.NVarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500)
            };

            parms[0].Value = entity.RID;
            parms[1].Value = entity.PrepareDesc;
            parms[2].Value = entity.CreateBy;
            parms[3].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PrepareToOther_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PrepareToOtherId 字符串删除 PrepareToOther 信息。
        /// </summary>
        /// <param name="idString">PrepareToOtherId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PrepareToOther_Delete", parms);
        }

        /// <summary>
        /// 根据 PrepareToOtherId 获取实体信息。
        /// </summary>
        /// <param name="prepareToOtherId">PrepareToOtherId。</param>
        /// <returns>PrepareToOther 实体对象。</returns>
        public PrepareToOtherInfo GetInfo(Int32 prepareToOtherId)
        {
            PrepareToOtherInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = prepareToOtherId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PrepareToOther_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PrepareToOtherInfo();
                    entity.RID = (int)rdr["RID"];
                    entity.EnableFlag = (int)rdr["EnableFlag"];
                    entity.PrepareId = (int)rdr["PrepareId"];
                    entity.PrepareDesc = rdr["PrepareDesc"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PrepareToOther 实体对象。</returns>
        public PrepareToOtherInfo GetInfo(String fieldValue)
        {
            PrepareToOtherInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PrepareToOther_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PrepareToOtherInfo();
                    entity.RID = (int)rdr["RID"];
                    entity.EnableFlag = (int)rdr["EnableFlag"];
                    entity.PrepareId = (int)rdr["PrepareId"];
                    entity.PrepareDesc = rdr["PrepareDesc"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 PrepareToOther 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="prepareToOtherCount">prepareToOther 总数。</param>
        /// <returns>PrepareToOther 列表。</returns>
        public List<PrepareToOtherInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PrepareToOtherInfo> list = new List<PrepareToOtherInfo>();
            PrepareToOtherInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwProd_PrepareToOther"
                , "RID",
                "[RID], [PrepareId], [PrepareDesc], [EnableFlag], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrepareToOtherInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
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
