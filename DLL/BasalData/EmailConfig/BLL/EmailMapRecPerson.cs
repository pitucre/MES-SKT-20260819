using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.EmailConfig.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.EmailConfig.BLL
{
    public class EmailMapRecPerson
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EmailMapRecPerson 信息。
        /// </summary>
        /// <param name="entity">EmailMapRecPerson 实体对象。</param>
        public Int32 Edit(EmailMapRecPersonInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ERecId", SqlDbType.Int),
                new SqlParameter("@RecId", SqlDbType.Int),
                new SqlParameter("@EmailTypeName", SqlDbType.NVarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ERecId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.RecId;
            parms[2].Value = entity.EmailTypeName;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EmailMapRecPerson_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 EmailMapRecPersonId 字符串删除 EmailMapRecPerson 信息。
        /// </summary>
        /// <param name="idString">EmailMapRecPersonId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EmailMapRecPerson_Delete", parms);
        }

        /// <summary>
        /// 根据 EmailMapRecPersonId 获取实体信息。
        /// </summary>
        /// <param name="emailMapRecPersonId">EmailMapRecPersonId。</param>
        /// <returns>EmailMapRecPerson 实体对象。</returns>
        public EmailMapRecPersonInfo GetInfo(Int32 emailMapRecPersonId)
        {
            EmailMapRecPersonInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = emailMapRecPersonId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EmailMapRecPerson_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EmailMapRecPersonInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EmailMapRecPerson 实体对象。</returns>
        public EmailMapRecPersonInfo GetInfo(String fieldValue)
        {
            EmailMapRecPersonInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EmailMapRecPerson_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EmailMapRecPersonInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EmailMapRecPerson 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="emailMapRecPersonCount">emailMapRecPerson 总数。</param>
        /// <returns>EmailMapRecPerson 列表。</returns>
        public List<EmailMapRecPersonInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EmailMapRecPersonInfo> list = new List<EmailMapRecPersonInfo>();
            EmailMapRecPersonInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_EmailMapRecPerson", "EmailMapRecPersonId",
                "[ERecId], [RecId], [EmailTypeName], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EmailMapRecPersonInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));

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