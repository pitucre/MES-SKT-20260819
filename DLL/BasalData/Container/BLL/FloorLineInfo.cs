using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Container.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Container.BLL
{
    public class FloorLineInfo
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） FloorLineInfo 信息。
        /// </summary>
        /// <param name="entity">FloorLineInfo 实体对象。</param>
        public Int32 Edit(FloorLineInfoInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FLId", SqlDbType.Int),
                new SqlParameter("@Fid", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200)
            };

            parms[0].Value = entity.FLId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Fid;
            parms[2].Value = entity.LineId;
            parms[3].Value = entity.Status;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_FloorLineInfo_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 FloorLineInfoId 字符串删除 FloorLineInfo 信息。
        /// </summary>
        /// <param name="idString">FloorLineInfoId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_FloorLineInfo_Delete", parms);
        }

        /// <summary>
        /// 根据 FloorLineInfoId 获取实体信息。
        /// </summary>
        /// <param name="floorLineInfoId">FloorLineInfoId。</param>
        /// <returns>FloorLineInfo 实体对象。</returns>
        public FloorLineInfoInfo GetInfo(Int32 floorLineInfoId)
        {
            FloorLineInfoInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = floorLineInfoId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_FloorLineInfo_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FloorLineInfoInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.FName = rdr.GetString(9);
                    entity.LineName = rdr.GetString(10);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FloorLineInfo 实体对象。</returns>
        public FloorLineInfoInfo GetInfo(String fieldValue)
        {
            FloorLineInfoInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_FloorLineInfo_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FloorLineInfoInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.FName = rdr.GetString(9);
                    entity.LineName = rdr.GetString(10);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 FloorLineInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="floorLineInfoCount">floorLineInfo 总数。</param>
        /// <returns>FloorLineInfo 列表。</returns>
        public List<FloorLineInfoInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FloorLineInfoInfo> list = new List<FloorLineInfoInfo>();
            FloorLineInfoInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwFloorLineInfo", "FLId",
                "[FLId], [Fid], [LineId], [Status], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[FName],[LineName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new FloorLineInfoInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.FName = rdr.GetString(9);
                    entity.LineName = rdr.GetString(10);

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