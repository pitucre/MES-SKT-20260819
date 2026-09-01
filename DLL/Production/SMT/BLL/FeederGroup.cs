using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class FeederGroup
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） FEEDERGROUP 信息。
        /// </summary>
        /// <param name="entity">FEEDERGROUP 实体对象。</param>
        public Int32 Edit(FeederGroupInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@MachineModelID", SqlDbType.Int),
                new SqlParameter("@MinSize", SqlDbType.Int),
                new SqlParameter("@MaxSize", SqlDbType.Int)
            };

            parms[0].Value = entity.ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MachineModelID;
            parms[2].Value = entity.MinSize;
            parms[3].Value = entity.MaxSize;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_FeederGroup_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 FEEDERGROUPId 字符串删除 FEEDERGROUP 信息。
        /// </summary>
        /// <param name="idString">FEEDERGROUPId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_FeederGroup_Delete", parms);
        }

        /// <summary>
        /// 根据 FEEDERGROUPId 获取实体信息。
        /// </summary>
        /// <param name="fEEDERGROUPId">FEEDERGROUPId。</param>
        /// <returns>FEEDERGROUP 实体对象。</returns>
        public FeederGroupInfo GetInfo(Int32 fEEDERGROUPId)
        {
            FeederGroupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fEEDERGROUPId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_FeederGroup_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FeederGroupInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4));

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FEEDERGROUP 实体对象。</returns>
        public FeederGroupInfo GetInfo(String fieldValue)
        {
            FeederGroupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_FeederGroup_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 FEEDERGROUP 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="fEEDERGROUPCount">fEEDERGROUP 总数。</param>
        /// <returns>FEEDERGROUP 列表。</returns>
        public List<FeederGroupInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FeederGroupInfo> list = new List<FeederGroupInfo>();
            FeederGroupInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "[dbo].[Basal_FeederGroup] A left join Basal_MachineModel B on a.MachineModelID=b.ModelID"
                , "ID"
                , "a.ID,a.MachineModelID,ISNULL(b.ModelName,'')AS ModelName,a.MinSize,a.MaxSize"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new FeederGroupInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4));

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