using Dapper;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.ERP;
using SKT.LeanMES.Warehouse.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Warehouse.BLL
{
    /// <summary>
    /// 销售备货
    /// </summary>
    public class WarehouseCpOutStock
    {

        private int recordCount = 0;
        /// <summary>
        /// 分页获取 WarehouseCpInConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warehouseCpInConfigCount">warehouseCpInConfig 总数。</param>
        /// <returns>WarehouseCpInConfig 列表。</returns>
        public List<WarehouseCpOutStockInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<WarehouseCpOutStockInfo> list = new List<WarehouseCpOutStockInfo>();
            //表名或者视图
            strTb = "vwOutStockReport";

            //主键
            string strKey = "SalOrderDtlID";
            //查询栏位字串
            string strColumns = @"[DNCode],[StatusName],[SalOrderDate],[SalOrderDtlID],[SalOrderNo],[CusCode],[CusName],[ItemCode],[ItemName],[PlanQty],[CurrentQty],[CreateBy],[CreateDateTime],
                    [ModifyBy],[ModifyDateTime],[FinishBy],[FinishDateTime],[BackERPStatus],[BackERPDateTime]";
            list = ComMethod.GetComList<WarehouseCpOutStockInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        public List<WarehouseCpOutStockInfo> Search(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<WarehouseCpOutStockInfo> list = new List<WarehouseCpOutStockInfo>();

            //表名或者视图
            strTb = "vwSalOrdelist";

            //主键
            string strKey = "Number";
            //查询栏位字串
            string strColumns = @"[ERPSalOrderID],[DNCode]";
            list = ComMethod.GetComList<WarehouseCpOutStockInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        public List<WarehouseCpOutStockInfo> Searchmes(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<WarehouseCpOutStockInfo> list = new List<WarehouseCpOutStockInfo>();
            strTb = "vw_Prod_SalOrder";//Prod_SalOrder

            //主键
            string strKey = "SalOrderID";
            //查询栏位字串
            string strColumns = @"[SalOrderID],[DNCode],[SalOrderDate],[CusCode],[CusName],[Address],[Status],[CreateBy],[CreateDateTime],[ModifyBy],[ModifyDateTime],[FinishBy],[FinishDateTime],[BackERPStatus],StockConfirmBy,StockConfirmTime";
            list = ComMethod.GetComList<WarehouseCpOutStockInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        /// <summary>
        /// 获取销售出货单详情
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public List<WarehouseCpOutStockDtlInfo> GetSalOrderDtlList(int code)
        {
            string sqlstr = @"SELECT t1.ItemName,t.*,ISNULL(t2.CWhName,'') CWhName,ISNULL(t.WhCode,'') WhCode,ISNULL(t1.CPN,'') CPN  FROM Prod_SalOrderDtl t WITH(NOLOCK) JOIN dbo.Basal_Item t1 WITH(NOLOCK) ON t1.ItemCode = t.ItemCode LEFT JOIN dbo.Basal_Warehouse t2 WITH(NOLOCK) ON t2.CWhCode = t.WhCode WHERE SalOrderID='" + code + "' ORDER BY t.SalOrderDtlID";
            List<WarehouseCpOutStockDtlInfo> list = new List<WarehouseCpOutStockDtlInfo>();
            list = ComMethod.GetListBySql<WarehouseCpOutStockDtlInfo>(sqlstr, null);
            return list;
            //return list.OrderByDescending(i => i.CurrentQty).ToList();
        }
        /// <summary>
        /// 获取销售出货单详情扫描记录
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public List<WarehouseCpOutStockDtlMemberInfo> GetSalOrderDtlMemberList(int code)
        {
            string sqlstr = String.Format(@"SELECT  a.ID,a.SalOrderDtlID,a.ScanType,a.Number,a.Qty,ISNULL(m1.CName,'') AS  CreateBy,a.CreateDateTime,a.[Status]
FROM    Prod_SalOrderDtlMember a(nolock)
        LEFT JOIN SYS_Users m1 ( NOLOCK ) ON RTRIM(LTRIM(a.CreateBy)) = m1.UserName
WHERE   SalOrderDtlID = '{0}'
ORDER BY CreateDateTime DESC;", code);
            List<WarehouseCpOutStockDtlMemberInfo> list = new List<WarehouseCpOutStockDtlMemberInfo>();
            list = ComMethod.GetListBySql<WarehouseCpOutStockDtlMemberInfo>(sqlstr, null);
            return list;
        }


        /// <summary>
        /// 获取出货列表可用的GRN
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <param name="Whcode"></param>
        /// <returns></returns>
        public List<WarehouseGrnMember> GetProductGRNMemberList(string ItemCode, string Whcode)
        {
            List<WarehouseGrnMember> list = new List<WarehouseGrnMember>();
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@ItemCode", SqlDbType.NVarChar) { Value=ItemCode },
                    new SqlParameter("@Whcode", SqlDbType.NVarChar) { Value=Whcode}
           };
            list = ComMethod.GetList<WarehouseGrnMember>("uspGetGRNByCpOutStock", parms);

            return list;
        }


        /// <summary>
        /// 获取销售出货单详情扫描记录
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public List<WarehouseCpOutStockDtlMemberInfoOutput> GetSalOrderMemberListDetails(int code)
        {
            string sqlstr = String.Format(@"select 
	ps.DNCode,  
	CAST(pn.Qty AS INT) AS Qty,
	pn.SerialNumber,
	pu.CustomerSN,
	pu.CartonNo,
	pu.PalletNo,
	pu.QcLotNo,
    ISNULL(m2.CName,'') AS CreateBy, 
	pn.CreateDateTime
	from
	dbo.Prod_SalOrder ps WITH (NOLOCK)
	INNER JOIN dbo.Prod_SalOrderDtl pd WITH (NOLOCK) ON ps.SalOrderID = pd.SalOrderID
	INNER JOIN dbo.Prod_SalOrderSN pn WITH (NOLOCK) ON pd.SalOrderDtlID = pn.SalOrderDtlId
	LEFT JOIN dbo.Prod_Unit pu WITH (NOLOCK) ON pn.SerialNumber = pu.SN
	LEFT JOIN SYS_Users m1 (NOLOCK) ON ps.CreateBy = m1.UserName
	LEFT JOIN SYS_Users m2 (NOLOCK) ON ps.FinishBy = m2.UserName
	where ps.SalOrderID='{0}'
	order by pn.CreateDateTime desc", code);
            List<WarehouseCpOutStockDtlMemberInfoOutput> list = new List<WarehouseCpOutStockDtlMemberInfoOutput>();
            list = ComMethod.GetListBySql<WarehouseCpOutStockDtlMemberInfoOutput>(sqlstr, null);
            return list;
        }
        /// <summary>
        /// 获取出货明细导出
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public DataTable GetSalOrderDtlMemberListExcle(int id)
        {
            string sql = string.Format(@"select 
	ps.DNCode AS 备货单号,  
	pn.Qty as 数量,
	pn.SerialNumber AS 序列号,
	pu.CustomerSN AS 客户号码,
	pu.CartonNo AS 包装箱号码,
	pu.PalletNo AS 栈板号码 ,
	pu.QcLotNo AS 批次号,
    ISNULL(m2.CName,'''') AS 出货人, 
	pn.CreateDateTime AS 扫描时间
	from
	dbo.Prod_SalOrder ps WITH (NOLOCK)
	INNER JOIN dbo.Prod_SalOrderDtl pd WITH (NOLOCK) ON ps.SalOrderID = pd.SalOrderID
	INNER JOIN dbo.Prod_SalOrderSN pn WITH (NOLOCK) ON pd.SalOrderDtlID = pn.SalOrderDtlId
	LEFT JOIN dbo.Prod_Unit pu WITH (NOLOCK) ON pn.SerialNumber = pu.SN
	LEFT JOIN SYS_Users m1 (NOLOCK) ON ps.CreateBy = m1.UserName
	LEFT JOIN SYS_Users m2 (NOLOCK) ON ps.FinishBy = m2.UserName
	where ps.SalOrderID='{0}'
	order by pn.CreateDateTime desc", id);
            DataTable dt = new DataTable();
            DataSet ds = ComMethod.GetListDataSetBySql(sql, null);
            dt = ds.Tables[0];
            return dt;
        }
        /// <summary>
        /// 查询扫描记录
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public List<WarehouseCpOutStockDtlMemberInfo> GetSalOrderDtlMemberHistoryList(int code)
        {
            string strsql = @"SELECT 
            Number,Code,CreateBy,CreateDateTime FROM dbo.Prod_SalOrderDtlMember t JOIN dbo.Prod_SalOrderDtlMemberHistory t1 ON t.ID=t1.ID WHERE SalOrderDtlID=" + code;
            List<WarehouseCpOutStockDtlMemberInfo> list = new List<WarehouseCpOutStockDtlMemberInfo>();
            list = ComMethod.GetListBySql<WarehouseCpOutStockDtlMemberInfo>(strsql, null);
            return list;
        }
        /// <summary>
        /// 保存dn到mes
        /// </summary>
        /// <param name="dnCode"></param>
        public void SaveDN(string dnCode, string username)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@dncode",SqlDbType.NVarChar),
                new SqlParameter("@username",SqlDbType.NVarChar)
            };
            parms[0].Value = dnCode.Trim();
            parms[1].Value = username.Trim();
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCpOutStockDNSave", parms);
        }
        /// <summary>
        /// 扫描保存条码信息
        /// </summary>
        /// <param name="DtlId"></param>
        /// <param name="Number"></param>
        /// <param name="Type"></param>
        /// <param name="username"></param>
        public void ScanSave(string DNcode, string Number, int Type, string username)
        {
            var entity = new WarehouseCpOutStockDtlInfo();
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@DNcode",SqlDbType.VarChar),
                new SqlParameter("@number",SqlDbType.NVarChar),
                new SqlParameter("@type",SqlDbType.Int),
                new SqlParameter("@username",SqlDbType.NVarChar)
            };
            parms[0].Value = DNcode;
            parms[1].Value = Number;
            parms[2].Value = Type;
            parms[3].Value = username.Trim();
            //entity = ComMethod.Get<WarehouseCpOutStockDtlInfo>("uspCpOutStockScanSave", parms);
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCpOutStockScanSave", parms);
            //return entity;
        }
        /// <summary>
        /// 删除保存条码信息
        /// </summary>
        /// <param name="DtlId"></param>
        /// <param name="Number"></param>
        /// <param name="Type"></param>
        /// <param name="username"></param>
        public void DeleteScan(int id)
        {
            var entity = new WarehouseCpOutStockDtlInfo();
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@id",SqlDbType.Int)
            };
            parms[0].Value = id;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCpOutStockDeleteScan", parms);
        }

        /// <summary>
        /// 备货确认
        /// </summary>
        /// <param name="id"></param>
        public string Stocking(int id, string username)
        {
            //string sqlstr = @"UPDATE Prod_SalOrder SET Status = Status + 1, ModifyBy = '" + username + "', ModifyDateTime = GETDATE() WHERE SalOrderID = '" + id + "'";
            //List<WarehouseCpOutStockDtlMemberInfo> list = new List<WarehouseCpOutStockDtlMemberInfo>();
            //ComMethod.EditBySql(sqlstr, null);

            //SqlParameter[] parms = new SqlParameter[] {
            //    new SqlParameter("@Id",SqlDbType.Int),
            //    new SqlParameter("@Username",SqlDbType.VarChar)
            //};
            //parms[0].Value = id;
            //parms[1].Value = username;
            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspStockConfirmation", parms);

            var msg = string.Empty;
            string erpReturnNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.SaleExWarehouse;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）

            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@Id", id);
                    dp.Add("@Username", username);
                    reader = conn.ExecuteReader("uspStockConfirmation", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    ////是否需要回写
                    //isWriteBack = WriteBackERP.IsWriteBack(em);
                    //if (isWriteBack)
                    //{
                    //    if (dtWrite == null || dtWrite.Rows.Count <= 0)
                    //    {
                    //        msg = "未获取到需要回写ERP数据";
                    //        throw new Exception(msg);
                    //    }

                    //    string dnCode = Convert.ToString(dtWrite.Rows[0]["MESDocNO"]);
                    //    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                    //    //调用接口
                    //    ERPReturnInfo info = WriteBackERP.SendPost(em, dtWrite, dnCode, username, dtEnterTime, dtAfterExecProcTime);
                    //    if (!info.Result)
                    //    {
                    //        //回写失败
                    //        throw new Exception(info.msg);
                    //    }
                    //}
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
                }
            }
            return erpReturnNo;

        }

        /// <summary>
        /// 出货确认
        /// </summary>
        public string OutStockConfirmation(int id, string username)
        {
            /*
            var entity = new WarehouseCpOutStockDtlInfo();
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@id",SqlDbType.Int),
                new SqlParameter("@username",SqlDbType.VarChar)
            };
            parms[0].Value = id;
            parms[1].Value = username;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOutStockConfirmation", parms);
            return string.Empty;
            */
            var msg = string.Empty;
            string erpReturnNo = string.Empty;
            string erpId = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.SaleExWarehouse;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            //List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@Id", id);
                    dp.Add("@Username", username);
                    dp.Add("@ERPId", "", DbType.String, ParameterDirection.Output);
                    reader = conn.ExecuteReader("uspOutStockConfirmation", dp, tran, null, CommandType.StoredProcedure);
                
                    dtWrite.Load(reader);
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    erpId = dp.Get<string>("@ERPId").ToString(); ;


                    //是否需要回写
                    isWriteBack = WriteBackERP.IsWriteBack(em);


                    if (isWriteBack && !string.IsNullOrEmpty(erpId))
                    {
                        if (dtWrite == null || dtWrite.Rows.Count <= 0)
                        {
                            msg = "未获取到需要回写ERP数据";
                            throw new Exception(msg);
                        }

                        string dnCode = Convert.ToString(dtWrite.Rows[0]["billCode"]);
                        DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间
                        if(dnCode.Length > 2 && dnCode.Substring(0, 2) == "SH")
                        {
                            //调用接口
                            ERPU9ReturnInfo info = WriteBackERP.SendPostU9(conn, em, dtWrite, dnCode, username, dtEnterTime, dtAfterExecProcTime);
                            if (!info.Result)
                            {
                                //回写失败
                                throw new Exception(info.Msg);
                            }


                        }                        
                        //PDA成品出库完成，回写审核ERP的标准出货单据
                        //2025-02-19 吴锋文
                        if(dnCode.Length >2 && dnCode.Substring(0,2)=="SM")
                        {
                            //获取所有的单据是否出货                           
                            string strsql1 = @"SELECT top 1 psd.itemcode FROM Prod_SalOrder pso inner join prod_salorderdtl psd on pso.salorderid=psd.salorderid  where  psd.CurrentQty<psd.PlanQty and pso.dncode='" + dnCode + "'";
                            var result = "";
                            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, strsql1, null))
                            {
                                while (rdr.Read())
                                {
                                    result = rdr.GetString(0);
                                }
                                rdr.Close();
                            }
                            if(result=="")
                            {
                                HttpClientHelper client = new HttpClientHelper();
                                result = client.PostU9ShipAudit(dnCode);
                                if(string.IsNullOrEmpty(result) || result!="OK")
                                {
                                    msg = "审核标准出货单失败";
                                    throw new Exception(result);
                                }
                            }
                        }
                        //logList.Add(new WriteBackLogInfo
                        //{
                        //    WriteBackCode = em.ToString(),
                        //    ERPMsg = info.Msg,
                        //    ERPResult = info.Result ? 1 : 0,
                        //    ERPNo = info.ERPNo,
                        //    MESBillNo = dnCode,
                        //    WriteBackData = info.SendInfo,
                        //    ReceiveData = info.ReceiveData,
                        //    EnterTime = dtEnterTime,
                        //    AfterExecProcTime = dtAfterExecProcTime,
                        //    AfterExecERPTime = info.dtAfterExecERPTime,
                        //    CreateDateTime = DateTime.Now
                        //});

                        
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
                    //foreach (var log in logList)
                    //{
                    //    WriteBackERP.AddWriteBackLog(conn, log);
                    //}
                    conn.Close();
                }
            }
            return erpReturnNo;
        }


        public void Delete(int id)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@id",SqlDbType.Int)
            };
            parms[0].Value = id;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOutStockDel", parms);
        }

        #region 保存备料单
        /// <summary>
        /// 保存备料单
        /// </summary>
        /// <param name="entity"></param>
        public void StockOrderEdit(StockOrderInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SalOrderID", SqlDbType.Int),
                new SqlParameter("@DNCode", SqlDbType.VarChar, 50),
                new SqlParameter("@SalOrderDate", SqlDbType.VarChar, 100),
                new SqlParameter("@CusCode", SqlDbType.VarChar, 100),
                new SqlParameter("@CusName", SqlDbType.VarChar, 50),
                new SqlParameter("@Address", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.SalOrderID;
            parms[1].Value = entity.DNCode;
            parms[2].Value = entity.SalOrderDate;
            parms[3].Value = entity.CusCode;
            parms[4].Value = entity.CusName;
            parms[5].Value = entity.Address;
            parms[6].Value = entity.CreateBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspStockOrderEdit", parms);

        }
        #endregion

        #region 获取备货单信息
        /// <summary>
        /// 获取备货单信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<WarehouseCpOutStockInfo> GetStockOrderAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<WarehouseCpOutStockInfo> list = new List<WarehouseCpOutStockInfo>();
            //表名或者视图
            strTb = "vwOutStockReport";

            //主键
            string strKey = "SalOrderID";
            //查询栏位字串
            string strColumns = @"SalOrderID,[DNCode],[StatusName],[SalOrderDate],[SalOrderDtlID],[SalOrderNo],[CusCode],[CusName],[ItemCode],[ItemName],[PlanQty],[CurrentQty],[CreateBy],[CreateDateTime],
                    [ModifyBy],[ModifyDateTime],[FinishBy],[FinishDateTime],[BackERPStatus],[BackERPDateTime],Address,CustomerOrder,SalorderItem";
            list = ComMethod.GetComList<WarehouseCpOutStockInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        #endregion

        #region 获取单条备料信息
        /// <summary>
        /// 获取单条号码范围信息
        /// </summary>
        /// <param name="ScopeId"></param>
        /// <returns></returns>
        public StockOrderInfo GetStockOrderInfo(Int32 SalOrderID)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<StockOrderInfo>(SalOrderID, "uspGetStockOrderInfo");
        }
        #endregion

        #region 获取备货单明细信息
        /// <summary>
        /// 获取备货单明细信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<WarehouseCpOutStockDtlInfo> GetStockOrderDtlAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<WarehouseCpOutStockDtlInfo> list = new List<WarehouseCpOutStockDtlInfo>();
            //表名或者视图
            strTb = "vwGetStockOrderDtl";

            //主键
            string strKey = "SalOrderDtlID";
            //查询栏位字串
            string strColumns = @"SalOrderDtlID, SalOrderID, SalOrderNo, ItemCode, ItemID, PlanQty,CurrentQty, CarNo, ContainerNo, SealNo, Remark,ItemName,CustomerOrder,SalorderItem";
            list = ComMethod.GetComList<WarehouseCpOutStockDtlInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        #endregion

        #region 保存备料单明细信息
        /// <summary>
        /// 保存备料单明细信息
        /// </summary>
        /// <param name="entity"></param>
        public void StockOrderDtlEdit(WarehouseCpOutStockDtlInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SalOrderDtlID", SqlDbType.Int),
                new SqlParameter("@SalOrderID", SqlDbType.Int),
                new SqlParameter("@SalOrderNo", SqlDbType.VarChar, 50),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 100),
                new SqlParameter("@ItemID", SqlDbType.Int),
                new SqlParameter("@PlanQty", SqlDbType.Decimal),
                new SqlParameter("@CurrentQty", SqlDbType.Decimal),
                new SqlParameter("@CarNo", SqlDbType.VarChar, 50),
                new SqlParameter("@ContainerNo", SqlDbType.VarChar, 50),
                new SqlParameter("@SealNo", SqlDbType.VarChar, 50),
                new SqlParameter("@Remark", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@CustomerOrder", SqlDbType.VarChar, 50),
                new SqlParameter("@SalorderItem", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.SalOrderDtlID;
            parms[1].Value = entity.SalOrderID;
            parms[2].Value = entity.SalOrderNo;
            parms[3].Value = entity.ItemCode;
            parms[4].Value = entity.ItemID;
            parms[5].Value = entity.PlanQty;
            parms[6].Value = entity.CurrentQty;
            parms[7].Value = entity.CarNo;
            parms[8].Value = entity.ContainerNo;
            parms[9].Value = entity.SealNo;
            parms[10].Value = entity.Remark;
            parms[11].Value = entity.CreateBy;
            parms[12].Value = entity.CustomerOrder;
            parms[13].Value = entity.SalorderItem;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspStockOrderDtlEdit", parms);

        }
        #endregion

        #region 获取单条备料明细信息
        /// <summary>
        /// 获取单条备料明细信息
        /// </summary>
        /// <param name="ScopeId"></param>
        /// <returns></returns>
        public WarehouseCpOutStockDtlInfo GetStockOrderDtlInfo(Int32 SalOrderID)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<WarehouseCpOutStockDtlInfo>(SalOrderID, "uspGetStockOrderDtlInfo");
        }
        #endregion

        #region 删除备货单信息
        /// <summary>
        /// 删除备货单信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void DeleteStockOrder(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteStockOrder", parms);
        }
        #endregion

        #region 删除备货单明细信息
        /// <summary>
        /// 删除备货单明细信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void DeleteStockOrderDtl(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteStockOrderDtl", parms);
        }
        #endregion

        #region 保存上传文件信息

        /// <summary>
        /// 新增成品出货附件信息
        /// </summary>
        /// <param name="salOrderID"></param>
        /// <param name="fileUpName"></param>
        /// <param name="fFileType"></param>
        /// <param name="fileSaveName"></param>
        /// <param name="filePath"></param>
        /// <param name="userName"></param>
        public void CPOutStockUploadFile(int salOrderID, string fileUpName, string fFileType, string fileSaveName, string filePath, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SalOrderID", SqlDbType.Int),
                new SqlParameter("@FileUpName", SqlDbType.NVarChar),
                new SqlParameter("@FileType", SqlDbType.NVarChar),
                new SqlParameter("@FileSaveName", SqlDbType.NVarChar),
                new SqlParameter("@FilePath", SqlDbType.NVarChar),
                new SqlParameter("@UserName", SqlDbType.NVarChar),
            };

            parms[0].Value = salOrderID;
            parms[1].Value = fileUpName;
            parms[2].Value = fFileType;
            parms[3].Value = fileSaveName;
            parms[4].Value = filePath;
            parms[5].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCPOutStockUploadFile", parms);
        }

        /// <summary>
        /// 获取成品出货附件信息
        /// </summary>
        /// <param name="salOrderID"></param>
        /// <returns></returns>
        public List<AttachFileInfo> GetAttachFileInfo(int salOrderID)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SalOrderID", SqlDbType.Int),
            };
            parms[0].Value = salOrderID;
            string sql = "SELECT FileID,FileUpName,FilePath,CreateBy,CreateDateTime FROM dbo.SYS_UpLoadFile WHERE RowType='SalOrder' AND FromID=@SalOrderID";

            return ComMethod.GetListBySql<AttachFileInfo>(sql, parms);
        }

        /// <summary>
        /// 删除文件
        /// </summary>
        /// <param name="fileID"></param>
        public void DeleteAttachFileInfo(int fileID)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FileID", SqlDbType.Int),
            };

            parms[0].Value = fileID;

            string sql = "Delete dbo.SYS_UpLoadFile WHERE FileID=@FileID";

            ComMethod.EditBySql(sql, parms);
        }

        #endregion

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 根据领料单号返回明细数据 --字符流
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public byte[] GetCpOutStockPdfByte(int intId, string strXmlFilePath, string strImgPath)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@SalOrderID",SqlDbType.Int),
            };
            parms[0].Value = intId;
            DataSet ds = ComMethod.GetListDataSet("upsGetCpOutStockPrint", parms, "dtApplyForm");

            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }
    }
}
