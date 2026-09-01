using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.SystemLog.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.SystemLog.BLL
{
    public class SystemErrorLog
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 AccreditLogInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="certificationMemberCount">certificationMember 总数。</param>
        /// <returns>CertificationMember 列表。</returns>
        public List<SystemErrorLogInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SystemErrorLogInfo> list = new List<SystemErrorLogInfo>();
            SystemErrorLogInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYS_SystemErrorLog", " ID ",////SYS_SystemErrorLog
                " ID, UserName, CreateDateTime, ErrorMsg, Remark ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SystemErrorLogInfo();
                    entity.ID = rdr.GetInt32(0);
                    entity.UserName = rdr.GetString(1);
                    entity.CreateDateTime = rdr.GetDateTime(2);
                    entity.ErrorMsg = rdr.GetString(3);
                    entity.Remark = rdr.GetString(4);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        public void AddLog(string ErrorMsg, string Remark, string MethodStr)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ErrorMsg", SqlDbType.NVarChar,1000),
                new SqlParameter("@Remark", SqlDbType.NVarChar,2000),
                new SqlParameter("@MethodStr", SqlDbType.NVarChar,2000)
            };

            parms[0].Value = ErrorMsg;
            parms[1].Value = Remark;
            parms[2].Value = MethodStr;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, "insert into SYS_SystemErrorLog(UserName, CreateDateTime, ErrorMsg, Remark, MethodStr)values('sys', getdate(), @ErrorMsg, @Remark, @MethodStr)", parms);
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
