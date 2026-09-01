using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Report.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Report.BLL
{
    public class Template
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Template 信息。
        /// </summary>
        /// <param name="entity">Template 实体对象。</param>
        public Int32 Edit(TemplateInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TemplateId", SqlDbType.Int),
                new SqlParameter("@TemplateName", SqlDbType.NVarChar, 50),
                new SqlParameter("@TemplateDesc", SqlDbType.NVarChar, 50),
                new SqlParameter("@TemplateContent", SqlDbType.NText),
                new SqlParameter("@Report", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.TemplateId;
            parms[1].Value = entity.TemplateName;
            parms[2].Value = entity.TemplateDesc;
            parms[3].Value = SKT.Common.Utility.EncryptHelper.Encrypt(entity.TemplateContent);
            parms[4].Value = entity.Report;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;
         
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Report_Template_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 TemplateId 字符串删除 Template 信息。
        /// </summary>
        /// <param name="idString">TemplateId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Report_Template_Delete", parms);
        }

        /// <summary>
        /// 根据 TemplateId 获取实体信息。
        /// </summary>
        /// <param name="templateId">TemplateId。</param>
        /// <returns>Template 实体对象。</returns>
        public TemplateInfo GetInfo(Int32 templateId)
        {
            TemplateInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = templateId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Report_Template_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new TemplateInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), SKT.Common.Utility.EncryptHelper.Decrypt(rdr.GetString(3)), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Template 实体对象。</returns>
        public TemplateInfo GetInfo(String fieldValue)
        {
            TemplateInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Report_Template_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new TemplateInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), SKT.Common.Utility.EncryptHelper.Decrypt(rdr.GetString(3)), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Template 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="templateCount">template 总数。</param>
        /// <returns>Template 列表。</returns>
        public List<TemplateInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TemplateInfo> list = new List<TemplateInfo>();
            TemplateInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Report_Template", "TemplateId",
                "[TemplateId], [TemplateName], [TemplateDesc], [Report], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TemplateInfo();
                    entity.TemplateId = rdr.GetInt32(0);
                    entity.TemplateName = rdr.GetString(1);
                    entity.TemplateDesc = rdr.GetString(2);
                    entity.Report = rdr.GetString(3);
                    entity.CreateBy = rdr.GetString(4);
                    entity.CreateDateTime = rdr.GetDateTime(5);
                    entity.ModifyBy = rdr.GetString(6);
                    entity.ModifyDateTime = rdr.GetDateTime(7);
                    entity.Remark = rdr.GetString(8);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        //获取模板内容
        public String GetContentInfo(string name)
        {
            String content = "";

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Report", SqlDbType.NVarChar,50)
            };

            parms[0].Value = name;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Report_GetTemplate", parms))
            {
                if (rdr.Read())
                {
                    content = SKT.Common.Utility.EncryptHelper.Decrypt(rdr.GetString(0));
                }
                rdr.Close();
            }

            return content;
        }


        /// <summary>
        /// 获取可以绑定的ReportName
        /// </summary>
        /// <returns></returns>
        public List<TemplateInfo> GetReportName()
        {
            List<TemplateInfo> list = new List<TemplateInfo>();
            TemplateInfo entity = null;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Report_ReportName", null))
            {
                while (rdr.Read())
                {
                    entity = new TemplateInfo();
                    entity.Report = rdr.GetString(0);
                    entity.TemplateDesc = rdr.GetString(1);
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}