using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.SaleReturn.Model;
using Dapper;
using SKT.LeanMES.ERP;

namespace SKT.LeanMES.SaleReturn.BLL
{
    public class SaleReturn
    {
        private Int32 recordCount = 0;


        /// <summary>
        /// 分页获取 成品退货 列表数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SaleReturnInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string columns = @"pr.SaleReturnId,pr.FactoryCode,pr.SaleReturnNo,pr.CustomerCode,pr.SaleReturnType,pr.SaleReturnDate,pr.Remark,pr.Status,pr.DeleteFlag,pr.CreateBy,pr.CreateDateTime,pr.ModifyBy,pr.ModifyDateTime,
                               bc.CustomerName";
            return ComMethod.GetComList<SaleReturnInfo>(ref this.recordCount, startRow, maxRows, "dbo.Prod_SaleReturn pr INNER JOIN dbo.Basal_Customer bc ON pr.CustomerCode = bc.CustomerCode", string.Empty, columns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 分页获取 成品退货明细 列表数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SaleReturnDtlInfo> GetSaleReturnDtlList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string columns = "SaleReturnId,SaleReturnNo,CustomerCode,SaleReturnType,SaleReturnDate,SaleReturnDtlId,SaleReturnRowId,DNCode,DNRowId,SaleOrderNo,SaleOrderItem,ItemID,ItemCode,CustomerOrderNo,CustomerOrderItem,CWhCode,SaleReturnQty,CurrentReturnQty,PrintQty,Status,StatusName,ModifyBy,ModifyDateTime,CustomerName,ItemName,CWhName";
            return ComMethod.GetComList<SaleReturnDtlInfo>(ref this.recordCount, startRow, maxRows, "vwGetSaleReturn", string.Empty, columns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 分页获取 成品退货明细 列表数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SaleReturnDtlExInfo> GetSaleReturnDtlExList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string columns = "DocId,DocNo,CustomerCode,Id,DocLineNo,DNCode,ItemCode,SaleReturnQty,CurrentReturnQty,Status,StatusName,CreateDateTime,ModifyBy,ModifyDateTime,CustomerName,ItemName";
            return ComMethod.GetComList<SaleReturnDtlExInfo>(ref this.recordCount, startRow, maxRows, "vwGetSaleReturnEx", string.Empty, columns, sortExpression, searchSettings);
        }
        /// <summary>
        /// 成品退货扫描记录
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<SaleReturnScanInfo> GetSaleReturnScanList(SaleReturnScanInfo entity)
        {
            string sql = @"SELECT
                               ps.SaleReturnScanId,ps.SaleReturnNo,ps.SaleReturnRowId,ps.ScanType,ps.BarCode,ps.Qty,ps.CreateBy,ps.CreateDateTime,ps.ModifyBy,ps.ModifyDateTime,
	                           pd.ItemCode,bi.ItemName,bi.ItemSpec
                           FROM dbo.Prod_SaleReturnScan ps
                           INNER JOIN dbo.Prod_SaleReturnDtl pd ON ps.SaleReturnNo = pd.SaleReturnNo AND ps.SaleReturnRowId = pd.SaleReturnRowId
                           INNER JOIN dbo.Basal_Item bi ON pd.ItemCode = bi.ItemCode
                           WHERE ps.SaleReturnNo = @SaleReturnNo";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@SaleReturnNo",SqlDbType.VarChar){ Value = entity.SaleReturnNo },
            };
            return ComMethod.GetListBySql<SaleReturnScanInfo>(sql, parms);
        }


