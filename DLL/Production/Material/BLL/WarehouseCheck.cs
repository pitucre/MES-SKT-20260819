using Dapper;
using Newtonsoft.Json;
using Org.BouncyCastle.Asn1.Ocsp;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.ERP;
using SKT.LeanMES.Material.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.BLL
{
    /// <summary>
    /// 盘点
    /// </summary>
    public class WarehouseCheck
    {
        private Int32 recordCount = 0;
        public List<WarehouseCheckInfo> GetMaInfo(string GRN, int status = -1)
        {
            //string strsql = @"SELECT t.SerialNumber AS GRN,t.cBarCode AS BarCode,t.BalanceQty AS StockQty,t1.ItemCode,ItemName,t.Flag,p.materialunitid as PID,p.SerialNumber as PSN
            //,p.flag as PFlag FROM dbo.Prod_MaterialUnit t 
            //                    JOIN dbo.Basal_Item t1 ON t1.ItemID=t.PartId left join Prod_MaterialUnit p on t.pid=p.materialunitid
            //                    where t.SerialNumber='" + GRN + "' ";
            //if (status > 0)
            //{
            //    strsql += strsql + " and  t.Status=" + status;
            //}


            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar),
                new SqlParameter("@Status",SqlDbType.Int)
            };
            parms[0].Value = GRN;
            parms[1].Value = status;


            return ComMethod.GetList<WarehouseCheckInfo>("uspWarehouseCheckGetMaInfo", parms);
        }

        public List<WarehouseCheckInfo> GetMaList(string GRN, int status = -1)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar),
                new SqlParameter("@Status",SqlDbType.Int)
            };
            parms[0].Value = GRN;
            parms[1].Value = status;
            return ComMethod.GetList<WarehouseCheckInfo>("uspWarehouseCheckGetMaList", parms);
        }


        /// <summary>
        /// 盘点撤销检验
        /// </summary>
        /// <param name="CheckNo"></param>
        /// <param name="GRN"></param>
        /// <param name="Type"></param>
        /// <returns></returns>
        public int ScanCancelCheck(string CheckNo, string GRN, int Type)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@CheckNo",SqlDbType.VarChar),
                new SqlParameter("@GRN",SqlDbType.VarChar),
                new SqlParameter("@Type",SqlDbType.Int),
                new SqlParameter("@Status",SqlDbType.Int)
            };
            parms[0].Value = CheckNo;
            parms[1].Value = GRN;
            parms[2].Value = Type;
            parms[3].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspWarehouseCheckCancelCheck", parms);

            return Convert.ToInt32(parms[3].Value);
        }
        /// <summary>
        /// 盘点撤销
        /// </summary>
        /// <param name="CheckNo"></param>
        /// <param name="GRN"></param>
        /// <param name="Type"></param>
        /// <returns></returns>
        public void ScanRollback(string CheckNo, string GRN, string UserName, int Type)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@CheckNo",SqlDbType.VarChar),
                new SqlParameter("@GRN",SqlDbType.VarChar),
                new SqlParameter("@Type",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar)
            };
            param[0].Value = CheckNo;
            param[1].Value = GRN;
            param[2].Value = Type;
            param[3].Value = UserName;
            ComMethod.Edit("uspWarehouseCheckCancel", param);
        }

        //获取盘点单明细信息
        public List<WarehouseCheckInfo> GetCheckOrderDetailInfo(string GRN, int checkOrderId)
        {
            //string strsql = @"select BalanceQty,StockQty,NowQty,ChangeQty,FirstBy  from Prod_WarehouseCheckOrderDtl  WHERE  SN = '" + GRN + "' AND  WhCheckOrderId =" + checkOrderId + "";

            SqlParameter[] param = new SqlParameter[] {

                new SqlParameter("@GRN",SqlDbType.VarChar),
                new SqlParameter("@CheckOrderId",SqlDbType.Int)

            };
            param[0].Value = GRN;
            param[1].Value = checkOrderId;

            return ComMethod.GetList<WarehouseCheckInfo>("uspWarehouseCheckGetCheckOrderDetailInfo", param);
        }

        //通过包装箱SN获取盘点单明细信息
        public List<WarehouseCheckInfo> GetCheckOrderDetailInfoByPackageSN(string packageSN, int checkOrderId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@SN", SqlDbType.VarChar,50),
                new SqlParameter("@WhCheckOrderId", SqlDbType.Int)
            };
            param[0].Value = packageSN;
            param[1].Value = checkOrderId;
            //string strsql = @"
            //    SELECT WCD.BalanceQty,WCD.StockQty,WCD.NowQty,WCD.ChangeQty,WCD.FirstBy,SN AS GRN  
            //    FROM Prod_WarehouseCheckOrderDtl WCD
            //     INNER JOIN (
            //      SELECT SerialNumber FROM Prod_MaterialUnit 
            //      WHERE PID =(SELECT MaterialUnitId FROM Prod_MaterialUnit WHERE SerialNumber =@SN)
            //     )T ON  T.SerialNumber = WCD.SN
            //    WHERE WCD.WhCheckOrderId = @WhCheckOrderId";
            return ComMethod.GetList<WarehouseCheckInfo>("uspWarehouseCheckGetCheckOrderDetailInfoByPackageSN", param);
        }
        /// <summary>
        /// choose 盘点单
        /// </summary>
        /// <returns></returns>
        public List<WarehouseCheckInfo> GetCheckList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<WarehouseCheckInfo> list = new List<WarehouseCheckInfo>();
            strTb = "Prod_WarehouseCheckOrder";

            //主键
            string strKey = "ProdWarehouseCheckId";
            //查询栏位字串
            string strColumns = @"[CheckOrder]";
            list = ComMethod.GetComList<WarehouseCheckInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        /// <summary>
        /// 差异记录
        /// </summary>
        /// <param name="checkNo"></param>
        /// <returns></returns>
        public List<WarehouseCheckInfo> CheckDifferenceList(string checkNo)
        {
            List<WarehouseCheckInfo> list = new List<WarehouseCheckInfo>();

            //     string str = @"  SELECT  A.SN AS GRN,ISNULL(D.CWhName,'')  AS  Warehouse,ISNULL(A.cBarCode,'') AS BarCode ,SN,A.ItemCode,B.ItemName,B.ItemSpec,A.BalanceQty,
            //               A.StockQty,ISNULL(m1.CName,'') AS FirstBy, CASE WHEN a.FirstTime IS NULL THEN '' WHEN DATEPART(YEAR, a.FirstTime) 
            //                  = '1900' THEN '' ELSE CONVERT(VARCHAR, a.FirstTime, 120) END AS FirstTime,ISNULL(m2.CName,'') AS RepeatBy,
            //                  CASE  WHEN  a.RepeatTime IS NULL THEN '' WHEN  DATEPART(YEAR, a.RepeatTime) ='1900' THEN '' ELSE CONVERT(VARCHAR, a.RepeatTime, 120) END AS RepeatTime , RepeatQty,ISNULL(A.Default3,'') AS Remark,A.NowQty,
            //                  ISNULL(m3.CName,'') ChangeBy,CASE WHEN a.ChangeTime IS NULL THEN '' WHEN DATEPART(YEAR, a.ChangeTime) 
            //                  = '1900' THEN '' ELSE CONVERT(VARCHAR, a.ChangeTime, 120) END AS ChangeTime,a.ChangeQty,
            //                  E.CheckOrder,E.CheckOrderName, CONVERT(VARCHAR, E.CreateTime, 120)  AS  CreateTime,
            //                  CASE WHEN  DATEPART(YEAR, E.CheckTime) ='1900' THEN '' ELSE CONVERT(VARCHAR, E.CheckTime, 120) END AS CheckTime
            //,ISNULL(B.ABCClass,'') AS  ABCClass,F.VendorCode FROM 
            //               Prod_WarehouseCheckOrderDtl  AS A LEFT OUTER JOIN   Basal_Item AS B  ON A.ItemCode = B.ItemCode
            //               LEFT  OUTER JOIN  [Basal_WarehouseLocation] AS C ON A.cBarCode = C.cBarCode
            //               LEFT JOIN  Basal_Warehouse AS D  ON A.WarehouseId = D.WarehouseId
            //               LEFT JOIN Prod_WarehouseCheckOrder AS E ON A.[WhCheckOrderId] = E.ProdWarehouseCheckId
            //LEFT JOIN Prod_MaterialUnit AS F ON A.SN =F.SerialNumber 
            //LEFT JOIN SYS_Users m1 ( NOLOCK ) ON RTRIM(LTRIM(a.FirstBy)) = m1.UserName
            //                  LEFT JOIN SYS_Users m2 ( NOLOCK ) ON RTRIM(LTRIM(a.RepeatBy)) = m2.UserName
            //LEFT JOIN SYS_Users m3 ( NOLOCK ) ON RTRIM(LTRIM(a.ChangeBy)) = m3.UserName
            //               WHERE E.CheckOrder =@CheckNo and F.flag=-1  ORDER BY A.WarehouseId,A.cBarCode,A.SN  DESC  ";
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@CheckNo",SqlDbType.VarChar)
            };
            param[0].Value = checkNo;
            list = ComMethod.GetList<WarehouseCheckInfo>("uspWarehouseCheckDifferenceList", param);
            return list;
        }

        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public DataTable CheckOrderImportToExcel(string checkOrder, int typeId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CheckOrder", SqlDbType.VarChar,200),
                new SqlParameter("@TypeId", SqlDbType.Int)
            };
            parms[0].Value = checkOrder;
            parms[1].Value = typeId;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspCheckOrderImportExcel", parms);
        }

        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public string ViewCheckOrderItem(string checkOrder, int typeId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CheckOrder", SqlDbType.VarChar,200),
                new SqlParameter("@TypeId", SqlDbType.Int)
            };
            parms[0].Value = checkOrder;
            parms[1].Value = typeId;
            return ComMethod.GetList("uspViewCheckOrderItem", parms);
        }

        /// <summary>
        /// 扫描操作
        /// </summary>
        public void Scan(string CheckNo, string GRN, decimal Qty, string UserName, int Type)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@CheckNo",SqlDbType.VarChar),
                new SqlParameter("@GRN",SqlDbType.VarChar),
                new SqlParameter("@Qty",SqlDbType.Decimal),
                new SqlParameter("@Type",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar)
            };
            param[0].Value = CheckNo;
            param[1].Value = GRN;
            param[2].Value = Qty;
            param[3].Value = Type;
            param[4].Value = UserName;
            ComMethod.Edit("uspWarehouseCheck", param);
        }

        public void Finish(string CheckNo, string UserName)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@CheckNo",SqlDbType.VarChar),
                new SqlParameter("@UserName",SqlDbType.VarChar)
            };
            param[0].Value = CheckNo;
            param[1].Value = UserName;
            ComMethod.Edit("uspWarehouseCheckFinish", param);
        }
        /// <summary>
        /// 修改GRN
        /// </summary>
        public void Edit(string CheckNo, string GRN, string Qty, string Remark, string UserName)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@CheckNo",SqlDbType.VarChar),
                new SqlParameter("@GRN",SqlDbType.VarChar),
                new SqlParameter("@Qty",SqlDbType.Decimal),
                new SqlParameter("@UserName",SqlDbType.VarChar),
                new SqlParameter("@Remark",SqlDbType.VarChar,200)
            };
            param[0].Value = CheckNo;
            param[1].Value = GRN;
            param[2].Value = Qty;
            param[3].Value = UserName;
            param[4].Value = Remark;
            ComMethod.Edit("uspWarehouseCheckEdit", param);
        }



        #region Report
        /// <summary>
        /// 盘点报表 -盘点单信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="paramarr"></param>
        /// <returns></returns>
        public List<WarehouseCheckReportInfo> GetOneList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseCheckReportInfo> list = new List<WarehouseCheckReportInfo>();
            //表名或者视图
            string strTb = "vwWarehouseCheckOrderListReport";
            //主键
            string strKey = "Number";
            //查询栏位字串
            string strColumns = @"[Number],[CWhName],[CheckOrder],[WarehouseCheckTypeName],[BeginDate],[WarehouseCheckStatusName], [CreateBy],[CreateTime],[FinishDate]";
            list = ComMethod.GetComList<WarehouseCheckReportInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }
        /// <summary>
        /// 盘点报表-物料信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<WarehouseCheckReportInfo> GetTwoList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseCheckReportInfo> list = new List<WarehouseCheckReportInfo>();
            //表名或者视图
            string strTb = "vwWarehouseCheckReport";
            //主键
            string strKey = "Number";
            //查询栏位字串
            string strColumns = @"[Number],[CheckOrder],[ItemCode],[ItemName],[ItemSpec], [GrnCount],[RealtGrnCount],[GrnSum],[RealtGrnSum]";
            list = ComMethod.GetComList<WarehouseCheckReportInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        /// <summary>
        /// 盘点报表-GRN信息
        /// </summary>
        /// <param name="orderNo"></param>
        /// <param name="itemCode"></param>
        /// <returns></returns>
        public List<WarehouseCheckReportInfo> GetThreeList(string orderNo, string itemCode)
        {
            string sqlstr = @"SELECT
                    t2.CWhName,t3.CheckOrder,t.ItemCode,t1.ItemSpec,'' AS MaterialLevel,t.cBarCode,'' AS SupplierCode,t.SN,t.BalanceQty,t.StockQty,t.NowQty,(t.BalanceQty-t.NowQty) AS DiffQty,
                    t.CreateBy,t.CreateTime,t.UpdateBy,t.UpdateTime,t.Default2,t.Default3,t.Remark
                    FROM dbo.Prod_WarehouseCheckOrderDtl t
                    JOIN dbo.Prod_WarehouseCheckOrder t3 ON t3.ProdWarehouseCheckId=t.WhCheckOrderId
                    JOIN dbo.Basal_Item t1 ON t1.ItemCode=t.ItemCode
                    JOIN dbo.Basal_Warehouse t2 ON t2.WarehouseId=t3.WarehouseId WHERE t3.CheckOrder='" + orderNo + "' AND t.ItemCode='" + itemCode + "' ";
            return ComMethod.GetListBySql<WarehouseCheckReportInfo>(sqlstr, null);
        }

        public void SaveFirstCheckOrder(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CheckOrder", SqlDbType.VarChar,50),
                new SqlParameter("@UpdateBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@TbDtl", SqlDbType.Structured)
            };
            ComMethod.Edit<WarehouseCheckInfo>(strJson, "uspSaveFirstCheckOrder", parms);
        }
        //保存盘点单初盘,复盘，平帐
        public void SaveCheckOrder(string strJson)
        {
            //SqlParameter[] parms = new SqlParameter[]{
            //    new SqlParameter("@CheckOrder", SqlDbType.VarChar,50),
            //    new SqlParameter("@UpdateBy", SqlDbType.NVarChar, 20),
            //    new SqlParameter("@Flag", SqlDbType.Int),
            //    new SqlParameter("@Remark", SqlDbType.VarChar,200),
            //    new SqlParameter("@TbDtl", SqlDbType.Structured)
            //};
            //ComMethod.Edit<WarehouseCheckInfo>(strJson, "uspSaveCheckOrder", parms);

            var msg = string.Empty;
            string erpApplyNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            var returnFLGrnStr = string.Empty;
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）

            WarehouseCheckInfo warehouseCheckInfo = JsonConvert.DeserializeObject<WarehouseCheckInfo>(strJson);

            DataTable dataTable = JsonConvert.DeserializeObject<DataTable>(warehouseCheckInfo.TbDtl);

            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@CheckOrder", warehouseCheckInfo.CheckOrder);
                    dp.Add("@UpdateBy", warehouseCheckInfo.UpdateBy);
                    dp.Add("@Flag", warehouseCheckInfo.Flag);
                    dp.Add("@Remark", warehouseCheckInfo.Remark);
                    dp.Add("@TbDtl", dataTable.AsTableValuedParameter("OrderDetailQty"));
                    reader = conn.ExecuteReader("uspSaveCheckOrder", dp, tran, null, CommandType.StoredProcedure);

                    dtWrite.Load(reader);

                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    //平帐后统一处理实际库位差异(RealBarCode): 同仓移库/跨仓调拨入库
                    if (warehouseCheckInfo.Flag == 2)
                    {
                        var locationUserName = warehouseCheckInfo.UpdateBy;
                        var sepIdx = locationUserName.IndexOf("||", StringComparison.Ordinal);
                        if (sepIdx > 0)
                        {
                            locationUserName = locationUserName.Substring(0, sepIdx);
                        }
                        var dpDiff = new DynamicParameters();
                        dpDiff.Add("@CheckOrder", warehouseCheckInfo.CheckOrder);
                        dpDiff.Add("@UserName", locationUserName);
                        conn.Execute("uspWarehouseCheckHandleLocationDiff_Program", dpDiff, tran, null, CommandType.StoredProcedure);
                    }
                    //判断是否全部备料
                    if (warehouseCheckInfo.Flag == 1)
                    {
                        WriteBackEnum em = WriteBackEnum.InventoryList;
                        //是否需要回写
                        isWriteBack = WriteBackERP.IsWriteBack(em);
                        if (isWriteBack && dtWrite != null && dtWrite.Rows.Count > 0)
                        {
                            //if (dtWrite == null || dtWrite.Rows.Count <= 0)
                            //{
                            //    msg = "未获取到需要回写ERP数据";
                            //    throw new Exception(msg);
                            //}

                            DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                            //调用接口
                            ERPU9InventoryListInfo info = WriteBackERP.SendPostU9InventoryList(em, dtWrite, warehouseCheckInfo.CheckOrder, warehouseCheckInfo.UpdateBy, dtEnterTime, dtAfterExecProcTime);

                            if (info.ReturnSingleItems[0].ExecuteResult != "ok")
                            {
                                //回写失败
                                throw new Exception(info.ReturnSingleItems[0].PromptText);
                            }
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
                    conn.Close();
                }
            }
        }
        #endregion

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }





        public void ChenckStationandSn(string station, string sn, string UserName)
        {

            if (string.IsNullOrEmpty(station) || string.IsNullOrEmpty(sn))
            {
                return;
            }

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@station", SqlDbType.NVarChar,50),
                new SqlParameter("@sn", SqlDbType.NVarChar,50),

            };

            parms[0].Value = station;
            parms[1].Value = sn;

            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, @"
            DECLARE @cWhIdbystation INT,@cWhIdbysn INT,@cWhNamebysn varchar(50),@ERRMSG varchar(200)

            SELECT @cWhIdbysn=ISNULL(bwl.cWhId,-1),@cWhNamebysn=ISNULL(bw.CWhName,'') FROM Prod_StorageMember psm
            INNER JOIN Basal_WarehouseLocation bwl ON psm.BarCode=bwl.cBarCode
            INNER JOIN dbo.Basal_Warehouse bw ON bwl.cWhId=bw.WarehouseId
            WHERE SerialNumber=@sn

            SELECT @cWhIdbystation=ISNULL(cWhId,-1)  FROM dbo.Basal_WarehouseLocation 
            WHERE cBarCode=@station
            IF @cWhIdbystation<>@cWhIdbysn
            BEGIN
                SET @ERRMSG='扫描的库位条码【'+@station+'】必须与成品当前库位所在的仓库【'+@cWhNamebysn+'】一致，请重新扫描！';
                RAISERROR(@ERRMSG,12,1);
                RETURN;
            END", parms);
        }

        /// <summary>
        /// 扫描库位批量操作
        /// </summary>
        public void ScanBatch(string CheckNo, string GRNJson, string UserName, int Type)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@CheckNo",SqlDbType.VarChar),
                new SqlParameter("@GRNTable",SqlDbType.Structured),
                new SqlParameter("@Type",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar)
            };
            param[0].Value = CheckNo;
            param[1].Value = string.IsNullOrEmpty(GRNJson) ? new DataTable() : JsonConvert.DeserializeObject<DataTable>(GRNJson);
            param[2].Value = Type;
            param[3].Value = UserName;
            ComMethod.Edit("uspWarehouseCheckBatch", param);
        }

    }
}
