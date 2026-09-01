using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Turnover.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Turnover.BLL
{
    public class StockCar
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） StockCar 信息。
        /// </summary>
        /// <param name="entity">StockCar 实体对象。</param>
        public void Edit(StockCarInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StockCarId", SqlDbType.Int),
                new SqlParameter("@StockCarNumber", SqlDbType.NVarChar, 100),
                new SqlParameter("@StockTypeId", SqlDbType.Int),
                new SqlParameter("@Status", SqlDbType.TinyInt),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@MinQty", SqlDbType.Int),
                new SqlParameter("@MaxQty", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar,100)
            };

            parms[0].Value = entity.StockCarId;
            parms[1].Value = entity.StockCarNumber;
            parms[2].Value = entity.StockTypeId;
            parms[3].Value = entity.Status;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.MinQty;
            parms[7].Value = entity.MaxQty;
            parms[8].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StockCarEdit", parms);

        }

        /// <summary>
        /// 根据 StockCarId 字符串删除 StockCar 信息。
        /// </summary>
        /// <param name="idString">StockCarId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StockCarDelete", parms);
        }

        /// <summary>
        /// 根据 StockCarId 获取实体信息。
        /// </summary>
        /// <param name="stockCarId">StockCarId。</param>
        /// <returns>StockCar 实体对象。</returns>
        public StockCarInfo GetInfo(Int32 stockCarId)
        {
            StockCarInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = stockCarId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StockCarGetInfo", parms))
            {
                if (rdr.Read())
                {
                   entity = new StockCarInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetByte(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                    entity.MinQty = rdr.GetInt32(8);
                    entity.MaxQty = rdr.GetInt32(9);
                    entity.Remark = rdr.GetString(10);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>StockCar 实体对象。</returns>
        public StockCarInfo GetInfo(String fieldValue)
        {
            StockCarInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StockCarGetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 StockCar 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="stockCarCount">stockCar 总数。</param>
        /// <returns>StockCar 列表。</returns>
        public List<StockCarInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string queryColumns = "StockCarId, StockCarNumber, StockTypeName, StatusName, MinQty, MaxQty, CreateDateTime,Remark,CreateBy,ModifyBy,ModifyDateTime";
            var list = ComMethod.GetComList<StockCarInfo>(ref this.recordCount, startRow, maxRows, "vwGetBasalStockCar", "StockCarId", queryColumns, sortExpression, searchSettings);
            return list;
            //List<StockCarInfo> list = new List<StockCarInfo>();
            //StockCarInfo entity = null;

            //SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetBasalStockCar", "StockCarID",
            //    "StockCarId, StockCarNumber, StockTypeName, StatusName, MinQty, MaxQty, CreateDateTime,Remark", searchSettings, sortExpression);

            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            //{
            //    while (rdr.Read())
            //    {
            //        entity = new StockCarInfo();
            //        entity.StockCarId = rdr.GetInt32(0);
            //        entity.StockCarNumber = rdr.GetString(1);
            //        entity.StockTypeName = rdr.GetString(2);
            //        entity.StatusName = rdr.GetString(3);
            //        entity.MinQty = rdr.GetInt32(4);
            //        entity.MaxQty = rdr.GetInt32(5);
            //        entity.CreateDateTime = rdr.GetDateTime(6);
            //        entity.Remark = rdr.GetString(7);
            //        list.Add(entity);
            //    }
            //    rdr.Close();
            //}

            //recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            //return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}