using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebAPI.Models.DataPush;
using WebAPI.Utility;

namespace WebAPI.Dao
{
    public class ERPJsonDao
    {

        /// <summary>
        /// 获取ERP原始JSON数据
        /// </summary>
        /// <returns></returns>
        public IList<ERPJsonInfo> GetERPJsonList(ERPJsonInfo entity)
        {
            string sql = @"SELECT
                               ej.SyncCode,ej.ERPJson,ej.FactoryCode,ej.CreateDateTime
                           FROM dbo.ERP_Json ej WITH (NOLOCK)
                           WHERE ej.SyncCode = @SyncCode AND ej.CreateDateTime > @CreateDateTime                            
                           -- AND ej.FactoryCode = @FactoryCode
                           ORDER BY ej.CreateDateTime";
            return SqlHelper.GetList<ERPJsonInfo>(sql, entity);
        }


    }
}