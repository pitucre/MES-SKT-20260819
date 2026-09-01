using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.SerialNumber.Model;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Data;

namespace SKT.LeanMES.SerialNumber.BLL
{
    public class SerialNumberPerfixSuf
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） DictionaryData 信息。
        /// </summary>
        /// <param name="entity">DictionaryData 实体对象。</param>
        public Int32 Edit(DictionaryInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DictionaryDataID", SqlDbType.Int),
                new SqlParameter("@Code", SqlDbType.NVarChar),               
                new SqlParameter("@Description", SqlDbType.NVarChar),
                new SqlParameter("@Value", SqlDbType.VarChar),              
                new SqlParameter("@ModifyBy", SqlDbType.VarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar)
            };

            parms[0].Value = entity.DictionaryDataId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Code;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.Value;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPerfixSufEdit", parms);

            return (Int32)parms[0].Value;
        }
        /// <summary>
        /// 分页获取 SerialNumberType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="serialNumberTypeCount">serialNumberType 总数。</param>
        /// <returns>SerialNumberType 列表。</returns>
        public List<DictionaryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DictionaryInfo> list = new List<DictionaryInfo>();

            //表名或者视图
            string strTb = "vwGetPrefixSufList";
            //主键
            string strKey = "DictionaryDataId";
            //查询栏位字串
            string strColumns = @"[DictionaryDataId], [Value], [Description],[Code],[FNType],[CreateDateTime],[CreateBy],ModifyBy,ModifyDateTime";
            //筛选条件--不显示系统内置条码类型            

            list = ComMethod.GetComList<DictionaryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

         /// <summary>
        /// 根据 DictionaryId 获取实体信息。
        /// </summary>
        /// <param name="dictionaryId">DictionaryId。</param>
        /// <returns>Dictionary 实体对象。</returns>
        public DictionaryInfo GetInfo(Int32 dictionaryId)
        {
            return ComMethod.GetInfo<DictionaryInfo>(dictionaryId, "SYS_DictionaryData_GetInfo"); 
        }

        /// <summary>
        /// 根据 value 获取实体信息。
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public DictionaryInfo GetInfo(string value)
        {
            return ComMethod.GetInfo<DictionaryInfo>(value, "SYS_DictionaryData_GetInfo");
        }

        /// <summary>
        /// 根据 SerialNumberTypeId 字符串删除 SerialNumberType 信息。
        /// </summary>
        /// <param name="idString">SerialNumberTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_DictionaryData_Delete", parms);
        }

        /// <summary>
        /// 获取用户自定义的函数、存储过程列表信息
        /// </summary>
        /// <returns></returns>
        public List<string> GetPrefixSufFunc()
        {
            List<string> list = new List<string>();

            string sql = "select * from [vwGetPrefixSufFunc]";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, null))
            {
                while (rdr.Read())
                {
                    list.Add(rdr[0].ToString());
                }
            }

            return list;
        }
    }
}
