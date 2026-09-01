using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Container.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Container.BLL
{
    public class FloorInfo
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） FloorInfo 信息。
        /// </summary>
        /// <param name="entity">FloorInfo 实体对象。</param>
        public Int32 Edit(FloorInfoInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Fid", SqlDbType.Int),
                new SqlParameter("@Code", SqlDbType.NVarChar, 100),
                new SqlParameter("@Name", SqlDbType.NVarChar, 100),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200)
            };

            parms[0].Value = entity.Fid;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Code;
            parms[2].Value = entity.Name;
            parms[3].Value = entity.Status;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_FloorInfo_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 FloorInfoId 字符串删除 FloorInfo 信息。
        /// </summary>
        /// <param name="idString">FloorInfoId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_FloorInfo_Delete", parms);
        }

        /// <summary>
        /// 根据 FloorInfoId 获取实体信息。
        /// </summary>
        /// <param name="floorInfoId">FloorInfoId。</param>
        /// <returns>FloorInfo 实体对象。</returns>
        public FloorInfoInfo GetInfo(Int32 floorInfoId)
        {
            FloorInfoInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = floorInfoId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_FloorInfo_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FloorInfoInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FloorInfo 实体对象。</returns>
        public FloorInfoInfo GetInfo(String fieldValue)
        {
            FloorInfoInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_FloorInfo_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FloorInfoInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 FloorInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="floorInfoCount">floorInfo 总数。</param>
        /// <returns>FloorInfo 列表。</returns>
        public List<FloorInfoInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FloorInfoInfo> list = new List<FloorInfoInfo>();
            FloorInfoInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_FloorInfo", "Fid",
                "[Fid], [Code], [Name], [Status], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new FloorInfoInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));

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