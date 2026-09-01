using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ProductionCollection.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.ProductionCollection.Client
{
    public class ProdCollectionOffLineBarCode
    {
        /// <summary>
        /// 检测拼版SN信息返回拼版规格
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public ProdCollectionInputInfo CheckProdOrderIdAndGetInfo(int prodOrderId)
        {
            List<ProdCollectionInputInfo> list = new List<ProdCollectionInputInfo>();

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@ProdOrderId",SqlDbType.Int)
            };

            param[0].Value = prodOrderId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckProdOrderIdAndGetInfo", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<ProdCollectionInputInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        public string  CheckOffLineBarCode(Int32 staitonId, Int32 prodOrderId)
        {
            //根据SN带出序列号信息
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@RegularExpressionStr",SqlDbType.NVarChar,-1)

            };
            parms[0].Value = staitonId;
            parms[1].Value = prodOrderId;
            parms[2].Value = "";
            parms[2].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckOffLineBarCode", parms);
            return parms[2].Value.ToString();
        }

        //验证扫描的离线条码
        public void checkOfflineSN(Int32 staitonId, Int32 prodOrderId,String  SN)
        {

            //根据SN带出序列号信息
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@SN",SqlDbType.NVarChar,200)
            };
            parms[0].Value = staitonId;
            parms[1].Value = prodOrderId;
            parms[2].Value = SN;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckOffLineSN", parms);
        }

        //保存离线条码注册
        public void SaveOffLineBarCode(string  scanStr,Int32 prodOrderId,int stationId,int resourceId, int userId)
        {

            //根据SN带出序列号信息
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ScanArr",SqlDbType.NVarChar,-1),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int)
            };
            parms[0].Value = scanStr;
            parms[1].Value = prodOrderId;
            parms[2].Value = stationId;
            parms[3].Value = resourceId;
            parms[4].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveOffLineBarCode", parms);
        }


        /// <summary>
        /// 离线注册条码批次
        /// </summary>
        /// <param name="scanStr"></param>
        /// <param name="SNQty"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        public void SaveOffLineBarCodeBatch(string scanStr, int SNQty,Int32 prodOrderId, int stationId, int resourceId, int userId)
        {

            //根据SN带出序列号信息
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ScanArr",SqlDbType.NVarChar){ Value = scanStr},
                 new SqlParameter("@SNQty",SqlDbType.Int){ Value = SNQty},
                new SqlParameter("@ProdOrderId",SqlDbType.Int){ Value = prodOrderId},
                new SqlParameter("@StationId",SqlDbType.Int){ Value = stationId},
                new SqlParameter("@ResourceId",SqlDbType.Int){ Value = resourceId},
                new SqlParameter("@UserId",SqlDbType.Int){ Value = userId}
            };

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveOffLineBarCodeBatch", parms);
        }


        //批量保存离线条码注册
        public void  SavePassByOffLineSN(string locationX ,string SN, Int32 prodOrderId, int stationId, int resourceId, int userId)
        {

            //根据SN带出序列号信息
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LocationX",SqlDbType.NVarChar,-1),
                new SqlParameter("@SN",SqlDbType.NVarChar,200),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int)
            };
            parms[0].Value = locationX;
            parms[1].Value = SN;
            parms[2].Value = prodOrderId;
            parms[3].Value = stationId;
            parms[4].Value = resourceId;
            parms[5].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSavePassByOffLineSN", parms);
        }
    }
}
