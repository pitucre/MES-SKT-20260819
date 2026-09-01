/*-------------------------------------------------
// Copyright(C)2016 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:ProdCollectBinding.cs
// 文件功能描述：用于查询生产采集绑定信息：包括装配、不良、装箱及码垛。
// 
// 创建标识：Larry.Lin 2016/08/11
// 
// 
//--------------------------------------------------*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.ProductionCollection.Model;

namespace SKT.LeanMES.ProductionCollection
{
    public class ProdCollectBinding
    {
        private Int32 recordCount = 0;

        #region 拼版绑定

        /// <summary>
        /// 检测拼版SN信息返回拼版规格
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public ProdCollectionInputInfo CheckPanelBindSN(string sn, int prodOrderId)
        {
            List<ProdCollectionInputInfo> list = new List<ProdCollectionInputInfo>();

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int)
            };

            param[0].Value = sn;
            param[1].Value = prodOrderId;           

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckPanelBindSN", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<ProdCollectionInputInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        /// <summary>
        /// 拼版投入过站
        /// </summary>
        /// <param name="panelUnitIdArr">拼版集合</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="resId">资源ID</param>
        /// <param name="userId">用户ID</param>
        public void CollectPanelBindSN(string panelUnitIdArr, int stationId, int resId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@PanelUnitIdArr",SqlDbType.VarChar),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserID",SqlDbType.Int),
            };
            param[0].Value = panelUnitIdArr;
            param[1].Value = stationId;
            param[2].Value = resId;
            param[3].Value = userId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectPanelBindSN", param);
        }

        /// <summary>
        /// 验证产线是否开拉
        ///验证GRN信息
        ///返回GRN数量 物料信息
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public decimal[] CheckPanelBindGRN(string grn, int prodOrderId, int stationId)
        {
            decimal[] grnArr = new decimal[3];
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@GRN",SqlDbType.NVarChar,300),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int)
            };
            param[0].Value = grn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckPanelBindGRN", param))
            {
                if (rdr.Read())
                {
                    grnArr[0] = rdr.GetDecimal(0);
                    grnArr[1] = Convert.ToDecimal(rdr.GetInt32(1));
                    grnArr[2] = rdr.GetDecimal(2);
                }
            }

            return grnArr;
        }

        /// <summary>
        /// 验证SN
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="sacnCount"></param>
        /// <returns></returns>
        public ProdCollectionInputInfo CheckMatPanelBindSN(string sn, int prodOrderId, int stationId, int resId, int userId)
        {
            List<ProdCollectionInputInfo> list = new List<ProdCollectionInputInfo>();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserID",SqlDbType.Int)                         
            };
            param[0].Value = sn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = userId;             

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckMatPanelBindSN", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<ProdCollectionInputInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        /// <summary>
        /// 拼版上料投入过站
        /// </summary>
        /// <param name="panelUnitIdArr"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        /// <param name="grn"></param>
        /// <returns></returns>
        public decimal CollectMatPanelBindSN(string panelUnitIdArr, int stationId, int resId, int userId, string userName, string grn)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@PanelUnitIdArr",SqlDbType.VarChar),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
                new SqlParameter("@GRN",SqlDbType.NVarChar),
                new SqlParameter("@BalanceQty",SqlDbType.Decimal)
            };
            param[0].Value = panelUnitIdArr;
            param[1].Value = stationId;
            param[2].Value = resId;
            param[3].Value = userId;
            param[4].Value = userName;
            param[5].Value = grn;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectMatPanelBindSN", param);

            return Convert.ToDecimal(param[6].Value);
        }
        #endregion

        #region 投入采集

        /// <summary>
        /// 投入过站
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="resId"></param>
        /// <param name="stationId"></param>
        /// <param name="userId"></param>
        public void CollectOrderInput(string sn, int resId, int stationId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),    
                new SqlParameter("@UserId",SqlDbType.Int)  
            };

            param[0].Value = sn;
            param[1].Value = stationId;
            param[2].Value = resId;
            param[3].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectOrderInput", param);
        }
        /// <summary>
        /// 在线条码投入过站--验证当前SN的工单是否与投入站位选择的工单一致
        /// 离线条码投入过站--将当前条码插入Prod_SerialNumber/Prod_Unit表并与投入工单关联起来
        /// </summary>
        /// <param name="SN">产品条码</param>
        /// <param name="prodOrderId">工单ID</param>
        /// <param name="routerId">路由ID</param>
        /// <param name="userId">用户ID</param>
        /// <param name="isOffLineSN">是否为离线条码投入 0、不是 1、是 </param>
        public Decimal CheckSNInputOrder(string SN, int prodOrderId, int routerId, int userId, int isOffLineSN, string grn, int resId, int stationId, string userName, int isOnLineSN)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.VarChar),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@RouterId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@IsOffLineSN",SqlDbType.Int),
                new SqlParameter("@GRN",SqlDbType.NVarChar,300),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,50),
                new SqlParameter("@IsOnLineSN",SqlDbType.Int),
                new SqlParameter("@BalanceQty",SqlDbType.Decimal)
            };

            param[0].Value = SN;
            param[1].Value = prodOrderId;
            param[2].Value = routerId;
            param[3].Value = userId;
            param[4].Value = isOffLineSN;
            param[5].Value = grn;
            param[6].Value = resId;
            param[7].Value = stationId;
            param[8].Value = userName;
            param[9].Value = isOnLineSN;
            param[10].Value = 0.000;
            param[10].Precision = 18;
            param[10].Scale = 6;
            param[10].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckSNInputOrder", param);

            return Convert.ToDecimal(param[10].Value);
        }
        
        /// <summary>
        /// 获取GRN包装内的数量
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public decimal[] GetGRNQty(string grn, int prodOrderId, int stationId)
        {
            decimal[] grnArr = new decimal[3];
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@GRN",SqlDbType.NVarChar,300),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int)              
            };
            param[0].Value = grn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;            

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetGRNQty", param))
            {
                if (rdr.Read())
                {
                    grnArr[0] = rdr.GetDecimal(0);
                    grnArr[1] = Convert.ToDecimal(rdr.GetInt32(1));
                    grnArr[2] = rdr.GetDecimal(2);
                }
            }

            return grnArr;
        }

        /// <summary>
        /// 检测SN是否属于离线条码，如果属于离线条码将产品相关的掩码规则带出
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public string[] GetSNRegExp(string sn, int prodOrderId)
        {
            string[] snRegExpArr = new string[2];
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),                
            };
            param[0].Value = sn;
            param[1].Value = prodOrderId;           

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetSNRegExp", param))
            {
                if (rdr.Read())
                {
                    snRegExpArr[0] = rdr.GetInt64(0).ToString();
                    snRegExpArr[1] = rdr.GetString(1);
                }
            }

            return snRegExpArr;
        }

        /// <summary>
        /// 进行离线条码投入过站
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="routerId"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        public void OffLineSNInput(string sn, int prodOrderId, int routerId, int stationId, int resId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),    
                new SqlParameter("@RouterId",SqlDbType.Int), 
                new SqlParameter("@UserId",SqlDbType.Int)  
            };

            param[0].Value = sn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = routerId;
            param[5].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOffLineSNInput", param);
        }

        /// <summary>
        /// 转工单
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="opeId"></param>
        public void ChangeOrder(int prodOrderId, string sn, int stationId, int resId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),               
                new SqlParameter("@UserId",SqlDbType.Int)  
            };

            param[0].Value = sn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspChangeOrder", param);
        }

        /// <summary>
        /// 获取工单产品的离线条码规则
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public string GetRegExpByOrderId(int prodOrderId)
        {
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@ProdOrderId",SqlDbType.Int),  
                new SqlParameter("@RegExp",SqlDbType.VarChar,300),                  
            };
            paras[0].Value = prodOrderId;
            paras[1].Value = "";
            paras[1].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetRegExpByOrderId", paras);

            return (string)paras[1].Value;
        }

        #endregion
 
        #region 成品入库

        /// <summary>
        /// 检测库位条码是否存在
        /// </summary>
        /// <param name="cBarCode"></param>
        public void CheckScrapInStorage(String cBarCode)
        {
            SqlParameter[] parms = new SqlParameter[]{ 
                new SqlParameter("@BarCode", SqlDbType.NVarChar,200)
            };

            parms[0].Value = cBarCode;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckScrapInStorage", parms);
        }

        /// <summary>
        ///  验证包装条码是否存在
        /// </summary>
        /// <param name="SerialNumber"></param>
        /// <returns>反回1：包内条码有已入库的</returns>
        public int CheckContainerSN(string serialNumber)
        {
            SqlParameter[] parms = new SqlParameter[]{ 
                new SqlParameter("@ReturnValue", SqlDbType.Int),
                new SqlParameter("@SerialNumber", SqlDbType.NVarChar,512)

            };
            parms[0].Value = -1;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = serialNumber;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckContainerSN", parms);

            return Convert.ToInt32(parms[0].Value);
        }

        /// <summary>
        /// 查询当前产线是否有入库单
        /// </summary>
        /// <param name="resId"></param>
        /// <returns></returns>
        public int CheckStorageOrder(int resId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StorageID", SqlDbType.Int),
                new SqlParameter("@ResId", SqlDbType.NVarChar, 50)              
            };
            parms[0].Value = -1;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = resId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckStorageOrder", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 通过SN获取库存表ID（SN 可为栈板、包装箱、产品SN）
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <returns></returns>
        public int GetStorageID(string serialNumber)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StorageID", SqlDbType.Int),
                new SqlParameter("@SerialNumber", SqlDbType.NVarChar, 512)              
            };
            parms[0].Value = -1;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = serialNumber;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetStorageIDByContainerSN", parms);

            return (Int32)parms[0].Value;
        }

        ///  </summary>
        ///  入库扫描
        /// </summary>
        /// <param name="SerialNumber"></param>
        public void PutInStorage(int StorageID, string SerialNumber, string BarCode, string userName, int scanType, int resId)
        {
            SqlParameter[] parms = new SqlParameter[]{               
                new SqlParameter("@StorageID", SqlDbType.Int),
                new SqlParameter("@SerialNumber", SqlDbType.NVarChar, 512),
                new SqlParameter("@BarCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),                
                new SqlParameter("@ScanType",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int)
            };
            parms[0].Value = StorageID;
            parms[1].Value = SerialNumber;
            parms[2].Value = BarCode;
            parms[3].Value = userName;
            parms[4].Value = scanType;
            parms[5].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPutInStorage", parms);
        }

        /// <summary>
        /// 获取产品入库子表信息
        /// </summary>
        /// <param name="StorageID"></param>
        /// <returns></returns>
        public List<StorageMemberInfo> GetStorageMember(Int32 StorageID)
        {
            List<StorageMemberInfo> list = new List<StorageMemberInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StorageID", SqlDbType.Int)      
            };

            parms[0].Value = StorageID;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetStorageMember", parms))
            {
                while (rdr.Read())
                {
                    StorageMemberInfo entity = null;
                    entity = new StorageMemberInfo();
                    entity.StorageMemberID = rdr.GetInt32(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.StorageNumber = rdr.GetString(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.ItemName = rdr.GetString(4);
                    entity.OrderNo = rdr.GetString(5);
                    entity.StorageQty = rdr.GetInt32(6);
                    entity.BarCode = rdr.GetString(7);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 保存入库信息
        /// </summary>
        /// <param name="storageID"></param>
        /// <param name="userName"></param>
        /// <param name="userId"></param>
        /// <param name="resId"></param>
        /// <param name="stationId"></param>
        public void SaveToStorage(int storageID, string userName, int userId, int resId, int stationId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@StorageID",SqlDbType.VarChar),   
                new SqlParameter("@UserName",SqlDbType.VarChar),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),               
                new SqlParameter("@StaionId",SqlDbType.Int),
                
            };
            param[0].Value = storageID;
            param[1].Value = userName;
            param[2].Value = userId;
            param[3].Value = resId;
            param[4].Value = stationId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveToStorage", param);
        }

        /// <summary>
        /// 删除未完成入库的扫描入库信息
        /// </summary>
        /// <param name="serialNumber"></param>
        public void PutInStorageDelete(int storageMemberId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StorageMemberId", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.NVarChar, 50)              
            };
            parms[0].Value = storageMemberId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPutInStorageDelete", parms);
        }
        #endregion

        #region 成品出库
        /// <summary>
        /// 分页获取 走货单号 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="storageMemberCount">storageMember 总数。</param>
        /// <returns>StorageMember 列表。</returns>
        public List<SoOrderInfo> GetAllSoOrder(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SoOrderInfo> list = new List<SoOrderInfo>();
            SoOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetSoOrderInfo", "ID",
                "ID,Code", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SoOrderInfo();
                    entity.ID = Convert.ToInt32(rdr[0]);
                    entity.Code = rdr.GetString(1);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 根据走货单号获取产品信息
        /// </summary>
        /// <param name="soCode"></param>
        /// <returns></returns>
        public List<OutStorageInfo> GetAllSoOrderInfo(string soCode)
        {
            List<OutStorageInfo> list = new List<OutStorageInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SoCode", SqlDbType.VarChar,50)   
            };

            parms[0].Value = soCode;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetOutSotrageSoInfo", parms))
            {
                while (rdr.Read())
                {
                    OutStorageInfo entity = null;
                    entity = new OutStorageInfo();
                    entity.ItemId = rdr.GetInt32(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.Description = rdr.GetString(2);
                    entity.TurnQty = Convert.ToInt32(rdr[3]);
                    entity.OutQty = Convert.ToInt32(rdr[4]);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public Int32 ProductOutStorage(string sn, int scanType, int itemId, int balanceQty, string soCode, string userName, int stationId, int resId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ScanType",SqlDbType.Int),
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@BalanceQty",SqlDbType.Int),
                new SqlParameter("@SoCode",SqlDbType.VarChar,50),
                new SqlParameter("@CreateBy",SqlDbType.VarChar,50),
                new SqlParameter("@OutCount",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
            };

            param[0].Value = sn;
            param[1].Value = scanType;
            param[2].Value = itemId;
            param[3].Value = balanceQty;
            param[4].Value = soCode;
            param[5].Value = userName;
            param[6].Value = 0;
            param[6].Direction = ParameterDirection.InputOutput;
            param[7].Value = stationId;
            param[8].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspProductOutStorage", param);

            return (int)param[6].Value;
        }

        /// <summary>
        /// 获取出库车辆信息
        /// </summary>
        /// <param name="soCode"></param>
        /// <returns></returns>
        public OutStorageCarInfo GetOutStorageCarInfo(string soCode)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SOCode",SqlDbType.VarChar,50),
            };
            OutStorageCarInfo entity = new OutStorageCarInfo();
            param[0].Value = soCode;

            string sql = "select OutStorageCarId,SOCode,CarNum,FileUrl,Remark from Prod_OutStorageCar where SOCode=@SOCode";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, param))
            {
                if (rdr.Read())
                {
                    entity.OutStorageCarId = rdr.GetInt32(0);
                    entity.SOCode = rdr.GetString(1);
                    entity.CarNum = rdr.GetString(2);
                    entity.FileUrl = rdr.GetString(3);
                    entity.Remark = rdr.GetString(4);
                }
            }

            return entity;
        }

        /// <summary>
        /// 编辑出货车辆信息
        /// </summary>
        /// <param name="entity"></param>
        public void OutStorageCarEdit(OutStorageCarInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{ 
                new SqlParameter("@SOCode", SqlDbType.VarChar, 50),
                new SqlParameter("@CarNum", SqlDbType.NVarChar, 50),
                new SqlParameter("@FileUrl", SqlDbType.VarChar, 200),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200)
            };

            parms[0].Value = entity.SOCode;
            parms[1].Value = entity.CarNum;
            parms[2].Value = entity.FileUrl;
            parms[3].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_OutStorageCar_Edit", parms);
        }
        #endregion
 
        #region 成品库位转移

        /// <summary>
        /// 成品信息库位转移
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="Code"></param>
        /// <param name="userName"></param>
        /// <param name="transType"></param>
        public void ProdStorageTransfer(String sn, String code, String userName,int transType)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@SN",SqlDbType.NVarChar,512),
                  new SqlParameter("@cBarCode",SqlDbType.NVarChar,50),
                  new SqlParameter("@UserName",SqlDbType.VarChar,20),
                  new SqlParameter("@Type",SqlDbType.Int,4),

            };
            parms[0].Value = sn;
            parms[1].Value = code;
            parms[2].Value = userName;
            parms[3].Value = transType;
            
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspProdStorageTransfer", parms);
        }

        /// <summary>
        /// 获取产品包装库位信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="transType"></param>
        /// <returns></returns>
        public List<StorageTransferInfo> GetStorageInfo(String sn, int transType)
        {
            List<StorageTransferInfo> list = new List<StorageTransferInfo>();
            StorageTransferInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@TransType",SqlDbType.Int)
            };
            parms[0].Value = sn;
            parms[1].Value = transType;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetProdStorageTransferInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new StorageTransferInfo();
                    entity.Id = rdr.GetInt32(0);
                    entity.PalletSN = rdr.GetString(1);
                    entity.PackSN = rdr.GetString(2);
                    entity.ProductSN = rdr.GetString(3);
                    entity.LocationCode = rdr.GetString(4);
                    entity.ItemName = rdr.GetString(5);
                    list.Add(entity);
                }
            }

            return list;
        }

        #endregion

        #region 送检单

        /// <summary>
        /// 获取送检单信息
        /// </summary>
        /// <param name="inspectionQty"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public string[] GetInspectionSheet(int inspectionQty, string userName)
        {
            string[] inspectionArr = new string[3];
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@InspectionQty",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.VarChar,20),
                  
            };
            parms[0].Value = inspectionQty;
            parms[1].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionSheet", parms))
            {
                if (rdr.Read())
                {
                    inspectionArr[0] = rdr.GetInt32(0).ToString();//送检单ID
                    inspectionArr[1] = rdr.GetString(1);//送检单号
                    inspectionArr[2] = rdr.GetInt32(2).ToString();//送检数量
                }
            }
            return inspectionArr;
        }

        /// <summary>
        /// 编辑送检单信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="inspectionId"></param>
        /// <param name="flag"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public string EditInspectionSheet(string sn, int opeId, int resId, int userId, string userName)
        {
            string inspectionSheet = "";

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@SN",SqlDbType.VarChar),                
                new SqlParameter("@InspectionNO",SqlDbType.VarChar,50),
                new SqlParameter("@OpeId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20) 
            };
            parms[0].Value = sn;
            parms[1].Value = "";
            parms[1].Direction = ParameterDirection.InputOutput;
            parms[2].Value = opeId;
            parms[3].Value = resId;
            parms[4].Value = userId;
            parms[5].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEditInspectionSheet", parms);
            inspectionSheet = parms[1].Value.ToString();//送检单 

            return inspectionSheet;
        }

        /// <summary>
        /// 手动关闭送检单
        /// </summary>
        /// <param name="inspectionId"></param>
        public void CloseInspectionSheet(int inspectionId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] {                 
                new SqlParameter("@InspectionId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20) 
            };
            parms[0].Value = inspectionId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCloseInspectionSheet", parms);

        }
        #endregion

        #region 离线条码绑定

        /// <summary>
        /// 获取离线条码采集配置信息
        /// </summary>
        /// <param name="mainSN"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        public List<OfflineSNConfigInfo> GetOfflineSNConfig(string mainSN, int stationId)
        {
            List<OfflineSNConfigInfo> list = new List<OfflineSNConfigInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512) , 
                new SqlParameter("@StationId",SqlDbType.Int),
            };
            param[0].Value = mainSN;
            param[1].Value = stationId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetOfflineSNConfig", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<OfflineSNConfigInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 检测离线条码是否被组装
        /// </summary>
        /// <returns></returns>
        public bool CheckOfflineSNIsAssy(string offlineSN)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@OfflineSN",SqlDbType.NVarChar,512),
            };
            parms[0].Value = offlineSN;
            int offlineSNDetailId = -1;
            string sql = "select OfflineSNDetailId from Prod_OfflineSNDetail where PartSN=@OfflineSN";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                if (rdr.Read())
                {
                    offlineSNDetailId = rdr.GetInt32(0);
                }
            }

            return offlineSNDetailId > 0 ? true : false;
        }

        /// <summary>
        /// 添加离线条码详情信息
        /// </summary>
        /// <param name="offlineSNConfigId"></param>
        /// <param name="mainSN"></param>
        /// <param name="partItemId"></param>
        /// <param name="partSN"></param>
        /// <param name="stationId"></param>
        /// <param name="user"></param>
        public void OfflineSNDetailEdit(string offlineSNConfigId, string mainSN, string partItemId, string partSN, string assyStationId, string user, int resId, int userId, int stationId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@OfflineSNConfigId",SqlDbType.VarChar),
                  new SqlParameter("@MainSN",SqlDbType.VarChar,50),
                  new SqlParameter("@PartItemId",SqlDbType.VarChar),
                  new SqlParameter("@PartSN",SqlDbType.VarChar),
                  new SqlParameter("@AssyStationId",SqlDbType.VarChar),
                  new SqlParameter("@CreateBy",SqlDbType.VarChar,20),
                  new SqlParameter("@ResId",SqlDbType.Int),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@StationId",SqlDbType.Int),
                  
            };
            parms[0].Value = offlineSNConfigId;
            parms[1].Value = mainSN;
            parms[2].Value = partItemId;
            parms[3].Value = partSN;
            parms[4].Value = assyStationId;
            parms[5].Value = user;
            parms[6].Value = resId;
            parms[7].Value = userId;
            parms[8].Value = stationId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOfflineSNDetailEdit", parms);
        }

        /// <summary>
        /// 添加离线条码详情信息--组装UI使用
        /// </summary>
        /// <param name="offlineSNConfigId"></param>
        /// <param name="mainSN"></param>
        /// <param name="partItemId"></param>
        /// <param name="partSN"></param>
        /// <param name="assyStationId"></param>
        /// <param name="user"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="stationId"></param>
        public void OfflineSNDetailEditAssy(int offlineSNConfigId, string mainSN, int partItemId, string partSN, int assyStationId, string user, int resId, int userId, int stationId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@OfflineSNConfigId",SqlDbType.Int),
                  new SqlParameter("@MainSN",SqlDbType.NVarChar,512),
                  new SqlParameter("@PartItemId",SqlDbType.Int),
                  new SqlParameter("@PartSN",SqlDbType.NVarChar,512),
                  new SqlParameter("@AssyStationId",SqlDbType.Int),
                  new SqlParameter("@CreateBy",SqlDbType.VarChar,20),
                  new SqlParameter("@ResId",SqlDbType.Int),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@StationId",SqlDbType.Int),
                  
            };
            parms[0].Value = offlineSNConfigId;
            parms[1].Value = mainSN;
            parms[2].Value = partItemId;
            parms[3].Value = partSN;
            parms[4].Value = assyStationId;
            parms[5].Value = user;
            parms[6].Value = resId;
            parms[7].Value = userId;
            parms[8].Value = stationId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOfflineSNDetailEditAssy", parms);
        }

        #endregion

        #region QC检测

        /// <summary>
        /// 获取送检单信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <returns></returns>
        public InspectionInfo GetInspectionInfoByLotId(int inspectionLotId)
        {
            List<InspectionInfo> list = new List<InspectionInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@InspectionLotId",SqlDbType.Int),                
            };
            param[0].Value = inspectionLotId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionInfoByLotId", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        /// <summary>
        /// 根据包装条码获取送检单信息,如果不存在则生成批次信息
        /// </summary>
        /// <param name="packSN"></param>
        /// <param name="statinId"></param>
        /// <param name="resId"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public InspectionInfo GetInspectionInfoByPackSN(int inspectionLotId, string packSN, int statinId, int resId, string userName)
        {
            List<InspectionInfo> list = new List<InspectionInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@InspectionLotId",SqlDbType.Int),
                new SqlParameter("@PackSN",SqlDbType.NVarChar,512) , 
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
            };
            param[0].Value = inspectionLotId;
            param[1].Value = packSN;
            param[2].Value = statinId;
            param[3].Value = resId;
            param[4].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionInfoByPackSN", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        /// <summary>
        /// 根据送检批ID获取包装信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <returns></returns>
        public List<PackInfo> GetPackSNByInspectionLotId(int inspectionLotId)
        {
            List<PackInfo> list = new List<PackInfo>();

            SqlParameter[] param = new SqlParameter[]{
                        new SqlParameter("@InspectionLotId",SqlDbType.Int),
                    };
            param[0].Value = inspectionLotId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPackSNByInspectionLotId", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<PackInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取批次、检验项信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<InspectionLotMemberInfo> GetInspectionMemberByLotId(int inspectionLotId, string userName, int checkType, int qcType)
        {
            List<InspectionLotMemberInfo> list = new List<InspectionLotMemberInfo>();

            SqlParameter[] param = new SqlParameter[]{
                        new SqlParameter("@InspectionLotId",SqlDbType.Int),
                         new SqlParameter("@UserName",SqlDbType.NVarChar),
                         new SqlParameter("@CheckType",SqlDbType.Int),
                         new SqlParameter("@QCType",SqlDbType.Int),
                    };
            param[0].Value = inspectionLotId;
            param[1].Value = userName;
            param[2].Value = checkType;
            param[3].Value = qcType;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionMemberByLotId", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionLotMemberInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取扫描的SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<InspectionLotMemberSNInfo> GetInspectionLotSNInfo(int inspectionLotMemberId)
        {
            List<InspectionLotMemberSNInfo> list = new List<InspectionLotMemberSNInfo>();

            SqlParameter[] param = new SqlParameter[]{
                        new SqlParameter("@InspectionLotMemberId",SqlDbType.Int)                       
                    };
            param[0].Value = inspectionLotMemberId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionLotSNInfo", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionLotMemberSNInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 添加扫描的SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        /// <param name="userName"></param>
        public string CollectInspectionLotSNInfo(int inspectionLotId, int inspectionLotMemberId, string sn, string userName, string inspectionSN)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@InspectionLotMemberId",SqlDbType.Int),
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@UserName",SqlDbType.VarChar), 
                  new SqlParameter("@InspectionSN",SqlDbType.NVarChar),    
                  new SqlParameter("@CollectMsg",SqlDbType.NVarChar,200)
                  
            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = inspectionLotMemberId;
            parms[2].Value = sn;
            parms[3].Value = userName;
            parms[4].Value = inspectionSN;
            parms[5].Value = "";
            parms[5].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotSNInfo", parms);

            return parms[5].Value.ToString();
        }

        /// <summary>
        /// 记录产品SN不良信息
        /// </summary>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        /// <param name="ncCode"></param>
        public void CollectInspectionLotNCCodeInfo(int inspectionLotMemberId, string sn, string ncCode, string userName, int userId, int opeId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@InspectionLotMemberId",SqlDbType.Int),
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@NCCode",SqlDbType.VarChar), 
                  new SqlParameter("@UserId",SqlDbType.Int), 
                  new SqlParameter("@UserName",SqlDbType.VarChar), 
                  new SqlParameter("@OpeId",SqlDbType.Int), 
                  new SqlParameter("@ResId",SqlDbType.Int), 
                  
            };
            parms[0].Value = inspectionLotMemberId;
            parms[1].Value = sn;
            parms[2].Value = ncCode;
            parms[3].Value = userId;
            parms[4].Value = userName;
            parms[5].Value = opeId;
            parms[6].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotNCCodeInfo", parms);
        }


        /// <summary>
        /// 检验单PASS操作
        /// </summary>
        /// <param name="inspectionLotId"></param>
        public void CollectInspectionLotPass(int inspectionLotId, int passType, string userName, int userId, int stationId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),   
                  new SqlParameter("@PassType",SqlDbType.Int),   
                  new SqlParameter("@UserId",SqlDbType.Int), 
                  new SqlParameter("@UserName",SqlDbType.NVarChar),    
                  new SqlParameter("@StationId",SqlDbType.Int),    
                  new SqlParameter("@ResId",SqlDbType.Int)
                  
            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = passType;
            parms[2].Value = userId;
            parms[3].Value = userName;
            parms[4].Value = stationId;
            parms[5].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotPassByLot", parms);
        }

        /// <summary>
        /// 检验单Reject操作
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="stationId"></param>
        /// <param name="userName"></param>
        public void CollectInspectionLotReject(int inspectionLotId, int stationId, string userName, int returnStationId, int userId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),   
                  new SqlParameter("@StationId",SqlDbType.Int),   
                  new SqlParameter("@ReturnStationId",SqlDbType.Int),  
                  new SqlParameter("@UserName",SqlDbType.NVarChar),  
                  new SqlParameter("@UserId",SqlDbType.Int),  
                  new SqlParameter("@ResId",SqlDbType.Int),  
                  
            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = stationId;
            parms[2].Value = returnStationId;
            parms[3].Value = userName;
            parms[4].Value = userId;
            parms[5].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotRejectByLot", parms);
        }

        /// <summary>
        /// 获取送检批关联的路由信息
        /// </summary>
        /// <param name="inspectionLotMemberId"></param>
        /// <returns></returns>
        public List<StationInfo> GetInspectionLotRouter(int inspectionLotId)
        {
            List<StationInfo> list = new List<StationInfo>();

            SqlParameter[] param = new SqlParameter[]{
                        new SqlParameter("@InspectionLotId",SqlDbType.Int)                       
                    };
            param[0].Value = inspectionLotId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionLotRouter", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<StationInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 记录SN检验信息 提前录入
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="userName"></param>
        public void CollectInspectionLotRecords(string sn, string userName, int aqlSampleId, string aqlSampleName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@SN",SqlDbType.NVarChar),  
                  new SqlParameter("@AQLSampleId",SqlDbType.Int),  
                  new SqlParameter("@AQLSampleName",SqlDbType.NVarChar),  
                  new SqlParameter("@UserName",SqlDbType.NVarChar),  
                  
            };
            parms[0].Value = sn;
            parms[1].Value = aqlSampleId;
            parms[2].Value = aqlSampleName;
            parms[3].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotRecords", parms);
        }

        /// <summary>
        /// 获取提前录入的扫描SN信息
        /// </summary>
        /// <returns></returns>
        public List<InspectionLotRecordsInfo> GetInspectionLotRecords(int importType, int aqlSampleId, int itemId)
        {
            List<InspectionLotRecordsInfo> list = new List<InspectionLotRecordsInfo>();

            SqlParameter[] parms = new SqlParameter[]{   
                         new SqlParameter("@ImportType",SqlDbType.Int),
                         new SqlParameter("@AqlSampleId",SqlDbType.Int) ,
                         new SqlParameter("@ItemId",SqlDbType.Int) 
                    };
            parms[0].Value = importType;
            parms[1].Value = aqlSampleId;
            parms[2].Value = itemId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionLotRecords", parms))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionLotRecordsInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 记录提前录入产品SN不良信息
        /// </summary>
        /// <param name="inspectionLotRecordsId"></param>
        /// <param name="sn"></param>
        /// <param name="ncCode"></param>
        /// <param name="userName"></param>
        /// <param name="userId"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        public void CollectPreInspectionLotNCCodeInfo(string sn, string ncCode, string userName, int userId, int opeId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] {                  
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@NCCode",SqlDbType.VarChar), 
                  new SqlParameter("@UserId",SqlDbType.Int), 
                  new SqlParameter("@UserName",SqlDbType.VarChar), 
                  new SqlParameter("@OpeId",SqlDbType.Int), 
                  new SqlParameter("@ResId",SqlDbType.Int), 
                  
            };
            parms[0].Value = sn;
            parms[1].Value = ncCode;
            parms[2].Value = userId;
            parms[3].Value = userName;
            parms[4].Value = opeId;
            parms[5].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectPreInspectionLotNCCodeInfo", parms);
        }

        /// <summary>
        /// 切入提前录入的扫描SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="userName"></param>
        public void ImportInspectionLotRecords(int inspectionLotId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),                   
                  new SqlParameter("@UserName",SqlDbType.VarChar),                               
                  
            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspImportInspectionLotRecords", parms);
        }
        #endregion
        
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