        /// <summary>
        /// 成品退货扫描记录
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<SaleReturnScanExInfo> GetSaleReturnScanExList(SaleReturnScanExInfo entity)
        {
            string sql = @"SELECT
                               ps.ScanId ,ps.DocNo ,ps.DocLineNo,ps.ScanType,ps.BarCode,ps.Qty,ps.CreateBy,ps.CreateDateTime,ps.ModifyBy,ps.ModifyDateTime,
	                           pd.ItemCode,bi.ItemName,bi.ItemSpec
                           FROM dbo.Prod_ERPRMAScan ps
                           INNER JOIN dbo.Prod_ERPRMALine pd ON ps.DocNo = pd.DocNo AND ps.DocLineNo = pd.DocLineNo
                           INNER JOIN dbo.Basal_Item bi ON pd.ItemCode = bi.ItemCode
                           WHERE ps.DocNo = @DocNo";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@DocNo",SqlDbType.VarChar){ Value = entity.DocNo },
            };
            return ComMethod.GetListBySql<SaleReturnScanExInfo>(sql, parms);
        }

        /// <summary>
        /// 分页获取 成品退货 列表数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SaleReturnScanInfo> GetSaleReturnScanAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string columns = @" ps.SaleReturnScanId,ps.SaleReturnNo,ps.SaleReturnRowId,ps.ScanType,ps.BarCode,ps.Qty,ps.CreateBy,ps.CreateDateTime,ps.ModifyBy,ps.ModifyDateTime,
	                           pd.ItemCode,bi.ItemName,bi.ItemSpec";
            string tableOrView = @"dbo.Prod_SaleReturnScan ps
                           INNER JOIN dbo.Prod_SaleReturnDtl pd ON ps.SaleReturnNo = pd.SaleReturnNo AND ps.SaleReturnRowId = pd.SaleReturnRowId
                           INNER JOIN dbo.Basal_Item bi ON pd.ItemCode = bi.ItemCode";
            return ComMethod.GetComList<SaleReturnScanInfo>(ref this.recordCount, startRow, maxRows, tableOrView, string.Empty, columns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 成品退货—扫描SN、客户SN、包装箱号、栈板号、GRN  
        /// </summary>
        /// <param name="entity"></param>
        public List<SaleReturnScanInfo> SaleReturnScanSN(SaleReturnScanInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@SaleReturnNo", SqlDbType.VarChar, 50) { Value = entity.SaleReturnNo },
                new SqlParameter("@BarCode", SqlDbType.VarChar, 50) { Value = entity.BarCode },
                new SqlParameter("@ScanType", SqlDbType.Int) { Value = entity.ScanType },
                new SqlParameter("@CBarCode", SqlDbType.VarChar, 50) { Value = entity.CBarCode },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            // return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaleReturnScanSN", parms);
            return ComMethod.GetList<SaleReturnScanInfo>("uspSaleReturnScanSN", parms);
        }

        /// <summary>
        /// 成品退货—扫描SN、客户SN、包装箱号、栈板号、GRN  
        /// </summary>
        /// <param name="entity"></param>
        public List<SaleReturnScanExInfo> SaleReturnScanSNEx(SaleReturnScanExInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@DocNo", SqlDbType.VarChar, 50) { Value = entity.DocNo },
                new SqlParameter("@BarCode", SqlDbType.VarChar, 50) { Value = entity.BarCode },
                new SqlParameter("@ScanType", SqlDbType.Int) { Value = entity.ScanType },
                new SqlParameter("@CBarCode", SqlDbType.VarChar, 50) { Value = entity.CBarCode },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            // return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaleReturnScanSN", parms);
            return ComMethod.GetList<SaleReturnScanExInfo>("uspSaleReturnScanSNEx", parms);
        }

        /// <summary>
        /// 成品退货-删除
        /// </summary>
        /// <param name="entity"></param>
        public void SaleReturnDeleteSN(SaleReturnScanInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
                        {
                new SqlParameter("@SaleReturnNo", SqlDbType.VarChar, 50) { Value = entity.SaleReturnNo },
                new SqlParameter("@BarCode", SqlDbType.VarChar, 50) { Value = entity.BarCode },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
                        };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaleReturnDeleteSN", parms);
        }

        /// <summary>
        /// 成品退货-删除
        /// </summary>
        /// <param name="entity"></param>
        public void SaleReturnDeleteSNEx(SaleReturnScanExInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
                        {
                new SqlParameter("@DocNo", SqlDbType.VarChar, 50) { Value = entity.DocNo },
                new SqlParameter("@BarCode", SqlDbType.VarChar, 50) { Value = entity.BarCode },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
                        };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaleReturnDeleteSNEx", parms);
        }

        /// <summary>
        /// 成品退货-保存
        /// </summary>
        /// <param name="entity"></param>
        public void SaleReturnSave(SaleReturnInfo entity)
        {
            //SqlParameter[] parms = new SqlParameter[]
            //            {
            //    new SqlParameter("@SaleReturnNo", SqlDbType.VarChar, 50) { Value = entity.SaleReturnNo },
            //    new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            //            };
            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaleReturnSave", parms);

            var msg = string.Empty;
            string erpNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.FinishedProductReturnReview;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@SaleReturnNo", entity.SaleReturnNo);
                    dp.Add("@ModifyBy", entity.ModifyBy);

                    reader = conn.ExecuteReader("uspSaleReturnSave", dp, tran, null, CommandType.StoredProcedure);

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
                        var returnOrderNo = Convert.ToString(dtWrite.Rows[0]["billCode"]);//MES退料单号

                         
                        //调用接口
                        var info = WriteBackERP.HttpPostU9Api<CreateSaleRcvResponse>(em, dtWrite, returnOrderNo, entity.ModifyBy, dtEnterTime, dtAfterExecProcTime);                     

                        if (info.ResCode != 0 || !info.Data[0].IsSucess)
                        {
                            //回写失败
                            throw new Exception(info.ResMsg ?? info.Data[0].ErrorMsg);
                        }
                        else
                        {

                        }
                    }

                    tran.Commit();
                }
                catch (Exception ex)
                {
                    // 捕获到异常，准备回滚事务  
                    try
                    {
                        tran.Rollback();
                        throw new Exception("事务处理失败，已回滚。", ex);
                    }
                    catch (Exception rollbackEx)
                    {

                        throw ex;
                    }

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
        }

        /// <summary>
        /// 成品退货-保存
        /// </summary>
        /// <param name="entity"></param>
        public void SaleReturnExSave(SaleReturnExInfo entity)
        {
            //SqlParameter[] parms = new SqlParameter[]
            //            {
            //    new SqlParameter("@SaleReturnNo", SqlDbType.VarChar, 50) { Value = entity.SaleReturnNo },
            //    new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            //            };
            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaleReturnSave", parms);

            var msg = string.Empty;
            string erpNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.FinishedProductReturnReview;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@DocNo", entity.DocNo);
                    dp.Add("@cBarCode", entity.BarCode);
                    dp.Add("@ModifyBy", entity.ModifyBy);

                    reader = conn.ExecuteReader("uspSaleReturnSaveEx", dp, tran, null, CommandType.StoredProcedure);

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
                        var returnOrderNo = Convert.ToString(dtWrite.Rows[0]["billCode"]);//MES退料单号

                        //调用接口
                        ERPU9ReturnInfo info = WriteBackERP.SendPostU9(conn, em, dtWrite, returnOrderNo, entity.ModifyBy, dtEnterTime, dtAfterExecProcTime);

                        logList.Add(new WriteBackLogInfo
                        {
                            WriteBackCode = em.ToString(),
                            ERPMsg = info.Msg,
                            ERPResult = info.Result ? 1 : 0,
                            ERPNo = info.ERPNo,
                            MESBillNo = returnOrderNo,
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

                    tran.Commit();
                }
                catch (Exception ex)
                {
                    // 捕获到异常，准备回滚事务  
                    try
                    {
                        tran.Rollback();
                        throw new Exception("事务处理失败，已回滚。", ex);
                    }
                    catch (Exception rollbackEx)
                    {

                        throw ex;
                    }

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
        }

        /// <summary>
        /// 成品退货新增编辑
        /// </summary>
        /// <param name="entity"></param>
        public void SaleReturnEdit(string strjson)
        {
            ComMethod.Edit(strjson, "uspSaleReturnEdit");
        }

        /// <summary>
        /// 成品退货删除
        /// </summary>
        /// <param name="saleReturnIds"></param>
        /// <param name="userName"></param>
        public void SaleReturnDelete(string saleReturnIds, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]
                        {
                new SqlParameter("@SaleReturnIds", SqlDbType.VarChar, 512) { Value = saleReturnIds },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = userName }
                        };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaleReturnDelete", parms);
        }


        /// <summary>
        /// 获取退货详情
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SaleReturnDetailInfo> GetSaleReturnDetailAll(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            int recordDelCount = 0;

            if (string.IsNullOrEmpty(sortExpression))
            {
                sortExpression = "SaleReturnRowId";
            }

            List<SaleReturnDetailInfo> list = new List<SaleReturnDetailInfo>();
            string strTb = "vwSaleReturnDetail";
            string strKey = "";
            string strColumns = "SaleReturnId,SaleReturnNo,CustomerCode,SaleReturnDate,SaleReturnRowId,DNCode,DNRowId,ItemCode,CWhCode,SaleReturnQty,Remark";
            return ComMethod.GetComList<SaleReturnDetailInfo>(ref recordDelCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 获取退货详情
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SaleReturnDetailExInfo> GetSaleReturnDetailExAll(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            int recordDelCount = 0;

            if (string.IsNullOrEmpty(sortExpression))
            {
                sortExpression = "DocLineNo";
            }

            List<SaleReturnDetailExInfo> list = new List<SaleReturnDetailExInfo>();
            string strTb = "vwSaleReturnDetailEx";
            string strKey = "";
            string strColumns = "DocId,DocNo,FactoryCode,CustomerCode,CustomerName,DocLineNo,Id,ItemCode,ItemId,ItemName,SaleReturnQty,CurrentReturnQty,PrintQty";
            return ComMethod.GetComList<SaleReturnDetailExInfo>(ref recordDelCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        public List<Prod_SaleReturn> GetSaleReturnByDel(long saleReturnDtlId)
        {
            string sql = @"SELECT tba.SaleReturnId,tba.SaleReturnNo 
                        FROM Prod_SaleReturnDtl AS tb
                        LEFT JOIN Prod_SaleReturn AS tba ON tb.SaleReturnNo=tba.SaleReturnNo
                        WHERE tb.SaleReturnDtlId=@SaleReturnDtlId";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@SaleReturnDtlId",SqlDbType.BigInt){ Value = saleReturnDtlId },
            };
            return ComMethod.GetListBySql<Prod_SaleReturn>(sql, parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 分页获取 成品退货 列表数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SaleReturnExInfo> GetAllEx(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string columns = @"pr.Id,pr.FactoryCode,pr.DocId,pr.DocNo,pr.CustomerCode,pr.Status,pr.DeleteFlag,pr.CreateBy,pr.CreateDateTime,pr.ModifyBy,pr.ModifyDateTime,
                               pr.CustomerName,pr.IsClosed";
            return ComMethod.GetComList<SaleReturnExInfo>(ref this.recordCount, startRow, maxRows, "dbo.Prod_ERPRMA pr ", string.Empty, columns, sortExpression, searchSettings);
        }
        public Int32 GetCountEx(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
