using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.EmailConfig.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.EmailConfig.BLL
{
    public class EmailRecPerson
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EmailRecPerson 信息。
        /// </summary>
        /// <param name="entity">EmailRecPerson 实体对象。</param>
        public void Edit(EmailRecPersonInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RecId", SqlDbType.Int),
                new SqlParameter("@MailAddress", SqlDbType.VarChar, 99),
                new SqlParameter("@PersonName", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@RecEmailType", SqlDbType.NVarChar, 500)
            };

            parms[0].Value = entity.RecId;
            parms[1].Value = entity.MailAddress;
            parms[2].Value = entity.PersonName;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.Remark;
            parms[6].Value = entity.RecEmailType;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EmailRecPerson_Edit", parms);

        }

        /// <summary>
        /// 根据 EmailRecPersonId 字符串删除 EmailRecPerson 信息。
        /// </summary>
        /// <param name="idString">EmailRecPersonId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EmailRecPerson_Delete", parms);
        }

        /// <summary>
        /// 根据 EmailRecPersonId 获取实体信息。
        /// </summary>
        /// <param name="emailRecPersonId">EmailRecPersonId。</param>
        /// <returns>EmailRecPerson 实体对象。</returns>
        public EmailRecPersonInfo GetInfo(Int32 emailRecPersonId)
        {
            EmailRecPersonInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = emailRecPersonId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EmailRecPerson_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EmailRecPersonInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
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
        /// <returns>EmailRecPerson 实体对象。</returns>
        public EmailRecPersonInfo GetInfo(String fieldValue)
        {
            EmailRecPersonInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EmailRecPerson_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EmailRecPersonInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EmailRecPerson 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="emailRecPersonCount">emailRecPerson 总数。</param>
        /// <returns>EmailRecPerson 列表。</returns>
        public List<EmailRecPersonInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EmailRecPersonInfo> list = new List<EmailRecPersonInfo>();
            EmailRecPersonInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_EmailRecPerson", "RecId",
                "[RecId], [MailAddress], [PersonName], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EmailRecPersonInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
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


        /// <summary>
        /// 从字典里获取Email的类别
        /// </summary>
        /// <returns></returns>
        public List<RecEmailTypeDictionary> GetRecEmailType(int recId)
        {
            List<RecEmailTypeDictionary> list = new List<RecEmailTypeDictionary>();
            RecEmailTypeDictionary entity = null;

            string cmd = recId > 0 ? "SELECT DictionaryDataId, Name, Description, ISNULL(b.EmailTypeName, '1') FROM SYS_DictionaryData as a LEFT JOIN dbo.Basal_EmailMapRecPerson as b ON a.Name = b.EmailTypeName and b.RecId = @RecId WHERE DicProperty = 'Email'"
                : "SELECT DictionaryDataId, Name, Description, '1' FROM SYS_DictionaryData WHERE DicProperty = 'Email'";

            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@RecId", SqlDbType.Int) };
            parms[0].Value = recId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, cmd, parms))
            {
                while(rdr.Read())
                {
                    entity = new RecEmailTypeDictionary();
                    entity.Id = rdr.GetInt32(0);
                    entity.Name = rdr.GetString(1);
                    entity.Description = rdr.GetString(2);
                    entity.NotBind = rdr.GetString(3);

                    list.Add(entity);
                }

                rdr.Close();
            }

            return list;
        }
    }
}