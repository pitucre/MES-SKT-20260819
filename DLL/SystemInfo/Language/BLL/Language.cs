using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Language.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Language.BLL
{
    public class Language
    {
        private int recordCount = 0;

        /// <summary>
        /// 获取所有数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<LanguageInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LanguageInfo> list = new List<LanguageInfo>();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwLanguage ", "LanguageId",
                @"LanguageId,LanguageKey,CN,EN,ModifyDateTime,ModifyBy,CreateBy,CreateDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    var entity = new LanguageInfo();
                    entity.LanguageId = ComMethod.FromDatabase<int>(rdr["LanguageId"]);
                    entity.LanguageKey = ComMethod.FromDatabase<string>(rdr["LanguageKey"]);
                    entity.CN = ComMethod.FromDatabase<string>(rdr["CN"]);
                    entity.EN = ComMethod.FromDatabase<string>(rdr["EN"]);
                    entity.ModifyBy = ComMethod.FromDatabase<string>(rdr["ModifyBy"]);
                    entity.ModifyDateTime = ComMethod.FromDatabase<DateTime?>(rdr["ModifyDateTime"]);
                    entity.CreateBy = ComMethod.FromDatabase<string>(rdr["CreateBy"]);
                    entity.CreateDateTime = ComMethod.FromDatabase<DateTime?>(rdr["CreateDateTime"]);
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获取信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public LanguageInfo GetInfo(int id)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@LanguageId",SqlDbType.Int),
            };

            parms[0].Value = id;
            return ComMethod.Get<LanguageInfo>("SYS_Language_GetInfo", parms);
        }
        /// <summary>
        /// 新增或者修改
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public Int32 Edit(LanguageInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@LanguageId",SqlDbType.Int),
                new SqlParameter("@LanguageKey",SqlDbType.NVarChar,255),
                new SqlParameter("@CN",SqlDbType.NVarChar,255),
                new SqlParameter("@EN",SqlDbType.NVarChar,255),
                new SqlParameter("@CreateBy",SqlDbType.VarChar,50),
                new SqlParameter("@ModifyBy",SqlDbType.VarChar,50),
            };

            parms[0].Value = entity.LanguageId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.LanguageKey;
            parms[2].Value = entity.CN;
            parms[3].Value = entity.EN;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Language_Edit", parms);
            return Convert.ToInt32(parms[0].Value);
        }
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void Delete(String idString, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@IdString",SqlDbType.VarChar,1000),
                new SqlParameter("@UserName",SqlDbType.VarChar,50),
            };
            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Language_Delete", parms);
        }

        public DateTime? GetLastModifyTime()
        {
            string sql = "SELECT CONVERT(DATETIME,MAX(ModifyDateTime)) AS ModifyDateTime FROM SYS_Language";
            DateTime? dateTime = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, null))
            {
                while (rdr.Read())
                {
                    dateTime = ComMethod.FromDatabase<DateTime?>(rdr["ModifyDateTime"]);
                }
                rdr.Close();
            }
            return dateTime;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
