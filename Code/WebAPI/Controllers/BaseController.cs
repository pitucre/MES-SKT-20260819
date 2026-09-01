using Newtonsoft.Json;
using SKT.LeanMES.SDK;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Web.Http;
using System.Web.Http.Results;
using WebAPI.Code;
using WebAPI.Dao;
using WebAPI.Models;
using WebAPI.Models.Enum;
using WebAPI.Models.ERP;
using WebAPI.Models.MES;
using WebAPI.Utility;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace WebAPI.Controllers
{
    public class BaseController : ApiController
    {

        List<string> listBillNo;

        BaseDao dao = new BaseDao();

        ERPSyncDao erpSyncDao = new ERPSyncDao();

        DataPushDao dataPushDao = new DataPushDao();


        #region 通用数据同步（缓存方式读取中间表配置）

        /// <summary>
        /// 同步ERP数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="entity"></param>
        /// <param name="em"></param>
        /// <returns></returns>
        protected string SyncERPData<T>(BasalSyncInfo<T> entity, ApiEnum em) where T : class
        {
            System.Diagnostics.Stopwatch sw = new System.Diagnostics.Stopwatch();
            sw.Start();

            //int affectedCount;//插入到MES中间库的行数
            try
            {
                #region 获取请求的原始JSON

                string requestString = string.Empty;
                string url = Request.RequestUri.AbsoluteUri;
                using (var stream = Request.Content.ReadAsStreamAsync().Result)
                {
                    if (stream.CanSeek)
                    {
                        stream.Position = 0;
                    }
                    requestString = Request.Content.ReadAsStringAsync().Result;
                }
                Logger.Write.Info($"捕获请求信息，URL：{url}，传入字符串：{requestString}");

                #endregion

                Logger.Write.Info($"开始同步{em}信息，JSON：{JsonConvert.SerializeObject(entity)}");

                //affectedCount = 0;//插入到MES中间库的行数

                //将ERP数据插入到MES中间库
                if (entity == null || entity.List == null || entity.List.Count() == 0)
                {
                    throw new Exception($"同步{em}信息失败，JSON序列化失败，请检查数据格式");
                }

                //获取中间表配置
                //ERPSyncInfo syncEntity = erpSyncDao.GetERPSyncInfo(em);
                //affectedCount = dao.BulkInsert(entity.List, syncEntity.MiddleTableName);
                //BulkInsertInfo bulkInsertInfo = dao.BulkInsert(entity.List, syncEntity.MiddleTableName);
                BulkInsertInfo bulkInsertInfo = dao.BulkInsert(entity.List, em);
                if (bulkInsertInfo.AffectedCount > 0)
                {
                    //部分资料需同步明细信息
                    SyncDetailInfo(entity, em);

                    //判断是否立即同步
                    SyncNow(entity, em, bulkInsertInfo.ListBillNo);
                }

                sw.Stop();
                Logger.Write.Info($"同步{em}成功，同步{bulkInsertInfo.AffectedCount}条数据，耗时{sw.Elapsed.Seconds}秒");

                //将原始JSON数据插入到ERP_Json表中
                dataPushDao.AddERPJson(new Models.DataPush.ERPJsonInfo { SyncCode = em.ToString(), ERPJson = requestString });

                return string.Empty;
            }
            catch (Exception ex)
            {
                sw.Stop();
                Logger.Write.Error($"同步{em}失败：{ex.Message}，耗时{sw.Elapsed.Seconds}秒", ex);

                var erpSyncInfo = new ERPSyncInfo
                {
                    SyncCode = em.ToString(),
                    LastSyncTime = DateTime.Now,
                    SyncByBillNo = entity.SyncNowFlag == 1,
                    LastSyncResult = 0,
                    LastSyncMsg = $"同步{em}失败：{ex.Message}"
                };

                erpSyncDao.UpdateERPSyncInfo(erpSyncInfo);
                //throw ex;
                return ex.Message;
            }
        }

        /// <summary>
        /// 同步单据明细信息
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="entity"></param>
        /// <param name="em"></param>
        private void SyncDetailInfo<T>(BasalSyncInfo<T> entity, ApiEnum em) where T : class
        {
            if (em == ApiEnum.ItemBom)
            {
                #region 产品BOM信息

                var list = entity.List as List<ERPBasalItemBomInfo>;
                //添加明细信息
                var listDetail = new List<ERPBasalItemBomChildInfo>();
                list.ForEach(p => listDetail.AddRange(p.Details));

                dao.BulkInsert(listDetail, ApiEnum.ItemBomChild);

                #endregion
            }
            else if (em == ApiEnum.Order)
            {
                #region 工单BOM信息

                var list = entity.List as List<ERPProdOrderInfo>;
                //添加明细信息
                var listDetail = new List<ERPProdOrderBomInfo>();
               
                list.ForEach(p => listDetail.AddRange(p.Details));
                if (listDetail.Count > 0)
                {
                    dao.BulkInsert(listDetail, ApiEnum.OrderBom);
                }
                

                #endregion
            }
            else if (em == ApiEnum.PoCode)
            {
                #region 采购单信息

                var list = entity.List as List<ERPERPPurOrderInfo>;
                //添加明细信息
                var listDetail = new List<ERPERPPurOrderDtlInfo>();
                list.ForEach(p => listDetail.AddRange(p.Details));

                dao.BulkInsert(listDetail, ApiEnum.PoCodeDetail);

                #endregion
            }
            else if (em == ApiEnum.Deliver)
            {
                #region 送货单信息

                var list = entity.List as List<ERPProdDeliverInfo>;
                //添加明细信息
                var listDetail = new List<ERPProdDeliverDtlInfo>();
                list.ForEach(p => listDetail.AddRange(p.Details));

                dao.BulkInsert(listDetail, ApiEnum.DeliverDetail);

                #endregion
            }
            else if (em == ApiEnum.Apply)
            {
                #region 领料单信息

                var list = entity.List as List<ERPProdApplyInfo>;
                //添加明细信息
                var listDetail = new List<ERPProdApplyDtlInfo>();
                list.ForEach(p => listDetail.AddRange(p.Details));

                dao.BulkInsert(listDetail, ApiEnum.ApplyDetail);

                #endregion
            }
            else if (em == ApiEnum.Transfer)
            {
                #region 调拨单信息

                var list = entity.List as List<ERPProdTransfersInfo>;
                //添加明细信息
                var listDetail = new List<ERPProdTransfersDtlInfo>();
                list.ForEach(p => listDetail.AddRange(p.Details));

                dao.BulkInsert(listDetail, ApiEnum.TransferDetail);

                #endregion
            }
            else if (em == ApiEnum.SaleOrder)
            {
                #region 销售出库单信息

                var list = entity.List as List<ERPProdSalOrderInfo>;
                //添加明细信息
                var listDetail = new List<ERPProdSalOrderDtlInfo>();
                list.ForEach(p => listDetail.AddRange(p.Details));

                dao.BulkInsert(listDetail, ApiEnum.SaleOrderDetail);

                #endregion
            }
            else if (em == ApiEnum.ReturnOrder)
            {
                #region 仓库退供应商单信息

                var list = entity.List as List<ERPProdReturnToVendorInfo>;
                //添加明细信息
                var listDetail = new List<ERPProdReturnToVendorDtlInfo>();
                list.ForEach(p => listDetail.AddRange(p.Details));

                dao.BulkInsert(listDetail, ApiEnum.ReturnOrderDetail);

                #endregion
            }
            else if (em == ApiEnum.SaleReturn)
            {
                #region 销售退货单信息

                var list = entity.List as List<ERPProdSaleReturnInfo>;
                //添加明细信息
                var listDetail = new List<ERPProdSaleReturnDtlInfo>();
                list.ForEach(p => listDetail.AddRange(p.Details));

                dao.BulkInsert(listDetail, ApiEnum.SaleReturnDetail);

                #endregion
            }
            else if (em == ApiEnum.Scrap)
            {
                #region 报废单信息

                var list = entity.List as List<ERPProdScrapInfo>;
                //添加明细信息
                var listDetail = new List<ERPProdScrapDtlInfo>();
                list.ForEach(p => listDetail.AddRange(p.Details));

                dao.BulkInsert(listDetail, ApiEnum.ScrapDetail);

                #endregion
            }
            else if (em == ApiEnum.FormChange)
            {
                #region 形态转换单信息

                var list = entity.List as List<ERPProdFormChangeInfo>;
                //添加明细信息
                var listDetail = new List<ERPProdFormChangeDtlInfo>();
                list.ForEach(p => listDetail.AddRange(p.Details));

                dao.BulkInsert(listDetail, ApiEnum.FormChangeDtl);
                //添加明细信息（转换后）
                var listDetailed = new List<ERPProdFormChangeDtledInfo>();
                //listDetail.ForEach(p => listDetailed.AddRange(p.Details));

                //dao.BulkInsert(listDetailed, ApiEnum.FormChangeDtled);

                listDetail.ForEach(p =>
                {
                    if (p.Details != null && p.Details.Count > 0)
                    {
                        listDetailed.AddRange(p.Details);
                    }
                });

                if (listDetailed.Count > 0) dao.BulkInsert(listDetailed, ApiEnum.FormChangeDtled);
                #endregion
            }
        }

        /// <summary>
        /// 是否立即同步
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="entity"></param>
        /// <param name="em"></param>
        /// <param name="listBillNo">需要同步的单号</param>
        private void SyncNow<T>(BasalSyncInfo<T> entity, ApiEnum em, List<string> listBillNo) where T : class
        {
            if (entity.SyncNowFlag == 1)
            {
                string billNo = string.Empty;

                var erpSyncInfo = new ERPSyncInfo
                {
                    SyncCode = em.ToString(),
                    LastSyncTime = DateTime.Now,
                    SyncByBillNo = true
                };

                try
                {
                    var procName = erpSyncDao.GetERPSyncInfo(em).SyncProcedure;

                    //获取需要同步的单据号                    
                    if (listBillNo != null)
                    {
                        billNo = string.Join(",", listBillNo);
                    }

                    string sql = $"EXEC {procName} ";

                    //按单据号同步
                    if (!string.IsNullOrEmpty(billNo))
                    {
                        sql += string.IsNullOrEmpty(billNo) ? string.Empty : $" '{billNo}' ";
                    }
                    SqlHelper.Execute(sql);

                    erpSyncInfo.LastSyncResult = 1;
                    erpSyncInfo.LastSyncMsg = $"同步{em}成功，单号[{billNo}]";
                    erpSyncDao.UpdateERPSyncInfo(erpSyncInfo);
                }
                catch (Exception ex)
                {
                    //erpSyncInfo.LastSyncResult = 0;
                    //erpSyncInfo.LastSyncMsg = $"同步{em}失败，单号[{billNo}]，错误消息：{ex.Message}";
                    string msg = $"立即同步{em}失败：{ex.Message}";
                    //Logger.Write.Error(erpSyncInfo.LastSyncMsg, ex);
                    //throw new Exception(erpSyncInfo.LastSyncMsg, ex);

                    Logger.Write.Error(msg, ex);
                    throw new Exception(msg);
                }
                //finally
                //{
                //    erpSyncDao.UpdateERPSyncInfo(erpSyncInfo);
                //}
            }
        }

        #endregion



        #region 通用数据同步（非缓存方式读取中间表配置）

        ///// <summary>
        ///// 同步ERP数据
        ///// </summary>
        ///// <typeparam name="T"></typeparam>
        ///// <param name="entity"></param>
        ///// <param name="em"></param>
        ///// <returns></returns>
        //protected string SyncERPData<T>(BasalSyncInfo<T> entity, ApiEnum em) where T : class
        //{
        //    System.Diagnostics.Stopwatch sw = new System.Diagnostics.Stopwatch();
        //    sw.Start();

        //    int affectedCount;//插入到MES中间库的行数
        //    try
        //    {
        //        Logger.Write.Info($"开始同步{em}信息，JSON：{JsonConvert.SerializeObject(entity)}");

        //        affectedCount = 0;//插入到MES中间库的行数

        //        //将ERP数据插入到MES中间库
        //        if (entity.List.Count() == 0)
        //        {
        //            throw new Exception($"同步{em}信息失败，JSON序列化失败，请检查数据格式");
        //        }

        //        var tableName = string.Empty;
        //        switch (em)
        //        {
        //            case ApiEnum.Warehouse:
        //                tableName = "ERP_Basal_Warehouse";
        //                break;
        //            case ApiEnum.WarehouseLocation:
        //                tableName = "ERP_Basal_WarehouseLocation";
        //                break;
        //            case ApiEnum.Customer:
        //                tableName = "ERP_Basal_Customer";
        //                break;
        //            case ApiEnum.Supplier:
        //                tableName = "ERP_Basal_Supplier";
        //                break;
        //            case ApiEnum.Department:
        //                tableName = "ERP_SYS_Organization";
        //                break;
        //            case ApiEnum.User:
        //                tableName = "ERP_SYS_Membership";
        //                break;
        //            case ApiEnum.Item:
        //                tableName = "ERP_Basal_Item";
        //                break;
        //            case ApiEnum.ItemBom:
        //                tableName = "ERP_Basal_ItemBom";
        //                break;
        //            case ApiEnum.ItemBomChild:
        //                tableName = "ERP_Basal_ItemBomChild";
        //                break;
        //            case ApiEnum.SubsItem:
        //                break;
        //            case ApiEnum.Order:
        //                tableName = "ERP_Prod_Order";
        //                break;
        //            case ApiEnum.OrderBom:
        //                tableName = "ERP_Prod_OrderBom";
        //                break;
        //            case ApiEnum.PoCode:
        //                tableName = "ERP_ERP_PurOrder";
        //                break;
        //            case ApiEnum.PoCodeDetail:
        //                tableName = "ERP_ERP_PurOrderDtl";
        //                break;
        //            case ApiEnum.Transfer:
        //                tableName = "ERP_Prod_Transfers";
        //                break;
        //            case ApiEnum.TransferDetail:
        //                tableName = "ERP_Prod_TransfersDtl";
        //                break;
        //            case ApiEnum.SaleOrder:
        //                tableName = "ERP_Prod_SalOrder";
        //                break;
        //            case ApiEnum.SaleOrderDetail:
        //                tableName = "ERP_Prod_SalOrderDtl";
        //                break;
        //            case ApiEnum.ReturnOrder:
        //                tableName = "ERP_Prod_ReturnToVendor";
        //                break;
        //            case ApiEnum.ReturnOrderDetail:
        //                tableName = "ERP_Prod_ReturnToVendorDtl";
        //                break;
        //            case ApiEnum.Apply:
        //                tableName = "ERP_Prod_Apply";
        //                break;
        //            case ApiEnum.ApplyDetail:
        //                tableName = "ERP_Prod_ApplyDtl";
        //                break;
        //            default:
        //                break;
        //        }

        //        affectedCount = dao.BulkInsert(entity.List, tableName);

        //        //部分资料需同步明细信息
        //        if (em == ApiEnum.ItemBom)
        //        {
        //            #region 产品BOM信息

        //            var list = entity.List as List<ERPBasalItemBomInfo>;
        //            //添加明细信息
        //            var listDetail = new List<ERPBasalItemBomChildInfo>();
        //            list.ForEach(p => listDetail.AddRange(p.Details));

        //            dao.BulkInsert(listDetail, "ERP_Basal_ItemBomChild");

        //            #endregion
        //        }
        //        else if (em == ApiEnum.PoCode)
        //        {
        //            #region 采购单信息

        //            var list = entity.List as List<ERPERPPurOrderInfo>;
        //            //添加明细信息
        //            var listDetail = new List<ERPERPPurOrderDtlInfo>();
        //            list.ForEach(p => listDetail.AddRange(p.Details));

        //            dao.BulkInsert(listDetail, "ERP_ERP_PurOrderDtl");

        //            #endregion
        //        }
        //        else if (em == ApiEnum.Apply)
        //        {
        //            #region 领料单信息

        //            var list = entity.List as List<ERPProdApplyInfo>;
        //            //添加明细信息
        //            var listDetail = new List<ERPProdApplyDtlInfo>();
        //            list.ForEach(p => listDetail.AddRange(p.Details));

        //            dao.BulkInsert(listDetail, "ERP_Prod_ApplyDtl");

        //            #endregion
        //        }
        //        else if (em == ApiEnum.Transfer)
        //        {
        //            #region 调拨单信息

        //            var list = entity.List as List<ERPProdTransfersInfo>;
        //            //添加明细信息
        //            var listDetail = new List<ERPProdTransfersDtlInfo>();
        //            list.ForEach(p => listDetail.AddRange(p.Details));

        //            dao.BulkInsert(listDetail, "ERP_Prod_TransfersDtl");

        //            #endregion
        //        }
        //        else if (em == ApiEnum.SaleOrder)
        //        {
        //            #region 销售出库单信息

        //            var list = entity.List as List<ERPProdSalOrderInfo>;
        //            //添加明细信息
        //            var listDetail = new List<ERPProdSalOrderDtlInfo>();
        //            list.ForEach(p => listDetail.AddRange(p.Details));

        //            dao.BulkInsert(listDetail, "ERP_Prod_SalOrderDtl");

        //            #endregion
        //        }
        //        else if (em == ApiEnum.ReturnOrder)
        //        {
        //            #region 仓库退供应商单信息

        //            var list = entity.List as List<ERPProdReturnToVendorInfo>;
        //            //添加明细信息
        //            var listDetail = new List<ERPProdReturnToVendorDtlInfo>();
        //            list.ForEach(p => listDetail.AddRange(p.Details));

        //            dao.BulkInsert(listDetail, "ERP_Prod_ReturnToVendorDtl");

        //            #endregion
        //        }
        //        sw.Stop();
        //        Logger.Write.Info($"同步{em}成功，同步{affectedCount}条数据，耗时{sw.Elapsed.Seconds}秒");

        //        //判断是否立即同步
        //        SyncNow(entity, em);

        //        return string.Empty;
        //    }
        //    catch (Exception ex)
        //    {
        //        sw.Stop();
        //        Logger.Write.Error($"同步{em}失败:{ex.Message}，耗时{sw.Elapsed.Seconds}秒", ex);
        //        throw ex;
        //    }
        //}

        ///// <summary>
        ///// 是否立即同步
        ///// </summary>
        //private void SyncNow<T>(BasalSyncInfo<T> entity, ApiEnum em) where T : class
        //{
        //    if (entity.SyncNowFlag == 1)
        //    {
        //        string procName = "";
        //        switch (em)
        //        {
        //            case ApiEnum.Warehouse:
        //                procName = "ERP_SyncWarehouseByTableOrView";
        //                break;
        //            case ApiEnum.WarehouseLocation:
        //                procName = "ERP_SyncWarehouseLocationByTableOrView";
        //                break;
        //            case ApiEnum.Customer:
        //                procName = "ERP_SyncCustomerByTableOrView";
        //                break;
        //            case ApiEnum.Supplier:
        //                procName = "ERP_SyncSupplierByTableOrView";
        //                break;
        //            case ApiEnum.Department:
        //                procName = "ERP_SyncDepartmentByTableOrView";
        //                break;
        //            case ApiEnum.User:
        //                procName = "ERP_SyncUserByTableOrView";
        //                break;
        //            case ApiEnum.Item:
        //                procName = "ERP_SyncItemByTableOrView";
        //                break;
        //            case ApiEnum.ItemBom:
        //                procName = "ERP_SyncItemBomByTableOrView";
        //                break;
        //            case ApiEnum.ItemBomChild:
        //                procName = "ERP_SyncItemBomChildByTableOrView";
        //                break;
        //            case ApiEnum.SubsItem:
        //                break;
        //            case ApiEnum.Order:
        //                procName = "ERP_SyncOrderByTableOrView";
        //                break;
        //            case ApiEnum.OrderBom:
        //                procName = "ERP_SyncOrderBomByTableOrView";
        //                break;
        //            case ApiEnum.PoCode:
        //                procName = "ERP_SyncPoCodeByTableOrView";
        //                break;
        //            case ApiEnum.PoCodeDetail:
        //                procName = "ERP_SyncPoCodeDetailByTableOrView";
        //                break;
        //            case ApiEnum.Transfer:
        //                procName = "ERP_SyncTransferByTableOrView";
        //                break;
        //            case ApiEnum.TransferDetail:
        //                procName = "ERP_SyncTransferDetailByTableOrView";
        //                break;
        //            case ApiEnum.SaleOrder:
        //                procName = "ERP_SyncSaleOrderByTableOrView";
        //                break;
        //            case ApiEnum.SaleOrderDetail:
        //                procName = "ERP_SyncSaleOrderDetailByTableOrView";
        //                break;
        //            case ApiEnum.ReturnOrder:
        //                procName = "ERP_SyncReturnOrderByTableOrView";
        //                break;
        //            case ApiEnum.ReturnOrderDetail:
        //                procName = "ERP_SyncReturnOrderDetailByTableOrView";
        //                break;
        //            case ApiEnum.Apply:
        //                procName = "ERP_SyncApplyByTableOrView";
        //                break;
        //            case ApiEnum.ApplyDetail:
        //                procName = "ERP_SyncApplyDetailByTableOrView";
        //                break;
        //            default:
        //                break;
        //        }
        //        try
        //        {
        //            string sql = $"EXEC {procName}";
        //            SqlHelper.Execute(sql);
        //        }
        //        catch (Exception ex)
        //        {
        //            Logger.Write.Error($"立即同步{em}失败:{ex.Message}", ex);
        //        }
        //    }
        //} 

        #endregion


    }

 
}
