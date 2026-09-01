using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebAPI.Models.DataPush;
using WebAPI.Utility;

namespace WebAPI.Dao
{
    public class DataPushConfigDao
    {

        /// <summary>
        /// 获取需要同步配置信息
        /// </summary>
        /// <returns></returns>
        public IList<ERPDataPushConfigInfo> GetDataPushConfigList(ERPDataPushConfigInfo entity)
        {
            string sql = @"SELECT
                              ec.DataPushConfigId,ec.SyncCode,ec.FactoryCode,ec.LastSyncTime,ec.Remark,ec.CreateBy,ec.CreateDateTime,ec.ModifyBy,ec.ModifyDateTime
                           FROM dbo.ERP_DataPushConfig ec 
                           WHERE ec.FactoryCode = @FactoryCode";
            return SqlHelper.GetList<ERPDataPushConfigInfo>(sql, entity);
        }

        /// <summary>
        /// 更新数据下发配置信息
        /// </summary>
        /// <param name="entity"></param>
        public int UpdateDataPushConfigInfo(ERPDataPushConfigInfo entity)
        {
            var sql = @"UPDATE ed SET 
	                        ed.LastSyncTime = @LastSyncTime,ed.ModifyDateTime = GETDATE()
                        FROM dbo.ERP_DataPushConfig ed
                        WHERE ed.SyncCode = @SyncCode AND ed.FactoryCode = @FactoryCode";
            return SqlHelper.Execute(sql, entity);
        }
    }
}