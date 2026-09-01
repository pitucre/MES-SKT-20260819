using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Linq;
using SKT.LeanMES.ERP;
using Dapper;
using static Dapper.SqlMapper;
using Newtonsoft.Json;

namespace SKT.LeanMES.Warehouse.BLL
{
    /// <summary>
    /// 成品入库列表
    /// </summary>
    public class WarehouseCpInList
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WarehouseCpInList 信息。
        /// </summary>
        /// <param name="entity">WarehouseCpInList 实体对象。</param>
        public Int32 Edit(WarehouseCpInListInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WarehouseCpInListId", SqlDbType.Int),
                new SqlParameter("@InStockNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@WorkOrderNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@MaterialId", SqlDbType.NVarChar, 50),
                new SqlParameter("@WarehouseId", SqlDbType.Int),
                new SqlParameter("@InQty", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.WarehouseCpInListId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.InStockNo;
            parms[2].Value = entity.WorkOrderNo;
            parms[3].Value = entity.MaterialId;
            parms[4].Value = entity.WarehouseId;
            parms[5].Value = entity.InQty;
            parms[6].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_WarehouseCpInList_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WarehouseCpInListId 字符串删除 WarehouseCpInList 信息。
        /// </summary>
        /// <param name="idString">WarehouseCpInListId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_WarehouseCpInList_Delete", parms);
        }

        /// <summary>
        /// 根据 WarehouseCpInListId 获取实体信息。
        /// </summary>
        /// <param name="warehouseCpInListId">WarehouseCpInListId。</param>
        /// <returns>WarehouseCpInList 实体对象。</returns>
        public WarehouseCpInListInfo GetInfo(Int32 warehouseCpInListId)
        {
            WarehouseCpInListInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = warehouseCpInListId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_WarehouseCpInList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseCpInListInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>WarehouseCpInList 实体对象。</returns>
        public WarehouseCpInListInfo GetInfo(String fieldValue)
        {
            WarehouseCpInListInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_WarehouseCpInList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseCpInListInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 WarehouseCpInList 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warehouseCpInListCount">warehouseCpInList 总数。</param>
        /// <returns>WarehouseCpInList 列表。</returns>
        public List<WarehouseCpInListInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseCpInListInfo> list = new List<WarehouseCpInListInfo>();
            WarehouseCpInListInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_WarehouseCpInList", "WarehouseCpInListId",
                "[WarehouseCpInListId], [InStockNo], [WorkOrderNo], [MaterialId], [WarehouseId], [InQty], [CreateBy], [CreateDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarehouseCpInListInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 判断扫描的值
        /// </summary>
        /// <param name="Number"></param>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        public List<WarehouseCpInListInfo> Check(string Number, string InStockNo, int ScanType, string UserName)
        {
            List<WarehouseCpInListInfo> model = new List<WarehouseCpInListInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Number", SqlDbType.VarChar, 50),
                new SqlParameter("@InStockNo", SqlDbType.VarChar, 50),
                new SqlParameter("@ScanType", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 50),
                new SqlParameter("@result", SqlDbType.VarChar, 50)
            };
            int Qty = 0;
            parms[0].Value = Number;
            parms[1].Value = InStockNo;
            parms[2].Value = ScanType;
            parms[3].Value = UserName;
            parms[4].Value = "";
            parms[4].Direction = ParameterDirection.InputOutput;
            model = ComMethod.GetList<WarehouseCpInListInfo>("uspChechedInStockNumber", parms);
            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspChechedInStockNumber", parms))
            //{
            //    while (rdr.Read())
            //    {
            //        model.SNId = rdr.GetString(0);
            //        model.ItemName = rdr.GetString(1);
            //        Qty++;
            //    }
            //    rdr.Close();
            //}
            //model.Value = Qty;
            return model;
        }
        /// <summary>
        ///  查询工单 SN 的入库状态 0：已入库 1：已扫描 2：待检验：3待入库
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<WarehouseCpInListInfo> Search(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            /*
            List<WarehouseCpInListInfo> list = new List<WarehouseCpInListInfo>();
            //表名或者视图
            //string strTb = "vwPoCpInStock";
            string strTb = "vwCpInStockPar";
            //主键
            string strKey = "WarehouseCpInListId";
            //查询栏位字串
            string strColumns = @"[WarehouseCpInListId],[WorkOrderNo],[ItemName], [ItemCode],[ErpStatus],[InStockNo],[CreateBy],[CreateDateTime],[InQty],[CWhCode],[CWhName]";
            list = ComMethod.GetComList<WarehouseCpInListInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list.OrderBy(i => i.WorkOrderNo).ToList();*/

            //by liwen 20200901
            List<WarehouseCpInListInfo> list = new List<WarehouseCpInListInfo>();
            WarehouseCpInListInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwCpInStockPar", "WarehouseCpInListId",
               "[WarehouseCpInListId],[WorkOrderNo],[ItemName], [ItemCode],[ErpStatus],[InStockNo],[CreateBy],[CreateDateTime],[InQty],[CWhCode],[CWhName],CPN,cBarCode"
               , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {//uspSearchItemList
                while (rdr.Read())
                {
                    entity = new WarehouseCpInListInfo();
                    entity.WarehouseCpInListId = rdr.GetInt32(0);
                    entity.WorkOrderNo = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.ErpStatus = rdr.GetString(4);
                    entity.InStockNo = rdr.GetString(5);
                    entity.CreateBy = rdr.GetString(6);
                    entity.CreateDateTime = rdr.GetDateTime(7);
                    entity.InQty = rdr.GetInt32(8);
                    entity.CWhCode = rdr.GetString(9);
                    entity.CWhName = rdr.GetString(10);
                    entity.CPN = rdr.GetString(11);
                    entity.cBarCode = rdr.GetString(12);
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        public List<WarehouseCpInListInfo> SearchDtl(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseCpInListInfo> list = new List<WarehouseCpInListInfo>();
            //表名或者视图
            string strTb = "vwPoCpInStock";
            //主键
            string strKey = "WarehouseCpInListId";
            //查询栏位字串
            string strColumns = @"[WarehouseCpInListId],[WorkOrderNo],[StatusId],[ItemName], [ItemCode],[SNStatusID],[SNId],[PalletCode],[ContainerCode],[QcLotNo],[CustomerSN],[BarCode],[Status],BatchQty";
            list = ComMethod.GetComList<WarehouseCpInListInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list.OrderBy(i => i.StatusId).ToList();
        }
        /// <summary>
        /// 查询工单信息
        /// </summary>
        /// <param name="OrderNo">工单号</param>
        /// <returns></returns>
        public WarehouseCpInListInfo SearchOrderCount(string OrderNo)
        {
            WarehouseCpInListInfo model = new WarehouseCpInListInfo();
            string sql = "";
            //if (typeID == "2")//工单入库
            //{
            sql = @"SELECT    t.OrderNO AS WorkOrderNo, t1.ItemCode, t1.ItemName, COUNT(t3.Value) AS Value,
            ISNULL((SELECT SUM(StorageQty) StorageQty FROM Prod_StorageMember s JOIN Prod_Storage s1 ON s.StorageID=s1.StorageID WHERE s.OrderNo=@OrderNO AND S1.Status='2'),0) AS	StorageQty
            FROM      dbo.Prod_Order AS t INNER JOIN
            dbo.Basal_Item AS t1 ON t1.ItemID = t.ItemId INNER JOIN
            dbo.Prod_Unit AS t2 ON t2.ProdOrderID = t.ProdOrderID AND t2.StatusID=2 INNER JOIN
            dbo.Prod_SerialNumber AS t3 ON t3.UID = t2.UID AND t3.SNTypeID = 0
            WHERE T.OrderNO=@OrderNO
            GROUP BY t.OrderNO,t1.ItemCode, t1.ItemName";
            //}
            //else//FQC入库
            //{

            //}
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNO", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = OrderNo;
            model = ComMethod.GetBySql<WarehouseCpInListInfo>(sql, parms);
            return model;
        }
        /// <summary>
        /// 获取入库单号
        /// </summary>
        /// <returns></returns>
        public string GetInStockNo()
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@NextNumberType", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@WOID", SqlDbType.Int),
                new SqlParameter("@SN", SqlDbType.NVarChar, 50)
            };

                parms[0].Value = "-9";
                parms[1].Value = 0;
                parms[2].Value = 0;
                parms[3].Value = "";
                parms[3].Direction = ParameterDirection.InputOutput;
                DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGenerateItemSN", parms);
                //string result = dt.Rows[0][0].ToString();
                return parms[3].Value.ToString();
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 更改sn状态 已扫描
        /// </summary>
        /// <param name="InStockNo"></param>
        /// <param name="SN"></param>
        /// <param name="WorkOrderNo"></param>
        /// <param name="userName"></param>
        public void ScanSave(string InStockNo, string SN, string WorkOrderNo, int Qty, string userName)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InStockNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@SN", SqlDbType.NVarChar, 50),
                new SqlParameter("@WorkOrderNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@Qty", SqlDbType.Int),
                new SqlParameter("@userName", SqlDbType.NVarChar, 50)
            };

                parms[0].Value = InStockNo;
                parms[1].Value = SN;
                parms[2].Value = WorkOrderNo;
                parms[3].Value = Qty;
                parms[4].Value = userName;
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCpScanInStock", parms);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 确认入库
        /// </summary>
        /// <param name="InStockNo">入库单号</param>
        /// <param name="StationId">入库库位</param>
        public void Save(string InStockNo, string StationId, string UserName)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InStockNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@StationId", SqlDbType.NVarChar, 50),
                new SqlParameter("@UserName", SqlDbType.NVarChar, 50)
            };

                parms[0].Value = InStockNo;
                parms[1].Value = StationId;
                parms[2].Value = UserName;
                int result = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspInStockUpdateStatus", parms);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        /// <summary>
        /// 通过入库单 获取已扫描信息
        /// </summary>
        /// <param name="InStockNo"></param>
        /// <returns></returns>
        public IList<WarehouseCpInListInfo> GetSNInfo(string InStockNo)
        {
            //string sqlstr = @"	SELEct		
            //        CASE 
            //       WHEN PalletCode IS NOT NULL  THEN  PalletCode 
            //       WHEN PalletCode IS NULL AND ContainerCode IS NOT NULL THEN  ContainerCode
            //       ELSE SNId END AS ItemCode,ItemName,COUNT(SNId) AS StorageQty FROM dbo.vwPoCpInStock WHERE InStockNo=@InStockNo
            //       GROUP BY 			 CASE 
            //       WHEN PalletCode IS NOT NULL  THEN  PalletCode 
            //       WHEN PalletCode IS NULL AND ContainerCode IS NOT NULL THEN  ContainerCode
            //       ELSE SNId END,ItemName";

            string sqlstr = @"SELECT WorkOrderNo,ItemCode,COUNT(*) Value FROM dbo.vwPoCpInStock WHERE InStockNo=@InStockNo AND StatusId=1 GROUP BY WorkOrderNo,ItemCode";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InStockNo", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = InStockNo;
            IList<WarehouseCpInListInfo> list = ComMethod.GetListBySql<WarehouseCpInListInfo>(sqlstr, parms);
            return list;
        }
        /// <summary>
        /// 获取未入库的入库单列表
        /// </summary>
        /// <returns></returns>
        public IList<WarehouseCpInListInfo> GetInStockNoList()
        {
            string sqlstr = @"SELECT StorageNumber AS InStockNo FROM dbo.Prod_Storage WHERE Status=1";
            IList<WarehouseCpInListInfo> list = ComMethod.GetListBySql<WarehouseCpInListInfo>(sqlstr, null);
            return list;
        }

        public void InStock(string SNList, string BarCode, string Uname)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SNlist", SqlDbType.VarChar, 2000),
                new SqlParameter("@barcode", SqlDbType.VarChar, 50),
                new SqlParameter("@userName", SqlDbType.VarChar, 50)
            };
            parms[0].Value = SNList;
            parms[1].Value = BarCode;
            parms[2].Value = Uname;
            ComMethod.Edit("uspCpStockBatch", parms);
        }

        /// <summary>
        /// 根据入库单号获取入库条码信息
        /// </summary>
        /// <returns></returns>
        public IList<WarehouseCpInListInfo> GetInStockSNList(WarehouseCpInListInfo entity)
        {
            string sql = "SELECT InStockNo,WorkOrderNo,ItemCode,ItemName,BarCode,SNId,CustomerSN,ContainerCode,PalletCode,QcLotNo FROM vwPoCpInStock WHERE InStockNo = @InStockNo ORDER BY CustomerSN";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InStockNo", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = entity.InStockNo;
            return ComMethod.GetListBySql<WarehouseCpInListInfo>(sql, parms);
        }

        /// <summary>
        /// 根据入库单号获取已扫描未入库条码信息
        /// </summary>
        /// <returns></returns>
        public IList<WarehouseCpInListInfo> GetInStockScanSN(WarehouseCpInListInfo entity)
        {
            string sql = "SELECT InStockNo,ContainerCode,COUNT(1) Value FROM vwPoCpInStock WHERE InStockNo = @InStockNo AND StatusId = 1 GROUP BY InStockNo,ContainerCode;";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InStockNo", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = entity.InStockNo;
            return ComMethod.GetListBySql<WarehouseCpInListInfo>(sql, parms);
        }

        /// <summary>
        /// 根据箱号号获取未入库的入库单
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public WarehouseCpInListInfo GetScanedInStockNo(WarehouseCpInListInfo entity)
        {
            string sql = "SELECT TOP 1 InStockNo,WorkOrderNo,ItemCode,ItemName,BarCode,SNId,CustomerSN,ContainerCode,PalletCode,QcLotNo,StatusId FROM vwPoCpInStock WHERE ContainerCode = @ContainerCode;";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ContainerCode", SqlDbType.VarChar, 50)
            };
            parms[0].Value = entity.ContainerCode;
            return ComMethod.GetBySql<WarehouseCpInListInfo>(sql, parms);
        }

        /// <summary>
        /// 不良录入
        /// </summary>
        /// <returns></returns>
        public string NcPrintCollection(NcPrintCollectionInfo entity)
        {
            var msg = string.Empty;
            string erpInstockNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.FinishStorage;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@ProdOrderId", entity.ProdOrderId);
                    dp.Add("@ResId", entity.ResId);
                    dp.Add("@StationId", entity.StationId);
                    dp.Add("@NCCodeIdFailure", entity.NCCodeIdFailure);
                    dp.Add("@NCCodeIdDefect", entity.NCCodeIdDefect);
                    dp.Add("@NgQty", entity.NgQty);
                    dp.Add("@Remark", entity.Remark);
                    dp.Add("@UserName", entity.UserName);
                    reader = conn.ExecuteReader("uspNcPrintCollection", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                    //是否需要回写
                    isWriteBack = WriteBackERP.IsWriteBack(em);
                    if (isWriteBack)
                    {
                        if (dtWrite == null || dtWrite.Rows.Count <= 0)
                        {
                            msg = "未获取到需要回写ERP数据";
                            throw new Exception(msg);
                        }

                        //调用接口
                        ERPU9ReturnInfo info = WriteBackERP.SendPostU9(conn, em, dtWrite, entity.ProdOrderId.ToString(), entity.UserName, dtEnterTime, dtAfterExecProcTime);

                        logList.Add(new WriteBackLogInfo
                        {
                            WriteBackCode = em.ToString(),
                            ERPMsg = info.Msg,
                            ERPResult = info.Result ? 1 : 0,
                            ERPNo = info.ERPNo,
                            MESBillNo = entity.ProdOrderId.ToString(),
                            WriteBackData = info.SendInfo,
                            ReceiveData = info.ReceiveData,
                            EnterTime = dtEnterTime,
                            AfterExecProcTime = dtAfterExecProcTime,
                            AfterExecERPTime = info.dtAfterExecERPTime,
                            CreateDateTime = DateTime.Now
                        });
                        if (!info.Result)
                        {
                            //回写失败
                            throw new Exception(info.Msg);
                        }
                    }
                    if (dtWrite != null || dtWrite.Rows.Count > 0)
                    {
                        erpInstockNo = dtWrite.Rows[0]["billCode"].ToString();
                    }
                    tran.Commit();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    throw ex;
                }
                finally
                {
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    foreach (var log in logList)
                    {
                        WriteBackERP.AddWriteBackLog(conn, log);
                    }
                    conn.Close();
                }
            }
            return erpInstockNo;

        }

        /// <summary>
        /// 料把打印
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string GenerateLineMaterialSN(LineMaterialSNInfo entity)
        {
            var msg = string.Empty;
            string erpInstockNo = string.Empty;
            string ItemId = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.OtherWarehousing;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@ProdOrderId", entity.ProdOrderId);
                    dp.Add("@ItemId", entity.ItemId);
                    dp.Add("@GRNQty", entity.GRNQty);
                    dp.Add("@UserName", entity.UserName);
                    dp.Add("@ResId", entity.ResId);
                    dp.Add("@OpeId", entity.OpenId);
                    dp.Add("@Remark", entity.Remark);
                    reader = conn.ExecuteReader("uspGenerateLineMaterialSN", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间


                    if (dtWrite != null || dtWrite.Rows.Count > 0)
                    {
                        erpInstockNo = dtWrite.Rows[0]["billCode"].ToString();
                        ItemId = dtWrite.Rows[0]["ItemId"].ToString();
                    }

                    //移除ItemId列，避免回写接口调用失败
                    if (dtWrite.Columns.Contains("ItemId"))
                    {
                        dtWrite.Columns.Remove("ItemId");
                    }
                    //是否需要回写
                    isWriteBack = WriteBackERP.IsWriteBack(em);
                    if (isWriteBack)
                    {
                        if (dtWrite == null || dtWrite.Rows.Count <= 0)
                        {
                            msg = "未获取到需要回写ERP数据";
                            throw new Exception(msg);
                        }

                        //调用接口
                        var info = WriteBackERP.HttpPostU9Api<CreateSaleRcvResponse>(em, dtWrite, entity.ProdOrderId.ToString(), entity.UserName, dtEnterTime, dtAfterExecProcTime);

                        if (info.ResCode != 0 || !info.Data[0].IsSucess)
                        {
                            //回写失败
                            throw new Exception(info.ResMsg ?? info.Data[0].ErrorMsg);
                        }
                        //ERPU9ReturnInfo infos = WriteBackERP.SendPostU9(conn, em, dtWrite, entity.ProdOrderId.ToString(), entity.UserName, dtEnterTime, dtAfterExecProcTime);
                    }
                    if (dtWrite != null || dtWrite.Rows.Count > 0)
                    {
                        erpInstockNo = dtWrite.Rows[0]["billCode"].ToString();
                    }
                    tran.Commit();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    throw ex;
                }
                finally
                {
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    foreach (var log in logList)
                    {
                        WriteBackERP.AddWriteBackLog(conn, log);
                    }
                    conn.Close();
                }
            }
            //返回Josn格式，包含单号和物料ID
            return JsonConvert.SerializeObject(new { GRNString = erpInstockNo, ItemId = ItemId });
        }

        /// <summary>
        /// 不良录入
        /// </summary>
        /// <returns></returns>
        public string CommonNcPrintCollection(NcPrintCollectionInfo entity)
        {
            var msg = string.Empty;
            string erpInstockNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.FinishStorage;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@ProdOrderId", entity.ProdOrderId);
                    dp.Add("@ResId", entity.ResId);
                    dp.Add("@StationId", entity.StationId);
                    dp.Add("@NCCodeIdFailure", entity.NCCodeIdFailure);
                    dp.Add("@NCCodeIdDefect", entity.NCCodeIdDefect);
                    dp.Add("@NgQty", entity.NgQty);
                    dp.Add("@Remark", entity.Remark);
                    dp.Add("@UserName", entity.UserName);
                    dp.Add("@SN", entity.SN);
                    reader = conn.ExecuteReader("uspCommonNcPrintCollection", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                    //是否需要回写
                    isWriteBack = WriteBackERP.IsWriteBack(em);
                    if (isWriteBack)
                    {
                        if (dtWrite == null || dtWrite.Rows.Count <= 0)
                        {
                            msg = "未获取到需要回写ERP数据";
                            throw new Exception(msg);
                        }

                        //调用接口
                        ERPU9ReturnInfo info = WriteBackERP.SendPostU9(conn, em, dtWrite, entity.ProdOrderId.ToString(), entity.UserName, dtEnterTime, dtAfterExecProcTime);

                        logList.Add(new WriteBackLogInfo
                        {
                            WriteBackCode = em.ToString(),
                            ERPMsg = info.Msg,
                            ERPResult = info.Result ? 1 : 0,
                            ERPNo = info.ERPNo,
                            MESBillNo = entity.ProdOrderId.ToString(),
                            WriteBackData = info.SendInfo,
                            ReceiveData = info.ReceiveData,
                            EnterTime = dtEnterTime,
                            AfterExecProcTime = dtAfterExecProcTime,
                            AfterExecERPTime = info.dtAfterExecERPTime,
                            CreateDateTime = DateTime.Now
                        });
                        if (!info.Result)
                        {
                            //回写失败
                            throw new Exception(info.Msg);
                        }
                    }
                    if (dtWrite != null || dtWrite.Rows.Count > 0)
                    {
                        erpInstockNo = dtWrite.Rows[0][1].ToString();
                    }
                    tran.Commit();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    throw ex;
                }
                finally
                {
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    foreach (var log in logList)
                    {
                        WriteBackERP.AddWriteBackLog(conn, log);
                    }
                    conn.Close();
                }
            }
            return erpInstockNo;

        }

        /// <summary>
        /// 成品入库
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>        
        public string FinishProductInStorage(WarehouseCpInListInfo entity)
        {
            var msg = string.Empty;
            string erpInstockNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.FinishStorage;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@StorageNo", entity.StorageNo);
                    dp.Add("@cBarCode", entity.cBarCode);
                    dp.Add("@ModifyBy", entity.ModifyBy);
                    reader = conn.ExecuteReader("uspFinishProductInStorageSave", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                    //是否需要回写
                    isWriteBack = WriteBackERP.IsWriteBack(em);
                    if (isWriteBack)
                    {
                        if (dtWrite == null || dtWrite.Rows.Count <= 0)
                        {
                            msg = "未获取到需要回写ERP数据";
                            throw new Exception(msg);
                        }

                        //打开工单
                        DataRow[] selectedRows = dtWrite.Select("IsOver = 1");

                        // 创建一个List<string>来存储sourceCode
                        List<string> sourceCodes = new List<string>();
                        foreach (DataRow row in selectedRows)
                        {
                            sourceCodes.Add(row["sourceCode"].ToString());
                        }
                        //sourceCodes去重
                        sourceCodes = sourceCodes.Distinct().ToList();

                        if (sourceCodes.Count > 0)
                        {
                            MODocCompleteMoResponse mODocCompleteMoResponse = WriteBackERP.CallMODocCompleteMoApi(sourceCodes);

                            if (mODocCompleteMoResponse == null || !mODocCompleteMoResponse.Success)
                            {
                                msg = "调用U9开工接口失败！";
                                throw new Exception(msg);
                            }
                            List<MODocCompleteMoData> dataList = mODocCompleteMoResponse.Data;

                            if (dataList.Count > 0 && !dataList[0].m_isSucess)
                            {
                                msg = "打开ERP工单失败!" + dataList[0].m_errorMsg;
                                throw new Exception(msg);
                            }
                        }
                        //调用接口
                        ERPU9ReturnInfo info = WriteBackERP.SendPostU9(conn, em, dtWrite, entity.StorageNo, entity.ModifyBy, dtEnterTime, dtAfterExecProcTime);

                        logList.Add(new WriteBackLogInfo
                        {
                            WriteBackCode = em.ToString(),
                            ERPMsg = info.Msg,
                            ERPResult = info.Result ? 1 : 0,
                            ERPNo = info.ERPNo,
                            MESBillNo = entity.StorageNo,
                            WriteBackData = info.SendInfo,
                            ReceiveData = info.ReceiveData,
                            EnterTime = dtEnterTime,
                            AfterExecProcTime = dtAfterExecProcTime,
                            AfterExecERPTime = info.dtAfterExecERPTime,
                            CreateDateTime = DateTime.Now
                        });

                        if (!info.Result)
                        {
                            //回写失败
                            throw new Exception(info.Msg);
                        }
                        else
                        {
                            //回写成功，更新ERP入库单号
                            var obj = new { ERPInstockNo = info.ERPNo, ModifyBy = entity.ModifyBy, StorageNumber = entity.StorageNo };
                            int i = conn.Execute(@"UPDATE ps SET ps.ERPInstockNo = @ERPInstockNo,ps.ModifyBy = @ModifyBy,ps.ModifyDateTime = GETDATE() FROM dbo.Prod_Storage ps WHERE ps.StorageNumber = @StorageNumber", obj, tran);

                            erpInstockNo = info.ERPNo;
                        }

                    }
                    tran.Commit();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    throw ex;
                }
                finally
                {
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    foreach (var log in logList)
                    {
                        WriteBackERP.AddWriteBackLog(conn, log);
                    }
                    conn.Close();
                }
            }
            return erpInstockNo;
        }


        /// <summary>
        /// 获取成品打印的数量
        /// </summary>
        /// <param name="PoCode">工单号</param>
        /// <returns></returns>
        public Decimal GetPrintQty(String PoCode)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@OrderNo",SqlDbType.VarChar),
                new SqlParameter("@PrintQty",SqlDbType.Float)
            };

            parms[0].Value = PoCode;
            parms[1].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetPrintQtyByOrder", parms);
            return Convert.ToDecimal(parms[1].Value);

        }
        /// <summary>
        /// 根据生产工单获取路由/工序/资源
        /// </summary>
        /// <param name="porderId"></param>
        /// <returns></returns>
        public IList<ProdOrderStationInfo> GetProdOrderStationList(Int32 porderId)
        {
            List<ProdOrderStationInfo> list = new List<ProdOrderStationInfo>();
            ProdOrderStationInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = porderId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetRouterStationResById", parms))
            {
                while (rdr.Read())
                {
                    entity = null;
                    entity = new ProdOrderStationInfo();
                    entity.Station = rdr.GetString(0);
                    entity.StationId = rdr.GetInt32(1).ToString();
                    entity.LineId = rdr.GetInt32(2).ToString();
                    entity.LineName = rdr.GetString(3);
                    entity.ResId = rdr.GetInt32(4).ToString();
                    entity.ResName = rdr.GetString(5);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
    }
}