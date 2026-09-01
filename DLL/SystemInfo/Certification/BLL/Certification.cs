using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Certification.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Certification.BLL
{
    public class Certification
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Certification 信息。
        /// </summary>
        /// <param name="entity">Certification 实体对象。</param>
        public Int32 Edit(CertificationInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CertificationId", SqlDbType.Int),
                new SqlParameter("@Certification", SqlDbType.NVarChar, 20),
                new SqlParameter("@Type", SqlDbType.NVarChar, 20),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@RenewalDays", SqlDbType.Int),
                new SqlParameter("@WarningDays", SqlDbType.Int),
                new SqlParameter("@Expiration_Alarm_Event", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.CertificationId;
            parms[1].Value = entity.Certification;
            parms[2].Value = entity.Type;
            parms[3].Value = entity.Description;
            parms[4].Value = entity.RenewalDays;
            parms[5].Value = entity.WarningDays;
            parms[6].Value = entity.Expiration_Alarm_Event;
            parms[7].Value = entity.Remark;
            parms[8].Value = entity.ModifyBy;
            parms[9].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Certification_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 CertificationId 字符串删除 Certification 信息。
        /// </summary>
        /// <param name="idString">CertificationId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Certification_Delete", parms);
        }

        /// <summary>
        /// 根据 CertificationId 获取实体信息。
        /// </summary>
        /// <param name="certificationId">CertificationId。</param>
        /// <returns>Certification 实体对象。</returns>
        public CertificationInfo GetInfo(Int32 certificationId)
        {
            CertificationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = certificationId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Certification_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CertificationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Certification 实体对象。</returns>
        public CertificationInfo GetInfo(String fieldValue)
        {
            CertificationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Certification_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CertificationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Certification 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="certificationCount">certification 总数。</param>
        /// <returns>Certification 列表。</returns>
        public List<CertificationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CertificationInfo> list = new List<CertificationInfo>();
            CertificationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYS_Certification", "CertificationId",////SYS_Certification
                "[CertificationId], [Certification], [Type], [Description], [RenewalDays], [WarningDays], [Expiration_Alarm_Event], [Remark], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CertificationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11));
                    entity.Type = entity.Type == "Skill" ? "技能认证" : ((entity.Type == "License") ? "证书认证" : "资格认证");
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