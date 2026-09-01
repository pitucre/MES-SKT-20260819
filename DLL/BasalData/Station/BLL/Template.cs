using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Station.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Station.BLL
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
                new SqlParameter("@Tmpl_ID", SqlDbType.Int),
                new SqlParameter("@Tmpl_TemplateName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Tmpl_TemplateDesc", SqlDbType.NVarChar, 100),
                new SqlParameter("@Tmpl_TemplateValue", SqlDbType.NVarChar, 0),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.TemplateID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Tmpl_TemplateName;
            parms[2].Value = entity.Tmpl_TemplateDesc;
            parms[3].Value = SKT.Common.Utility.EncryptHelper.Encrypt(entity.Tmpl_TemplateValue);
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Template_Edit", parms);

            return (Int32)parms[0].Value;
        }

        public void UpdateTmpAttr(int tmpId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@TmpId",SqlDbType.Int),
                new SqlParameter("@Attr",SqlDbType.VarChar,100)
            };

            parms[0].Value = tmpId;
            parms[1].Value = SKT.Common.Utility.EncryptHelper.Encrypt(tmpId.ToString() + ",Customize," + DateTime.Now.Millisecond.ToString());
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Template_Updateattr", parms);
        }
        /// <summary>
        /// 验证模板状态
        /// </summary>
        /// <param name="tmplId"></param>
        /// <returns></returns>
        public bool CheckTemplateStatus(int tmplId)
        {
            bool isUsing = true;
            int flage = 0;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@TmplID",SqlDbType.Int)
            };

            parameters[0].Value = tmplId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Template_CheckTemplStatus", parameters))
            {
                if(rdr.Read())
                {
                    flage = rdr.GetInt32(0);
                }
                rdr.Close();
            }
            if(flage ==0)
            {
                isUsing = false;
            }
            return isUsing;
        }
        /// <summary>
        /// 获取参数
        /// </summary>
        /// <param name="tId"></param>
        /// <returns></returns>
        public Int32 GetRtAtt(int tId)
        {
            int flag = 1;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@TmpId",SqlDbType.Int),
                new SqlParameter("@TemplateAttr",SqlDbType.VarChar,100)
            };

            parms[0].Value = tId;
            parms[1].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Template_Gettmpattr", parms);

            string att = Convert.ToString(parms[1].Value);
            if (att != "")
            {
                try
                {
                    string deEncry = SKT.Common.Utility.EncryptHelper.Decrypt(att);
                    string[] arr = new string[3];
                    arr = deEncry.Split(new char[] { ',' });
                    if (arr[0] != tId.ToString())
                    {
                        flag = -1;
                    }
                    else if (arr[1].ToLower() != "sys")
                    {
                        flag = 0;
                    }
                }
                catch (Exception ex)
                {
                    throw new MESException("lang", "InvalidTmpAttr", ExceptionLevel.Error);
                }
            }
            else
            {
                flag = -1;
            }

            return flag;
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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Template_Delete", parms);
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

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Template_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new TemplateInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8),rdr.GetBoolean(9));

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

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Template_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new TemplateInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetBoolean(9));
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

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Template", "TemplateID",
                "[TemplateID], [Tmpl_TemplateName], [Tmpl_TemplateDesc], [Tmpl_TemplateValue], [CreateDateTime], [CreateBy], [ModifyBy], [ModifyDateTime], [Tmp_Attribute],[Flag]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TemplateInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetBoolean(9));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取工位模板
        /// </summary>
        /// <param name="opeTypeId">工位类型ID</param>
        /// <param name="opeId">工位ID</param>
        /// <returns>如果工位没有绑定模板则返回工位类型绑定的模板</returns>
        public string GetTmplContentByOpeTypeId(int opeTypeId, int opeId)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@OpeTypeID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int)
            };

            parameters[0].Value = opeTypeId;
            parameters[1].Value = opeId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetProductionTemplateGetTmpl", parameters))
            {
                if (rdr.Read())
                {
                    s = rdr.GetString(0);
                }
                rdr.Close();
            }
            return SKT.Common.Utility.EncryptHelper.Decrypt(s);
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}