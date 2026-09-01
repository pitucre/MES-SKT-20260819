using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.EmailConfig.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.EmailConfig.BLL
{
    public class EmailServerConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EmailServerConfig 信息。
        /// </summary>
        /// <param name="entity">EmailServerConfig 实体对象。</param>
        public void Edit(EmailServerConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@MailServerName", SqlDbType.VarChar, 99),
                new SqlParameter("@MailServertype", SqlDbType.VarChar, 10),
                new SqlParameter("@Port", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 90),
                new SqlParameter("@PWD", SqlDbType.VarChar, 50),
                new SqlParameter("@MailAddress", SqlDbType.VarChar, 99)
            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.MailServerName;
            parms[2].Value = entity.MailServertype;
            parms[3].Value = entity.Port;
            parms[4].Value = entity.UserName;
            parms[5].Value = entity.PWD;
            parms[6].Value = entity.MailAddress;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EmailServerConfig_Edit", parms);

        }

        /// <summary>
        /// 根据 EmailServerConfigId 获取实体信息。
        /// </summary>
        /// <param name="emailServerConfigId">EmailServerConfigId。</param>
        /// <returns>EmailServerConfig 实体对象。</returns>
        public EmailServerConfigInfo GetInfo(Int32 emailServerConfigId)
        {
            EmailServerConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = emailServerConfigId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EmailServerConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EmailServerConfigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EmailServerConfig 实体对象。</returns>
        public EmailServerConfigInfo GetInfo(String fieldValue)
        {
            EmailServerConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EmailServerConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EmailServerConfigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6));
                }
                rdr.Close();
            }

            return entity;
        }


    }
}