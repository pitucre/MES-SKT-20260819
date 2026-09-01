using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Material.BLL
{
    public class ERPPOorder
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） POorder 信息。
        /// </summary>
        /// <param name="entity">POorder 实体对象。</param>
        public Int32 Edit(ERPPOorderInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FactoryCode", SqlDbType.Int),
                new SqlParameter("@FinterID", SqlDbType.Int),
                new SqlParameter("@FBILLNO", SqlDbType.VarChar, 50),
                new SqlParameter("@FSupplierFnumber", SqlDbType.VarChar, 200),
                new SqlParameter("@FSupplierName", SqlDbType.VarChar, 200),
                new SqlParameter("@FSupplierID", SqlDbType.Int),
                new SqlParameter("@FADDRESS", SqlDbType.VarChar, 300),
                new SqlParameter("@FDATE", SqlDbType.DateTime),
                new SqlParameter("@FSTATUS", SqlDbType.VarChar, 10),
                new SqlParameter("@OperationState", SqlDbType.Int),
                new SqlParameter("@MESFState", SqlDbType.Int),
                new SqlParameter("@Default_1", SqlDbType.NChar, 10),
                new SqlParameter("@Default_2", SqlDbType.NChar, 10),
                new SqlParameter("@Default_3", SqlDbType.NChar, 10),
                new SqlParameter("@Default_4", SqlDbType.NChar, 10),
                new SqlParameter("@Default_5", SqlDbType.NChar, 10),
                new SqlParameter("@Default_6", SqlDbType.NChar, 10),
                new SqlParameter("@Default_7", SqlDbType.NChar, 10),
                new SqlParameter("@Default_8", SqlDbType.NChar, 10),
                new SqlParameter("@Default_9", SqlDbType.NChar, 10),
                new SqlParameter("@Default_10", SqlDbType.NChar, 10)
            };

            parms[0].Value = entity.FactoryCode;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.FinterID;
            parms[2].Value = entity.FBILLNO;
            parms[3].Value = entity.FSupplierFnumber;
            parms[4].Value = entity.FSupplierName;
            parms[5].Value = entity.FSupplierID;
            parms[6].Value = entity.FADDRESS;
            parms[7].Value = entity.FDATE;
            parms[8].Value = entity.FSTATUS;
            parms[9].Value = entity.OperationState;
            parms[10].Value = entity.MESFState;
            parms[11].Value = entity.Default_1;
            parms[12].Value = entity.Default_2;
            parms[13].Value = entity.Default_3;
            parms[14].Value = entity.Default_4;
            parms[15].Value = entity.Default_5;
            parms[16].Value = entity.Default_6;
            parms[17].Value = entity.Default_7;
            parms[18].Value = entity.Default_8;
            parms[19].Value = entity.Default_9;
            parms[20].Value = entity.Default_10;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "ERP_POorder_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 POorderId 字符串删除 POorder 信息。
        /// </summary>
        /// <param name="idString">POorderId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "ERP_POorder_Delete", parms);
        }

        /// <summary>
        /// 根据 POorderId 获取实体信息。
        /// </summary>
        /// <param name="pOorderId">POorderId。</param>
        /// <returns>POorder 实体对象。</returns>
        public ERPPOorderInfo GetInfo(Int32 pOorderId)
        {
            ERPPOorderInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = pOorderId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "ERP_POorder_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ERPPOorderInfo(rdr.GetString(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetInt32(9), 
                        rdr.GetInt32(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14), 
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>POorder 实体对象。</returns>
        public ERPPOorderInfo GetInfo(String fieldValue)
        {     
            ERPPOorderInfo entity = null;
            
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "ERP_POorder_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ERPPOorderInfo(rdr.GetString(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetInt32(9), 
                        rdr.GetInt32(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14), 
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20));
                   
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>POorder 实体对象。</returns>
        public ERPPOorderInfo GetBillNoInfo(string billNo,int lineNo,string itemCode)
        {
            ERPPOorderInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@BillNo", SqlDbType.VarChar, 50), 
                new SqlParameter("@LineNo", SqlDbType.Int),
                new SqlParameter("@ItemCode",SqlDbType.NVarChar,50)
            };

            parms[0].Value = billNo;
            parms[1].Value = lineNo;
            parms[2].Value = itemCode;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "ERP_POorder_GetBillNoInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ERPPOorderInfo();
                    entity.FBILLNO = rdr.GetString(0);
                    entity.FinterID = rdr.GetString(1);
                    entity.ErpItemId = rdr.GetInt32(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.ItemName = rdr.GetString(4);
                    entity.VendorCode = rdr.GetString(5);
                    entity.VendorName = rdr.GetString(6);
                    entity.POLineGrnQty = rdr.GetDecimal(7);
                    entity.POQty = rdr.GetDecimal(8);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 POorder 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="pOorderCount">pOorder 总数。</param>
        /// <returns>POorder 列表。</returns>
        public List<ERPPOorderInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ERPPOorderInfo> list = new List<ERPPOorderInfo>();
            ERPPOorderInfo entity = null;

            //Add By Alen 2015-08-11 增加Site的过滤，如果site为空则获取全部数据，否则根据site过滤
            string site = System.Configuration.ConfigurationManager.AppSettings["Site"];
            if (!String.IsNullOrEmpty(site))
            {
                searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? " [FactoryCode] = '" + site + "' " : " and [FactoryCode] = '" + site + "' ";
            }

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwErpPoOrder", "FinterID",
                "[FactoryCode], [FinterID], [FBILLNO], [VendorCode], [VendorName], [SupplierId], [FADDRESS], [FDATE], [FSTATUS], [OperationState], [MESFState], [Default_1], [Default_2], [Default_3], [Default_4], [Default_5], [Default_6], [Default_7], [Default_8], [Default_9], [Default_10]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ERPPOorderInfo(rdr.GetString(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetInt32(9),
                        rdr.GetInt32(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14),
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19),
                        rdr.GetString(20));

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