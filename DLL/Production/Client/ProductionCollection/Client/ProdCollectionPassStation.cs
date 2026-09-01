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
    public class ProdCollectionPassStation
    {
        #region 生产过站采集UI(可采集不良)

        /// <summary>
        /// 验证扫描条码是否为不良，如果为不良则验证不良并返回不良描述信息，否则返回空字串
        /// </summary>
        /// <param name="nccode"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        public string[] GetNCCodeInfo(string nccode,int stationId)
        {
            string[] nccodeArr = new string[2];
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@NCCode",SqlDbType.NVarChar),
                new SqlParameter("@StationId",SqlDbType.Int)
            };
            param[0].Value = nccode;
            param[1].Value = stationId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetNCCodeInfo", param))
            {
                if (rdr.Read())
                {
                    nccodeArr[0] = rdr.GetString(0);
                    nccodeArr[1] = rdr.GetString(1);
                }
            }

            return nccodeArr;
        }

        /// <summary>
        /// 过站采集UI 可采集不良（单个不良、拼版不良）
        /// </summary>
        /// <param name="panelId"></param>
        /// <param name="sn"></param>
        /// <param name="resId"></param>
        /// <param name="stationId"></param>
        /// <param name="userId"></param>
        /// <param name="nccodeXML"></param>
        public void CollectPassStationNEW(Int64 panelId, string sn, int resId, int stationId, int userId, string nccodeXML)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@PanelId",SqlDbType.BigInt),
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@NCCodeXML",SqlDbType.NVarChar),
            };
            param[0].Value = panelId;
            param[1].Value = sn;
            param[2].Value = resId;
            param[3].Value = stationId;
            param[4].Value = userId;
            param[5].Value = nccodeXML;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectPassStation_PDA", param);
        }

        /// <summary>
        /// 过站采集UI 可采集不良（单个不良、拼版不良）
        /// </summary>
        /// <param name="panelId"></param>
        /// <param name="sn"></param>
        /// <param name="resId"></param>
        /// <param name="stationId"></param>
        /// <param name="userId"></param>
        /// <param name="nccodeXML"></param>
        public void CollectPassStation(Int64 panelId, string sn, int resId, int stationId, int userId, string nccodeXML)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@PanelId",SqlDbType.BigInt),
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@NCCodeXML",SqlDbType.NVarChar),
            };
            param[0].Value = panelId;
            param[1].Value = sn;
            param[2].Value = resId;
            param[3].Value = stationId;
            param[4].Value = userId;
            param[5].Value = nccodeXML;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectPassStation", param);
        }

        /// <summary>
        /// 离线生产采集UI（可采集不良信息 只记录采集历史 不进行过站操作）
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="nccodeArr"></param>
        /// <param name="resId"></param>
        /// <param name="stationId"></param>
        /// <param name="userId"></param>
        public void OfflineProCollect(string sn, string nccodeArr, int resId, int stationId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar),
                new SqlParameter("@NCCodeArr",SqlDbType.NVarChar),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
            };
            param[0].Value = sn;
            param[1].Value = nccodeArr;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOfflineProCollection", param);
        }

        /// <summary>
        /// 不良采集UI 验证 SN Pass最大允许次数
        /// </summary>
        public void CheckPassCountStation(string sn, int stationId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar),
                new SqlParameter("@StationId",SqlDbType.Int)
            };
            param[0].Value = sn;
            param[1].Value = stationId;


            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckPassCountStation", param);
        }
        #endregion
    }
}
