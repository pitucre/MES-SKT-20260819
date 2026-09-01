using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Anormal.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Anormal.BLL
{
    public class AnormalType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Anormal_SubType 信息。
        /// </summary>
        /// <param name="entity">Anormal_SubType 实体对象。</param>
        public Int32 Edit(AnormalTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AnormalTypeId", SqlDbType.Int),
                new SqlParameter("@AnormalTypeCode", SqlDbType.VarChar, 20),
                new SqlParameter("@AnormalTypeName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Descriptions", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@AnormalGroupId", SqlDbType.Int)
            };

            parms[0].Value = entity.AnormalTypeId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.AnormalTypeCode;
            parms[2].Value = entity.AnormalTypeName;
            parms[3].Value = entity.Descriptions;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;
            parms[7].Value = entity.AnormalGroupId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Type_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 Anormal_SubTypeId 字符串删除 Anormal_SubType 信息。
        /// </summary>
        /// <param name="idString">Anormal_SubTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Type_Delete", parms);
        }

        /// <summary>
        /// 根据 Anormal_SubTypeId 获取实体信息。
        /// </summary>
        /// <param name="anormal_SubTypeId">Anormal_SubTypeId。</param>
        /// <returns>Anormal_SubType 实体对象。</returns>
        public AnormalTypeInfo GetInfo(Int32 anormal_SubTypeId)
        {
            AnormalTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = anormal_SubTypeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Type_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetInt32(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Anormal_SubType 实体对象。</returns>
        public AnormalTypeInfo GetInfo(String fieldValue)
        {
            AnormalTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Type_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetInt32(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Anormal_SubType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="anormal_SubTypeCount">anormal_SubType 总数。</param>
        /// <returns>Anormal_SubType 列表。</returns>
        public List<AnormalTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string queryColumns = "[AnormalTypeId], [AnormalTypeCode], [AnormalTypeName], [Descriptions], [AnormalGroupName],CreateBy,CreateDateTime,ModifyBy,ModifyDateTime";
            return ComMethod.GetComList<AnormalTypeInfo>(ref recordCount, startRow, maxRows, "vwGetAnormalList", "AnormalTypeId", queryColumns, sortExpression, searchSettings);

            //List<AnormalTypeInfo> list = new List<AnormalTypeInfo>();
            //AnormalTypeInfo entity = null;
            //SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetAnormalList", "AnormalTypeId",
            //    "[AnormalTypeId], [AnormalTypeCode], [AnormalTypeName], [Descriptions], [AnormalGroupName],CreateBy,CreateDateTime,ModifyBy,ModifyDateTime", searchSettings, sortExpression);
            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            //{
            //    while (rdr.Read())
            //    {
            //        entity = new AnormalTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4));
            //        entity.CreateBy=
            //        list.Add(entity);
            //    }
            //    rdr.Close();
            //}

            //recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            //return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}