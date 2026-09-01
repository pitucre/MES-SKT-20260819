using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.SystemLog.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data;

namespace SKT.LeanMES.SystemLog.BLL
{
    public class AccreditLog
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
        public List<AccreditLogInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AccreditLogInfo> list = new List<AccreditLogInfo>();
            string strTb = "Basal_Accredit";
            //主键
            string strKey = "LogId";
            //查询栏位字串
            string strColumns = @" [LogId], [UserNo], [UserName], [LogContent], [CreateDateTime] ";
            list = ComMethod.GetComList<AccreditLogInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public List<AccreditLogInfo> GetOperationLog(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AccreditLogInfo> list = new List<AccreditLogInfo>();
            //表名或者视图
            string strTb = "Basal_OperationLog";
            //主键
            string strKey = "LogId";
            //查询栏位字串
            string strColumns = @" LogId, LogType, ModuleName, PageName, OederNo, Operation, UserName, CreateDateTime ";
            list = ComMethod.GetComList<AccreditLogInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public List<AccreditLogInfo> GetUserUILog(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AccreditLogInfo> list = new List<AccreditLogInfo>();
            //表名或者视图
            string strTb = "vwUserUILog";
            //主键
            string strKey = "LogId";
            //查询栏位字串
            string strColumns = @" LogId, LogType, Station, ResName, OederNo, Operation, UserName, CreateDateTime ";
            list = ComMethod.GetComList<AccreditLogInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public void CreateOperationLog(AccreditLogInfo en)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                    new SqlParameter("@LogType", SqlDbType.VarChar, 50),
                    new SqlParameter("@ModuleName", SqlDbType.VarChar, 50),
                    new SqlParameter("@PageName", SqlDbType.VarChar, 50),
                    new SqlParameter("@OederNo", SqlDbType.VarChar, 50),
                    new SqlParameter("@LogContent", SqlDbType.VarChar, 500)
                };

                parms[0].Value = en.UserName;
                parms[1].Value = en.LogType;
                parms[2].Value = en.ModuleName;
                parms[3].Value = en.PageName;
                parms[4].Value = en.OederNo;
                parms[5].Value = en.LogContent;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveOperationLog", parms);
            }
            catch (Exception ex)
            {

                throw;
            }
        }


        public void CreateMaterialHistoryLog(MaterialHistoryLogInfo en)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                    new SqlParameter("@LogType", SqlDbType.Int),
                    new SqlParameter("@OperateOrder", SqlDbType.VarChar, 50),
                    new SqlParameter("@ActionDesc", SqlDbType.VarChar, 100),
                    new SqlParameter("@LogContent", SqlDbType.VarChar, 1000)
                };

                parms[0].Value = en.CreateBy;
                parms[1].Value = en.ActionType;
                parms[2].Value = en.OperateOrder;
                parms[3].Value = en.ActionDesc;
                parms[4].Value = en.Description;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveMaterialHistoryLog", parms);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

       
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
