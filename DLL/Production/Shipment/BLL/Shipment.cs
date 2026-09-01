using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Shipment.Model;

namespace SKT.LeanMES.Shipment.BLL
{
    public class Shipment
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Shipment 信息。
        /// </summary>
        /// <param name="entity">Shipment 实体对象。</param>
        public Int32 Edit(ShipmentInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ShipmentId", SqlDbType.Int),
                new SqlParameter("@OrderNO", SqlDbType.NVarChar, 100),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@Qty", SqlDbType.Decimal),
                new SqlParameter("@ShipDate", SqlDbType.DateTime),
                new SqlParameter("@State", SqlDbType.TinyInt),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@AuditBy", SqlDbType.VarChar, 50),
                new SqlParameter("@AuditDateTime", SqlDbType.DateTime),
                new SqlParameter("@RejectBy", SqlDbType.VarChar, 50),
                new SqlParameter("@RejectDateTime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.ShipmentId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.OrderNO;
            parms[2].Value = entity.ItemId;
            parms[3].Value = entity.Qty;
            parms[4].Value = entity.ShipDate;
            parms[5].Value = entity.State;
            parms[6].Value = entity.Remark;
            parms[7].Value = entity.AuditBy;
            parms[8].Value = entity.AuditDateTime;
            parms[9].Value = entity.RejectBy;
            parms[10].Value = entity.RejectDateTime;
            parms[11].Value = entity.CreateBy;
            parms[12].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Shipment_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ShipmentId 字符串删除 Shipment 信息。
        /// </summary>
        /// <param name="idString">ShipmentId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Shipment_Delete", parms);
        }

        /// <summary>
        /// 根据 ShipmentId 获取实体信息。
        /// </summary>
        /// <param name="shipmentId">ShipmentId。</param>
        /// <returns>Shipment 实体对象。</returns>
        public ShipmentInfo GetInfo(Int32 shipmentId)
        {
            ShipmentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = shipmentId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Shipment_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ShipmentInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetDateTime(4), 
                        rdr.GetByte(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Shipment 实体对象。</returns>
        public ShipmentInfo GetInfo(String fieldValue)
        {
            ShipmentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Shipment_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ShipmentInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetDateTime(4), 
                        rdr.GetByte(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Shipment 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="shipmentCount">shipment 总数。</param>
        /// <returns>Shipment 列表。</returns>
        public List<ShipmentInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShipmentInfo> list = new List<ShipmentInfo>();
            ShipmentInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_Shipment", "ShipmentId",
                "[ShipmentId], [OrderNO], [ItemId], [Qty], [ShipDate], [State], [Remark], [AuditBy], [AuditDateTime], [RejectBy], [RejectDateTime], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ShipmentInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetDateTime(4), 
                        rdr.GetByte(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14));

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