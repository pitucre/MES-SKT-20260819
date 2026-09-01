using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Quartz;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using WebAPI.Dao;
using WebAPI.Models;
using WebAPI.Models.DataPush;
using WebAPI.Models.Enum;
using WebAPI.Models.ERP;
using WebAPI.Models.MES;
using WebAPI.Utility;

namespace WebAPI.Job
{
    [DisallowConcurrentExecution]
    public class SyncJob : BaseJob, IJob
    {

        /// <summary>
        /// 子工厂工厂代码（如果GroupHeadquartersFlag配置为1，则此处可以为空，否则不能为空
        /// </summary>
        protected readonly string SubFactory = ConfigurationManager.AppSettings["SubFactory"] ?? string.Empty;

        //同步信息
        ERPSyncDao erpSyncDao = new ERPSyncDao();

        //遍历需要同步的工厂信息
        FactoryDao factoryDao = new FactoryDao();

        /// <summary>
        /// 定时任务执行
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public async Task Execute(IJobExecutionContext context)
        {
            await Task.Run(() =>
            {
                try
                {
                    var syncList = erpSyncDao.GetERPSyncListByCache();

                    var subFactoryList = factoryDao.GetSyncSubFactoryList();
                    foreach (var factoryInfo in subFactoryList)
                    {
                        try
                        {
                            //同步仓库信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.Warehouse);

                            //同步客户信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.Customer);

                            //同步供应商信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.Supplier);

                            //同步部门信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.Department);

                            //同步用户信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.User);

                            //同步物料分类信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.ItemCategory);

                            //同步物料信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.Item);

                            //同步替代料信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.SubsItem);

                            //同步产品BOM信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.ItemBom);

                            //同步工单信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.Order);

                            //同步采购单信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.PoCode);

                            //同步调拨单信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.Transfer);

                            //同步销售出库单信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.SaleOrder);

                            //同步供应商退料信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.ReturnOrder);

                            //同步领料单信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.Apply);

                            //同步客退单信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.SaleReturn);

                            //同步生产退料单信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.ReturnToWarehouse);

                            //同步送货单信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.Deliver);

                            //同步设备信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.Equipment);

                            //同步工厂信息                  
                            SyncToSubFactory(syncList, factoryInfo, ApiEnum.Factory);
                        }
                        catch (Exception ex)
                        {
                            Logger.Write.Error($"下发数据到子工厂[{factoryInfo.FactoryCode}]失败：{ex.Message}", ex);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Logger.Write.Error($"执行Job信息失败：{ex.Message}", ex);
                }
            });
        }

        /// <summary>
        /// 将数据分发到子工厂
        /// </summary>
        /// <param name="syncList"></param>
        /// <param name="factoryInfo"></param>
        /// <param name="em"></param>
        /// <exception cref="Exception"></exception>
        private static void SyncToSubFactory(IList<ERPSyncInfo> syncList, BasalFactoryInfo factoryInfo, ApiEnum em)
        {
            string syncCode = em.ToString();

            var dataPushConfigInfo = new ERPDataPushConfigInfo { FactoryCode = factoryInfo.FactoryCode, SyncCode = em.ToString() };

            //同步配置信息
            DataPushConfigDao dataPushConfigDao = new DataPushConfigDao();

            //获取此工厂同步配置信息
            var listDataPushConfig = dataPushConfigDao.GetDataPushConfigList(dataPushConfigInfo);
            if (listDataPushConfig == null)
            {
                return;
            }

            //ERP原始JSON
            ERPJsonDao erpJsonDao = new ERPJsonDao();

            HttpClientHelper client = new HttpClientHelper();

            //API中的控制器
            var controller = syncList.FirstOrDefault(p => string.Equals(p.SyncCode, syncCode, StringComparison.CurrentCultureIgnoreCase))?.Api;

            var dataPushConfigItem = listDataPushConfig.FirstOrDefault(p => string.Equals(p.SyncCode, syncCode, StringComparison.CurrentCultureIgnoreCase));
            if (dataPushConfigItem == null)
            {
                throw new Exception($"请先配置ERP_DataPushConfig表{syncCode}信息");
            }
            //获取需要同步的数据
            var listJson = erpJsonDao.GetERPJsonList(new ERPJsonInfo { SyncCode = syncCode, CreateDateTime = dataPushConfigItem.LastSyncTime ?? DateTime.MinValue.AddYears(1900) });

            SyncResult syncResult;
            bool isOK = true;
            foreach (var entity in listJson)
            {
                var url = $"{factoryInfo.Api}/{controller}";
                var returnJson = client.Post(url, entity.ERPJson);
                syncResult = JsonConvert.DeserializeObject<SyncResult>(returnJson);
                if (!syncResult.Result)
                {
                    Logger.Write.Error($"下发数据到子工厂[{factoryInfo.FactoryCode}]失败，同步编码：{syncCode}，URL：{url}，子工厂API返回信息：{returnJson}，集团总部下发JSON：{entity.ERPJson}");
                    isOK = false;
                    continue;
                }
                if (isOK)
                {
                    dataPushConfigInfo.LastSyncTime = entity.CreateDateTime;
                }
            }
            if (isOK && listJson.Count > 0)
            {
                //更新数据下发配置表同步时间字段
                dataPushConfigDao.UpdateDataPushConfigInfo(dataPushConfigInfo);
            }
        }

    }

    /// <summary>
    /// 同步结果
    /// </summary>
    public class SyncResult
    {
        /// <summary>
        /// 结果（true or fasle）
        /// </summary>
        public bool Result { get; set; }

        /// <summary>
        /// 消息
        /// </summary>
        public string Msg { get; set; }
    }

}