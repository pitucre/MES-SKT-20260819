using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.MobileMat.Model;

namespace SKT.LeanMES.MobileMat.BLL
{
    public class FinishProdShipmentDetail
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） FinishProdOut 信息。
        /// </summary>
        /// <param name="entity">Shipment 实体对象。</param>
        public Int32 Edit(FinishProdShipmentDetailInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ShipmentDetailId", SqlDbType.Int),
                new SqlParameter("@ShipmentId", SqlDbType.NVarChar, 30),
                new SqlParameter("@ItemId", SqlDbType.VarChar,50)
            };
            parms[0].Value = entity.ShipmentDetailId;
            parms[0].Direction = ParameterDirection.Output;
            parms[1].Value = entity.ShipmentId;
            parms[2].Value = entity.ItemId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_finishprodshipmentdetail_edit", parms);
            return (Int32)parms[0].Value;
        }
        /// <summary>
        /// 根据 ShipmentDetailId 字符串删除 Prod_FinishProdOutDtl 信息。
        /// </summary>
        /// <param name="idString">ShipmentId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000)
            };
            parms[0].Value = idString;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Shipment_Delete", parms);
        }
        /// <summary>
        /// 根据 ShipmentDetailId 获取实体信息。
        /// </summary>
        /// <param name="ShipmentDetailId">ShipmentDetailId。</param>
        /// <returns>FinishProdOutInfo 实体对象。</returns>
        public FinishProdShipmentDetailInfo GetInfo(Int32 ShipmentId)
        {
            FinishProdShipmentDetailInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };
            parms[0].Value = ShipmentId;
            parms[1].Value = true;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_FinishProdShipment_getInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FinishProdShipmentDetailInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2));
                }
                rdr.Close();
            }
            return entity;
        }
        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FinishProdOutDtlInfo 实体对象。</returns>
        public FinishProdShipmentDetailInfo GetInfo(String fieldValue)
        {
            FinishProdShipmentDetailInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };
            parms[0].Value = fieldValue;
            parms[1].Value = false;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_FinishProdShipment_getInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FinishProdShipmentDetailInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2));
                }
                rdr.Close();
            }
            return entity;
        }
        /// <summary>
        /// 分页获取 FinishProdOutDtlInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="shipmentCount">shipment 总数。</param>
        /// <returns>Shipment 列表。</returns>
        public List<FinishProdShipmentDetailInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FinishProdShipmentDetailInfo> list = new List<FinishProdShipmentDetailInfo>();
            FinishProdShipmentDetailInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_FinishProdShipment", "ShipmentDetailId",
                "ShipmentDetailId,ShipmentId,ItemId", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new FinishProdShipmentDetailInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2));

                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 取得记录个数
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
