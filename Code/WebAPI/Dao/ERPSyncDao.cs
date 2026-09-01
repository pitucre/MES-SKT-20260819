using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebAPI.Models.Enum;
using WebAPI.Models.MES;
using WebAPI.Utility;

namespace WebAPI.Dao
{
    /// <summary>
    /// 针对ERP_Sync表的操作
    /// </summary>
    public class ERPSyncDao
    {
        /// <summary>
        /// 同步配置表缓存名称
        /// </summary>
        public static string CacheKey = "ERPSyncInfo";

        /// <summary>
        /// 获取ERP同步信息
        /// </summary>
        /// <returns></returns>
        public IList<ERPSyncInfo> GetERPSyncList()
        {
            string sql = @"SELECT
                              es.SyncId,es.SyncCode,es.SyncName,es.IsFullSync,es.InitCompleteFlag,es.IncrementalValue,es.LastSyncResult,es.LastSyncMsg,es.LastSyncTime,es.Remark,es.EnableFlag,es.CreateBy,es.CreateDateTime,es.ModifyBy,es.ModifyDateTime,es.Api,es.MiddleTableName,es.SyncProcedure,ISNULL(SyncByFactroyCodeFlag,0) SyncByFactroyCodeFlag
                           FROM dbo.ERP_Sync es";

            return SqlHelper.GetList<ERPSyncInfo>(sql, null);
        }

        /// <summary>
        /// 获取ERP同步信息
        /// </summary>
        /// <param name="en"></param>
        /// <returns></returns>
        public ERPSyncInfo GetERPSyncInfo(ApiEnum en)
        {
            string sql = @"SELECT
                              es.SyncId,es.SyncCode,es.SyncName,es.IsFullSync,es.InitCompleteFlag,es.IncrementalValue,es.LastSyncResult,es.LastSyncMsg,es.LastSyncTime,es.Remark,es.EnableFlag,es.CreateBy,es.CreateDateTime,es.ModifyBy,es.ModifyDateTime,es.Api,es.MiddleTableName,es.SyncProcedure
                              ,GETDATE() CurrentDBTime,ISNULL(SyncByFactroyCodeFlag,0) SyncByFactroyCodeFlag
                           FROM dbo.ERP_Sync es WITH (NOLOCK)
                           WHERE es.SyncCode = @SyncCode";

            return SqlHelper.Get<ERPSyncInfo>(sql, new { SyncCode = en.ToString() });
        }

        /// <summary>
        /// 更新ERP_Sync信息
        /// </summary>
        /// <param name="entity"></param>
        public void UpdateERPSyncInfo(ERPSyncInfo entity)
        {
            //var sql = @"UPDATE er SET 
            //    er.LastSyncResult = @LastSyncResult,er.LastSyncMsg = @LastSyncMsg,er.LastSyncTime = CASE WHEN @SyncByBillNo = 0 THEN @LastSyncTime ELSE er.LastSyncTime END,
            //    er.InitCompleteFlag = CASE WHEN @SyncByBillNo = 0 AND er.InitCompleteFlag = 0 AND @BreakFlag = 1 THEN 1 ELSE er.InitCompleteFlag END,
            //    er.ModifyBy = @ModifyBy,er.ModifyDateTime = GETDATE() 
            //   FROM dbo.ERP_Sync er WHERE er.SyncCode = @SyncCode";

            //var sql = @"UPDATE er SET 
            //    er.LastSyncResult = @LastSyncResult,er.LastSyncMsg = @LastSyncMsg,er.LastSyncTime = CASE WHEN @SyncByBillNo = 0 THEN @LastSyncTime ELSE er.LastSyncTime END,
            //    er.InitCompleteFlag = CASE WHEN @SyncByBillNo = 0 AND er.InitCompleteFlag = 0 THEN @InitCompleteFlag ELSE er.InitCompleteFlag END,
            //    er.ModifyBy = @ModifyBy,er.ModifyDateTime = GETDATE() 
            //   FROM dbo.ERP_Sync er 
            //            WHERE er.SyncCode = @SyncCode";
            var sql = @"UPDATE er SET 
				            er.LastSyncResult = @LastSyncResult,er.LastSyncMsg = @LastSyncMsg,er.LastSyncTime = @LastSyncTime,
				            er.InitCompleteFlag = CASE WHEN @SyncByBillNo = 0 AND er.InitCompleteFlag = 0 THEN @InitCompleteFlag ELSE er.InitCompleteFlag END,
				            er.ModifyBy = @ModifyBy,er.ModifyDateTime = GETDATE() 
			            FROM dbo.ERP_Sync er 
                        WHERE er.SyncCode = @SyncCode";
            SqlHelper.Execute(sql, entity);
        }


        /// <summary>
        /// 获取同步配置
        /// </summary>
        /// <param name="em"></param>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        public IList<ERPSyncInfo> GetERPSyncListByCache()
        {
            //获取缓存
            var list = WebAPI.Utility.CacheHelper.GetCache(CacheKey) as IList<ERPSyncInfo>;
            if (list == null)
            {
                list = new ERPSyncDao().GetERPSyncList();
                if (list == null || list.Count <= 0)
                {
                    throw new Exception("未获取到同步配置信息");
                }
                //写入缓存
                WebAPI.Utility.CacheHelper.SetCache(CacheKey, list, 60);
            }
            return list;
        }

        /// <summary>
        /// 获取同步配置
        /// </summary>
        /// <param name="em"></param>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        private ERPSyncInfo GetERPSyncInfoByCache(ApiEnum em)
        {
            //获取缓存
            var list = GetERPSyncListByCache();

            //获取同步配置
            var entity = list?.FirstOrDefault(p => string.Equals(p.SyncCode, em.ToString(), StringComparison.CurrentCultureIgnoreCase));
            if (entity == null)
            {
                throw new Exception($"未获取到{em}同步配置信息");
            }
            if (string.IsNullOrWhiteSpace(entity.MiddleTableName) || string.IsNullOrWhiteSpace(entity.SyncProcedure))
            {
                throw new Exception($"{em}同步配置信息中未维护MiddleTableName或SyncProcedure字段值");
            }
            return entity;
        }

        /// <summary>
        /// 获取同步编码对应的中间表表名
        /// </summary>
        /// <param name="em"></param>
        /// <returns></returns>
        public string GetERPSyncTableName(ApiEnum em)
        {
            var entity = GetERPSyncInfo(em);
            return entity.MiddleTableName;
        }
    }
}