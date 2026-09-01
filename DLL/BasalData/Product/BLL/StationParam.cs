using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Product.BLL
{
    public class StationParam
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） StationParam 信息。
        /// </summary>
        /// <param name="entity">StationParam 实体对象。</param>
        public void Edit(StationParamInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ParamXML", SqlDbType.Xml),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.ItemId;
            parms[1].Value = entity.ParamName;
            parms[2].Value = entity.CreateBy;
            parms[3].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationParam_Edit", parms);

        }

        /// <summary>
        /// 根据 StationParamId 字符串删除 StationParam 信息。
        /// </summary>
        /// <param name="idString">StationParamId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationParam_Delete", parms);
        }

        /// <summary>
        /// 根据 StationParamId 获取实体信息。
        /// </summary>
        /// <param name="stationParamId">StationParamId。</param>
        /// <returns>StationParam 实体对象。</returns>
        public StationParamInfo GetInfo(Int32 stationParamId)
        {
            StationParamInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = stationParamId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StationParam_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StationParamInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetString(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>StationParam 实体对象。</returns>
        public StationParamInfo GetInfo(String fieldValue)
        {
            StationParamInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StationParam_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StationParamInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetString(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 StationParam 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="stationParamCount">stationParam 总数。</param>
        /// <returns>StationParam 列表。</returns>
        public List<StationParamInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<StationParamInfo> list = new List<StationParamInfo>();
            StationParamInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasalStationParam", "StationParamId",
                "[StationParamId], [ItemId], [StationId], [ParamName], [ParamValue], [ParamSeq], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime],[ItemName],[Station]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationParamInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetString(11));

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
        /// <summary>
        /// 根据ItemId获取该物料已配置参数列表
        /// </summary>
        /// <param name="ItemId">物料Id</param>
        /// <returns>StationParam参数列表</returns>
        public List<StationParamInfo> GetStationParamList(Int32 ItemId)
        {
            List<StationParamInfo> list = new List<StationParamInfo>();
            StationParamInfo entity = null;

            SearchSettings searchSettings = new SearchSettings();
            //  searchSettings.AddCondition("ItemId",ItemId.ToString());
            searchSettings.ExtensionCondition = "ItemId =" + ItemId + "";

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, 99, "vwBasalGetStationParamByItemId", "StationParamId", "[StationParamId],[ItemId],[ParamSeq],[StationId],[Station],[ParamName], [ParamValue]", searchSettings, "ParamName");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationParamInfo();
                    entity.StationParamId = rdr.GetInt32(0);
                    entity.ItemId = rdr.GetInt32(1);
                    entity.ParamSeq = rdr.GetInt32(2);
                    entity.StationId = rdr.GetInt32(3);
                    entity.Station = rdr.GetString(4);
                    entity.ParamName = rdr.GetString(5);
                    entity.ParamValue = rdr.GetString(6);

                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 根据产品id和工位id查询
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="StationId"></param>
        /// <returns></returns>
        public List<StationParamInfo> GetStationParamListByStationId(Int32 ItemId, Int32 StationId)
        {
            List<StationParamInfo> list = new List<StationParamInfo>();
            StationParamInfo entity = null;

            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = "ItemId = " + ItemId + " and StationId = " + StationId;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1, "vwBasalGetStationParamByItemId", "StationParamId",
                "[StationParamId],[ItemId],[ParamSeq],[StationId],[Station],[ParamName], [ParamValue]", searchSettings, "ParamSeq");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationParamInfo();
                    entity.StationParamId = rdr.GetInt32(0);
                    entity.ItemId = rdr.GetInt32(1);
                    entity.ParamSeq = rdr.GetInt32(2);
                    entity.StationId = rdr.GetInt32(3);
                    entity.Station = rdr.GetString(4);
                    entity.ParamName = rdr.GetString(5);
                    entity.ParamValue = rdr.GetString(6);

                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }
    }
}