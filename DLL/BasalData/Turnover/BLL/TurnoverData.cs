using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Turnover.Model;

namespace SKT.LeanMES.Turnover.BLL
{
    /// <summary>
    /// 具体的周转工具
    /// </summary>
    public class TurnoverData
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新） TurnoverData 信息。
        /// </summary>
        /// <param name="entity">TurnoverData 实体对象。</param>
        public void Edit(TurnoverDataInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TurnoverDataId", SqlDbType.Int),
                new SqlParameter("@TurnoverNumber", SqlDbType.VarChar, 50),
                new SqlParameter("@TurnoverGroupId", SqlDbType.Int),
                new SqlParameter("@TurnoverStatusId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.TurnoverDataId;
            parms[1].Value = entity.TurnoverNumber;
            parms[2].Value = entity.TurnoverGroupId;
            parms[3].Value = entity.TurnoverStatusId;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverData_Edit", parms);
        }

        /// <summary>
        /// 根据 TurnoverDataId 字符串删除 TurnoverData 信息。
        /// </summary>
        /// <param name="idString">TurnoverDataId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverData_Delete", parms);
        }


        /// <summary>
        /// 根据 TurnoverGroupId 和 TurnoverNumber字符串删除 TurnoverData 信息。
        /// </summary>
        /// <param name="turnoverNumberString">周转工具编号字符串</param>
        /// <param name="userName">操作人</param>
        /// <param name="turnoverGroupId">周转箱分组Id</param>
        /// <returns>日志内容。</returns>
        public void Delete(String turnoverNumberString, String userName, Int32 turnoverGroupId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TurnoverNumberString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@TurnoverGroupId",SqlDbType.Int)
            };

            parms[0].Value = turnoverNumberString;
            parms[1].Value = userName;
            parms[2].Value = turnoverGroupId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspTurnoverDataDelete", parms);
        }

        /// <summary>
        /// 根据 TurnoverData 获取实体信息。
        /// </summary>
        /// <param name="turnoverDataId">TurnoverDataId。</param>
        /// <returns>TurnoverData 实体对象。</returns>
        public TurnoverDataInfo GetInfo(Int32 turnoverDataId)
        {
            TurnoverDataInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = turnoverDataId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverData_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new TurnoverDataInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取TurnoverData实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>TurnoverData 实体对象。</returns>
        public TurnoverDataInfo GetInfo(String fieldValue)
        {
            TurnoverDataInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverData_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 TurnoverData 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="TurnoverDataCount">TurnoverData 总数。</param>
        /// <returns>TurnoverData 列表。</returns>
        public List<TurnoverDataInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TurnoverDataInfo> list = new List<TurnoverDataInfo>();
            TurnoverDataInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_TurnoverData", "TurnoverDataId",
                "[TurnoverDataId], [TurnoverNumber], [TurnoverGroupId], [TurnoverStatusId], [CreateDateTime], [CreateBy], [ModifyDateTime], [ModifyBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TurnoverDataInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 根据周转工具分组TurnoverGroupId，获取该分组所包含的周转工具条码列表
        /// </summary>
        /// <param name="TurnoverGroupId">周转工具分组id</param>
        /// <returns>TurnoverNumber 列表</returns>
        public List<TurnoverDataInfo> GetTurnoverNumberList(Int32 turnoverGroupId)
        {
            List<TurnoverDataInfo> list = new List<TurnoverDataInfo>();
            TurnoverDataInfo entity = null;

            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("TurnoverGroupId", turnoverGroupId.ToString());
            String sortExpression = " TurnoverDataId DESC";

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, 99, "vwTurnoverNumberList", "TurnoverDataId",
                "[TurnoverDataId], [TurnoverNumber], [Description], [TurnoverGroupId]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TurnoverDataInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2));

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


        /// <summary>
        /// 批量导入工具条码，并注册。
        /// </summary>
        /// <param name="turnoverNumberStr">工具条码字符串</param>
        /// <param name="turnoverGroupId">工具分组ID</param>
        /// <param name="createBy"></param>
        /// <param name="statusId">工具状态</param>
        public void ImportTurnoverNumber(String turnoverNumberStr, Int32 turnoverGroupId, String createBy, Int32 turnoverStatusId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TurnoverNumberStr", SqlDbType.Text),
                new SqlParameter("@TurnoverGroupId", SqlDbType.Int),
                new SqlParameter("@TurnoverStatusId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = turnoverNumberStr;
            parms[1].Value = turnoverGroupId;
            parms[2].Value = turnoverStatusId;
            parms[3].Value = createBy;

            try
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspTurnoverNumberImport", parms);
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
    }
}