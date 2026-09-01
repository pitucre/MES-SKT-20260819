/*-------------------------------------------------
// Copyright(C)2016 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:ExecActivity.cs
// 文件功能描述：执行Activity动作。
// 
// 创建标识：Larry.Lin 2016/08/08
// 
// 
//--------------------------------------------------*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.ProductionCollection.Validation;

namespace SKT.LeanMES.ProductionCollection.Activity
{
    public class ExecActivity
    {

        /// <summary>
        /// 执行Activity，默认“uspExecActivity”
        /// </summary>
        /// <param name="prodCollectionInfo"></param>
        /// <returns></returns>
        public static int Start(ProductionCollectionInfo prodCollectionInfo)
        {
            return Start(prodCollectionInfo, "uspExecActivity");
        }

        /// <summary>
        /// 执行Activity入口
        /// </summary>
        /// <param name="prodCollectionInfo"></param>
        /// <param name="uspActivityName"></param>
        /// <returns></returns>
        public static int Start(ProductionCollectionInfo prodCollectionInfo, string uspActivityName)
        {
            //执行Activity动作
            int blResult = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@RelationNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@StatusId",SqlDbType.TinyInt),//RouterDetail->StatusId
                new SqlParameter("@Result",SqlDbType.Int)
            };
            parms[0].Value = prodCollectionInfo.SerialNumber;
            parms[1].Value = prodCollectionInfo.UserId;
            parms[2].Value = prodCollectionInfo.StationId;
            parms[3].Value = prodCollectionInfo.ResourceId;
            parms[4].Value = prodCollectionInfo.RelationNumber;
            parms[5].Value = prodCollectionInfo.StatusId;
            parms[6].Value = blResult;
            parms[6].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, uspActivityName, parms);
            //return blResult;
            return (int)parms[6].Value;   //2016.09.09 Beck Ye修改返回值.

        }
        /// <summary>
        /// 执行误判去除入口
        /// </summary>
        /// <param name="prodCollectionInfo"></param>
        /// <param name="uspActivityName"></param>
        /// <returns></returns>
        public static int OutMiscalculation(string SN, int OutType, int stationId, int UserId)
        {
            //执行误判去除动作
            int blResult = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@OutType",SqlDbType.Int),
                new SqlParameter("@stationId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@Result",SqlDbType.Int)
            };
            parms[0].Value = SN;
            parms[1].Value = OutType;
            parms[2].Value = stationId;
            parms[3].Value = UserId;
            parms[4].Value = blResult;
            parms[4].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOutMiscalculation", parms);
            return (int)parms[4].Value;  

        }
    }
}
