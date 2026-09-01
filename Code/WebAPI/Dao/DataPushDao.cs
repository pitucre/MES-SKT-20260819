using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebAPI.Models.DataPush;
using WebAPI.Utility;

namespace WebAPI.Dao
{
    public class DataPushDao
    {
        /// <summary>
        /// 新增ERP Json信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public int AddERPJson(ERPJsonInfo entity)
        {
            string sql = @"INSERT INTO dbo.ERP_Json (SyncCode,ERPJson,FactoryCode,Remark,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime)
                           VALUES (@SyncCode,@ERPJson,@FactoryCode,@Remark,@CreateBy,GETDATE(),@ModifyBy,GETDATE())";
            return SqlHelper.Execute(sql, entity);
        }

    }
}