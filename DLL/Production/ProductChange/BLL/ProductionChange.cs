using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using SKT.Common.Model;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.ProductChange.Model;

namespace SKT.LeanMES.ProductChange.BLL
{
    public class ProductionChange
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ProductionChange 信息。
        /// </summary>
        /// <param name="entity">ProductionChange 实体对象。</param>
        public Int32 Edit(ProductionChangeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProductionChangeId", SqlDbType.Int),
                new SqlParameter("@SerialNumber", SqlDbType.NVarChar, 50),
                new SqlParameter("@OldRouterId", SqlDbType.Int),
                new SqlParameter("@OldStationId", SqlDbType.Int),
                new SqlParameter("@NewRouterId", SqlDbType.Int),
                new SqlParameter("@NewStationId", SqlDbType.Int),
                new SqlParameter("@CreatedBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@CretatedTime", SqlDbType.DateTime)
            };

            parms[0].Value = entity.ProductionChangeId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.SerialNumber;
            parms[2].Value = entity.OldRouterId;
            parms[3].Value = entity.OldStationId;
            parms[4].Value = entity.NewRouterId;
            parms[5].Value = entity.NewStationId;
            parms[6].Value = entity.CreatedBy;
            parms[7].Value = entity.CretatedTime;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ProductionChange_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ProductionChangeId 字符串删除 ProductionChange 信息。
        /// </summary>
        /// <param name="idString">ProductionChangeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ProductionChange_Delete", parms);
        }

        /// <summary>
        /// 根据 ProductionChangeId 获取实体信息。
        /// </summary>
        /// <param name="productionChangeId">ProductionChangeId。</param>
        /// <returns>ProductionChange 实体对象。</returns>
        public ProductionChangeInfo GetInfo(Int32 productionChangeId)
        {
            ProductionChangeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = productionChangeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ProductionChange_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProductionChangeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(4),
                        rdr.GetInt32(6), rdr.GetInt32(8), rdr.GetString(10), rdr.GetDateTime(11));

                    entity.OldRouterName = rdr.GetString(3);
                    entity.OldStationName = rdr.GetString(5);
                    entity.NewRouterName = rdr.GetString(7);
                    entity.NewRouterName = rdr.GetString(9);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ProductionChange 实体对象。</returns>
        public ProductionChangeInfo GetInfo(String fieldValue)
        {
            ProductionChangeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ProductionChange_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProductionChangeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(4),
                        rdr.GetInt32(6), rdr.GetInt32(8), rdr.GetString(10), rdr.GetDateTime(11));

                    entity.OldRouterName = rdr.GetString(3);
                    entity.OldStationName = rdr.GetString(5);
                    entity.NewRouterName = rdr.GetString(7);
                    entity.NewRouterName = rdr.GetString(9);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ProductionChange 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="productionChangeCount">productionChange 总数。</param>
        /// <returns>ProductionChange 列表。</returns>
        public List<ProductionChangeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ProductionChangeInfo> list = new List<ProductionChangeInfo>();
            ProductionChangeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetProductionChangeList", "ProductionChangeId",
                "ProductionChangeId,SerialNumber,OldOrderNo,NewOrderNo,OldRouterName,NewRouterName,OldStation,NewStation,CreatedBy,CretatedTime,Remark", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProductionChangeInfo();
                    entity.ProductionChangeId = rdr.GetInt32(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.OldOrderNo = rdr.GetString(2);
                    entity.NewOrderNo = rdr.GetString(3);
                    entity.OldRouterName = rdr.GetString(4);
                    entity.NewRouterName = rdr.GetString(5);
                    entity.OldStationName = rdr.GetString(6);
                    entity.NewStationName = rdr.GetString(7);
                    entity.CreatedBy = rdr.GetString(8);
                    entity.CretatedTime = rdr.GetDateTime(9);
                    entity.Remark = rdr.GetString(10);

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
