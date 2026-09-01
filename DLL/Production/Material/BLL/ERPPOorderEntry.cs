using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Material.BLL
{
    public class ERPPOorderEntry
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 根据 POorderEntryId 获取实体信息。
        /// </summary>
        /// <param name="pOorderEntryId">POorderEntryId。</param>
        /// <returns>POorderEntry 实体对象。</returns>
        public ERPPOorderEntryInfo GetInfo(Int32 pOorderEntryId)
        {
            ERPPOorderEntryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = pOorderEntryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspPOorderEntry_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ERPPOorderEntryInfo(rdr.GetString(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDecimal(8), rdr.GetDecimal(9), 
                        rdr.GetDecimal(10), rdr.GetDecimal(11), rdr.GetString(12), rdr.GetInt32(13), rdr.GetInt32(14), 
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>POorderEntry 实体对象。</returns>
        public ERPPOorderEntryInfo GetInfo(String fieldValue)
        {
            ERPPOorderEntryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspPOorderEntry_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ERPPOorderEntryInfo(rdr.GetString(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDecimal(8), rdr.GetDecimal(9), 
                        rdr.GetDecimal(10), rdr.GetDecimal(11), rdr.GetString(12), rdr.GetInt32(13), rdr.GetInt32(14), 
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 POorderEntry 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="pOorderEntryCount">pOorderEntry 总数。</param>
        /// <returns>POorderEntry 列表。</returns>
        public List<ERPPOorderEntryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ERPPOorderEntryInfo> list = new List<ERPPOorderEntryInfo>();
            ERPPOorderEntryInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwErpPoOrderEntry", "FEntryid",
                "[FInterID], [FBILLNO], [FEntryid], [ItemCode], [ItemName], [ItemModel], [FDATE], [FUnitID], [FQty], [FMESQty], [FStockQty], [FReturnQty], [FSTATUS], [OperationState], [MESFState], [Default_1], [Default_2], [Default_3], [Default_4], [Default_5], [PODATE]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ERPPOorderEntryInfo(rdr.GetString(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDecimal(8), rdr.GetDecimal(9), 
                        rdr.GetDecimal(10), rdr.GetDecimal(11), rdr.GetString(12), rdr.GetInt32(13), rdr.GetInt32(14), 
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19));
                    entity.PODate = rdr.GetDateTime(20);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 根据采购订单号获取采购订单表体列表
        /// </summary>
        /// <param name="billNo"></param>
        /// <returns></returns>
        public List<ERPPOorderEntryInfo> GetPOEntryByBillNum(String billNo)
        {
            List<ERPPOorderEntryInfo> list = new List<ERPPOorderEntryInfo>();
            ERPPOorderEntryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@BillNum", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = billNo;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspPOorderEntryByBillNum", parms))
            {
                if (rdr.Read())
                {
                    entity = new ERPPOorderEntryInfo(rdr.GetString(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDecimal(8), rdr.GetDecimal(9),
                        rdr.GetDecimal(10), rdr.GetDecimal(11), rdr.GetString(12), rdr.GetInt32(13), rdr.GetInt32(14),
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19));
                }
                rdr.Close();
            }
            return list;
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}