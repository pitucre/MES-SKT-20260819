using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebAPI.Models.DataPush;
using WebAPI.Utility;

namespace WebAPI.Dao
{
    public class FactoryDao
    {
        /// <summary>
        /// 获取需要同步的子工厂信息
        /// </summary>
        /// <returns></returns>
        public IList<BasalFactoryInfo> GetSyncSubFactoryList()
        {
            string sql = @"SELECT
                              bf.FactoryID,bf.FactoryName,bf.FactoryCode,bf.CreateBy,bf.CreateDateTime,bf.ModifyBy,bf.ModifyDateTime,bf.Remark,bf.ChkIsDefaultFactory,bf.TypeId,bf.Api
                           FROM dbo.Basal_Factory bf 
                           WHERE ISNULL(bf.Api,'') <> '' ";
            return SqlHelper.GetList<BasalFactoryInfo>(sql, null);
        }

    }
}