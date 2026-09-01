using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Container.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Container.BLL
{
    public class ContainerPackingLevel
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ContainerPackingLevel 信息。
        /// </summary>
        /// <param name="entity">ContainerPackingLevel 实体对象。</param>
        //public Int32 Edit(ContainerPackingLevelInfo entity)
        //{
        //    SqlParameter[] parms = new SqlParameter[]{
        //        new SqlParameter("@ContainerPackingLevelId", SqlDbType.Int),
        //        new SqlParameter("@ContainerId", SqlDbType.Int),
        //        new SqlParameter("@Sequence", SqlDbType.Int),
        //        new SqlParameter("@PackingLevel", SqlDbType.NVarChar, 20),
        //        new SqlParameter("@PackingLevelValue", SqlDbType.NVarChar, 50),
        //        new SqlParameter("@Revision", SqlDbType.NVarChar, 10),
        //        new SqlParameter("@ProdOrderID", SqlDbType.Int),
        //        new SqlParameter("@MinQty", SqlDbType.Decimal),
        //        new SqlParameter("@MaxQty", SqlDbType.Decimal),
        //        new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
        //        new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
        //    };

        //    parms[0].Value = entity.ContainerPackingLevelId;
        //    parms[0].Direction = ParameterDirection.InputOutput;
        //    parms[1].Value = entity.ContainerId;
        //    parms[2].Value = entity.Sequence;
        //    parms[3].Value = entity.PackingLevel;
        //    parms[4].Value = entity.PackingLevelValue;
        //    parms[5].Value = entity.Revision;
        //    parms[6].Value = entity.ProdOrderID;
        //    parms[7].Value = entity.MinQty;
        //    parms[8].Value = entity.MaxQty;
        //    parms[9].Value = entity.ModifyBy;
        //    parms[10].Value = entity.CreateBy;

        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ContainerPackingLevel_Edit", parms);

        //    return (Int32)parms[0].Value;
        //}

        /// <summary>
        /// 根据 ContainerPackingLevelId 字符串删除 ContainerPackingLevel 信息。
        /// </summary>
        /// <param name="idString">ContainerPackingLevelId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ContainerPackingLevel_Delete", parms);
        }

        /// <summary>
        /// 根据 ContainerPackingLevelId 获取实体信息。
        /// </summary>
        /// <param name="containerPackingLevelId">ContainerPackingLevelId。</param>
        /// <returns>ContainerPackingLevel 实体对象。</returns>
        public ContainerPackingLevelInfo GetInfo(Int32 containerPackingLevelId)
        {
            ContainerPackingLevelInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = containerPackingLevelId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ContainerPackingLevel_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ContainerPackingLevelInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),rdr.GetString(13));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ContainerPackingLevel 实体对象。</returns>
        public List<ContainerPackingLevelInfo> GetInfo(String fieldValue)
        {
            List<ContainerPackingLevelInfo> list = new List<ContainerPackingLevelInfo>();
            ContainerPackingLevelInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ContainerPackingLevel_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new ContainerPackingLevelInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetDateTime(9),
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetString(13));
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 ContainerPackingLevel 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="containerPackingLevelCount">containerPackingLevel 总数。</param>
        /// <returns>ContainerPackingLevel 列表。</returns>
        //public List<ContainerPackingLevelInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        //{
        //    List<ContainerPackingLevelInfo> list = new List<ContainerPackingLevelInfo>();
        //    ContainerPackingLevelInfo entity = null;

        //    SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_ContainerPackingLevel", "ContainerPackingLevelId",
        //        "[ContainerPackingLevelId], [ContainerId], [Sequence], [PackingLevel], [PackingLevelValue], [Revision], [ProdOrderID], [MinQty], [MaxQty], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

        //    using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
        //    {
        //        while (rdr.Read())
        //        {
        //            entity = new ContainerPackingLevelInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
        //                rdr.GetString(5), rdr.GetInt32(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetDateTime(9), 
        //                rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));

        //            list.Add(entity);
        //        }
        //        rdr.Close();
        //    }

        //    recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
        //    return list;
        //}

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}