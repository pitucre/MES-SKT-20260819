using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SDP.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SDP.BLL
{
    public class FunctionExecStep
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） FunctionExecStep 信息。
        /// </summary>
        /// <param name="entity">FunctionExecStep 实体对象。</param>
        public Int32 Edit(FunctionExecStepInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LogicID", SqlDbType.Int),
                new SqlParameter("@AC_ID", SqlDbType.Int),
                new SqlParameter("@PreLogicID", SqlDbType.Int),
                new SqlParameter("@StepName", SqlDbType.VarChar, 40),
                new SqlParameter("@StepType", SqlDbType.VarChar, 20),
                new SqlParameter("@StepXml", SqlDbType.VarChar, -1),
                new SqlParameter("@DataSourceId", SqlDbType.NVarChar, 50),
                new SqlParameter("@DataSourceControlId", SqlDbType.NVarChar, 100)
            };

            parms[0].Value = entity.LogicID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.AC_ID;
            parms[2].Value = entity.PreLogicID;
            parms[3].Value = entity.StepName;
            parms[4].Value = entity.StepType;
            parms[5].Value = entity.StepXml;
            parms[6].Value = entity.DataSourceId;
            parms[7].Value = entity.DataSourceControlId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_FunctionExecStep_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 FunctionExecStepId 字符串删除 FunctionExecStep 信息。
        /// </summary>
        /// <param name="idString">FunctionExecStepId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_FunctionExecStep_Delete", parms);
        }

        /// <summary>
        /// 根据 FunctionExecStepId 获取实体信息。
        /// </summary>
        /// <param name="functionExecStepId">FunctionExecStepId。</param>
        /// <returns>FunctionExecStep 实体对象。</returns>
        public FunctionExecStepInfo GetInfo(Int32 functionExecStepId)
        {
            FunctionExecStepInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = functionExecStepId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_FunctionExecStep_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FunctionExecStepInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="activityId"></param>
        /// <returns></returns>
        public List<FunctionExecStepInfo> GetInfo(List<string> AcIdlst)
        {
            List<FunctionExecStepInfo> list = new List<FunctionExecStepInfo>();
            FunctionExecStepInfo entity;

            string sql = string.Format("SELECT * FROM dbo.SDP_FunctionExecStep WHERE AC_ID IN ({0}) ORDER BY AC_ID,OrderId", string.Join(",", AcIdlst));

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql))
            {
                while (rdr.Read())
                {
                    entity = new FunctionExecStepInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7));

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FunctionExecStep 实体对象。</returns>
        public FunctionExecStepInfo GetInfo(String fieldValue)
        {
            FunctionExecStepInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SDP_FunctionExecStep_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FunctionExecStepInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 查找所有引用过这个数据源的步骤
        /// </summary>
        /// <returns></returns>
        public List<FunctionExecStepInfo> GetInfoByDataSourceId(Int32 dataSourceId)
        {
            List<FunctionExecStepInfo> entitys = new List<FunctionExecStepInfo>();
            FunctionExecStepInfo entity = null;
            string sqlText = "SELECT * FROM dbo.SDP_FunctionExecStep WHERE DataSourceId = @DataSourceId ORDER BY AC_ID,OrderId";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DataSourceId", SqlDbType.Int, 50)};
            parms[0].Value = dataSourceId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlText, parms))
            {
                while (rdr.Read())
                {
                    entity = new FunctionExecStepInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7));

                    entitys.Add(entity);
                }
                rdr.Close();
            }
            return entitys;
        }

        /// <summary>
        /// 分页获取 FunctionExecStep 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="functionExecStepCount">functionExecStep 总数。</param>
        /// <returns>FunctionExecStep 列表。</returns>
        public List<FunctionExecStepInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FunctionExecStepInfo> list = new List<FunctionExecStepInfo>();
            FunctionExecStepInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SDP_FunctionExecStep", "LogicID",
                "[LogicID], [AC_ID], [PreLogicID], [StepName], [StepType], [StepXml], [DataSourceId], [DataSourceControlId]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new FunctionExecStepInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7));

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


        public void ChangeOrderId(int logicId,string OrderType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LogicId", SqlDbType.Int),
                new SqlParameter("@OrderType",SqlDbType.VarChar)
            };

            parms[0].Value = logicId;
            parms[1].Value = OrderType;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SDP_FunctionExecStep_ChangeOrderId", parms);
        }
    }
}