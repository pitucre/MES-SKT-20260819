using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.PieceWage.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper;
using SKT.LeanMES.CommonHelper.BLL;
namespace SKT.LeanMES.PieceWage.BLL
{
    public class StationOutputRate
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 新增数据
        /// </summary>
        /// <param name="strJson"></param>
        public void Edit(string strJson)
        {
            ComMethod.Edit(strJson, "Basal_StationOutputRate_Edit");
        }

        /// <summary>
        /// 根据 StationOutputRateId 字符串删除 StationOutputRate 信息。
        /// </summary>
        /// <param name="idString">StationOutputRateId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationOutputRate_Delete", parms);
        }

        /// <summary>
        /// 根据 StationOutputRateId 获取实体信息。
        /// </summary>
        /// <param name="stationOutputRateId">StationOutputRateId。</param>
        /// <returns>StationOutputRate 实体对象。</returns>
        public StationOutputRateInfo GetInfo(Int32 stationOutputRateId)
        {
            StationOutputRateInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = stationOutputRateId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StationOutputRate_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StationOutputRateInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDecimal(2), rdr.GetDecimal(3), rdr.GetDecimal(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetString(8));
                    entity.ProductTypeID = rdr.GetInt32(9);
                    entity.Station = rdr.GetString(10);
                }

                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>StationOutputRate 实体对象。</returns>
        public StationOutputRateInfo GetInfo(String fieldValue)
        {
            StationOutputRateInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StationOutputRate_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StationOutputRateInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDecimal(2), rdr.GetDecimal(3), rdr.GetDecimal(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetString(8));
                    entity.ProductTypeID = rdr.GetInt32(9);
                    entity.Station = rdr.GetString(10);
                   

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 StationOutputRate 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="stationOutputRateCount">stationOutputRate 总数。</param>
        /// <returns>StationOutputRate 列表。</returns>
        public List<StationOutputRateInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<StationOutputRateInfo> list = new List<StationOutputRateInfo>();
            StationOutputRateInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwStationOutputRate", "StationOutputRateId",
                "[StationOutputRateId], [StationID], [StartRate], [EndRate], [Coefficient], [CreateBy], [CreateDateTime], [Remark], [ProductType],ProductTypeID,Station", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationOutputRateInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDecimal(2), rdr.GetDecimal(3), rdr.GetDecimal(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetString(8));
                    entity.ProductTypeID = rdr.GetInt32(9);
                    entity.Station = rdr.GetString(10);
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