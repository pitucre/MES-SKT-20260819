using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.ProductionCollection.Client
{
    public class ProdCollectionCommon
    {
        #region 验证、过站
        /// <summary>
        /// 通用条码验证
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="userId"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="isRepair"></param>
        public void ProcessValidation(string sn, int userId, int stationId, int resId, bool isRepair)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@IsRepair",SqlDbType.Bit),
            };

            parms[0].Value = sn;
            parms[1].Value = userId;
            parms[2].Value = stationId;
            parms[3].Value = resId;
            parms[4].Value = isRepair;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUnitProcessValidation", parms);
        }

        /// <summary>
        /// 通过SN完成过站操作
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="userId"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="isPass"></param>
        public void UnitComplete(string sn, int userId, int stationId, int resId, bool isPass)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@IsPass",SqlDbType.Bit),
            };

            parms[0].Value = sn;
            parms[1].Value = userId;
            parms[2].Value = stationId;
            parms[3].Value = resId;
            parms[4].Value = isPass;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUnitCompleteBySN", parms);
        }
        #endregion

        #region 获取拼版信息
        /// <summary>
        /// 通过扫描的SN获取拼版信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public string[] GetPanelInfoBySN(string sn)
        {
            string[] panelArr = new string[4];

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512)                 
            };

            parms[0].Value = sn;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPanelInfoBySN", parms))
            {
                if (rdr.Read())
                {
                    panelArr[0] = rdr.GetInt64(0).ToString();
                    panelArr[1] = rdr.GetString(1);
                    panelArr[2] = rdr.GetInt32(2).ToString();
                    panelArr[3] = rdr.GetInt32(3).ToString();
                }
            }

            return panelArr;
        }

        /// <summary>
        /// 通过扫描的SN获取拼版信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public string[] GetPanelInfoBySN_PDA(string sn)
        {
            string[] panelArr = new string[5];

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512)
            };

            parms[0].Value = sn;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPanelInfoBySN_PDA", parms))
            {
                if (rdr.Read())
                {
                    panelArr[0] = rdr.GetInt64(0).ToString();
                    panelArr[1] = rdr.GetString(1);
                    panelArr[2] = rdr.GetString(2);
                    panelArr[3] = rdr.GetString(3);
                    panelArr[4] = rdr.GetDecimal(4).ToString();
                }
            }

            return panelArr;
        }

        /// <summary>
        /// 通过扫描的SN获取拼版信息SN信息
        /// </summary>
        /// <param name="panelId"></param>
        /// <returns></returns>
        public string[] GetPanelListInfoById(Int64 panelId)
        {
            string[] panelArr = new string[] { };
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PanelId",SqlDbType.BigInt),
                new SqlParameter("@PanelSN",SqlDbType.VarChar,int.MaxValue) 
            };

            parms[0].Value = panelId;
            parms[1].Value = "";
            parms[1].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetPanelListInfoByPanelId", parms);

            return parms[1].Value.ToString().Split('^');

        }
        #endregion

        #region 获取是否打印条码信息

        /// <summary>
        /// 获取是否打印条码信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="snTypeId">--1、包装箱 2、栈板 3、客户条码</param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        public Boolean CheckIsPrintSN(string sn,int snTypeId,int stationId)
        {
            
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                 new SqlParameter("@SNTypeId",SqlDbType.Int),
                  new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@IsPrint",SqlDbType.Bit) 
            };

            parms[0].Value = sn;
            parms[1].Value = snTypeId;
            parms[2].Value = stationId;
            parms[3].Value = 1;
            parms[3].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckIsPrintSN", parms);

            return Convert.ToBoolean(parms[3].Value);

        }

        #endregion

        #region 释放打印条码

        /// <summary>
        /// 根据扫描条码释放新的SN
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public string ReleaseSNAndPrint(string sn, int stationId, int resourceId, int userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@SNArr",SqlDbType.NVarChar,500),
            };

            parms[0].Value = sn;
            parms[1].Value = stationId;
            parms[2].Value = resourceId;
            parms[3].Value = userId;
            parms[4].Value = "";
            parms[4].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReleaseSNAndPrint", parms);

            return parms[4].Value.ToString();
        }

        #endregion

        #region 获取是否需要某一类操作

        /// <summary>
        /// 检查是否需要进行某项操作
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="operateType"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        public Boolean CheckIsOperate(string sn, int operateType, int stationId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@OperateType",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@IsOperate",SqlDbType.Bit)
            };

            parms[0].Value = sn;
            parms[1].Value = operateType;
            parms[2].Value = stationId;
            parms[3].Value = 0;
            parms[3].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckIsOperate", parms);

            return Convert.ToBoolean(parms[3].Value);

        }

        /// <summary>
        /// 检查系统是否存在此条码
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public bool CheckIsExsitSN(string sn,int stationId,int resouceId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),                
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@IsExsist",SqlDbType.Bit)
            };

            parms[0].Value = sn;           
            parms[1].Value = stationId;
            parms[2].Value = resouceId;
            parms[3].Value = 1;
            parms[3].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckIsExsitSN", parms);

            return Convert.ToBoolean(parms[3].Value);
        }

        #endregion
    }
}
