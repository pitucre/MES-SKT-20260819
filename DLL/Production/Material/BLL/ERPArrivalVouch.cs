using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Material.BLL
{
    public class ERPArrivalVouch
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PU_ArrivalVouch 实体对象。</returns>
        public ERPArrivalVouchInfo GetInfo(String fieldValue)
        {
            ERPArrivalVouchInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "ERP_PU_ArrivalVouch_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ERPArrivalVouchInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDateTime(2), rdr.GetString(3), 
                        rdr.GetInt32(5));
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 根据 字段值 获取实体信息。 从U811PU_ArrivalVouch获取
        /// add zhibin.chen 2015-05-29
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <param name="u8erp">方法重载的识别标识</param>
        /// <returns>PU_ArrivalVouch 实体对象。</returns>
        public ERPArrivalVouchInfo GetInfo(String fieldValue, String u8erp)
        {
            ERPArrivalVouchInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "U811PU_ArrivalVouch_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ERPArrivalVouchInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDateTime(2), rdr.GetString(3),
                        rdr.GetInt32(5));
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 分页获取 ERPArrivalVouchInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="pU_ArrivalVouchCount">ERPArrivalVouchInfo 总数。</param>
        /// <returns>ERPArrivalVouchInfo 列表。</returns>
        public List<ERPArrivalVouchInfo> GetCanBeRecFormList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ERPArrivalVouchInfo> list = new List<ERPArrivalVouchInfo>();
            ERPArrivalVouchInfo entity = null;

            searchSettings.ExtensionCondition = "MESState!=9 and MESState!=10 and MESState!=2 and status=1";

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[InterfaceERP_POInStock]", "ID",
                "[ID], [Code], isnull([Date],'2012-06-03'), [VenCode],[MESState]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ERPArrivalVouchInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDateTime(2), rdr.GetString(3), 
                        rdr.GetInt32(4));
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
        /// 根据到货单单号，获取该到货单的明细列表。
        /// </summary>
        /// <param name="formNO">到货单单号</param>
        /// <returns></returns>
        public List<ERPArrivalVouchsInfo> ArrivalFormSelect(string formNO)
        {
            List<ERPArrivalVouchsInfo> list = new List<ERPArrivalVouchsInfo>();
            ERPArrivalVouchsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@FormNO",SqlDbType.NVarChar)};
            parms[0].Value = formNO;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetArrivalFormDetail", parms))
            {
                while (rdr.Read())
                {
                    entity = new ERPArrivalVouchsInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetFloat(2), rdr.GetDecimal(3), rdr.GetDecimal(4), rdr.GetInt32(5), rdr.GetInt32(6));

                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 分页获取收料
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemCount">item 总数。</param>
        /// <returns>Item 列表。</returns>
        public List<ERPArrivalVouchsInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ERPArrivalVouchsInfo> list = new List<ERPArrivalVouchsInfo>();
            ERPArrivalVouchsInfo entity = null;

            try
            {
                SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " [vwGetPOInStockDetail]", "AutoIDs",
                    "[Autoid], [ItemCode], [Qty], [ItemName],[Date],[itemDes],[VenCode],VendorName,[Code],[IdS]", searchSettings, sortExpression);

                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
                {
                    while (rdr.Read())
                     {
                    //    rdr.GetInt32(0);
                    //    rdr.GetString(1);
                    //    rdr.GetFloat(2);
                    //    rdr.GetString(3);
                    //    rdr.GetDateTime(4);
                    //    rdr.GetString(5);
                    //    rdr.GetString(6);
                    //    rdr.GetString(7);
                    //    rdr.GetString(8);
                        entity = new ERPArrivalVouchsInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDouble(2),rdr.GetString(3), rdr.GetDateTime(4), rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8),rdr.GetString(9));
                        list.Add(entity);

                    }
                    rdr.Close();
                }            
                recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            }catch(Exception ex)
            {
                return null;
            }
         return list;
        }

    }
}