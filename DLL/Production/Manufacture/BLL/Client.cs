using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Manufacture.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Manufacture.BLL
{
    public class Client
    {
        /// <summary>
        /// Client端共用验证处理
        /// </summary>
        /// <param name="entity">参数实体</param>
        /// <returns>返回给Client端的错误信息</returns>
        public String ExecValidattion(ClientInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Type", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ResourceId", SqlDbType.Int),
                new SqlParameter("@InputValue", SqlDbType.NVarChar,200),            
                new SqlParameter("@TagValue", SqlDbType.NVarChar,200),   
                new SqlParameter("@ErrorMsg", SqlDbType.NVarChar, 500)  
            };

            parms[0].Value = entity.Type;
            parms[1].Value = entity.StationId;
            parms[2].Value = entity.ResourceId;
            parms[3].Value = entity.InputValue;
            parms[4].Value = entity.TagValue;
            parms[5].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ClientValidattion", parms);

            return parms[5].Value.ToString();
        }        
    }
}
