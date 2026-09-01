using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.SMT.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SMT.BLL
{
    /// <summary>
    /// 前置加工
    /// </summary>
    public class PrepLoadingMaterial
    {
        /// <summary>
        /// 上料
        /// </summary>
        /// <param name="orderno"></param>
        /// <param name="stationid"></param>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        public HandLoadingMaterialInfo Loading(int pid, string orderno, int stationid, string grn, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@PId",SqlDbType.Int),
                 new SqlParameter("@OrderNo",SqlDbType.VarChar),
                 new SqlParameter("@StationId", SqlDbType.Int),
                 new SqlParameter("@GRN", SqlDbType.VarChar),
                 new SqlParameter("@UserName",SqlDbType.VarChar)
            };
            parms[0].Value = pid;
            parms[1].Value = orderno;
            parms[2].Value = stationid;
            parms[3].Value = grn;
            parms[4].Value = username;
            HandLoadingMaterialInfo model = new HandLoadingMaterialInfo();
            model = ComMethod.Get<HandLoadingMaterialInfo>("uspPrepLodingMaterialCheck", parms);
            return model;
        }
        /// <summary>
        /// 续料
        /// </summary>
        /// <param name="orderno"></param>
        /// <param name="stationid"></param>
        /// <param name="oldgrn"></param>
        /// <param name="newgrn"></param>
        /// <param name="username"></param>
        public HandLoadingMaterialInfo Continued(int pid, string orderno, string stationid, string oldgrn, string newgrn, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@PId",SqlDbType.Int),
                 new SqlParameter("@orderno",SqlDbType.VarChar),
                 new SqlParameter("@stationid", SqlDbType.Int),
                 new SqlParameter("@oldGRN", SqlDbType.VarChar),
                 new SqlParameter("@newGRN", SqlDbType.VarChar),
                 new SqlParameter("@username",SqlDbType.VarChar)
            };
            parms[0].Value = pid;
            parms[1].Value = orderno;
            parms[2].Value = stationid;
            parms[3].Value = oldgrn;
            parms[4].Value = newgrn;
            parms[5].Value = username;
            HandLoadingMaterialInfo model = new HandLoadingMaterialInfo();
            model = ComMethod.Get<HandLoadingMaterialInfo>("uspPrepContinuedMaterialCheck", parms);
            return model;
        }
        /// <summary>
        /// 开拉、停拉、卸料操作
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <param name="LineId"></param>
        /// <param name="Type"></param>
        /// <param name="UserName"></param>
        public int Opeation(string OrderNo, int LineId, int Type, string UserName)
        {
            int result = 0;
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@orderNo",SqlDbType.VarChar),
                 new SqlParameter("@LineId", SqlDbType.Int),
                 new SqlParameter("@Type", SqlDbType.Int),
                 new SqlParameter("@UserName", SqlDbType.VarChar)
            };
            parms[0].Value = OrderNo;
            parms[1].Value = LineId;
            parms[2].Value = Type;
            parms[3].Value = UserName;
            DataTable dt = new DataTable();
            if (Type == 0)
            {
                result = (int)SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, "uspPrepLoadingStatusChange", parms);
            }
            else
            {
                SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, "uspPrepLoadingStatusChange", parms);
            }
            return result;
        }
    }
}
