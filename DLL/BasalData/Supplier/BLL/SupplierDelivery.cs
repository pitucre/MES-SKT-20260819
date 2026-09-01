using System;
using System.Data;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Supplier.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Supplier.BLL
{
    public class SupplierDelivery
    {
        private Int32 recordCount = 0;
        public string Save(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierDelivery", SqlDbType.Int),                
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@tbDtl", SqlDbType.Structured)
            };
            parms[0].Direction = ParameterDirection.InputOutput;
            ComMethod.Edit<SupplierDeliveryInfo>(strJson, "uspSaveSupplierDelivery", parms);
            return parms[0].Value.ToString();
        }

        /// <summary>
        /// 根据 SupplierDeliveryId 字符串删除 SupplierDelivery 信息。
        /// </summary>
        /// <param name="idString">SupplierDeliveryId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SupplierDelivery_Delete", parms);
        }

        /// <summary>
        /// 根据 SupplierDeliveryId 获取实体信息。
        /// </summary>
        /// <param name="supplierDeliveryId">SupplierDeliveryId。</param>
        /// <returns>SupplierDelivery 实体对象。</returns>
        public SupplierDeliveryInfo GetInfo(Int32 supplierDeliveryId)
        {
            SupplierDeliveryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = supplierDeliveryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SupplierDelivery_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SupplierDeliveryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDecimal(5), rdr.GetDecimal(6), rdr.GetDecimal(7), rdr.GetDateTime(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14), 
                        rdr.GetDateTime(15), rdr.GetDateTime(15));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SupplierDelivery 实体对象。</returns>
        public SupplierDeliveryInfo GetInfo(String fieldValue)
        {
            SupplierDeliveryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SupplierDelivery_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SupplierDeliveryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDecimal(5), rdr.GetDecimal(6), rdr.GetDecimal(7), rdr.GetDateTime(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14), 
                        rdr.GetDateTime(15), rdr.GetDateTime(15));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SupplierDelivery 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="supplierDeliveryCount">supplierDelivery 总数。</param>
        /// <returns>SupplierDelivery 列表。</returns>
        public List<SupplierDeliveryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierDeliveryInfo> list = new List<SupplierDeliveryInfo>();
            SupplierDeliveryInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_SupplierDelivery", "SupplierDeliveryId",
                "[SupplierDeliveryId], [POCode], [ItemId], [ItemCode], [SuplierCode], [ItemQty], [UnpaidQty], [FinishQty], [PlanDateTime], [ActualDateTime], [Remark], [DeliveryMan], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime],ConfirmDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SupplierDeliveryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDecimal(5), rdr.GetDecimal(6), rdr.GetDecimal(7), rdr.GetDateTime(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14), 
                        rdr.GetDateTime(15), rdr.GetDateTime(16));

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

        // 可收料的采购订单列表
        public List<SupplierDeliveryInfo> GetPoOrderList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierDeliveryInfo> list = new List<SupplierDeliveryInfo>();
            //表名或者视图
            string strTb = "vwPoSupplier";
            //主键
            string strKey = "SupplierId";
            //查询栏位字串
            string strColumns = @"[POID], [POCode], [VendorCode], [VendorName], SupplierId";
            list = ComMethod.GetComList<SupplierDeliveryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            
            return list;
        }

        /// <summary>
        /// 供应商生成物料条码—选择采购单
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SupplierDeliveryInfo> SupplierDeliveryPONotPrintComplete(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierDeliveryInfo> list = new List<SupplierDeliveryInfo>();

            sortExpression = "PurDate DESC";
            //表名或者视图
            string strTb = "vwSupplierDeliveryPONotPrintComplete";
            //主键
            string strKey = "SupplierId";
            //查询栏位字串
            string strColumns = @"[POID], [POCode], [VendorCode], [VendorName], SupplierId,[FactoryCode],PurDate";
            list = ComMethod.GetComList<SupplierDeliveryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            list = list.OrderByDescending(q => q.PurDate).ToList();

            return list;
        }


        // 供应商交期维护-选择可以维护的采购订单列表
        public List<SupplierDeliveryInfo> SupplierDeliveryPO(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierDeliveryInfo> list = new List<SupplierDeliveryInfo>();

            sortExpression = "PurDate DESC";
            //表名或者视图
            string strTb = "vwSupplierDeliveryPO";
            //主键
            string strKey = "SupplierId";
            //查询栏位字串
            string strColumns = @"[POID], [POCode], [VendorCode], [VendorName], SupplierId,[FactoryCode],PurDate";
            list = ComMethod.GetComList<SupplierDeliveryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            list = list.OrderByDescending(q => q.POCode).ToList();
            
            return list;
        }
        public List<SupplierDeliveryInfo> SupplierDeliveryPOMaterialDeliver(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierDeliveryInfo> list = new List<SupplierDeliveryInfo>();

            sortExpression = "PurDate DESC";
            //表名或者视图
            string strTb = "vwSupplierDeliveryPOMaterialDeliver";
            //主键
            string strKey = "SupplierId";
            //查询栏位字串
            string strColumns = @"[POID], [POCode], [VendorCode], [VendorName], SupplierId,[FactoryCode],PurDate";
            list = ComMethod.GetComList<SupplierDeliveryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            list = list.OrderByDescending(q => q.POCode).ToList();

            return list;
        }

        // add by weixia on 2016.9.19仓库收料的到货单
        public List<SupplierDeliveryInfo>  ReceiveInStock(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierDeliveryInfo> list = new List<SupplierDeliveryInfo>();
            //表名或者视图
            string strTb = "vwPOInStock";
            //主键
            string strKey = "SupplierId";
            //查询栏位字串
            string strColumns = @"[POID], [POCode], [VendorCode], [VendorName], SupplierId,[FactoryCode]";
            list = ComMethod.GetComList<SupplierDeliveryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        // add by weixia on 2016.9.19仓库收料的送货单
        public List<SupplierDeliveryInfo> ReceiveDeliverPO(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierDeliveryInfo> list = new List<SupplierDeliveryInfo>();
            //表名或者视图
            string strTb = "vwReceiveDeliverPO";
            //主键
            string strKey = "SupplierId";
            //查询栏位字串
            string strColumns = @"[POID], [POCode], [VendorCode], [VendorName], SupplierId,[FactoryCode]";
            list = ComMethod.GetComList<SupplierDeliveryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }


        // 供应商交期维护-根据采购单号获取采购单详细
        public string GetSupplierDeliveryItem(string poCode)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@POCode",SqlDbType.NVarChar,50)
            };
            parms[0].Value = poCode;

            return ComMethod.GetList("uspGetSupplierDeliveryItem", parms);
        }

        // 供应商交货日期维护列表
        public List<SupplierDeliveryInfo> GetSupplierDeliveryList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierDeliveryInfo> list = new List<SupplierDeliveryInfo>();
            //表名或者视图
            string strTb = "vwSupplierDelivery";
            //主键
            string strKey = "SupplierDeliveryId";
            //查询栏位字串
            string strColumns = @"[SupplierDeliveryId], [POCode], [SuplierCode], [ItemCode], ItemName,PlanDateTime,DeliveryMan,ItemQty,FinishQty,VendorName,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,ConfirmDateTime,ItemDescription,UnpaidQyt,DeliveryManCName,ModifyByCName,AutoId";
            list = ComMethod.GetComList<SupplierDeliveryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            
            return list;
        }
        // 编辑供应商交期维护-根据采购单号获取供应商信息
        public SupplierDeliveryInfo GetVendorByPO(string supplierDeliveryId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@SupplierDeliveryId",SqlDbType.NVarChar,50)
            };
            parms[0].Value = supplierDeliveryId;
            string sql = @"SELECT a.POCode,b.VendorName FROM Basal_SupplierDelivery a INNER JOIN  Basal_Supplier b on a.SuplierCode=b.VendorCode WHERE a.SupplierDeliveryId=@SupplierDeliveryId";
            return ComMethod.GetBySql<SupplierDeliveryInfo>(sql, parms);
        }

        // 编辑供应商交期维护-根据供应商交期ID获取供应商交期详细信息
        public string SupplierDeliveryEdit(string supplierDeliveryId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@SupplierDeliveryId",SqlDbType.NVarChar,50)
            };
            parms[0].Value = supplierDeliveryId;

            string sql = @"select POCode,ItemID,ItemCode,ItemName,SuplierCode as VenCode,ItemQty as PBuyQty,
						    ISNULL(FinishQty,0) as ReceiveQty,isnull(AutoID,0) AutoID,0 as UnpaidQty,CONVERT(varchar(100), PlanDateTime, 23) AS PlanDateTime,DeliveryMan,CONVERT(varchar(100), ConfirmDateTime, 23) AS ConfirmDateTime
							,ItemSpec from vwSupplierDelivery  where SupplierDeliveryId=@SupplierDeliveryId";

            
            return ComMethod.GetListBySql(sql, parms);
        }

        // 供应商交货日期 导出功能
        public DataTable GetSupplierDeliveryDataTable(string strWhere)
        {
            SqlParameter[] parms = new SqlParameter[] { 
            };
            string sql = @"select POCode as 采购单号,AutoId AS 采购单行号, ItemCode as 物料编码, ItemName as 物料名称,ItemSpec AS 物料规格
                            ,SuplierCode AS 供应商代码,VendorName AS 供应商名称,
                            ISNULL(REVERSE(STUFF(REVERSE(ItemQty),1,PATINDEX('%[1-9]%',REVERSE(ItemQty))-1,'')),0)  as 物料数量, 
                            ISNULL(REVERSE(STUFF(REVERSE(FinishQty),1,PATINDEX('%[1-9]%',REVERSE(FinishQty))-1,'')),0) as 已交数量,
                            ISNULL(REVERSE(STUFF(REVERSE(ItemQty-FinishQty),1,PATINDEX('%[1-9]%',REVERSE(ItemQty-FinishQty))-1,'')),0) AS 未交数量, 
                            CASE WHEN ItemQty-FinishQty <= 0 THEN '已完成' ELSE '未完成' END  AS 交货状态,
                            PlanDateTime as 交货日期,ConfirmDateTime AS 确认交期, DeliveryManCName as 交货人,ModifyByCName AS 确认人,ModifyDateTime AS 确认时间
                            FROM dbo.vwSupplierDelivery where " + strWhere;
            DataSet ds = ComMethod.GetListDataSetBySql(sql, parms);

            //SheetTable stTable = new SheetTable();
            //stTable.SheetName = "sheet"; //--导出execl时必须设定
            //stTable.MergeColumns = new string[] { "B", "C" };
            //NpoiExcelHelper.DataTableToExcel("e:\\1dfk\\", ds, stTable);

            return ds.Tables[0];
        }

        // 供应商交期维护-根据登录用户名获取用户中文名
        public string GetNameByUser(string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@UserName",SqlDbType.NVarChar,50)
            };
            parms[0].Value = userName;

            string sql = @"select B.CName from SYS_Users A inner join SYS_Membership B ON A.UserId=B.UserId where UserName=@UserName";

            
            return ComMethod.GetListBySql(sql, parms);
        }
        /// <summary>
        /// 保存供应商送样信息
        /// </summary>
        /// <param name="strJson"></param>
        /// <returns></returns>
        public void SaveSendSample(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.BigInt),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@tbDtl", SqlDbType.Structured)
            };
            ComMethod.Edit<SupplierDeliveryInfo>(strJson, "upsSaveSendSample", parms);
        }
        /// <summary>
        /// 根据产品ID获取产品的供应商送样信息
        /// </summary>
        /// <param name="itemId"></param>
        /// <returns></returns>
        public String GetSupplierSendSample(int itemId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int)
            };

            parms[0].Value = itemId;
            string strSql = "select SendSample, SupplierId, VendorCode, VendorName from Basal_SupplierSendSample where ItemId=@ItemId";
            return ComMethod.GetListBySql(strSql, parms);
        }

        public List<SupplierDeliveryInfo> GetPODtl(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierDeliveryInfo> list = new List<SupplierDeliveryInfo>();
            //表名或者视图
            string strTb = "vwPODtl";
            //主键
            string strKey = "POID";
            //查询栏位字串
            string strColumns = @"POID,POCode,ItemCode";
            list = ComMethod.GetComList<SupplierDeliveryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
    }
}