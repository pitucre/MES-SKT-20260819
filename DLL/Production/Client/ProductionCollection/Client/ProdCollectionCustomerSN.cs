using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.ProductionCollection.Client
{
    public class ProdCollectionCustomerSN
    {
        /// <summary>
        /// 检查客户条码关联工序扫描的产品序列号
        //确定客户条码关联的处理模式
        ///1、在线打印客户条码：有在路由中的工序设置需要打印客户条码。
        ///2、离线打印客户条码:系统后台管理模块先打印出客户条码 ,再在采集UI中扫描
        ///3、外购客户条码：供应商打好的客户条码，在工单或产品中维护掩码组进行客户条码验证
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public string[] CheckJoinCustomerSN(string sn, int stationId, int resourceId, int userId)
        {
            string[] customerArr = new string[3];
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@StationId",System.Data.SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@JoinType",SqlDbType.Int),
                new SqlParameter("@RegExpress",SqlDbType.VarChar,1000),
                new SqlParameter("@CustomerSN",SqlDbType.NVarChar,512),
            };
            parms[0].Value = sn;
            parms[1].Value = stationId;
            parms[2].Value = resourceId;
            parms[3].Value = userId;
            parms[4].Value = 0;
            parms[4].Direction = ParameterDirection.InputOutput;
            parms[5].Value = "";
            parms[5].Direction = ParameterDirection.InputOutput;
            parms[6].Value = "";
            parms[6].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetCustomerSNJoinInfo", parms);

            customerArr[0] = Convert.ToString(parms[4].Value);
            customerArr[1] = Convert.ToString(parms[5].Value);
            customerArr[2] = Convert.ToString(parms[6].Value);
            return customerArr;
        }

        /// <summary>
        /// 序列号和客户序列号绑定前的检查
        /// </summary>
        /// <param name="SN">序列号</param>
        /// <param name="CSN">客户序列号</param>
        /// <param name="messageType">返回消息类型</param>
        /// <param name="message">返回的消息</param>
        public void CheckSNAndCSNJoin(string SN, string CSN, ref string messageType, ref string message)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@CSN",SqlDbType.NVarChar,512),
                new SqlParameter("@MessageType",SqlDbType.VarChar,10),
                new SqlParameter("@Message",SqlDbType.VarChar,100)
            };

            parms[0].Value = SN;
            parms[1].Value = CSN;
            parms[2].Value = messageType;
            parms[2].Direction = ParameterDirection.InputOutput;
            parms[3].Value = message;
            parms[3].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_SerialNumber_CheckSNAndCSN", parms);
            messageType = (string)parms[2].Value;
            message = (string)parms[3].Value;
        }

        /// <summary>
        /// 序列号和客户序列号绑定
        /// </summary>
        /// <param name="SN">序列号</param>
        /// <param name="CSN">客户序列号</param>
        /// <returns></returns>
        public bool SNAndCSNJoin(string SN, string CSN, int opeId, int resId, int userId, string assyDataChangeRecords,int joinType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@CSN",SqlDbType.NVarChar,512),
                new SqlParameter("@OpeID",System.Data.SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@AssyDataChangeRecords",SqlDbType.Xml),
                new SqlParameter("@JoinType",SqlDbType.Int),
            };
            parms[0].Value = SN;
            parms[1].Value = CSN;
            parms[2].Value = opeId;
            parms[3].Value = resId;
            parms[4].Value = userId;
            parms[5].Value = assyDataChangeRecords;
            parms[6].Value = joinType;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_SerialNumber_SNAndCSNJoin", parms);
            return true;
        }

        /// <summary>
        /// 关联主条码与客户条码
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="customerSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        public bool CollectCustomerSN(string sn,string customerSN,int stationId,int resouceId,int userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@CustomerSN",SqlDbType.NVarChar,512),
                new SqlParameter("@StationId",System.Data.SqlDbType.Int),
                new SqlParameter("@ResouceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int) ,
                new SqlParameter("@IsPrint",SqlDbType.Bit) ,
            };
            parms[0].Value = sn;
            parms[1].Value = customerSN;
            parms[2].Value = stationId;
            parms[3].Value = resouceId;
            parms[4].Value = userId;
            parms[5].Value = 1;
            parms[5].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectCustomerSN", parms);

            return Convert.ToBoolean(parms[5].Value);
        }

        /// <summary>
        /// 扫描STBID（SN）带出烽火包装箱与客户条码对应关系中 最小的未绑定过STBID的客户条码信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="customerSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        public string[] CollectAutoCustomerSN(string sn, int stationId, int resouceId, int userId)
        {
            string[] arr = new string[2];

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar),
                new SqlParameter("@CustomerSN",SqlDbType.NVarChar,100),
                new SqlParameter("@StationId",System.Data.SqlDbType.Int),
                new SqlParameter("@ResouceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int) ,
                new SqlParameter("@IsPrint",SqlDbType.Bit) ,
            };
            parms[0].Value = sn;
            parms[1].Value = "";
            parms[1].Direction = ParameterDirection.InputOutput;
            parms[2].Value = stationId;
            parms[3].Value = resouceId;
            parms[4].Value = userId;
            parms[5].Value = 1;
            parms[5].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectAutoCustomerSN", parms);

            arr[0] = Convert.ToString(parms[1].Value);
            arr[1] = Convert.ToString(parms[5].Value);
            return arr;
        }
    }
}
